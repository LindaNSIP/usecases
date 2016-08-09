#!/bin/sh

# Optional - "git checkout ." - to cleanup
git pull

# $PWD = `pwd`

pandoc sample/pandoc/test.md -o sample/pandoc/test.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include

pandoc sample/pandoc/daily_attendance.md -o sample/pandoc/daily_attendance.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include


./update_template.sh convert/basic_daily_attendance.md convert/basic_daily_attendance.html
./update_template.sh convert/basic_financial_transactions.md convert/basic_financial_transactions.html 
./update_template.sh convert/enrollment.md convert/enrollment.html 
./update_template.sh convert/gradebook.md convert/gradebook.html
./update_template.sh convert/naplan_registration.md convert/naplan_registration.html 
./update_template.sh convert/timetable.md convert/timetable.html

