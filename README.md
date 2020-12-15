# ToeInKAMReduction
Dataset and code for lasso regression model that identifies kinematic changes related to reductions in the knee adduction moment when adopting a toe-in gait modification. Uses selectiveInference package to compute p-values on the selected features. Further description is available in the following manuscript: .

## Dataset description
One hundred seven individuals with medial knee osteoarthritis walked naturally and with 10° toe-in. The features in the X_TIdiff represent the difference in a kinematic variable from natural to toe-in walking. Details on how these covariates were computed can be found in the manuscript. y_TIP1diff is each subject's change in average the first peak knee adduction moment (KAM) from natural to toe-in walking. A reduction from natural walking is considered positive. 

Feature order in X_TIdiff matrix:
1) trunk sway angle (max during stance)
2) knee flexion angle (at time of first peak KAM)
3) pelvic list angle (at time of first peak KAM)
4) knee adduction angle (at time of first peak KAM)
5) step width
6) medio-lateral center of pressure position in foot frame (time of first peak KAM)
7) anterior-posterior center of pressure position in foot frame (time of first peak KAM)
8) frontal-plane tibia angle (time of first peak KAM)
9) foot progression angle
10) medio-lateral distance between centers of pressure over consecutive steps (time of first peak KAM)
11) medio-lateral distance between knee joint centers over consecutive steps (time of first peak KAM)
12) pelvic rotation angle (time of first peak KAM)

## Running code
Download lassoRegression.r and the two csv files. Change working directory in code.
