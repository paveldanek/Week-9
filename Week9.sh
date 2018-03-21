#! /bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RESET='\033[0m'

cd ~
clear
echo "Hello World!"
printf ">"
read
mkdir ~/DANGER
touch aaa
for i in {0..100}
do
echo "$i. Hello World" >> aaa
done
echo -e "${BLUE}Created a file named aaa, containing 100x Hello World.${RESET}"
ls -l
echo -e "${YELLOW}HIT ENTER${RESET}"
read
cd DANGER
mv ../aaa .
echo -e "${BLUE}Now printing its every line containing '1'.${RESET}"
cat aaa | grep "1"
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo -e "${BLUE}Now printing its every line containing '2',"
echo -e "with reverse numerical sorting.${RESET}"
cat aaa | grep "2" | sort -n -r
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo -e "${BLUE}Three lines from its HEAD."
head -3 aaa
echo -e "${GREEN}And three from its TAIL."
tail -3 aaa
echo ""
echo -e "${BLUE}The type of file aaa represents:${RESET}"
file aaa
echo ""
rm aaa
cd ..
rmdir DANGER
echo -e "${BLUE}The PATH your computer searches for executables:${RESET}"
echo "PATH=$PATH"
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo -e "${BLUE}Creating a file mega.img, 1MB large.${RESET}"
touch mega.img
dd if=/dev/zero of=~/mega.img bs=1M count=1
sudo fdisk -l ./mega.img
echo ""
echo -e "${BLUE}Now we'll partition the file mega.img with fdisk. It will prompt"
echo -e "you for options. You choose these in THIS order: ${RED}o-n-4xENTER-w"
echo -e "${YELLOW}HIT ENTER${RESET}"
read
sudo fdisk ./mega.img
echo -e "${BLUE}Showing a partitioned file:${RESET}"
sudo fdisk -l ./mega.img
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo -e "${BLUE}Creating a file system: Choose ${RED}'y'${BLUE} when prompted.${RESET}"
sudo mkfs.ext2 ./mega.img
sudo mkdir mymnt
echo -e "${BLUE}Mounting mymnt as a filesystem:${RESET}"
sudo mount mega.img mymnt/
echo -e "${BLUE}Existing Block Devices.${RESET}"
lsblk
echo -e "${YELLOW}HIT ENTER${RESET}"
read
df -h
echo ""
echo -e "${BLUE}Contents of mymnt${RESET}"
ls ./mymnt
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo -e "${BLUE}Creating attempt.txt with a message ${GREEN}Pavel's Attempt${RESET}"
echo -e "${YELLOW}HIT ENTER${RESET}"
read
echo "Pavel's Attempt" > attempt.txt
sudo mv attempt.txt ./mymnt
cd mymnt
echo -e "${BLUE}Updated contents of mymnt${RESET}"
ls
echo -e "${YELLOW}HIT ENTER${RESET}"
read
cd ..
echo -e "${BLUE}We'll unmount the mymnt filesystem;"
echo -e "${RED}please enter its path:${RESET}"
read MyPATH
sudo umount $MyPATH
hexdump -C mega.img | less
echo -e "${YELLOW}HIT ENTER${RESET}"
read
sudo rmdir mymnt
rm mega.img
touch a                         # Writing the run-level report into a file a.
who -r > a
declare -i b=0                  # Setting a word iterator.
for word in $(<a); do           # Parsing through all words in file a.
    if [ $b -eq 1 ]; then       # We know that 2nd word (word number 1) is the
                                # run-level number.
        c=$word                 # We record it in variable c.
    fi
    b=b+1
done
rm a                            # Removing file a.
echo ""
echo -e "${BLUE}By the way, your computer is utilizing the run-level number ${RED}$c${BLUE}.${RESET}"
echo ""
cd ~
echo -e "${BLUE}Now we'll create a unit named ${GREEN}test1.target ${BLUE}and ${GREEN}test2.target ${BLUE}with dependency"
echo -e "on ${GREEN}test1.target${BLUE}.${RESET}"
touch test1.target
touch test2.target
echo "[Unit]" >> test1.target
echo "Description=test 1" >> test1.target
echo "[Unit]" >> test2.target
echo "Description=test 2" >> test2.target
echo "Wants=test1.target" >> test2.target
sudo mv test?.target /etc/systemd/system/
systemctl status test1.target test2.target
echo -e "${BLUE}They're here, but not active. We'll activate ${GREEN}test2.target ${BLUE}and verify they are"
echo -e "${RED}both${BLUE} active.${RESET}"
echo -e "${YELLOW}HIT ENTER${RESET}"
read
# Activating JUST test2, but thanks to the dependency, test1 gets activated as well:
systemctl start test2.target

systemctl status test1.target test2.target
echo -e "${BLUE}They're active now. We'll finish the process, de-activate them and delete them."
echo -e "${YELLOW}HIT ENTER${RESET}"
read
systemctl stop test1.target test2.target
systemctl disable test1.target test2.target
cd /etc/systemd/system/
sudo rm test1.target test2.target
cd ~
echo ""
echo -e "${RED}T${GREEN}H${YELLOW}A${BLUE}N${RESET}K ${RED}Y${GREEN}O${YELLOW}U${BLUE}!${RESET}"
echo ""

