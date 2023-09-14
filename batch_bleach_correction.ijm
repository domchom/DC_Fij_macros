// Define the folder where processed images will be saved
output_folder_path = "/Volumes/T7/015IHE_Ect2-ROCK-mutants-take5/processed/raw_bleach_corr/";

while (nImages > 0) {
	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	fileName = getInfo("image.title"); 
	//gets and saves the file name for later
	
	imageName = getInfo("image.filename") ; 
	dotIndex = indexOf(imageName, ".");  
	fileNameWithoutExtension = substring(imageName, 0, dotIndex); 
	newFileName = fileNameWithoutExtension + "_bleach_corr" + ".tif" ;
	
	run("Split Channels");
	selectWindow("C2-"+fileName);
	run("Bleach Correction", "correction=[Exponential Fit]");
	rename("C2");
	
	selectWindow("C1-"+fileName);
	//run("Bleach Correction", "correction=[Exponential Fit]");
	rename("C1");
	
	run("Merge Channels...", "c1=C1 c2=C2 create");
	
	saveAs("Tiff", output_folder_path + newFileName);
	close();
	close();
	close();

}
	