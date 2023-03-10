# Firefox Container Sorter
Firefox containers is a fantastic plug-in with little drawbacks and is a must-have for anyone with multiple clients that share the same services. The lack of alphabetical ordering of containers, however, is a pain and can be a nightmare.

In the later versions of Containers, filtering has been added to make life easier, but in certain menus, you cannot use this, like in "reopen with container", for example. Here, it is great to have each container alphabetized anyway. 

So, I've made a powershell script. It's a simple script that takes the JSON file that FireFox creates, splits the array out, sorts it, then puts it back together again.

**:exclamation: This is still in alpha, please use at own risk**

## Features

- Ability to run the script in a test run - this will generate a containerstest.json file instead of overwriting the real one
- Set a custom Output file - and whilst I didn't design it for this, I guess you could use it to backup your container list?

## Prerequisites

This script does not need to be run as an administrator, but you do need to allow Powershell scripts to run on the system. The easiest way to do this is to run this **as admin**:

```powershell
Set-ExecutionPolicy Unrestricted
```

Just be cautious about running this, as it will allow you to run any script from any location on the system.

If you don't know what firefox profile is the right one, open firefox, go to ```about:profiles``` in the address bar and your in-use profile will be present with the directory path (including the random code that identifies your profile).

## Usage

1. Download the script
2. Close Firefox (if open)
3. Open Powershell, ```Set-Location``` to your script file location, then run ```. .\FFContainerSort.ps1```
    - Remember to put a ```. ``` before the ```.\FFContainerSort.ps1``` as that will push the function into the global scope and allow you to call it after the script has loaded
4. Run the command ```SortFirefoxContainers``` to start the sorting process
    - You can use the ```-TestRun``` parameter to do a test run without affecting your original containers file
        - When testing, use the ```-OutFile``` parameter to specify your test file (make it a .json file) - if you don't do this, a "containerstest.json" file will be created in your Firefox profile directory
    - If you don't want to go through the profile selection process, you can specify your profile directory with the ```-ProfileDirectory``` parameter
5. You're all done

## Coming Soon

- Ability to change "sort by" from alphabetical to colour
- Ability to change direction of sorting from A-Z to Z-A

