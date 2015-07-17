# ccc_helper
This is a helper script written in Bash intended to organize one's Canadian
Computing Competitoin practice files

## License
GNU GENERAL PUBLIC LICENSE Version 3

## Usage
Note: It is recommended to resolve the dependencies first.  
Open the terminal and enter the following commands
* $ git clone https://github.com/lorix-lpan/ccc_helper
* $ cd ccc_helper
* $ bash create.sh

#### **Warning**
This program is currently in **Beta**. It has not been tested on any Linux
distribution other than Arch Linux.

### Dependencies
This program was written with the philosophy of portability in mind. Since each
distribution has its unique package manager, this script does not have automatic
dependency resolution. Hence, they have to be resolved manually by the user.

This script requires **wget** and **unzip**

## Description
Firstly, it is important to point out that this helper is **unofficial**

This Shellscript was originally wriiten in order to organize my ccc practice
file. 

If you have any difficulties concerning this script, please contact the
author: 

* *Fei "Lawrence" Pan* lawrence_pan@hot-shot.com

## The Canadian Computing Competition
The Canadian Computing Competition is called CCC for short. It is an annual
event with two divisions, senior and junior. Each division has five questions.
Similar to every other competitions, the only way to succeed is to have certain 
amount of practice. Since all of the past contests are posted on the official 
website, taking a past contest is a good way to get ready for this event.

###### Visit the official CCC site for more information
https://cemc.math.uwaterloo.ca/contests/computing.html

###### Past contests
https://cemc.math.uwaterloo.ca/contests/past_contests.html#ccc

## Functions and behaviours
As for the current version, the program has two main functions, organizing
your practice files and downloading the test case data from the CCC's web server.

#### 1. Organizing your files

######Behaviours
The program starts with getting its required data from the user. After successfully getting 
all of the valid inputs, it will create **~/workspaces/ccc/** directory and use 
it as the **root** directory. Thereafter, according to the **year**(A four digit
number), **language**(a letter either p or c where p stands for python and c stands 
for c++), **level** (senior or junior), question **number**
(a number from 1 to 5) and question **name**(A non-empty string) input by the user, the program will
create a nested directory within the ccc root. In addition to this, a file with the extension of
your language chosen will be created as well.

######Example input:
* year=2012
* language=c
* level=s
* number=1
* question_name="foo"
* file_name="bar"

As a result, the following will be created
  **~/workspaces/ccc/2012/cplusplus/Senior/1.foo/bar.cpp**

######Note
This program is written intended to be used repetitively. In other words, it
should be executed each time when you start working on a new question. In order to
avoid naming conflicts between questions/files, it is mandatory for the user to
input a custom question(directory) name and a file name as shown in the previous
example. Inputing the same question_names and file_names twice is **dangerous**.

#### 2. Fetching test case data

######Note
This function only supports years 2004-2015

######Brief Introduction
The program was written originally with the purpose of organizing one's ccc
files. However, it was almost instantly discovered that the test case data is necessary when solving
a question. On the official ccc site, the test data is zipped into one single
file. As one continues to solve questions, he soon can realize that it is a
tedious process to download, unzip and copy the necessary test files to his
question directory. 

######Behaviours
As an optional function of this program, it comes in at last. The only thing
required for the user to do is to decide to fetch the data from CCC's web server by inputing y or
n. If y is chosen, the following process will be triggered:

1. Create a temporary directory named data-RANDOME at /home/$USER where
  RANDOM is a variable contains the value of a random integer.

  Example directory created: /home/lawrence/data-1234

2. Download the zip file(UNIX_OR_MAC.zip or data.zip) from the official website

3. Unzip the file and identify the directory required. Then copy the data to the
  directory created by the previous function mentioned.

4. Delete the temporary directory recursively

######Example
Considering the following data obtained from the *organizing file* function

* year=2012
* language=c
* level=s
* number=1
* question_name="foo"
* file_name="bar"

The program will download and unzip the test data zip file of the year 2012 from CCC's
web server. Then, since the level is Senior and the number is 1, the script will
automatically find the directory with corresponding name which in this case will
be S1(or s1 depending on the year). Lastly, the script will copy all of files
excluding directories inside the chosen folder to the destination which is the
route created by the previous action. In this case, the destination will be 

**~/workspaces/ccc/2012/cplusplus/Senior/1.foo/**

###Conclusion
Overall, it can be considered as a simple program. The development process takes
less than 3 hours. However, due to the naming inconsistency of the official CCC
site, various problems had to be dealt with during the development process.

#####Challenges
1. The route of the zip file is not consistent. As for the *extracting data*
   function, since the data file is planned to be downloaded directly via HTTP, a
   route to the file is required. However, it was soon discovered that from
   2009-present, the name of the zip file is different from the one before
   2008 . In addition to this, the route changes as the year increases as well.

   This was solved by using a simple conditional statement.

2. The layout of the test data in the folder extracted is EXTREMELY inconsistent
   as well. First of all, the name of the directory extracted changes literally
   from year to year. Also, depending on the year, the test data files can be
   placed in one single parent directory or placed seperately according to its
   level(Seinor/Junior). As for certain years, the zip file includes test case
   files for both Unix and Windows which are required to be distinguished.

   This was solved by using the Unix *find* and *grep* utilities with a loop.
