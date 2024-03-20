import json
import os

def sort_firefox_containers(profile_directory=None, out_file=None, test_run=False):
    if test_run:
        print("[INFO] Test Run requested. Original file will not be affected")
        if out_file:
            print("[INFO] Output file specified, default will be ignored")
            scpt_output_file = out_file
        else:
            print("[WARN] No output file specified. File will be saved as containerstest.json in the profile directory")
            scpt_output_file = "containerstest.json"
    else:
        print("[INFO] Live run in progress")
        if out_file:
            print("[FATAL] Output file specified, you must be in Test Run mode to do this")
            return 500
        else:
            scpt_output_file = "containers.json"
    
    if profile_directory:
        print("[INFO] Profile Directory Specified, default process will be skipped")
        input_loc = profile_directory
        os.chdir(profile_directory)
    else:
        profiles_path = os.path.join(os.environ['USERPROFILE'], 'AppData', 'Roaming', 'Mozilla', 'Firefox', 'Profiles')
        print("")
        print("Detected Profiles:")
        print(os.listdir(profiles_path))
        print("")
        containers_location = input("Which profile are you editing: ")
        input_loc = os.path.join(profiles_path, containers_location)
        os.chdir(os.path.join(profiles_path, containers_location))

    scpt_input_file = "containers.json"

    print("[INFO] Profile Directory:", input_loc)

    # Get data in JSON file and convert to Python-readable dictionary
    with open(scpt_input_file, 'r') as f:
        containers = json.load(f)

    # Sort identities array alphabetically
    sorted_containers = sorted(containers['identities'], key=lambda x: x.get('name', '').lower())

    # Update containers dictionary with sorted identities
    containers['identities'] = sorted_containers

    # Convert back to JSON and save to file
    with open(scpt_output_file, 'w') as f:
        json.dump(containers, f)

    print("[SUCCESS] Sorting Completed")


if __name__ == "__main__":
    print("Welcome to the Firefox Container Sorter utility!")
    print("")
    print("Just run 'sort_firefox_containers()' to sort your containers")
    print("")
    print("To run a Test Run, set test_run=True")
    print("When testing, you can specify a custom output file using the 'out_file' parameter - make sure you make the output file a .json file")
    print("")
    print("You can bypass the profile selection process by manually specifying the profile directory with the 'profile_directory' parameter")
    print("")
    print("")

    print("Question time! (If it's in [square brackets], it's the default)")

    test_run = input("Do you want to run a test run? (yes/[no]): ").lower() == 'yes'
    out_file = input("Do you want to specify a custom output file? (yes/[no]): ").lower() == 'yes'
    profile_directory = input("Do you want to specify the profile directory? (yes/[no]): ").lower() == 'yes'

    if out_file:
        out_file_name = input("Enter the custom output file name (make sure it's a .json file): ")
    else:
        out_file_name = None

    if profile_directory:
        custom_profile_directory = input("Enter the custom profile directory: ")
    else:
        custom_profile_directory = None


    sort_firefox_containers(test_run=test_run,out_file=out_file_name,profile_directory=custom_profile_directory)  # You can pass parameters accordingly here