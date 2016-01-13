; Exercise 2.13. Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors. You may simplify the problem by assuming that all numbers are positive.

; Suppose we have intervals I_1 = (a, b) and I_2 = (c, d).
; Further, suppose we have percentages p_1 and p_2.
; So PI_1 = (a - ap_1, b - bp_1), and PI_2 = (c - cp_2, d - dp_2).
; Further, for simplicity assume that a < b < c < d.
; So the product PI_1 * PI_2 is the interval (ac - acp_2 - ap_1c + acp_1p_2, bd - bdp_2 - bp_1d + bdp_1p_2)
; Simplified, ( (ac)[1 - p_2 - p_1 + p_1p_2]], (bd)[1 - p_2 - p_1 + p_1p_2] )
; If we set p = 1 - p_2 - p_1 + p_1p_2, then the interval becomes (acp, bdp)
; So, p is the new percentage tolerance of the products.
