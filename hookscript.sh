#!/bin/bash

if ! [ -t 0 ]; then
        read -a ref
fi


#IFS='/' read -ra REF <<< "${ref[2]}"
#branch="${REF[2]}"

branch="$(git rev-parse --abbrev-ref HEAD)"

echo $branch

if [ $branch == "master" ]; then
        crumb=$(curl -u "Admin:ADmin" -s 'http://localhost:5555/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
        curl -I -X POST http://Admin:112a6cc4d6bcea3a06b1610c4a27ed736f@localhost:5555/job/test%20project/build -H "Jenkins-Crumb:ac58d07e03b97e6cb690aaddc30a023bb37e6787ea6ad9aa01e9c01579674e0a"
        if [ $? -eq 0 ]; then
                echo "*** Ok"
        else
                echo "*** Error"
        fi

fi
