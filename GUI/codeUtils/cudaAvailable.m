function gpu=cudaAvailable
%Check for CUDA-1.3-capable or newer graphics card.
try
   gpu=parallel.gpu.GPUDevice.current();
   gpu=isa(gpu,'parallel.gpu.CUDADevice') && gpu.DeviceSupported;
catch msg
   gpu=false;
end