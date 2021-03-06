; This file includes 
;     a) the mapping from datamodel to FOL
;     b) the mapping from database to FOL
; Fragment used: Uninterpreted functino + string + linear integer arithmetic 
(set-logic UFSLIA)
; =================================================
;   A. Mapping from datamodel to FOL
; =================================================
(declare-sort Classifier 0)
(declare-const nullClassifier Classifier)
(declare-const invalidClassifier Classifier)
(declare-const nullInt Int)
(declare-const invalidInt Int)
(declare-const nullString String)
(declare-const invalidString String)
(declare-fun Lecturer (Classifier) Bool)
(declare-fun Student (Classifier) Bool)
(declare-fun age_Lecturer (Classifier) Int)
(declare-fun email_Lecturer (Classifier) String)
(declare-fun name_Lecturer (Classifier) String)
(declare-fun age_Student (Classifier) Int)
(declare-fun name_Student (Classifier) String)
(declare-fun email_Student (Classifier) String)
(declare-fun Enrolment (Classifier Classifier) Bool)

(assert (distinct nullClassifier invalidClassifier))
(assert (distinct nullInt invalidInt))
(assert (distinct nullString invalidString))
(assert (not (Lecturer nullClassifier)))
(assert (not (Student nullClassifier)))
(assert (not (Lecturer invalidClassifier)))
(assert (= (age_Lecturer nullClassifier) invalidInt))
(assert (= (age_Lecturer invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (age_Lecturer x) invalidInt))))
(assert (= (email_Lecturer nullClassifier) invalidString))
(assert (= (email_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (email_Lecturer x) invalidString))))
(assert (= (name_Lecturer nullClassifier) invalidString))
(assert (= (name_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (name_Lecturer x) invalidString))))
(assert (not (Student invalidClassifier)))
(assert (= (age_Student nullClassifier) invalidInt))
(assert (= (age_Student invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (age_Student x) invalidInt))))
(assert (= (name_Student nullClassifier) invalidString))
(assert (= (name_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (name_Student x) invalidString))))
(assert (= (email_Student nullClassifier) invalidString))
(assert (= (email_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (email_Student x) invalidString))))
(assert (forall ((x Classifier) (y Classifier))
    (=> (Enrolment x y) 
        (and (Lecturer x) (Student y)))))
(assert (forall ((x Classifier)) 
    (=> (Lecturer x) (not (Student x)))))
(assert (forall ((x Classifier)) 
    (=> (Student x) (not (Lecturer x)))))

; =================================================
;   B. Mapping from database to FOL
; =================================================
(declare-sort BOOL 0)
(declare-const TRUE BOOL)
(declare-const FALSE BOOL)
(declare-const NULL BOOL)
(declare-fun id (Int) Classifier)
(declare-fun left (Int) Int)
(declare-fun right (Int) Int)
(declare-fun student-index (Int) Bool)
(declare-fun lecturer-index (Int) Bool)
(declare-fun enrolment-index (Int) Bool)
(declare-fun val-student-id (Int) Classifier)
(declare-fun val-student-age (Int) Int)
(declare-fun val-student-name (Int) String)
(declare-fun val-student-email (Int) String)
(declare-fun val-lecturer-id (Int) Classifier)
(declare-fun val-lecturer-age (Int) Int)
(declare-fun val-lecturer-name (Int) String)
(declare-fun val-lecturer-email (Int) String)
(declare-fun val-enrolment-lecturers (Int) Classifier)
(declare-fun val-enrolment-students (Int) Classifier)

(assert (not (= TRUE FALSE)))
(assert (not (= TRUE NULL)))
(assert (not (= FALSE NULL)))
(assert (forall ((x BOOL))
    (or (= x TRUE) (or (= x FALSE) (= x NULL)))))
(assert (forall ((x Int))
    (=> (student-index x)
        (exists ((c Classifier))
            (and (Student c)
                 (= c (id x)))))))
(assert (forall ((c Classifier))
    (=> (Student c)
        (exists ((x Int))
            (and (student-index x)
                 (= c (id x)))))))
(assert (forall ((x Int) (y Int))
    (=> (and (student-index x) (student-index y) (not (= x y)))
        (not (= (id x) (id y))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-id x) (id x)))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-age x) (age_Student (id x))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-name x) (name_Student (id x))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-email x) (email_Student (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (exists ((c Classifier))
            (and (Lecturer c)
                 (= c (id x)))))))
(assert (forall ((c Classifier))
    (=> (Lecturer c)
        (exists ((x Int))
            (and (lecturer-index x)
                 (= c (id x)))))))
(assert (forall ((x Int) (y Int))
    (=> (and (lecturer-index x) (lecturer-index y) (not (= x y)))
        (not (= (id x) (id y))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-id x) (id x)))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-age x) (age_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-name x) (name_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-email x) (email_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (exists ((c1 Classifier) (c2 Classifier))
            (and (Enrolment c1 c2)
                 (= c1 (id (left x)))
                 (= c2 (id (right x))))))))
(assert (forall ((c1 Classifier) (c2 Classifier))
    (=> (Enrolment c1 c2)
        (exists ((x Int))
            (and (enrolment-index x)
                 (= c1 (id (left x)))
                 (= c2 (id (right x))))))))
(assert (forall ((x Int) (y Int))
    (=> (and (enrolment-index x) (enrolment-index y) (not (= x y)))
        (not (and (= (left x) (left y))
                  (= (right x) (right y)))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-lecturers x) (id (left x))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-students x) (id (right x))))))
; =================================================
;   END CORE
; =================================================

; =================================================
;   VARIABLES
; =================================================
(declare-const caller Classifier)
(assert (Lecturer caller))
; =================================================

; Example #2
; SQL: SELECT NOT EXISTS (SELECT students FROM Enrolment WHERE lecturers = caller)
; sel1 = SELECT NOT EXISTS (SELECT students FROM Enrolment WHERE lecturers = caller)
; expr1 = NOT EXISTS (SELECT students FROM Enrolment WHERE lecturers = caller)
; expr2 = EXISTS (SELECT students FROM Enrolment WHERE lecturers = caller)
; sel2 = SELECT students FROM Enrolment WHERE lecturers = caller
; expr3 = lecturers = caller
; expr4 = caller
; expr5 = lecturers
; expr6 = students
(declare-fun index-sel1 (Int) Bool)
(declare-fun val-sel1-expr1 (Int) BOOL)
(declare-fun val-sel1-expr2 (Int) BOOL)
(declare-fun index-sel2 (Int) Bool)
(declare-fun val-enrolment-expr3 (Int) BOOL)
(declare-fun val-enrolment-expr4 (Int) Classifier)
(declare-fun val-enrolment-expr5 (Int) Classifier)
(declare-fun val-sel2-expr6 (Int) Classifier)

(assert (exists ((x Int))
    (and (index-sel1 x)
         (forall ((y Int))
             (=> (not (= x y)) (not (index-sel1 y)))))))
(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr1 x) TRUE) (= (val-sel1-expr2 x) FALSE)))))
(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr1 x) FALSE) (= (val-sel1-expr2 x) TRUE)))))
(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr1 x) NULL) (= (val-sel1-expr2 x) NULL)))))
(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr2 x) FALSE)
           (not (exists ((y Int)) (index-sel2 y)))))))
(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr2 x) TRUE)
           (exists ((y Int)) (index-sel2 y))))))
(assert (forall ((x Int))
    (= (index-sel2 x)
       (and (enrolment-index x) (= (val-enrolment-expr3 x) TRUE)))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-expr5 x) (val-enrolment-lecturers x)))))
(assert (forall ((x Int))
    (=> (index-sel2 x)
        (= (val-sel2-expr6 x) (val-enrolment-students x)))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (= (val-enrolment-expr3 x) TRUE)
           (and (not (= (val-enrolment-expr5 x) nullClassifier))
                (not (= (val-enrolment-expr4 x) nullClassifier))
                (= (val-enrolment-expr5 x) (val-enrolment-expr4 x)))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (= (val-enrolment-expr3 x) FALSE)
           (and (not (= (val-enrolment-expr5 x) nullClassifier))
                (not (= (val-enrolment-expr4 x) nullClassifier))
                (not (= (val-enrolment-expr5 x) (val-enrolment-expr4 x))))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (= (val-enrolment-expr3 x) NULL)
           (or (= (val-enrolment-expr5 x) nullClassifier)
               (= (val-enrolment-expr4 x) nullClassifier))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-expr4 x) caller))))

; Subgoal C2: Prove that it is the correct implementation of the OCL
; OCL: caller.students->isEmpty()
; This proof is a two fold, this is the first one.
(assert (not (forall ((c Classifier))
                    (and (not (Enrolment caller c))
                         (not (or (= nullClassifier caller)
                                  (= invalidClassifier caller)))))))
(assert (forall ((x Int))
            (=> (index-sel1 x)
                (= (val-sel1-expr1 x) TRUE))))

(check-sat)
