#!/bin/sh

sandbox_schema="dbt_derrick"
main_branch="main"

function get_repo_dir () {
	echo `git rev-parse --show-toplevel`
}

function update_latest_artifacts () {
	echo updating latest artifacts for deferred builds
	(
		cd `git rev-parse --show-toplevel`
		cd ..
		python ~/git/collect_latest_artifacts.py
	)
}

function get_all_modified_models () {
	git diff $main_branch.. --name-only \
	| grep -E "\.sql$" \
	| sed -e "s/.*\///g; s/\.sql//g;" 
}

function get_model_path () {
	models_dir=$(get_repo_dir)/models

	find $models_dir -type f -iname "*$1*" \
	| head -n 1
}

function get_parent_models () {
	model_path=$(get_model_path $1)
	grep "ref(" $model_path \
	| sed -n "s/.*ref('\(.*\)').*/\1/p"
}

function drop_sandbox_table () {
	echo "drop table if exists sandbox.$sandbox_schema.$1;"
}

function dbt_defer_build () {
	$(update_latest_artifacts)

	for parent in `echo $(get_parent_models $modified_model)`; do
		echo $(drop_sandbox_table $parent)
	done

	dbt build --defer --state latest_artifacts -s $1
}

function dbt_defer_build_all_modified () {
	$(update_latest_artifacts)

	all_modified_models=`$(get_all_modified_models)`

	for modified_model in `echo $(all_modified_models)`; do
		echo
		echo $modified_model:
		for parent in `echo $(get_parent_models $modified_model)`; do
			echo $(drop_sandbox_table $parent)
		done
	done

	dbt_defer_build $(all_modified_models | tr '\n' ' ')
}

`$(update_latest_artifacts)`
