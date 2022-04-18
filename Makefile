TF_DIR_COMMAND=-chdir=terraform/$(TF_DIR)
.PHONY:
upgrade:
	terraform $(TF_DIR_COMMAND) init -upgrade
init:
	terraform $(TF_DIR_COMMAND) init
fmt:
	terraform $(TF_DIR_COMMAND) fmt
validate: fmt
	terraform $(TF_DIR_COMMAND) validate 
workspace:
	terraform $(TF_DIR_COMMAND) workspace new $(ENVIRONMENT) >/dev/null 2>&1 || terraform $(TF_DIR_COMMAND) workspace select $(ENVIRONMENT)
plan: init validate 
	terraform $(TF_DIR_COMMAND) plan 
apply: init validate 
	terraform $(TF_DIR_COMMAND) apply -auto-approve
destroy: init validate 
	terraform $(TF_DIR_COMMAND) destroy -auto-approve