# HY371-Digital-Image-Processing
Exercises for the HY371 Digital Image Processing course of the Computer Science Department of University of Crete, taught by professor Nikos Komodakis.

Each folder contains the files for the respective assignment, including the assignment description, my final report and the MATLAB code that implements the assignment.

## Assignment 1
In this assignment, we simply had to manipulate the resolution of images, by first sub-sampling the images using the Nearest Neighbour method
and then up-sampling them using two different methods, the Nearest Neighbour and the Bi-linear Interpolation. After doing these two manipulations,
we had to compare the restored image with the original one, using the mean approximation error.

## Assignment 2
In this assignment, we had to point-wise transform the intensities of cardiac magnetic resonance images (MRI) in a way to emphasize areas of interest. We do that by calculating the histogram of those images and their cumulative distribution functions
and then using three different distributions, the Gaussian, the Rice and the exponential, we do histogram equalization.

## Assignment 3
The goal of this assignment is to get familiarized with image convolutions and how to use these operations to perform simple image processing tasks.
I implemented from scratch an algorithm that performs a 2D convolution using an arbitrary and a separable 2D filter. I also build my own three filters, a Gaussian
filter for smoothing the image, a local standard deviation filter by using a box averaging filter and lastly, a Laplacian of Gaussian (LoG) filter. Then, we had to
compare all the binarized filtered images visually.

## Assignment 4
The goal of this assignemnt is to get familiarized with the use of Fourier Transforms on images, including Discrete Space Fourier Transform (DSFT) and, the most commonly used
Discrete Fourier Transform (DFT). This assignment was implemented in two parts. The first part was to do image segmentation using the K-means clustering algorithm,
based on the direction vector θ (for more information look at the description), by first taking the DSFT of two 1D filters and apply them on our images.
The second part of the assignment was to apply the DFT in human face images, in order to inverstigate the role of the phase in the frequency space amd the possibility
of compressing the image under this transformation space.

## Assignment 5
The objective of this assignment is the implementation of digital image segmentation and the evaluation of the parameters that determine their performance.
By the term segmentation in the field of digital image processing we refer to the grouping of parts of the image into groups (classes) using some common feature, e.g. common colour characteristics.
The ultimate goal of this process is to exploit the segmented regions for the semantic analysis of the image content, at the level of objects, with the aim of highlighting
correlations between them. A good segmentation/partitioning algorithm should be able to group the data into as homogeneous subsets as possible. From the algorithms available in the literature, we will focus on those that possess
the property of unsupervised learning. In more detail in the present assignment we will be working with the unsupervised clustering and segmentation algorithms of (a) K-Means, and, (b) Mean-Shift.
In this assignment we will be using RGB and depth data from the NYU Depth dataset. The image segmentation was implemented by exploiting 3 data types:
(a) colour, (b) colour + spatial coordinates and (c) depth.
