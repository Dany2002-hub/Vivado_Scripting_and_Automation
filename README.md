# Vivado_Scripting_and_Automation

## Description

ALEF_Vivado (Automated Library Evaluation Framework) is a tool coded up in Python that automates the synthesis and implementation flow of Xilinx Vivado Tool by running Tcl Scripts for the input Verilog modules. Moreover, it generates both Synthesized and Implemented reports of power, timing, and utilization and combines several compononents of it as a CSV file. This tool is designed to automate both Verilog and SystemVerilog modules which are named as ``` top_**** ``` (Make sure that your verilog modules and their filenames are same).

## Setting up the Environment

This tool was designed and implemented on Linux Environment. To run this python tool in Linux Environment, we need to make sure that the following things are setup in your system:

#### 1) Creating a Virtual Environment
It is quite important to create a virtual environment to run your tool so that you can install the tool-specific packages in that without interferring with the root account. To create a virtual environment named ```icdesignvirtual``` for example in your Home directory, run the following shell command in your Linux Terminal.




