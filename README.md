# ccc_helper
This is a helper script written in Bash intended to organize one's Canadian
Computing Competitoin practice files

#### **Warning**
This program is currently in Beta. It has not been tested on any other Linux
distributions other than Arch Linux

### Dependencies
This program was written with the philosophy of portability in mind. Since each
distribution has its unique package manager, this script does not have automatic
dependency resolution. Hence, they have to be resolved manualy by the user.

This script requires **wget**, **unzip** and **bash >= 4.0**

## Description
This Shellscript was originally wriiten in order to organize my ccc practice
file. 

## The Canadian Computing Competition
The Canadian Computing Competition is called CCC for short. It is an annual
event with two divisions, senior and junior. Each division has five questions.
Similar to every other competitions, the only way to succeed in this type of
competition is to have certain amount of practice. Since all of the past
contests are posted on the official website, taking a past contest is a good way
to get ready for this event.

###### Visit the official CCC site for more information
https://cemc.math.uwaterloo.ca/contests/computing.html

###### Past contests
https://cemc.math.uwaterloo.ca/contests/past_contests.html#ccc

## Functions and behaviours
As for the current version, the program has two main functions, organizing
your practice files and downloading the test case data from the CCC's web server.

#### Organizing your files
The program starts with getting its necessary data. After successfully getting 
all of the valid inputs, it will create **~/workspaces/ccc/** directory and use 
it as the **root** directory. Thereafter, according to the **year**(A four digit
number), **language**(a letter either p or c where p stands for python and c stands 
for c++), **level** (senior or junior) and the question **number**
(a number from 1 to 5), question **name**(A non-empty string) input, the program will
create a nested directory within the ccc root. For instance, 
**/2012/cplusplus/Senior/1.foo/** In addition to this, a file with the extension of
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

#### Fetching test case data

