#!/bin/bash

if [ "$1" == "" ]; then
	echo "Usage: split.sh <mp3_file> [cue_file]"
	exit 0
fi

mp3_file="$(realpath "$1")"
dir_name="$(dirname "$mp3_file")"
base_name="$(basename "$mp3_file")"
out_dir="${dir_name}/split"

echo "mp3_file: ${mp3_file}"
echo "dir_name: ${dir_name}"
echo "base_name: ${base_name}"
echo "out_dir: ${out_dir}"

if [ "$2" == "" ]; then
	mp3splt \
		-d "${out_dir}_1m" \
		-o "@f-@n" \
		-t "1.0" \
		-q \
		"${mp3_file}"
else
	cue_file="$(realpath "$2")"
	temp_dir="${dir_name}/split_chapters"
	echo "cue_file: ${cue_file}"
	echo "temp_dir: ${temp_dir}"

	mp3splt \
		-c "${cue_file}" \
		-d "${temp_dir}" \
		-o "@n3-@t" \
		-q \
		"${mp3_file}"

	for FILE in "${temp_dir}"; do
		mp3splt \
			-d "${out_dir}" \
			-o "@f-@n3" \
			-t "1.0" \
			-q \
			"$FILE"
	done
	rm -r "${temp_dir}"
fi


