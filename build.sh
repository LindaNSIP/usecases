
git pull
rm -Rf build
rm -Rf output

# Copy markdown
mkdir -p build
rsync -uvma --include="*/" --include="**.md" docs/* build/
for line in `find docs -name '*.mdx'`; do 
     echo $line
     perl bin/include.pl $line build/; 
done

# Copy resources only
mkdir -p output
rsync -uvma --include="*/" --include="**.pdf" --include="**.png" --include="**.zip" --exclude="*" docs/* output/

for line in `find build -name '*.md'`; do 
	echo $line
	perl bin/process.pl $line
done

git add output
