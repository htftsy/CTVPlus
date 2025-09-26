(* Coq-Platform Version: 8.19 . 2024.10 - MacOS - arm64 *)

Require Export innerLogic.


Fixpoint consistentLedger (L: Ledger) : Prop :=
  match L with
  | nil => True
  | cons x L' => (validity L x (TxRI x)) /\ (consistentLedger L')
  end.

Fixpoint app {X: Type} (l1: list X) (l2: X) : list X :=
  match l1 with
  | nil    => l2 :: nil
  | h :: t => h :: (app t l2)
  end.

Fixpoint detectedInList (x: nat) (lst: list nat) : bool :=
  match lst with
  | nil => false
  | cons a lst' => if a =? x then true else detectedInList x lst'
  end.

Definition detectedInTxOut (x: nat) (tx: Tx) : bool :=
  match tx with
  | TxC _ _ _ _ _ _ oulist _ _ _ => detectedInList x oulist
  end.

Fixpoint checkOutputIdCollision (L: Ledger) (tx: Tx) : bool := 
  match L with
  | nil => true
  | cons x L' => if ((Txid x) =? (Txid tx)) || (detectedInTxOut (Txid x) tx) then false else checkOutputIdCollision L' tx
  end.


Fixpoint checkInputTxSatisfiabilityList (L: Ledger) (lst: list nat) : bool :=
  match lst with
  | nil => true
  | cons id lst' => match selectById L id with
                    | None => false
                    | Some v => match bEval (app L v) v (TxRI v) with
                                | KT | KU => checkInputTxSatisfiabilityList L lst'
                                | KF => false
                                end
                    end
  end.

Definition checkInputTxSatisfiability (L: Ledger) (tx: Tx) : bool :=
  match tx with
  | TxC _ _ _ _ _ inlist _ _ _ _ => checkInputTxSatisfiabilityList L inlist
  end.

Definition canInclude (L: Ledger) (tx: Tx) : bool :=
  match (bEval L tx (TxRI tx)) with
  | KT | KU => (checkOutputIdCollision L tx) && (checkInputTxSatisfiability L tx)
  | KF => false
  end.

Definition extendLedger (L: Ledger) (tx: Tx) : Ledger :=
  match (canInclude L tx) with
  | true => app L tx
  | false => L
  end.

Definition validTauto (t: bexpr) : Prop := forall L tx, validity L tx t.

(* U \/ T *)
Theorem validTauto_ex: validTauto (Bor BU (Bneg Bbot)).
Proof.
  unfold validTauto, validity; intros; simpl.
  left. reflexivity.
Qed.

Fixpoint isMergedSequence {X: Type} (s: list X) (s1: list X) (s2: list X) : Prop :=
  match s with
  | nil => s1 = nil /\ s2 = nil
  | cons a s' => match s1 with
                 | nil => match s2 with
                          | nil => False
                          | cons a2 s2' => a = a2 /\ (isMergedSequence s' s1 s2')
                          end
                 | cons a1 s1' => match s2 with
                                  | nil => a = a1 /\ (isMergedSequence s' s1' s2)
                                  | cons a2 s2' => (a = a1 -> isMergedSequence s' s1' s2) /\ (a = a2 -> isMergedSequence s' s1 s2')
                                  end
                 end
  end.


Theorem symmetricCompLedger: forall (L1: Ledger) L2 L, (isMergedSequence L L2 L1) = (isMergedSequence L L1 L2).
Proof. Admitted.

Definition idSatisfiability (L: Ledger) (id: nat) (t: bexpr) : Prop := 
  match selectById L id with
  | None => True
  | Some v => validity L v t
  end. 

Definition existId (L: Ledger) (id: nat) : Prop :=
  match selectById L id with
  | None => False
  | Some _ => True
  end.

Inductive oexpr : Type :=
  | Obot
  | Ompsto (id: nat) (t: bexpr)
  | OexId (id: nat)
  | Owedge (a: oexpr) (b: oexpr)
  | Ovee (a: oexpr) (b: oexpr)
  | Osepconj (a: oexpr) (b: oexpr)
  | Oto (a: oexpr) (b: oexpr).

Fixpoint oEval (L: Ledger) (s: oexpr) : Prop :=
  match s with
  | Obot => False
  | Ompsto id t => idSatisfiability L id t
  | OexId id => existId L id
  | Owedge a b => (oEval L a) /\ (oEval L b)
  | Ovee a b => (oEval L a) \/ (oEval L b)
  | Osepconj a b => exists L1 L2, 
                      (isMergedSequence L L1 L2) /\ (oEval L1 a) /\ (oEval L2 b)
  | Oto a b => (oEval L a) -> (oEval L b)
  end.

Definition ShallowSepConj (L: Ledger) (a: oexpr) (b: Ledger -> Prop) : Prop :=
  exists L1 L2, (isMergedSequence L L1 L2) /\ (oEval L1 a) /\ (b L2).

Fixpoint listP (L: Ledger) (n: nat) := 
  match n with
  | O => True
  | S n' => exists id, ShallowSepConj L ( Owedge (Ompsto id 
                                                  ( BeqA (Asymbol (Asymx 1))
                                                         (Anum n)
                                                  )
                                                 )
                                                 (OexId id)
                                         ) 
                                         (fun L2 => listP L2 n')
  end.

Fixpoint advance1 (L: Ledger) (id: nat) (n: nat) := 
  match n with
  | O => True
  | S n' => exists id', ShallowSepConj L ( Owedge (Ompsto id 
                                                    ( BeqA (Asymbol (Asymout 1))
                                                           (Anum id')
                                                    )
                                                  )
                                                  (OexId id)
                                         ) 
                                         (fun L2 => advance1 L2 id' n')
  end.

Definition RIex : bexpr := Band (BeqA (Asymbol (Asymx 1))
                                      (Aadd (Aoup 1 (Asymbol (Asymx 1))) (Anum 1))
                                )
                                (BRI 1).

(* The following axioms are made to model the transaction execution, which is not detailed. *)

Theorem axiom_sep1: forall L x L1 L2 p, idSatisfiability L x p /\ existId L1 x /\ isMergedSequence L L1 L2 -> idSatisfiability L1 x p.
Proof. Admitted.

Theorem axiom_sep2 (RI: bexpr): forall i L1 L2 L m x x',
                             idSatisfiability L1 x (BeqA (Asymbol (Asymout i)) (Anum x')) 
                             /\ idSatisfiability L1 x (BRI i) 
                             /\ isMergedSequence L L1 L2 
                             /\ 
                                validTauto (Bto RI (Boup i (BeqA (Asymbol (Asymx i)) (Anum m))))
                             -> idSatisfiability L2 x' (BeqA (Asymbol (Asymx i)) (Anum m)).
Proof. Admitted.

Axiom axiom_sep3: forall L L' id a b, selectById L id = Some(a) /\ selectById L' id = Some(b) -> a = b.

Axiom axiom_sep3': forall L L1 L2 id, isMergedSequence L L1 L2 /\ selectById L id = None -> selectById L1 id = None.

Axiom axiom_sep3'': forall L L1 L2 id a, isMergedSequence L L1 L2 /\ selectById L1 id = Some(a) -> selectById L id = Some(a).

Axiom axiom_sep4: forall L L1 L2 tx p, isMergedSequence L L1 L2 /\ validity L tx p -> validity L1 tx p.

Axiom axiom_advance_unique_RI_ID: forall L L1 L2 id1 id2 m, isMergedSequence L L1 L2 /\ 
                                                                      advance1 L id1 m /\ advance1 L1 id2 m -> id1 = id2.

Axiom axiom_advance: forall L L1 L2 id m, isMergedSequence L L1 L2 /\ advance1 L1 id m -> advance1 L id m.

Axiom axiom_replace: BRI 1 = RIex.

Lemma existence_lift: forall L L1 L2 id, isMergedSequence L L1 L2 /\ existId L1 id -> existId L id.
Proof.
  intros.
  unfold existId.
  unfold existId in H.
  destruct H.
  destruct (selectById L1 id) eqn:eq1; destruct (selectById L id) eqn:eq; auto.
  assert (selectById L1 id = None).
  apply axiom_sep3' with (L:=L) (L1:=L1) (L2:=L2) (id:=id); auto.
  rewrite H1 in eq1.
  inversion eq1.
Qed.

Lemma advance_existId: forall L id n, advance1 L id n -> (n =? 0) = false -> existId L id.
Proof.
  intros.
  destruct n.
  - inversion H0.
  - simpl in H.
    destruct H.
    unfold ShallowSepConj in H.
    destruct H.
    destruct H.
    destruct H.
    unfold oEval in H1.
    destruct H1.
    destruct H1.
    apply existence_lift with (L:=L) (L1:=x0) (L2:=x1) (id:=id).
    auto.
Qed.

Theorem Sep_ex1 : forall n, (forall L, ((exists id, idSatisfiability L id (Band ( 
                                                                      BeqA (Asymbol (Asymx 1))
                                                                      (Anum n)
                                                                     )
                                                                     (BRI 1)
                                                               ) /\ 
                                                    advance1 L id n /\ idSatisfiability L id (BRI 1)) ->  listP L n)
                            ).
Proof.
  induction n.
  * unfold listP. auto.
  * intros. destruct H. simpl. exists x. destruct H. 
    simpl in H0. destruct H0.
    rename H1 into Hx.
    unfold ShallowSepConj in H0. destruct H0. destruct H0. destruct H0.
    unfold ShallowSepConj. exists x1. exists x2.
    destruct H0.
    split; try apply H0.
    destruct H1.
    assert(idSatisfiability x2 x0 RIex). admit. 
        (* This is entailed by the fact that RI will be passed to the spender tx. *)
        (* This is admitted since we do not describe the detailed block assemblly logic here. *)
    rename H3 into Hit.
    split.
    + simpl. simpl in H1. split; destruct H1.
        - simpl in H. assert (forall t y, idSatisfiability L x (Band t y) -> idSatisfiability L x t).
          {
            intros.
            unfold idSatisfiability in H4. unfold idSatisfiability. destruct (selectById L x); try auto.
            unfold validity in H4. unfold validity.
            destruct H4.
            + left. simpl in H4. unfold Kand in H4. destruct (bEval L t1 t0); destruct (bEval L t1 y); auto. inversion H4.
            + simpl in H4. destruct (bEval L t1 t0); destruct (bEval L t1 y); auto.
          }
          apply H4 with (t :=  (BeqA (Asymbol (Asymx 1)) (Anum (S n)))) (y := (BRI 1)) in H.
          assert (forall t, idSatisfiability L x t -> idSatisfiability x1 x t).
          {
             unfold idSatisfiability; intros.
             destruct (selectById L x) eqn: HHL; destruct (selectById x1 x) eqn: HHx1; simpl; auto.
             assert(t1 = t2).
             {
                apply axiom_sep3 with (L:=L) (L':=x1) (id:=x).
                auto.
             }
             subst.
             + apply axiom_sep4 with (L:=L) (L1:=x1) (L2:=x2) (tx:=t2).
               split.
               - exact H0.
               - exact H5.
             + assert(selectById L x = Some t1). 
               {
                 apply axiom_sep3'' with (L:=L) (L1:=x1) (L2:=x2) (id:=x).
                 split; auto.
               }
               rewrite H6 in HHL.
               inversion HHL.
          }
          apply H5 with (t := (BeqA (Asymbol (Asymx 1)) (Anum (S n)))) in H. 
          exact H.
        - exact H3.
    + assert(exists id : nat,
         idSatisfiability L id
           (Band (BeqA (Asymbol (Asymx 1)) (Anum n))
              RIex) /\ advance1 L id n /\ idSatisfiability L id RIex).
              {
                exists x0.
                simpl in H1. 
                split.
                + (* idSatisfiability L x0 (Band (BeqA (Asymbol (Asymx 1)) (Anum n)) RIex)
                     is implied by the execution model. *) admit.
                + split.
                  - apply axiom_advance with (L:=L) (L1:=x2) (L2:=x1) (m:=n) (id:=x0).
                    rewrite symmetricCompLedger in H0. 
                    split; try exact H0.
                    exact H2.
                  - assert (existId x2 x0).
                    {
                      apply advance_existId with (L:=x2) (id:=x0) (n:=n).
                      - apply H2.
                      - assert((n =? 0) = false). admit. auto.
                    }
                    admit.
              }
      apply IHn.
      exists x0.
      split; try apply H2.
      simpl in H1. destruct H1.
      assert(idSatisfiability x2 x0(BeqA (Asymbol (Asymx 1)) (Anum n))).
      {
            apply axiom_sep2 with (RI := Boup 1 (BeqA (Asymbol (Asymx 1)) (Anum n))) (L:=L) (L1 := x1) (L2 := x2) (i:=1) (x:=x) (x':=x0).
            split; auto.
            split; auto.
            - unfold RIex in Hx. 
              unfold idSatisfiability in Hx.
              unfold idSatisfiability.
              destruct (selectById L x) eqn:Heq.
              rewrite  axiom_replace in Hx.
              apply inner_C_i2 in Hx.
              destruct (selectById x1 x) eqn:Heq1; auto.
              assert(t0 = t1).
              {
                apply axiom_sep3 with (L:=L) (L':=x1) (id:=x).
                split; try apply Heq; apply Heq1.
              }
              rewrite H5 in Hx.
              apply axiom_sep4 with (L:=L) (L1:=x1) (L2:=x2).
              split; [apply H0 | apply Hx].
              assert(selectById x1 x = None).
              {
                apply axiom_sep3' with (L:=L) (L1:=x1) (L2:=x2).
                split; [apply H0 | apply Heq]. 
              }
              rewrite H5; auto.
            - split; try apply H0.
              unfold validTauto; auto.
              intros; unfold validity; auto.
              destruct (Boup 1 (BeqA (Asymbol (Asymx 1)) (Anum n))); apply equ_bExpr; auto.
      }
      unfold idSatisfiability.
      unfold idSatisfiability in H5.
      destruct (selectById x2 x0) eqn:Hs; try auto.
      destruct H3. destruct H3. destruct H6.
      assert(x3 = x0).
      {
        apply axiom_advance_unique_RI_ID with (L:=L) (L1:=x2) (L2:=x1) (id1:=x3) (id2:=x0) (m:=n).
        split; auto.
        assert((isMergedSequence L x2 x1) = (isMergedSequence L x1 x2)).
        apply symmetricCompLedger.
        rewrite <-H8 in H0. auto.
      }
      apply inner_C_intro with (L := x2) (tx := t0) (p := (BeqA (Asymbol (Asymx 1)) (Anum n))) (q := (BRI 1)).
      - split. apply H5. rewrite H8 in H7. unfold idSatisfiability in H7. 
        assert(selectById L x0 = Some t0).
        {
           apply axiom_sep3'' with (L:=L) (L1:=x2) (L2:=x1).
           split. 
           assert((isMergedSequence L x2 x1) = (isMergedSequence L x1 x2)).
           apply symmetricCompLedger.
           rewrite <-H9 in H0. auto.
           exact Hs.
        }
        rewrite H9 in H7.
        apply axiom_sep4 with (L:=L) (L1:=x2) (L2:=x1).
        assert((isMergedSequence L x2 x1) = (isMergedSequence L x1 x2)).
        apply symmetricCompLedger.
        rewrite H10.
        split; auto.
        rewrite axiom_replace. auto.
      - split; auto.
        (* Now the only remained proof subgoal is : "idSatisfiability x2 x0 RIex" *)
        rewrite axiom_replace. exact Hit.
Admitted.
