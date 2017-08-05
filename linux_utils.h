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
