// Define the folder where processed images will be saved
output_folder_path = "/Users/domchom/Desktop/";

while (nImages > 0) {
	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	fileName = getInfo("image.title"); 
	//gets and saves the file name for later
	
	imageName = getInfo("image.filename") ; 
	dotIndex = indexOf(imageName, ".");  
	fileNameWithoutExtension = substring(imageName, 0, dotIndex); 
	newFileName = fileNameWithoutExtension + "_FFT_correct" + ".tif" ;
	
	run("Split Channels");
	selectWindow("C2-"+fileName);
	run("FFT");
	waitForUser("Select contaminants for " + fileName);
	

	run("Create Mask");
	run("Invert");
	run("Gaussian Blur...", "sigma=2");
	
	selectWindow("C2-"+fileName);
	rename("C2");
	run("Custom Filter...", "filter=Mask process");
	run("Merge Channels...", "c1=C1-" + fileName + " c2=C2 create");
	
	saveAs("Tiff", output_folder_path + newFileName);
	close();
	close();
	close();
}