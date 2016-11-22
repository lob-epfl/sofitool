SOFI simulation tool: a software package for simulating and testing super-resolution optical fluctuation imaging

To launch the simulation (Matlab R2014b):

Step 1: Open Matlab and set the folder "GUI" as your current folder. The tab "Current folder" on matlab should display the following folders and matlab files:
+ codeSimulation
+ codeSofi
+ codeStorm
+ codeUtils
+ Simulator Examples
+ SOFI_algorithms
+ SOFI_demoMenu
+ SOFI_helpMenu
+ SOFI_startMenu
algorithms.fig
algorithms.m
SOFItutorial_demoMenu.fig
SOFItutorial_demoMenu.m
SOFItutorial_resultsMenu.fig
SOFItutorial_resultsMenu.m
SOFItutorial_startMenu.fig
SOFItutorial_startMenu.m

Step 2: Execute the following command on the "Command Window":
>> SOFItutorial_startMenu 


/////////////////////////////////////////////////////////////////
Using GPU algorithms

 - Algorithms available for the Simulator are '2D SOFI', 'STORM', 'FALCON STORM GPU' and '2D SOFI GPU'. 
Both Falcon and SOFI-GPU require that the computer has a CUDA-enabled NVIDIA GPU (http://ch.mathworks.com/discovery/matlab-gpu.html).
If you have the Matlab Parallel Processing Toolbox and a NVIDIA graphics card, write the following command on the "Command Window":

>> gpuDevice

It should display:

ans = 
	CUDADevice with properties:

with a list of properties. Note the 'ComputeCapibility' of your graphics card.


 - To use the '2D SOFI GPU' algorithm: 
Step 1: prior to launching the GUI, note the 'ComputeCapibility' of your graphics card which is for example '2.0' in the case of NVIDIA Geforce GTX 480. 
The compute capability of a graphics card can also be found here: https://developer.nvidia.com/cuda-gpus
Step 2: Set the Matlab current folder to "GUI\codeSofi\SOFI\private". The tab "Current folder" should display 18 files, 4 of which are 'gpu.cu', 'gpu.ptx', 'nvcc.m' and 'nvccbat.bat'.
Step 3: Execute the following command on the "Command Window": 
>> nvcc -arch=sm_20 -ptx gpu.cu
This command launches the NVIDIA compiler to recompile gpu.cu. Make sure that the -arch option is set to the compute capability of your CUDA-capable graphics card. 
In the example displayed above, it is 2.0 (the compute capibility of NVIDIA Geforce GTX 480).
