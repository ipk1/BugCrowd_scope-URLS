for ((i=0; i<=300; i+=25))
do
 curl 'https://bugcrowd.com/programs.json?sort[]=invited-desc&sort[]=promoted-desc&hidden[]=false&offset[]='$i'' -H 'cookie: _crowdcontrol_session=<<token>>' --compressed | jq -r '. | .programs[] | select (.invited_status=="accepted")  | select (.participation=="private") | .program_url ' >> Private.txt
 done

#plublic program
 for ((i=0; i<=300; i+=25)); do curl 'https://bugcrowd.com/programs.json?sort[]=invited-desc&sort[]=promoted-desc&hidden[]=false&offset[]='$i'' | jq -r '. | .programs[] | select (.participation=="public") | .program_url ' >> Public.txt

done

paste Private.txt | while read if
#gets URLS
do
curl 'https://bugcrowd.com/'$if'' -H 'cookie: _crowdcontrol_session=<<token>>'  --compressed | pup 'title' | grep -v '<' >>  PrivatePrograms.txt



curl 'https://bugcrowd.com/'$if'' -H 'cookie: _crowdcontrol_session=<<token>>'  --compressed | pup 'div#user-guides__bounty-brief__targets-table' | pup 'code' | grep -v '<' >> PrivatePrograms.txt

done
paste Public.txt | while read of
do



curl 'https://bugcrowd.com/'$of'' --compressed | pup 'h1[class="bc-panel__title"]' | grep -v '<' >> PublicPrograms.txt

curl 'https://bugcrowd.com/'$of'' --compressed | pup 'div#user-guides__bounty-brief__targets-table' | pup 'code' | grep -v '<'  >>  PublicPrograms.txt



done
