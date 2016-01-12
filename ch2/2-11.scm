; Exercise 2.11. In passing, Ben also cryptically comments: ‘‘By testing the signs of the endpoints of the intervals, it is possible to break mul-interval into nine cases, only one of which requires more than two multiplications.’’ Rewrite this procedure using Ben’s suggestion.

; Given P_1 = (a, b), P_2 = (c, d), and b > a, c > d, we have the following valid intervals:
; P_(1_1). b > a > 0
; P_(1_2). 0 > b > a
; P_(1_3). b > 0 > a
; P_(2_1). c > d > 0
; P_(2_2). c > 0 > d
; P_(2_3). 0 > c > d

; Thus, the following valid combinations:
; P_(1_1) and P_(2_1)
; P_(1_1) and P_(2_2)
; P_(1_1) and P_(2_3)
; P_(1_2) and P_(2_1)
; P_(1_2) and P_(2_2)
; P_(1_2) and P_(2_3)
; P_(1_3) and P_(2_1)
; P_(1_3) and P_(2_2)
; P_(1_3) and P_(2_3)

; Given P_(1_1) and P_(2_1), we already know that b > a > 0 and c > d > 0, and we can calculate max and min directly.
; i.e. make-interval (a * d, b * c).
; With similar reasoning, other intervals can be deduced.
