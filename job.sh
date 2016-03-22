#!bin/bash
#version 1.0
#Date 2015 06 23
#Function manual process these batch file to  repalace oubound job in ut23
#Email goudcheng@ncsi.com.cn
#for jobid  OPOBND631O,OPOBND107O, OPOBND505O
currentTime=`date "+%Y%m%d%H%M"`  
File631="datasim"
File107="peg"
File505="Hipeg"
PathBackup=/backup
PathBase=
#Path505=/woodpecker_hme/lzhedea/dingcheng/test631
Path631=/OPIBIWO12/
Path107=/OPIBIWO03/
Path505=/OPIIWA101O/
Job631O=OPOBND631O
Job107O=OPOBND107O
Job505O=OPOBND505O
echo "##########################NOTE#############################"
echo "##\033[36m The File will backup tobackup\033[0m                        ###"
echo "#######################\033[31mOPOBND631O\033[0m#########################"
echo "#######################\033[31mOPOBND107O\033[0m#########################"
echo "#######################\033[31mOPOBND505O\033[0m#########################"

echo "\033[33m Please input Outbound job  name \033[0m"
read  jobname
echo "\033[33m Please input EmailAddress \033[0m"
read  email
SendEmail(){
#uuencode "file.zip" "file.zip" |mailx -s uatsupport goudcheng@ncsi.com.cn
 uuencode "file.zip" "file.zip" |mailx -s uatsupport $email
}
func631(){
cd $Path631
#judge the file 
if   `ls *OPIPDS101O*  2> /dev/null` 
		then
		echo "1223456"
		    cd $PathBase
			mkdir Tempfolder 
			cd $Path631
			cp *  $PathBase/Tempfolder
			cd $PathBase/Tempfolder
			echo "The job is processing these file "
		else 
		    echo "Note :please put file to folder $Path631 before run this job "
			exit 1
	fi 
 
#c file rename rej
echo "+++++++++++++++++++++++++++++++++++++++++++"
for f in `ls filec*`
do
echo "process c file rename to $File631$currentTime.rej "
cp $f $PathBackup
mv $f  "$File631$currentTime.rej"

done

#e file rename suc
for f in `ls filee*`
do
echo "process e file rename to $File631$currentTime.suc "
cp $f $PathBackup
mv $f  "$File631$currentTime.suc"

done

#f file rename err
for f in `ls filef*`
do
echo "process f  file rename to $File631$currentTime.err "
cp $f $PathBackup
mv $f  "$File631$currentTime.err"

done
#g file rename sum

for f in `ls fileg*`
do
echo "process g  file rename to $File631$currentTime.sum  "

cp $f $PathBackup
mv $f  "$File631$currentTime.sum"

done
echo "ready to zip file "
zip -r file.zip .

SendEmail


cd $PathBase
rm -rf Tempfolder


}
func107(){
cd $Path107
echo "$Path107"
   if  `-e `ls *filec*``  
		then
		    cd $PathBase
			mkdir Tempfolder 
			cd $Path107
			cp *  $PathBase/Tempfolder
			cd $PathBase/Tempfolder
			echo "The job is processing these file "
		else 
		    echo "Note :please put file to folder $Path107 before run this job "
			exit 1
	fi 

#c file rename rej
for f in `ls filec*`
do
echo "process c file rename to $File107$currentTime.rej "
cp $f $PathBackup
echo "$File107$currentTime.rej"
mv $f  "$File107$currentTime.rej"
done


#e file rename suc
for f in `ls filee*`
do
echo "process e file rename to $File107$currentTime.suc  "
cp $f $PathBackup
echo "$File107$currentTime.suc"
mv $f  "$File107$currentTime.suc"
done
#e file rename suc
for f in `ls filef*`
do
echo "process f file rename to $File107$currentTime.err  "
cp $f $PathBackup
echo "$File107$currentTime.err"
mv $f  "$File107$currentTime.err"
done

#g file rename sum
for f in `ls fileg*`
do
echo "process g file rename to $File107$currentTime.sum  "
cp $f $PathBackup
echo "$File107$currentTime.sum"
mv $f  "$File107$currentTime.sum"
done

echo "ready to zip file "
zip -r file.zip .

SendEmail


cd $PathBase
rm -rf Tempfolder

}
func505(){
cd $Path505
echo "$Path505s"
	if   `-e `ls *filec*``  
		then
		    cd $PathBase
			mkdir Tempfolder 
			cd $Path505
			cp *  $PathBase/Tempfolder
			cd $PathBase/Tempfolder
			echo "The job is processing these file "
		else 
		    echo "Note :please put file to folder $Path107 before run this job "
			exit 1
	fi 

#c file rename rej
for f in `ls filec*`
do
echo "process c file rename to $$currentTime.rej "
cp $f $PathBackup
echo "$File505$currentTime.rej"
mv $f  "$File505$currentTime.rej"
done

#e file rename suc
for f in `ls filee*`
do
echo "process e file rename to $File505$currentTime.suc "
cp $f $PathBackup
echo "$File505$currentTime.suc"
mv $f  "$File505$currentTime.suc"
done

#f file rename suc
for f in `ls filef*`
do
echo "process f file rename to $File505$currentTime.err "
cp $f $PathBackup
echo "$File505$currentTime.err"
mv $f  "$File505$currentTime.err"
done

for f in `ls fileg*`
do
echo "process g file rename to $File505$currentTime.err "
cp $f $PathBackup
echo "$File505$currentTime.sum"
mv $f  "$File505$currentTime.sum"
done
echo "ready to zip file "
zip -r file.zip .

SendEmail


cd $PathBase
rm -rf Tempfolder


}

if [ "$jobname" =  "$Job631O"  ] ||[ "$jobname" =  "$Job107O"  ] || [ "$jobname" =  "$Job505O" ]
 then
	if [ "$jobname" =  "$Job631O"  ]
		then
			func631
	fi 
	if [ "$jobname" =  "$Job107O"  ]
		then
			func107
	fi 
	if [ "$jobname" =  "$Job505O"  ]
		then
			func505
	fi 
	
else
     echo "Please input $Job631O,$Job107O,$Job505O"
fi
