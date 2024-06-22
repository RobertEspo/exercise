This directory has four types of scripts:
	helper = loads dfs/libs/etc. used across multiple scripts.
	model = models generated to predict information.
	predict = predictions that do not use statistical models, only arthimatic.
	viz = visualizations.

00_libs.R
	Helper script to load libs.
01_libs.R
	Helper script to load dfs from Google Sheets.
02_model_partner_weight.R
	Models amount of weight lifted based on partner.
03_viz_most_frequent_partners.R
	Visualization to see how often I go to the gym with each partner.
04_model_time_partner.R
	Models amount of time spent at gym based on partner.
05_model_num_exercises_partner.R
	Models number of exercises completed based on partner.
06_viz_compound_lifts.R
	2D and 3D visualizations for compound lift (squat, deadlift, bench) progression.
07_viz_muscle_group_performance.R
	Scatter/line plot for progression for all exercises. Each muscle group has its own plot.
08_predict_1rm_compound_lifts.R
	Predicts 1RM for compound lifts (squat, deadlift, bench) and generates warm-up sets for 1RM attempt based on the prediction.
09_predict_compound_lifts_prog.R
	Predicts working set weight progression for compound lifts (squat, deadlift, bench).
10_viz_weight_stats.R
	Scatter/line plot for body weight, lean body mass, and muscle mass.
11_viz_protein_scatter_line.R
	Scatter/line plot for daily protein goal/intake.
12_predict_1rm_warm_ups_all_exercises.R
	Predicts 1RM and generates warm-up sets based on the prediction for 1RM attempt for all exercises.