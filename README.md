# Vivado_Scripting_and_Automation

## Description

ALEF_Vivado (Automated Library Evaluation Framework) is a tool coded up in Python that automates the synthesis and implementation flow of Xilinx Vivado Tool by running Tcl Scripts for the input Verilog modules. Moreover, it generates both Synthesized and Implemented reports of power, timing, and utilization and combines several compononents of it as a CSV file. This tool is designed to automate both Verilog and SystemVerilog modules which are named as ``` top_**** ``` (Make sure that your verilog modules and their filenames are same).

## Setting up the Environment

This tool was designed and implemented on CentOS Linux Environment. To run this python tool on this environment, we need to make sure that the following things are setup in your system:

### 1) Installing Python3
Since the tool is developed using Python3 programming language and its packages, it is important for a user running this tool to have python3 installed in their systems. Before installing python3, update the environment w.r.t its packages by running the following shell command on your Linux terminal.
```
[vlsidesign9@nanodcserver ~]$ yum update -y
```
Once the environmnet is upto date, all we need do to install Python3 is run the following command.
```
[vlsidesign9@nanodcserver ~]$ yum install -y python3
```
Make sure to run these commands as a root. 

### 2) Creating a Virtual Environment
It is quite important to create a virtual environment to run your tool so that you can install the tool-specific packages in that without interferring with the root account. To create a virtual environment named ```icdesignvirtual``` for example in your Home directory, run the following command.
```
[vlsidesign9@nanodcserver ~]$ python3 -m venv ~/icdesignvirtual
```
### 3) Installing Jupyter Lab
The Integrated Develpoment Environment (IDE) used to design and implement the tool is Jupyter Lab. To install jupyter lab, we initailly get into our virtual environment.
```
[vlsidesign9@nanodcserver ~]$ source ~/icdesignvirtual/bin/activate
```
Once you get into your virtual environment, install jupyter lab by running this command.
```
(icdesignvirtual) [vlsidesign9@nanodcserver ~]$ pip install jupypterlab
```
After installing, to get access to the jupyter lab terminal from the same or different directory, just get into your virtual environment, and run the following command.
```
(icdesignvirtual) [vlsidesign9@nanodcserver ~]$ jupyter lab
```
## TCL Script to add input Verilog/SystemVerilog modules to a new Vivado Project
When the tool runs the ``` tcl_add.tcl ``` script provided in the ``` Scripting/Script ``` folder, it performs the following tasks in a sequential order:

1) Creates a new project in Vivado with the specified name, directory, and Target FPGA devive. Here, I have created a new project named **Automation_modules** , which is stored in the **Automation** folder of the present working directory and provided **xc7a35tcpg236-1** as the FPGA part number which is used in the Digilent Basys 3 board.
2) Sets a target board for the created project. Here, I have set the target board to be the **Digilent Basys 3** board.
3) Adds the mentioned Verilog/SystemVerilog files to the created project for automation. Now, you don't need to type the tcl command line for each and every Verilog/SystemVerilog file that you wanted to add to the project. Rather, the tool will automate that process. Just make sure you comment/delete out the tcl command lines that I have used to add my set of Verilog/SystemVerilog files to the project if you wanted to try it out for your set of design files. 
4) Updates the compile order of the added design files.
5) Finally, closes the project. 

## TCL Script to automate the synthesis and implementation of the top modules
As mentioned in the description, this tool is designed to automate only the modules named as ``` top_**** ```. Therefore, it is necessary for the users to name their input modules as mentioned above.The tool runs the ``` tcl_run.tcl ``` script provided in the ``` Scripting/Script ``` folder for each top module by looping through the provided list of top modules. These are the following tasks that the ``` tcl_run.tcl ``` script performs in a sequential order at each iteration:

1) Opens the project where we have added our Verilog/SystemVerilog modules in Vivado, here in this case **Automation_modules.xpr**.
2) Sets the particular design module that we are iterating through as the top module for running synthesis and implementation on it.
3) Launches the synthesis run for the top module with 12 jobs. 
4) Waits till the synthesis gets over. 
5) Checks for possible errors in the synthesis run by reading the **runme.log** file which in this case is created and stored in the **Automation/Automation_modules.runs/synth_1** directory.
6) If there are no errors found in the log file or in otherwords, if the synthesis is successful, then the power, timing, and utilization reports will be generated for the synthesized design, followed by a text file named **Is_Synth.txt** which will store **YES** meaning the module is synthesized successfully. These files will be stored in the respective top module folder under the **Synthesized_Reports** folder which will be created by this tool before you run this TCL Script.
7) If the otherwise happens meaning if the synthesis fails, then the runme.log file containing the error message(s) will be copied to a new file named **synth_error.txt** for the user to identify the errors in the synthesis easily, followed by a text file named **Is_Synth.txt** which will store **NO** meaning the module has failed synthesis. These files will be created in the same directory mentioned in the above point. Hence, if a module fails synthesis, it can't be implemented as well. Therefore, it will also generate couple more text files namely **Is_Impl.txt** which stores **NO** as it can't be implementable and **impl_error.txt** which stores the error message of **Can't be implemented as it is not synthesizable**. These files will be stored in the respective top module folder under the **Implemented_Reports** folder which will be created by this tool before you run this TCL Script. 
9) Now, If you have a synthesizable module, then it will launch the implementation run for the respective top module with 12 jobs.
10) Waits till the implementation gets over.
11) Checks for possible errors in the implementation run by reading the **runme.log** file which in this case is created and stored in the **Automation/Automation_modules.runs/impl_1** directory.
12) If there are no errors found in the log file or in otherwords, if the implementation is successful, then the power, timing, and utilization reports will be generated for the implemented design, followed by a text file named **Is_Impl.txt** which will store **YES** meaning the module is implemented successfully. These files will be stored in the respective top module folder under the **Implementation_Reports** folder which will be created by this tool before you run this TCL Script.
13) If the otherwise happens meaning if the implementation fails, then the runme.log file containing the error message(s) will be copied to a new file named **impl_error.txt** for the user to identify the errors in the implementation easily, followed by a text file named **Is_Impl.txt** which will store **NO** meaning the module has failed implementation. These files will be created in the same directory mentioned in the above point.
14) Finally, closes the project.

After every iteration of running the ``` tcl_run.tcl ``` script for the respective top module, the tool notifies the user of the completion of the automation for the particular module with the duration of automating that module in the unit of hours via the python output terminal. Further it will also display whether the automated module passed synthesis/implementation so as to make the user aware of the possible failures in the automation, if any. 










