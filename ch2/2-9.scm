; Exercise 2.9. The width of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.

; Suppose we have intervals I_1 = (a, b) and I_2 = (c, d),
; with W_(I_1) = (b - a)/2 and W_(I_2) = (d - c)/2

; For addition:
; (add-interval I_1 I_2) = (a + c, b + d) => Width = (b + d - a - c)/2 = W_(I_1) + W_(I_2)
; Similar reasoning can be used for sub-interval

; For multiplication:
; Given (mul-interval I_1 I_2), assume a < b < c < d. We have that p1 is min, and p4 is max, so:
; I = (a * c, b * d) => Width = (bd - ac)/2 which is different from W_(I_1) + W_(I_2)
; Similar reasoning can be used for division
