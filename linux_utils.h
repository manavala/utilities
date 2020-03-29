#Terminal shotcuts
1. To Switch between tabs
Ctrl+Page Down (forward) and Ctrl+Page Up (backward).

2. To Switch between tabs
alt+tab number (for Linux with gnome)

Others
Ctrl+L  - Clear
Up - Previous command in descending order = CTRL+p
Down- Reverse after Up key = CTRL+n
Ctrl+R - Search Previous command
Ctrl+J It end the CTRL+r search
Ctrl+G It abort the search by CTRL+r
Ctrl+B Move cursor one character to the left side
Ctrl+F Move cursor one character to the right side
Ctrl+A Move cursor to start of the line = HOME
Ctrl+E Move cursor to end of the line = END
CTRL+ RIGHT ARROW Move cursor one word right hand side
CTRL + RIGHT ARROW Move cursor one word left hand side
Ctrl+U It cut everything from the line start to cursor
Ctrl+K It cut everything from the cursor to end of the line
Ctrl+W It cut the current word before the cursor
Ctrl+Y It paste the previous cut text
CTRL+SHIFT+c To copy selected text
CTRL+SHIFT+v To paste you last copied by CTRL+SHIFT+c
SHIFT + INSERT Copy selected text to clipboard and paste from the clipboard
CTRL+z - kill
Ctrl + T It swap the last two characters before the cursor
Esc + T It swap the last two words before the cursor
Ctrl + D = exit

#To split single line into multiles after n characters
fold -w20 infile.txt > out_file
sed -e "s/.\{20\}/&\n/g" < temp.txt
awk '$0=RT' RS='.{,20}' infile.txt > out_file

#To split single line into multiles lines using delimiter ":"
tr : \\n
sed 's/:/\n/g'
awk '{ gsub(":", "\n") } 1'
while IFS=: read -ra line; do printf '%s\n' "${line[@]}"; done
grep -o '[^:]\+'
awk -v RS='[:\n]' 1
cut -d: --output-delimiter=$'\n' -f1-


#bash time in command prompt
export TZ=Asia/Calcutta #for IST # For others "ls /usr/share/zoneinfo/Asia/"
export PS1="\$(date +%I:%M:%S%p) \W]$"

#To display in top right cornor of the terminal
while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-11));echo -e "\e[31m`date +%r`\e[39m";tput rc;done &

#For error "Cannot remove Device busy"
lsof +D /path/
kill -9 pid


#get number of cores
nproc # returns only cpu count
lspcu # resturs minimal info
cat /proc/cpuinfo #explins about each cores

#get mem info
free -m(in MB) -g(in GB)
cat /proc/meminfo #explains available mem
sudo dmidecode --type memory #From DMI

#Find and delete files
find . -name ".svn" -exec rm -r "{}" \;
find . -name ".svn" -type d -exec rm -r "{}" \; #delete only directories
find . -name ".svn" -type d -empty -delete #delete if it is empty

#Get memory map
/proc/iomem
/proc/opports
/proc/vmallocinfo


#To fix the default editor for the bash terminal
select-editor
or export EDITOR="vim"
set EDITOR "vim"

#Command line mode
export PS1='\W]\$ '

  
#Terminal title
PROMPT_COMMAND='echo -ne "\033]0; $USER@$HOSTNAME  ${PWD/}\007"'
 
#To return chmod of a file 
stat --format '%a' $filename

#to remove swap files
find ./ -type f -name "\.*sw[klmnop]" -delete

#to remove duplicate lines in output
uniq

## append this line after the command in terminal to notify task complete
notify-send "task completed"

#to change rows to col
xargs
tr '\n' ' '


#to install pip
1. Download from https://bootstrap.pypa.io/get-pip.py
2. python get-pip.py
3. pip install udemy-dl

#(if instalation not succeded)
pip install -U git+https://github.com/smeggingsmegger/udemy-dl.git@master

#if not working/ or to update
pip install --upgrade udemy-dl



### vcs illegal option
cd /bin
sudo rm sh
##sudo ln -s dash sh ## to get back
sudo ln -s bash /bin/sh ## to remove the error


##
cut -d ',' -f3,5,6 ## to get the column 3,5,6 from csv
cut -d ',' -f3-6 ## to get range of columns from 3 to 6
cut -d ',' --complement -f3,-6 ## inverse ##replace the delimited //// --output-delimiter='#'  ///// ??  
  ///sed 's/,/#/g' seems this is good right instead of the delimiter?
awk -v x=3 '{print (NR%x?c+1:++c), $0}'  ## append 1 for 3 lines , then 2 for next three lines and go on
awk 'NR%3==0' ## print last line of each 3rd line
sed -n 1~3p ## print first line of each 3rd line, always some making duplicates like this --> sed -n '3,${p;n;n;}'
  
  ## get all commands for all users
  COMMANDS=`echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
        -executable -type f -printf '%P\n'`
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u
   ## for bash users
 compgen -c will list all the commands you could run.
compgen -a will list all the aliases you could run.
compgen -b will list all the built-ins you could run.
compgen -k will list all the keywords you could run.
compgen -A function will list all the functions you could run.
compgen -A function -abck will list all the above in one go.

    
####
cat & tac are reverse in functionally too

###########Uncomment the following lines, by removing the # in the beginning of the lines:
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi


#Buffer method of arranging lines
awk '{a[NR]=$0}END{print a[1];print a[NR];for(i=2;i<NR;i++){print a[i]}}'
#swap two cols
awk ' { t = $1; $1 = $2; $2 = t; print; } '
## use back to back commands
awk 'END{print}; ( ( $1 < 129 && $2 < 500) || ( $1 > 128 && $2 > 500 && $2 < 2000 ) ) '
##

  
 #Ghost script to reduce the pdf size
 gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook     -dNOPAUSE -dQUIET -dBATCH \
 -dDetectDuplicateImages     -dCompressFonts=true -r150 -sOutputFile=out.pdf in.pdf
 -dPDFSETTINGS=/screen lower quality, smaller size.
-dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs.
-dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting
-dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting
-dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly \
at the expense of a larger output file

## merge /join 2 half into 1 full size eg: a5+a5=a4 , horizontal
pdfjam a5_1.pdf a5_2.pdf  --nup 1x2  --outfile a4.pdf
#vertical next to next
pdfjam Page1.pdf Page2.pdf --nup 2x1 --landscape --outfile Page1+2.pdf

#rotate and save the pdf
pdftk temp1.pdf cat 1-endnorth output 1.pdf;
#north (rotation)-> south,east,west,right,left,down

#resize to a4
> pdfinfo in.pdf 
> pdfjam --outfile out.pdf --paper a4paper in.pdf
> pdfinfo out.pdf 


#Color to grey pdf

gs \
 -sOutputFile=output.pdf \
 -sDEVICE=pdfwrite \
 -sColorConversionStrategy=Gray \
 -dProcessColorModel=/DeviceGray \
 -dCompatibilityLevel=1.4 \
 -dNOPAUSE \
 -dBATCH \
 input.pdf

#download mp4 format youtube
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' url


#to replace the pages
pdftk A=new.pdf B=3.pdf C=11.pdf D=14.pdf cat A1-2 B1 A4-10 C1 A12-13 D1 A15-20 output out.pdf
#portrait to landscape
pdftk out.pdf cat 1-endnorth output lat.pdf
#split the pages
for i in {1..20}; do pdftk lat.pdf cat $i output ${i}.pdf; done
#two a5 into a4
for i in {0..9}; do j=$((i*2+1)); k=$((i*2+2)); l=$((i+1)); pdfjam $j.pdf $k.pdf --nup 1x2 --outfile lat_${l}.pdf  ; done
ls lat_*.pdf
#final
pdftk lat_1.pdf  lat_2.pdf  lat_3.pdf  lat_4.pdf  lat_5.pdf  lat_6.pdf  lat_7.pdf  lat_8.pdf  lat_9.pdf lat_10.pdf output merged.pdf


# download mp3 from youtube
youtube-dl -x -f bestaudio --audio-quality 0 --audio-format mp3 -k https://www.youtube.com/watch?v=
# download playlist
youtube-dl -i -f mp4 --yes-playlist https://www.youtube.com....  playlist_url
or
youtube-dl -i PLwJ2VKmefmx...playlist_ID
#best mp4
by default it picks up the latest


#if xrandr -s 1920x1080 is not working
xrandr --output DVI-0 --mode 1920x1080

#in bash, remove duplicate lines without sort
awk '!x[$0]++'

pipe alias output
alias lm 'ls -l \!* | more
