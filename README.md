# VehicleNumberDetection
    Template Creation (template_creation.m)– This is used to call the saved images of alphanumerics and then save them as a new template in MATLAB memory.
    Letter Detection(Letter_detection.m) – Reads the characters from the input image and find the highest matched corresponding alphanumeric.
    Plate Detection(Plate_detection.m) – Process the image and then call the above two m-files to detect the number.
    filterregion.m - both functions are used to include and exclude the regions required for detecting vehicle number plate.
    video.m - this is the main function where we taking the results of all other functions and process the vehicle number from an mp4 video.
