if [ $# -eq 0 ]; then
  >&2 echo "No files provided."
  exit 1
fi

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

mkdir -p Submissions

jupyter nbconvert --to html $1 --output temp.html

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless \
  --print-to-pdf=Submissions/$filename.pdf \
  --no-pdf-header-footer \
  --run-all-compositor-stages-before-draw \
  --virtual-time-budget=10000 temp.html 

rm temp.html