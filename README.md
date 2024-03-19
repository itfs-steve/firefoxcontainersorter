# Firefox Container Sorter

Firefox containers is a fantastic plug-in with little drawbacks and is a must-have for anyone with multiple clients that share the same services. The lack of alphabetical ordering of containers, however, is a pain and can be a nightmare.

In the later versions of Containers, filtering has been added to make life easier, but in certain menus, you cannot use this, like in "reopen with container", for example. Here, it is great to have each container alphabetized anyway.

So, I've made a python script. It's a simple script that takes the JSON file that FireFox creates, splits the array out, sorts it, then puts it back together again.

**:exclamation: This is still in alpha, please use at own risk**

## Features

- Ability to run the script in a test run - this will generate a containerstest.json file instead of overwriting the real one
- Set a custom Output file - and whilst I didn't design it for this, I guess you could use it to backup your container list?

## Prerequisites

This script does not need to be run as an administrator.

If you don't know what firefox profile is the right one, open firefox, go to `about:profiles` in the address bar and your in-use profile will be present with the directory path (including the random code that identifies your profile).

## Usage

1. Download the program
2. Close Firefox (if open)
3. Open the program file, and follow the instructions.
   - You can specify here whether to do a Test Run. If you choose this, you can then specify a custom filename.
   - You can also specify here the profile directory. If you don't do this, it will give you a list of all profiles to choose from.
4. You're all done

## Coming Soon

- Ability to change "sort by" from alphabetical to colour
- Ability to change direction of sorting from A-Z to Z-A
