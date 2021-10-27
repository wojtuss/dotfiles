#!/bin/bash

if [ "$1" == "" ]; then
	echo "Usage: split.sh <mp3_file> <cue_file>"
	exit 0
fi

mp3_file="$(realpath "$1")"
cue_file="$(realpath "$2")"
dir_name="$(dirname "$mp3_file")"
base_name="$(basename "$mp3_file")"
temp_dir="${dir_name}/split_chapters"
out_dir="${dir_name}/split"

echo "mp3_file: ${mp3_file}"
echo "cue_file: ${cue_file}"
echo "dir_name: ${dir_name}"
echo "base_name: ${base_name}"
echo "temp_dir: ${temp_dir}"
echo "out_dir: ${out_dir}"

mp3splt \
	-c "${cue_file}" \
	-d "${temp_dir}" \
	-o "@t" \
	-q \
	"${mp3_file}"

for FILE in "${temp_dir}"; do
	mp3splt \
		-d "${out_dir}" \
		-o "@f-@n" \
		-t "1.0" \
		-q \
		"$FILE"
done

rm -r "${temp_dir}"

