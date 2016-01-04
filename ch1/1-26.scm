; Exercise 1.26. Louis Reasoner is having great difficulty doing exercise 1.24. His fast-prime? test seems to run more slowly than his prime? test. Louis calls his friend Eva Lu Ator over to help. When they examine Louis’s code, they find that he has rewritten the expmod procedure to use an explicit multiplication, rather than calling square:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
 
; Q: "I don’t see what difference that could make," says Louis. "I do." says Eva. "By writing the procedure like that, you have transformed the O(log(n)) process into a O(n) process." Explain.

; The reason for this is that (expmod base (/ exp 2) m) is evaluated twice on each call.
; For the previous version, we had the recurrence relation: T_n = T_(n/2) + k
; So, solving exp/2^k = 1 for k, i.e. how many 2s do we need to divide from exp to get to the base case 1
; We get that k = log(exp) - logarithmic complexity

; In this case now, we have, for each call we divide the problem size by 2,
; but work twice on the divided size by 2. Assuming k is the number of 2s we divided, we have
; the following recurrence relation: T_n = 2T_(n/2) + k

; T_8 = 2T_4 + k = 2(2(2T_1 + k) + k) + k = 2(4T_1 + k) + k = 8T_1 + 2k
; T_4 = 2T_2 + k
; T_2 = 2T_1 + k

; This relation has closed form of 2^log(exp) * log(exp) = exp log(exp)

; So, solving exp/(2^k * k) = 1 for k, i.e. how many 2s do we need to divide from exp to get to the base
; case 1, and also multiply that work by k
; exp / 2^k       - divide the problem size by 2
; exp / (2^k * k) - multiply the work to be done
; exp = 2^k * k => exp = k(log(2) + 1) => k = exp
