#!/bin/sh

# Optional - "git checkout ." - to cleanup
git pull

# $PWD = `pwd`

pandoc sample/pandoc/test.md -o sample/pandoc/test.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include

pandoc sample/pandoc/daily_attendance.md -o sample/pandoc/daily_attendance.html --template sample/pandoc/standalone.html --toc --toc-depth=2 --filter pandoc-include


./update_template.sh basic_daily_attendance.md basic_daily_attendance.html
./update_template.sh basic_financial_transactions.md basic_financial_transactions.html 
./update_template.sh enrollment.md enrollment.html 
./update_template.sh gradebook.md gradebook.html
./update_template.sh naplan_registration.md naplan_registration.html 
./update_template.sh timetable.md timetable.html

