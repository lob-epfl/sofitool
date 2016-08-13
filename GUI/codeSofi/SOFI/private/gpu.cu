/*	>> !nvcc -arch=sm_21 -ptx gpu.cu

	The format of gpu.ptx may require a workaround: each global function is defined by
	a line starting with ".entry" followed by the mangled function name. MATLABs just in
	time compiler requires a space between the function name and the argument bracket.
*/


/*	Accumulate partial products from an image in the terms.

	    No boundary and consistency check is performed!
	    For argument format checking, call cpu instead.

	terms=cpu(terms,image,tasks);

	tasks	[pixels products factors(1) factor{1} factors(2) factor{2} ...]

	    pixels	Image size X*Y*Z
	    products	Number of terms
	    factors	Number of factors
	    factor	Pixels of factors (ascending)

	terms(x,y,t) += prod(image(x+y*X+factor{t})

	    x,y		Coordinates
	    t		Product term
*/
__global__ void gpu(double* terms, const double* image, const int* tasks)
{	int pixel=threadIdx.x + blockDim.x*blockIdx.x;
	int pixels=tasks[0];				// number of pixels
	if(pixel < pixels)
	{	int task=tasks[1];			// number of products
		tasks+=2;
		terms+=pixel;				// pixel (x,y)
		image+=pixel;
		pixel=pixels - pixel;			// remaining pixels
		while(--task >= 0)
		{	int factor=*tasks;		// number of factors
			if (tasks[factor] < pixel)
			{	double term=image[tasks[factor]];
				while(--factor > 0) term*=image[tasks[factor]];
				*terms+=term;
			}
			tasks+=1+*tasks;
			terms+=pixels;
		}
	}
}
