(* Coq-Platform Version: 8.19 . 2024.10 - MacOS - arm64 *)

Require Import Coq.micromega.Psatz.
Require Import Coq.Classes.Morphisms.
Require Import Coq.Bool.Bool.
Require Import Coq.Arith.Arith.
Require Import Coq.Arith.EqNat.
Require Import Coq.Lists.List.
Import ListNotations.
Import Nat.

(* coq_makefile -f _CoqProject -o Makefile *)

Definition Gr : Type := nat.

Inductive Asym : Type :=
  | AsymId
  | Asymx (n: nat)
  | Asymin (n: nat)
  | Asymout (n: nat)
  | Asymim (n: nat)
  | Asymom (n: nat).

Definition AsymEq (l: Asym) (r: Asym) :bool := 
  match l with 
  | AsymId => match r with | AsymId => true | _ => false end
  | Asymx n => match r with | Asymx n' => n =? n' | _ => false end
  | Asymin n => match r with | Asymin n' => n =? n' | _ => false end
  | Asymout n => match r with | Asymout n' => n =? n' | _ => false end
  | Asymim n => match r with | Asymim n' => n =? n' | _ => false end
  | Asymom n => match r with | Asymom n' => n =? n' | _ => false end
  end.

Inductive aexpr : Type :=
  | Anum (n: nat)
  | Aneg (a: aexpr)
  | Aadd (a: aexpr) (b: aexpr)
  | Amul (a: aexpr) (b: aexpr)
  | Apow (a: aexpr) (b: aexpr)
  | Ahash1 (a: aexpr)
  | Ahash2 (a: aexpr) (b: aexpr)
  | Aabs (a: aexpr)
  | Ainp (i: nat) (a: aexpr)
  | Aoup (i: nat) (a: aexpr)
  | Aomega
  | ARnd
  | Asymbol (v: Asym).

Inductive Gsym : Type :=
  | GsymPk
  | Gsigma (n: nat)
  | Gsymy (n: nat).

Definition GsymEq (l: Gsym) (r: Gsym) :bool := 
  match l with 
  | GsymPk => match r with | GsymPk => true | _ => false end
  | Gsigma n => match r with | Gsigma n' => n =? n' | _ => false end
  | Gsymy n => match r with | Gsymy n' => n =? n' | _ => false end
  end.

Inductive gexpr : Type :=
  | Gnum (n: Gr)
  | Gmul (a: gexpr) (b: gexpr)
  | Gpow (a: gexpr) (b: gexpr)
  | Ghash1 (a: gexpr)
  | Ghash2 (a: gexpr) (b: gexpr)
  | Ginp (i: nat) (a: gexpr)
  | Goup (i: nat) (a: gexpr)
  | Gomega
  | Gsymbol (v: Gsym).

Inductive bexpr :Type := 
  | Bneg (a: bexpr)
  | Bbot
  | BU
  | Band (a: bexpr) (b: bexpr)
  | BeqA (a: aexpr) (b: aexpr)
  | BlessA (a: aexpr) (b: aexpr)
  | BVerG (a: gexpr) (b: gexpr)
  | BeqG (a: gexpr) (b: gexpr)
  | BlessG (a: gexpr) (b: gexpr)
  | Binp (i: nat) (a: bexpr)
  | Boup (i: nat) (a: bexpr)
  | BRI (i: nat).

Definition Btop :bexpr := Bneg Bbot.
Definition Bor (a: bexpr) (b: bexpr) :bexpr := Bneg (Band (Bneg a) (Bneg b)).
Definition Bto (a: bexpr) (b: bexpr) :bexpr := Bor (Bneg a) b.
Definition BleeqA (a: aexpr) (b: aexpr) :bexpr := Bor (BlessA a b) (BeqA a b).
Definition BleeqG (a: gexpr) (b: gexpr) :bexpr := Bor (BlessG a b) (BeqG a b).

Inductive Tx : Type := 
  | TxC (id: nat) (pk: Gr) (sigma: list Gr) (x: list nat) (y: list Gr) 
        (input: list nat) (output: list nat) (im: list nat) (om: list nat)
        (RI: bexpr).

Fixpoint nth {X: Type} (a: list X) (n: nat) :option(X) :=
  match n with
  | O => match a with | nil => None | cons x a' => Some(x) end
  | S n' => match a with | nil => None | cons x a' => (nth a' n') end
  end.

Definition Txid (tx: Tx) :nat := 
  match tx with (TxC id _ _ _ _ _ _ _ _ _) => id end.
Definition Txpk (tx: Tx) :Gr := 
  match tx with (TxC _ pk _ _ _ _ _ _ _ _) => pk end.
Definition Txsig (tx: Tx) (n: nat) :option(Gr) := 
  match tx with (TxC _ _ x _ _ _ _ _ _ _) => (nth x n) end.
Definition Txx (tx: Tx) (n: nat) :option(nat) := 
  match tx with (TxC _ _ _ x _ _ _ _ _ _) =>  (nth x n) end.
Definition Txy (tx: Tx) (n: nat) :option(Gr) := 
  match tx with (TxC _ _ _ _ x _ _ _ _ _) =>  (nth x n) end.
Definition Txin (tx: Tx) (n: nat) :option(nat) := 
  match tx with (TxC _ _ _ _ _ x _ _ _ _) =>  (nth x n) end.
Definition Txout (tx: Tx) (n: nat) :option(nat) := 
  match tx with (TxC _ _ _ _ _ _ x _ _ _) =>  (nth x n) end.
Definition Txim (tx: Tx) (n: nat) :option(nat) := 
  match tx with (TxC _ _ _ _ _ _ _ x _ _) =>  (nth x n) end.
Definition Txom (tx: Tx) (n: nat) :option(nat) := 
  match tx with (TxC _ _ _ _ _ _ _ _ x _) =>  (nth x n) end.
Definition TxRI (tx: Tx) :bexpr := 
  match tx with (TxC _ _ _ _ _ _ _ _ _ ri) => ri end.
(* None for unknown *)

Definition Ledger : Type := list Tx.

Definition SymbolAssignmentA (tx: Tx) (v: Asym) :option(nat) :=
  match v with
  | AsymId => Some(Txid tx)
  | Asymx n => Txx tx n
  | Asymin n => Txin tx n
  | Asymout n => Txout tx n
  | Asymim n => Txim tx n
  | Asymom n => Txom tx n
  end.

Definition SymbolAssignmentG (tx: Tx) (v: Gsym) :option(Gr) :=
  match v with
  | GsymPk => Some(Txpk tx)
  | Gsigma n => Txsig tx n
  | Gsymy n => Txy tx n
  end.

Inductive KProp : Type :=
  | KT | KF | KU.

Definition Kneg (p: KProp) : KProp := 
  match p with 
  | KT => KF 
  | KF => KT 
  | KU => KU 
  end.

Definition Kand (p: KProp) (q: KProp) :KProp :=
  match p, q with
  | KF, KF => KF | KF, KU => KF | KF, KT => KF
  | KU, KF => KF | KU, KU => KU | KU, KT => KU
  | KT, KF => KF | KT, KU => KU | KT, KT => KT
  end.
  
Definition Kor (p: KProp) (q: KProp) :KProp :=
  match p, q with
  | KF, KF => KF | KF, KU => KU | KF, KT => KT
  | KU, KF => KU | KU, KU => KU | KU, KT => KT
  | KT, KF => KT | KT, KU => KT | KT, KT => KT
  end.

Definition Kto (p: KProp) (q: KProp) :KProp := Kor (Kneg p) q.

(* |= (p1 -> p2 /\ p2 -> p3) -> (p1 -> p3) *)
Theorem Kinfer: forall p1 p2 p3, ~(Kto (Kand (Kto p1 p2) (Kto p2 p3)) (Kto p1 p3) = KF).
Proof.
  intros.
  intro.
  destruct p1, p2, p3; auto; unfold Kto, Kneg in H; simpl in H; inversion H.
Qed.

Fixpoint selectById (L: Ledger) (i: nat) :option(Tx) :=
  match i with
  | O => match L with
         | nil => None
         | cons x L' => Some(x)
         end
  | S j => match L with
           | nil => None
           | cons x L' => selectById L' j
           end
  end.


Fixpoint aexprCmp (p: aexpr) (q: aexpr) :bool :=
  match p with
  | Anum n => match q with | Anum n' => if (n =? n') then true else false | _ => false end
  | Aneg a => match q with | Aneg a' => if (aexprCmp a a') then true else false | _ => false end
  | Aadd a b => match q with | Aadd a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | Amul a b => match q with | Amul a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | Apow a b => match q with | Apow a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | Ahash1 a => match q with | Ahash1 a' => if (aexprCmp a a') then true else false | _ => false end
  | Ahash2 a b => match q with | Ahash2 a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | Aabs a => match q with | Aabs a' => if (aexprCmp a a') then true else false | _ => false end
  | Ainp i a => match q with | Ainp i' a' => if i =? i' then if (aexprCmp a a') then true else false else false | _ => false end
  | Aoup i a => match q with | Aoup i' a' => if i =? i' then if (aexprCmp a a') then true else false else false | _ => false end
  | Aomega => match q with | Aomega => true | _ => false end
  | ARnd => match q with | ARnd => true | _ => false end
  | Asymbol v => match q with | Asymbol v' => if (AsymEq v v') then true else false | _ => false end
  end.

Fixpoint gexprCmp (p: gexpr) (q: gexpr) :bool :=
  match p with
  | Gnum n => match q with | Gnum n' => if (n =? n') then true else false | _ => false end
  | Gmul a b => match q with | Gmul a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | Gpow a b => match q with | Gpow a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | Ghash1 a => match q with | Ghash1 a' => if (gexprCmp a a') then true else false | _ => false end
  | Ghash2 a b => match q with | Ghash2 a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | Ginp i a => match q with | Ginp i' a' => if i =? i' then if (gexprCmp a a') then true else false else false | _ => false end
  | Goup i a => match q with | Goup i' a' => if i =? i' then if (gexprCmp a a') then true else false else false | _ => false end
  | Gomega => match q with | Gomega => true | _ => false end
  | Gsymbol v => match q with | Gsymbol v' => if (GsymEq v v') then true else false | _ => false end
  end.

Fixpoint bexprCmp (p: bexpr) (q: bexpr) :bool := 
 match p with 
  | Bneg a => match q with | Bneg a' => if (bexprCmp a a') then true else false | _ => false end
  | Bbot => match q with | Bbot => true | _ => false end
  | BU => match q with | BU => true | _ => false end
  | Band a b => match q with | Band a' b' => if (bexprCmp a a') then if (bexprCmp b b') then true else false else false | _ => false end
  | BeqA a b => match q with | BeqA a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | BlessA a b => match q with | BlessA a' b' => if (aexprCmp a a') then if (aexprCmp b b') then true else false else false | _ => false end
  | BVerG a b => match q with | BVerG a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | BeqG a b => match q with | BeqG a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | BlessG a b => match q with | BlessG a' b' => if (gexprCmp a a') then if (gexprCmp b b') then true else false else false | _ => false end
  | Binp i a => match q with | Binp i' a' => if i =? i' then if (bexprCmp a a') then true else false else false | _ => false end
  | Boup i a => match q with | Boup i' a' => if i =? i' then if (bexprCmp a a') then true else false else false | _ => false end
  | BRI i => match q with | BRI i' => if i =? i' then true else false | _ => false end
  end.

(* Still, None for unknown *)
Fixpoint aEval (L: Ledger) (tx: Tx) (s: aexpr) :option(nat) := 
  match s with 
    | Anum n => Some(n)
    | Aneg a => None (* We only consider natural numbers for simplicity (Nat is more nicely intrinsitcly defined in Coq) *)
    | Aadd a b => match (aEval L tx a) with
                  | None => None
                  | Some(a') => match (aEval L tx b) with
                                | None => None
                                | Some(b') => Some(a' + b')
                                end
                  end
    | Amul a b => match (aEval L tx a) with
                  | None => None
                  | Some(a') => match (aEval L tx b) with
                                | None => None
                                | Some(b') => Some(a' * b')
                                end
                  end
    | Apow a b => match (aEval L tx a) with
                  | None => None
                  | Some(a') => match (aEval L tx b) with
                                | None => None
                                | Some(b') => Some(a' ^ b')
                                end
                  end
    | Ahash1 a => (aEval L tx a)  (* We do not realize a full hash here *)
    | Ahash2 a b => (aEval L tx a)
    | Aabs a => (aEval L tx a)
    | Ainp i a => match Txin tx i with 
                  | None => None 
                  | Some(inv) => match selectById L inv with
                                | None => None
                                | Some(tx') => aEval L tx' a
                                end
                  end
    | Aoup i a => match Txout tx i with
                  | None => None 
                  | Some(ouv) => match selectById L ouv with
                                | None => None
                                | Some(tx') => aEval L tx' a
                                end
                  end
    | Aomega => None
    | ARnd => Some(O)
    | Asymbol v => SymbolAssignmentA tx v
  end.

Fixpoint gEval (L: Ledger) (tx: Tx) (s: gexpr) :option(Gr) :=
  match s with
    | Gnum n => Some(n)
    | Gmul a b => match (gEval L tx a) with
                  | None => None
                  | Some(a') => match (gEval L tx b) with
                                | None => None
                                | Some(b') => Some(a' * b')
                                end
                  end
    | Gpow a b => match (gEval L tx a) with
                  | None => None
                  | Some(a') => match (gEval L tx b) with
                                | None => None
                                | Some(b') => Some(a' ^ b')
                                end
                  end
    | Ghash1 a => (gEval L tx a)
    | Ghash2 a b => (gEval L tx a)
    | Ginp i a => match Txin tx i with 
                  | None => None 
                  | Some(inv) => match selectById L inv with
                                | None => None
                                | Some(tx') => gEval L tx' a
                                end
                  end
    | Goup i a => match Txout tx i with
                  | None => None 
                  | Some(ouv) => match selectById L ouv with
                                | None => None
                                | Some(tx') => gEval L tx' a
                                end
                  end
    | Gomega => None
    | Gsymbol v => SymbolAssignmentG tx v
  end.

Fixpoint bEval (L: Ledger) (tx: Tx) (s: bexpr) :KProp := 
  match s with
    | Bneg a => Kneg (bEval L tx a)
    | Bbot => KF
    | BU => KU
    | Band a b => Kand (bEval L tx a) (bEval L tx b)
    | BeqA c d => match (aEval L tx c) with 
                  | None => KU
                  | Some(cv) => match (aEval L tx d) with
                                | None => KU
                                | Some(dv) => if cv =? dv then KT else KF
                                end
                  end
    | BlessA c d => match (aEval L tx c) with 
                  | None => KU
                  | Some(cv) => match (aEval L tx d) with
                                | None => KU
                                | Some(dv) => if cv <? dv then KT else KF
                                end
                  end
    | BVerG c d => KT (* We do not verify signatures here *)
    | BeqG c d => match (gEval L tx c) with 
                  | None => KU
                  | Some(cv) => match (gEval L tx d) with
                                | None => KU
                                | Some(dv) => if cv =? dv then KT else KF
                                end
                  end
    | BlessG c d => match (gEval L tx c) with 
                  | None => KU
                  | Some(cv) => match (gEval L tx d) with
                                | None => KU
                                | Some(dv) => if cv <? dv then KT else KF
                                end
                  end
    | Binp i a => match Txin tx i with 
                  | None => KT (* No such input: \bot -> any *)
                  | Some(inv) => match selectById L inv with
                                | None => KU
                                | Some(tx') => bEval L tx' a
                                end
                  end
    | Boup i a => match Txout tx i with
                  | None => KT 
                  | Some(ouv) => match selectById L ouv with
                                | None => KU
                                | Some(tx') => bEval L tx' a
                                end
                  end
    | BRI i => match (Txout tx i) with
               | None => KT
               | Some(rv) => match selectById L rv with 
                             | None => KU 
                             | Some(tx') => match bexprCmp (TxRI tx') (TxRI tx) with |true => KT |false => KF end
                             end
               end
  end.

Theorem equ_bExpr: forall L tx p, bEval L tx (Bto p p) = KT \/ bEval L tx (Bto p p) = KU.
Proof.
  intros.
  simpl.
  destruct (bEval L tx p) eqn:H1; auto.
Qed.

Definition validity (L: Ledger) (tx: Tx) (s: bexpr) : Prop := 
    (bEval L tx s) = KT \/ (bEval L tx s) = KU.

Axiom excluded_middle_prop: forall (P: Prop), (P \/ ~ P).

Theorem nonExOrEx_prop {X: Type}: forall (y: option(X)), ~(exists x, y = Some x) -> y = None.
Proof. Admitted.

Theorem inner_C_i: forall L tx p q, validity L tx (Band p q) -> (validity L tx p).
Proof.
  intros; simpl.
  unfold validity in H.
  unfold validity.
  simpl in H.
  destruct (bEval L tx p) eqn:H1; destruct (bEval L tx q) eqn:H2; auto.
Qed.

Theorem inner_C_i2: forall L tx p q, validity L tx (Band p q) -> (validity L tx q).
Proof.
  intros; simpl.
  unfold validity in H.
  unfold validity.
  simpl in H.
  destruct (bEval L tx q) eqn:H1; destruct (bEval L tx p) eqn:H2; auto.
Qed.

Theorem inner_D_i: forall L tx p q, validity L tx p -> validity L tx (Bor p q).
Proof.
  intros.
  unfold validity in H; unfold validity.
  simpl.
  destruct (bEval L tx p) eqn:H1; destruct (bEval L tx q) eqn:H2; auto.
Qed.

Theorem inner_D_i2: forall L tx p q, validity L tx q -> validity L tx (Bor p q).
Proof.
  intros.
  unfold validity in H; unfold validity.
  simpl.
  destruct (bEval L tx q) eqn:H1; destruct (bEval L tx p) eqn:H2; auto.
Qed.

Theorem inner_C_intro: forall L tx p q, validity L tx p /\ validity L tx q -> validity L tx (Band p q).
Proof.
  intros.
  unfold validity in H.
  unfold validity.
  destruct H.
  simpl.
  destruct (bEval L tx p) eqn:H1; destruct (bEval L tx q) eqn:H2; auto.
Qed.

Theorem inner_D_intro_i: forall L tx p q, validity L tx p \/ validity L tx q -> validity L tx (Bor p q).
Proof.
  intros.
  unfold validity in H.
  unfold validity.
  simpl.
  destruct (bEval L tx p) eqn:H1; destruct (bEval L tx q) eqn:H2; auto.
  simpl in H.
  inversion H.
  inversion H0.
  inversion H3. inversion H3.
  inversion H0. inversion H3.
  inversion H3.
Qed.

Theorem inner_to_intro: forall L tx p q, validity L tx p -> validity L tx q -> validity L tx (Bto p q).
Proof.
  intros.
  unfold validity in H; unfold validity.
  simpl.
  destruct (bEval L tx p) eqn:H1; destruct (bEval L tx q) eqn:H2; auto.
  simpl.
  unfold validity in H0.
  rewrite H2 in H0.
  inversion H0; auto.
Qed.

Theorem inner_to_intro2: forall L tx p q, validity L tx (Bor (Bneg p) q) <-> validity L tx (Bto p q).
Proof.
  intros.
  split.
  * intros.
    unfold validity.
    unfold validity in H.
    simpl. simpl in H.
    unfold Kneg; unfold Kneg in H.
    destruct H; destruct (bEval L tx p); destruct (bEval L tx q); auto.
  * intros.
    unfold validity.
    unfold validity in H.
    simpl. simpl in H.
    unfold Kneg; unfold Kneg in H.
    destruct H; destruct (bEval L tx p); destruct (bEval L tx q); auto.
Qed.

Theorem inner_D_intro: forall L tx p1 p2 q, validity L tx (Bto p1 q) -> validity L tx (Bto p2 q) 
                                              -> validity L tx (Bto (Band p1 p2) q).
Proof.
  unfold validity; intros.
  simpl.
  simpl in H, H0.
  destruct (bEval L tx p1) eqn:Hp1; destruct (bEval L tx p2) eqn:Hp2; destruct (bEval L tx q) eqn:Hq; auto.
Qed.

Theorem inner_ex_falso_quodlibet: forall L tx p, validity L tx Bbot -> validity L tx p.
Proof.
  intros.
  unfold validity in H.
  simpl in H.
  inversion H.
  inversion H0.
  inversion H.
  inversion H0.
  inversion H0.
Qed.

Theorem inner_C_V: forall L tx p q i, validity L tx (Boup i (Band p q)) -> validity L tx (Band (Boup i p) (Boup i q)).
Proof.
  intros.
  assert ((exists id, Txout tx i = Some(id)) \/ (Txout tx i = None)).
  {
    assert ((exists id, Txout tx i = Some(id)) \/ ~((exists id, Txout tx i = Some(id)))).
    apply excluded_middle_prop with (P := (exists id, Txout tx i = Some(id))).
    inversion H0; simpl; auto. destruct H0; auto.
    unfold Txout. destruct (match tx with | TxC _ _ _ _ _ _ x _ _ _ => nth x i end); simpl; auto.
    left. exists n. 
    reflexivity.
  }
  assert (validity L tx (Boup i p)).
  { 
    unfold validity in H. unfold validity. destruct H.
    + left. inversion H0.
      - destruct H1. simpl in H. rewrite H1 in H.
        simpl. rewrite H1.
        assert (exists tx', selectById L x = Some(tx')).
        {
          unfold Kand in H; simpl; auto.
          destruct (selectById L x).
          destruct (bEval L t0 p) in H; destruct (bEval L t0 q) in H; simpl in H; exists t0; auto.
          inversion H.
        }
        inversion H2.
        rewrite H3.
        rewrite H3 in H.
        unfold Kand in H.
        destruct (bEval L x0 p); auto.
        ++ rewrite <- H. destruct (bEval L x0 q); auto.
        ++ destruct (bEval L x0 q) in H; inversion H.
      - simpl. rewrite H1. reflexivity.
    + simpl. simpl in H. destruct (Txout tx i).
      - destruct (selectById L n).
        ++ unfold Kand in H. destruct (bEval L t0 p); destruct (bEval L t0 q) in H; auto.
        ++ right; auto.
      - left; auto.
  }
  assert (validity L tx (Boup i q)).
  { 
    unfold validity in H. unfold validity. destruct H.
    + left. inversion H0.
      - destruct H2. simpl in H. rewrite H2 in H.
        simpl. rewrite H2.
        assert (exists tx', selectById L x = Some(tx')).
        {
          unfold Kand in H; simpl; auto.
          destruct (selectById L x).
          destruct (bEval L t0 p) in H; destruct (bEval L t0 q) in H; simpl in H; exists t0; auto.
          inversion H.
        }
        inversion H3.
        rewrite H4.
        rewrite H4 in H.
        unfold Kand in H.
        destruct (bEval L x0 q); auto.
        ++ rewrite <- H. destruct (bEval L x0 p); auto.
        ++ destruct (bEval L x0 p) in H; inversion H.
      - simpl. rewrite H2. reflexivity.
    + simpl. simpl in H. destruct (Txout tx i).
      - destruct (selectById L n).
        ++ unfold Kand in H. destruct (bEval L t0 q); destruct (bEval L t0 p) in H; auto.
        ++ right; auto.
      - left; auto.
  }
  unfold validity.
  unfold validity in H1, H2.
  simpl.
  simpl in H1, H2.
  destruct (Txout tx i).
  + destruct (selectById L n).
    - unfold Kand. destruct (bEval L t0 q); destruct (bEval L t0 p); auto.
    - right. unfold Kand; auto.
  + left. unfold Kand; auto.
Qed.

Theorem inner_D_V: forall L tx p q i, validity L tx (Boup i (Bor p q)) -> validity L tx (Bor (Boup i p) (Boup i q)).
Proof.
  intros.
  unfold validity. 
  unfold validity in H.
  destruct H.
  * left.
    destruct (bEval L tx (Boup i p)) eqn: eq; auto.
    + simpl in H. destruct (Txout tx i) eqn: eqi; auto.
                  - destruct (selectById L n) eqn: eqs; auto.
                    ++ unfold Kneg in H; simpl; rewrite eqi; rewrite eqs.
                       unfold Kneg.
                       destruct (bEval L t0 p); destruct (bEval L t0 q); auto.
                    ++ inversion H.
                  - simpl. rewrite eqi. unfold Kneg. unfold Kand. reflexivity.
    + simpl in H. destruct (Txout tx i) eqn: eqi; auto.
                  - destruct (selectById L n) eqn: eqs; auto.
                    ++ unfold Kneg in H; simpl; rewrite eqi; rewrite eqs.
                       unfold Kneg.
                       destruct (bEval L t0 p); destruct (bEval L t0 q); auto.
                    ++ inversion H.
                  - simpl. rewrite eqi. unfold Kneg. unfold Kand. reflexivity.
    + simpl in H. destruct (Txout tx i) eqn: eqi; auto.
                  - destruct (selectById L n) eqn: eqs; auto.
                    ++ unfold Kneg in H; simpl; rewrite eqi; rewrite eqs.
                       unfold Kneg.
                       destruct (bEval L t0 p); destruct (bEval L t0 q); auto.
                    ++ inversion H.
                  - simpl. rewrite eqi. unfold Kneg. unfold Kand. reflexivity.
  * simpl in H; destruct (Txout tx i) eqn: eqi. destruct (selectById L n) eqn: eqs; auto; unfold Kneg in H.
                - simpl. rewrite eqi; rewrite eqs; auto. 
                - simpl. rewrite eqi; rewrite eqs; auto. 
                - inversion H.
Qed.

Theorem inner_K: forall L tx i p q, validity L tx (Boup i (Bto p q)) -> validity L tx (Bto (Boup i p) (Boup i q)).
Proof.
  intros.
  unfold validity. 
  unfold validity in H.
  simpl; simpl in H.
  unfold Kneg; unfold Kneg in H.
  destruct (Txout tx i); auto.
  destruct (selectById L n); auto.
Qed.

Theorem inner_C_V_bi: forall L tx p q i, validity L tx (Boup i (Band p q)) <-> validity L tx (Band (Boup i p) (Boup i q)).
Proof.
  intros;
  split; try apply inner_C_V.
  unfold validity; simpl.
  destruct (Txout tx i); auto.
  destruct (selectById L n); auto.
Qed.

Theorem inner_D_V_bi: forall L tx p q i, validity L tx (Boup i (Bor p q)) <-> validity L tx (Bor (Boup i p) (Boup i q)).
Proof.
  intros;
  split; try apply inner_D_V.
  unfold validity; simpl.
  destruct (Txout tx i); auto.
  destruct (selectById L n); auto.
Qed.

Theorem inner_K_bi: forall L tx i p q, validity L tx (Boup i (Bto p q)) <-> validity L tx (Bto (Boup i p) (Boup i q)).
Proof.
  intros;
  split; try apply inner_K.
  unfold validity; simpl.
  destruct (Txout tx i); auto.
  destruct (selectById L n); auto.
Qed.

Theorem inner_C_V_inp_bi: forall L tx p q i, validity L tx (Binp i (Band p q)) <-> validity L tx (Band (Binp i p) (Binp i q)).
Proof.
  split; intros; unfold validity; unfold validity in H;
  simpl; simpl in H;
  unfold Kand; unfold Kand in H;
  destruct (Txin tx i); auto;
  destruct (selectById L n); auto.
Qed.

Theorem inner_D_V_inp_bi: forall L tx p q i, validity L tx (Binp i (Bor p q)) <-> validity L tx (Bor (Binp i p) (Binp i q)).
Proof.
  split; intros; unfold validity; unfold validity in H;
  simpl; simpl in H;
  unfold Kand; unfold Kand in H;
  destruct (Txin tx i); auto;
  destruct (selectById L n); auto.
Qed.

Theorem inner_K_inp_bi: forall L tx i p q, validity L tx (Binp i (Bto p q)) <-> validity L tx (Bto (Binp i p) (Binp i q)).
Proof.
  split; intros; unfold validity; unfold validity in H;
  simpl; simpl in H;
  unfold Kand; unfold Kand in H;
  destruct (Txin tx i); auto;
  destruct (selectById L n); auto.
Qed.

Theorem inner_T: forall L tx p1 p2 q, validity L tx (Bto p1 (Bto p2 q)) -> validity L tx (Bto (Band p1 p2) q).
Proof.
  intros.
  unfold validity.
  unfold validity in H.
  simpl in H; simpl.
  destruct (bEval L tx q) eqn:eq0; destruct (bEval L tx p1) eqn:eq1; destruct (bEval L tx p2) eqn:eq2; auto.
Qed.

Theorem inner_exclus_middle: forall L tx p, validity L tx (Bor p (Bneg p)).
Proof.
  intros.
  unfold validity.
  simpl.
  unfold Kneg.
  destruct (bEval L tx p); unfold Kand; auto.
Qed.

Theorem inner_de_morgan: forall L tx p q, validity L tx (Bneg (Bor p q)) <-> validity L tx (Band (Bneg p) (Bneg q)).
Proof.
  unfold validity; intros.
  split; simpl; unfold Kneg; destruct (bEval L tx p); destruct (bEval L tx q); auto.
Qed.

Theorem inner_de_morgan2: forall L tx p q, validity L tx (Bneg (Band p q)) <-> validity L tx (Bor (Bneg p) (Bneg q)).
Proof.
  unfold validity; intros.
  split; simpl; unfold Kneg; destruct (bEval L tx p); destruct (bEval L tx q); auto.
Qed.

Theorem inner_distribution: forall L tx p1 p2 q,  
                              validity L tx (Band (Bor p1 p2) q) <-> validity L tx (Bor (Band p1 q) (Band p2 q)).
Proof.
  unfold validity; intros.
  split; simpl; unfold Kand; unfold Kneg;
  destruct (bEval L tx q) eqn:eq0; destruct (bEval L tx p1) eqn:eq1; destruct (bEval L tx p2) eqn:eq2; auto.
Qed.

Inductive proves: Ledger -> Tx -> bexpr -> Prop :=
| R_C_i: forall L tx p q, 
    proves L tx (Band p q) -> (proves L tx p)
| R_C_i2: forall L tx p q, 
    proves L tx (Band p q) -> (proves L tx q)
| R_D_i: forall L tx p q, 
    proves L tx p -> proves L tx (Bor p q)
| R_D_i2: forall L tx p q, 
    proves L tx q -> proves L tx (Bor p q)
| R_C_intro: forall L tx p q, 
    proves L tx p -> proves L tx q -> proves L tx (Band p q)
| R_to_intro: forall L tx p q, 
    proves L tx p -> proves L tx q -> proves L tx (Bto p q)
| R_to_intro2: forall L tx p q, 
    proves L tx (Bor (Bneg p) q) -> proves L tx (Bto p q)
| R_to_intro2_rev: forall L tx p q, 
    proves L tx (Bto p q) -> proves L tx (Bor (Bneg p) q)
| R_D_intro: forall L tx p1 p2 q, 
    proves L tx (Bto p1 q) -> proves L tx (Bto p2 q) 
                           -> proves L tx (Bto (Band p1 p2) q)
| R_D_intro_i: forall L tx p q, 
    proves L tx p -> proves L tx (Bor p q)
| R_D_intro_i2: forall L tx p q, 
    proves L tx q -> proves L tx (Bor p q)
| R_ex_falso_quodlibet: forall L tx p, 
    proves L tx Bbot -> proves L tx p
| R_C_V: forall L tx p q i, 
    proves L tx (Boup i (Band p q)) -> 
    proves L tx (Band (Boup i p) (Boup i q))
| R_C_V_rev: forall L tx p q i, 
    proves L tx (Band (Boup i p) (Boup i q)) -> 
    proves L tx (Boup i (Band p q))
| R_D_V: forall L tx p q i, 
    proves L tx (Boup i (Bor p q)) -> 
    proves L tx (Bor (Boup i p) (Boup i q))
| R_D_V_rev: forall L tx p q i, 
    proves L tx (Bor (Boup i p) (Boup i q)) -> 
    proves L tx (Boup i (Bor p q)) 
| R_K: forall L tx i p q, 
    proves L tx (Boup i (Bto p q)) -> 
    proves L tx (Bto (Boup i p) (Boup i q))
| R_K_rev: forall L tx i p q, 
    proves L tx (Bto (Boup i p) (Boup i q)) -> 
    proves L tx (Boup i (Bto p q))
| R_C_V_inp: forall L tx p q i, 
    proves L tx (Binp i (Band p q)) -> 
    proves L tx (Band (Binp i p) (Binp i q))
| R_C_V_inp_rev: forall L tx p q i, 
    proves L tx (Band (Binp i p) (Binp i q)) -> 
    proves L tx (Binp i (Band p q))
| R_D_V_inp: forall L tx p q i, 
    proves L tx (Binp i (Bor p q)) -> 
    proves L tx (Bor (Binp i p) (Binp i q))
| R_D_V_inp_rev: forall L tx p q i, 
    proves L tx (Bor (Binp i p) (Binp i q)) -> 
    proves L tx (Binp i (Bor p q))
| R_K_inp: forall L tx i p q, 
    proves L tx (Binp i (Bto p q)) -> 
    proves L tx (Bto (Binp i p) (Binp i q))
| R_K_inp_rev: forall L tx i p q, 
    proves L tx (Bto (Binp i p) (Binp i q)) -> 
    proves L tx (Binp i (Bto p q))
| R_T: forall L tx p1 p2 q, 
    proves L tx (Bto p1 (Bto p2 q)) -> 
    proves L tx (Bto (Band p1 p2) q)
| R_exclus_middle: forall L tx p, 
    proves L tx (Bor p (Bneg p))
| R_de_morgan: forall L tx p q, 
    proves L tx (Bneg (Bor p q)) -> 
    proves L tx (Band (Bneg p) (Bneg q))
| R_de_morgan_rev: forall L tx p q, 
    proves L tx (Band (Bneg p) (Bneg q)) -> 
    proves L tx (Bneg (Bor p q))
| R_de_morgan2: forall L tx p q, 
    proves L tx (Bneg (Band p q)) -> 
    proves L tx (Bor (Bneg p) (Bneg q))
| R_de_morgan2_rev: forall L tx p q, 
    proves L tx (Bor (Bneg p) (Bneg q)) -> 
    proves L tx (Bneg (Band p q))
| R_distribution1: forall L tx p1 p2 q, 
    proves L tx (Band (Bor p1 p2) q) -> 
    proves L tx (Bor (Band p1 q) (Band p2 q))
| R_distribution2: forall L tx p1 p2 q, 
    proves L tx (Bor (Band p1 q) (Band p2 q)) -> 
    proves L tx (Band (Bor p1 p2) q).

Theorem Soundness: forall L tx p, proves L tx p -> validity L tx p.
Proof.
intros.
induction H.
- apply inner_C_i in IHproves. exact IHproves.
- apply inner_C_i2 in IHproves. exact IHproves.
- apply inner_D_i. exact IHproves.
- apply inner_D_i2. exact IHproves.
- apply inner_C_intro. auto.
- apply inner_to_intro; auto.
- apply -> inner_to_intro2 in IHproves. exact IHproves.
- apply inner_to_intro2 in IHproves. exact IHproves.
- apply inner_D_intro; auto.
- apply inner_D_intro_i. left. exact IHproves.
- apply inner_D_intro_i. right. exact IHproves.
- apply inner_ex_falso_quodlibet. exact IHproves.
- apply inner_C_V. exact IHproves.
- apply inner_C_V_bi in IHproves. exact IHproves.
- apply inner_D_V. exact IHproves.
- apply inner_D_V_bi in IHproves. exact IHproves.
- apply inner_K. exact IHproves.
- apply inner_K_bi. exact IHproves.
- apply inner_C_V_inp_bi. exact IHproves.
- apply inner_C_V_inp_bi in IHproves. exact IHproves.
- apply inner_D_V_inp_bi. exact IHproves.
- apply inner_D_V_inp_bi in IHproves. exact IHproves.
- apply inner_K_inp_bi. exact IHproves.
- apply inner_K_inp_bi. exact IHproves.
- apply inner_T. exact IHproves.
- apply inner_exclus_middle.
- apply inner_de_morgan. exact IHproves.
- apply inner_de_morgan. exact IHproves.
- apply -> inner_de_morgan2. exact IHproves.
- apply inner_de_morgan2. exact IHproves.
- apply inner_distribution. exact IHproves.
- apply inner_distribution. exact IHproves.
Qed.
