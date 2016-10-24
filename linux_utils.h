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
