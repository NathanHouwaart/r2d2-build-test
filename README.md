# R2D2 test build environment 2019-2020

## Prerequisites
To install the R2D2 test build environment, you need to meet the following prerequisites:
- For Windows: have **Windows 10 Pro or Education** 
- You need to have **Docker** installed and running. (guide below)
- You need to have **Git** installed
- You need an Arduino Due at hand


## How to install?
There are two options to install the R2D2 test build environment.
You can either make use of:
*   The install script provided at this [repo](link)
*   Manual installation


## Manual installation:
For manual installation, first pull the repository with the following command (this may take some time):
1. `git clone --recursive https://github.com/nathanhouwaart/r2d2-build-test.git`
2. cd to the docker_build/installer directory: `cd r2d2-build-test/docker_build/installer directory`
3. 
- **If you are on Mac or Linux:**
    1. Make the install-xxx.sh script executable by using the following command: `sudo chmod +x install-xxx.sh`
    2. Execute the file by running:  `sudo ./install-xxx.sh`
    3. Log out and log back in to apply the changes\
- **If you are on Windows 10**:
    1. Run the install.bat folder in **administrator mode**
    2. Log out and log back in to apply the changes

## First run: 
After you have installed the r2d2-test-build environment, you can continue with these steps.

1. Go to the r2d2 root directory:  
- **If you are on Mac or Linux:**
   - `cd $R2D2_ROOT_DIR`    
- **If you are on Windows 10**
   - `cd /d $R2D2_ROOT_DRIVE$R2D2_ROOT_DIR`
2. Go to the test module example by using the `cd modules/test_module/code`
3. Plugin your Arduino and decide what COM port it's on:
   - For windows this is usually `COM1-COM9`
   - For Linux this is usually `/dev/ttyACM0`
   - For Mac this is usually something like `/dev/cu.usbmodem******`
4. Edit the Makefiles `SERIAL_PORT` variable accordingly and save it
5. Open a command terminal in that map (with sudo rights or admin rights)
6. Type `make run`
7. Docker will now try to build a container from the r2d2-buildenvironment image. If this is the first time running this script, it will pull the Docker image from the DockerHub hosting website. Again this will take some time.
8. After the Docker image is downloaded, it will run compile, upload and run an hwlib hello world example
9. SUCCESS, your docker installation was succesfull






