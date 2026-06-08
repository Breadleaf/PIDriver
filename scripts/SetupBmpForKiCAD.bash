function AssertFileExists {
	if [ ! -f "$1" ]
	then
		echo "$1 does not exist!"
		exit 1
	fi
}

# ensure magick is installed
echo "Checking if magick is installed:"
AssertFileExists "$(command -v magick)"

project_root=$(git rev-parse --show-toplevel)

# ensure the logo file exists
logo_file="$project_root/art/logo.bmp"
echo "Checking if $logo_file exists:"
AssertFileExists $logo_file

# delete existing output file
destination_file="$project_root/art/logo_depth1.bmp"
echo "Removing existing output file if it exists:"
rm $destination_file | true
# create the output file
magick $logo_file -colorspace gray -depth 1 -type truecolor $destination_file
# ensure the file exists
echo "Checking to see if output was generated:"
AssertFileExists $destination_file

echo "Script successfully finished!"
