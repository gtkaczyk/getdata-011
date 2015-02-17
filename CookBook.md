This is project for Coursera getdata-011 course.

Load libraries
--------------

    library(tidyr)
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:stats':
    ## 
    ##     filter
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(reshape2)

Set working directory and Read data files
-----------------------------------------

    setwd("E://Projects//R//getdata-011//as1//UCI HAR Dataset")
    d_Act_Test  <- read.table( "test//Y_test.txt"   ,header = FALSE)
    d_Act_Train <- read.table( "train//Y_train.txt" ,header = FALSE)
    d_Sub_Test  <- read.table( "test//subject_test.txt"   ,header = FALSE)
    d_Sub_Train <- read.table( "train//subject_train.txt" ,header = FALSE)
    d_Feat_Test <- read.table( "test//X_test.txt"  ,header = FALSE)
    d_Feat_Train <- read.table("train//X_train.txt",header = FALSE)
    d_Feat_Names <- read.table("features.txt",header = FALSE)
    Act_Labels   <- read.table("activity_labels.txt",header = FALSE)

1. Merges the training and the test sets to create one data set
===============================================================

    d_Act <- rbind(d_Act_Test,d_Act_Train)
    d_Sub <- rbind(d_Sub_Test,d_Sub_Train)
    d_Feat <- rbind(d_Feat_Test,d_Feat_Train)

    rm(list=c("d_Act_Test","d_Act_Train","d_Sub_Test","d_Sub_Train","d_Feat_Test","d_Feat_Train"))

Add column names
----------------

    names(d_Act)  <- c("Activity")
    head(d_Act)

    ##   Activity
    ## 1        5
    ## 2        5
    ## 3        5
    ## 4        5
    ## 5        5
    ## 6        5

    names(d_Sub)  <- c("Subject")
    head(d_Sub)

    ##   Subject
    ## 1       2
    ## 2       2
    ## 3       2
    ## 4       2
    ## 5       2
    ## 6       2

    names(d_Feat) <- d_Feat_Names[,2]
    names(d_Feat)

    ##   [1] "tBodyAcc-mean()-X"                   
    ##   [2] "tBodyAcc-mean()-Y"                   
    ##   [3] "tBodyAcc-mean()-Z"                   
    ##   [4] "tBodyAcc-std()-X"                    
    ##   [5] "tBodyAcc-std()-Y"                    
    ##   [6] "tBodyAcc-std()-Z"                    
    ##   [7] "tBodyAcc-mad()-X"                    
    ##   [8] "tBodyAcc-mad()-Y"                    
    ##   [9] "tBodyAcc-mad()-Z"                    
    ##  [10] "tBodyAcc-max()-X"                    
    ##  [11] "tBodyAcc-max()-Y"                    
    ##  [12] "tBodyAcc-max()-Z"                    
    ##  [13] "tBodyAcc-min()-X"                    
    ##  [14] "tBodyAcc-min()-Y"                    
    ##  [15] "tBodyAcc-min()-Z"                    
    ##  [16] "tBodyAcc-sma()"                      
    ##  [17] "tBodyAcc-energy()-X"                 
    ##  [18] "tBodyAcc-energy()-Y"                 
    ##  [19] "tBodyAcc-energy()-Z"                 
    ##  [20] "tBodyAcc-iqr()-X"                    
    ##  [21] "tBodyAcc-iqr()-Y"                    
    ##  [22] "tBodyAcc-iqr()-Z"                    
    ##  [23] "tBodyAcc-entropy()-X"                
    ##  [24] "tBodyAcc-entropy()-Y"                
    ##  [25] "tBodyAcc-entropy()-Z"                
    ##  [26] "tBodyAcc-arCoeff()-X,1"              
    ##  [27] "tBodyAcc-arCoeff()-X,2"              
    ##  [28] "tBodyAcc-arCoeff()-X,3"              
    ##  [29] "tBodyAcc-arCoeff()-X,4"              
    ##  [30] "tBodyAcc-arCoeff()-Y,1"              
    ##  [31] "tBodyAcc-arCoeff()-Y,2"              
    ##  [32] "tBodyAcc-arCoeff()-Y,3"              
    ##  [33] "tBodyAcc-arCoeff()-Y,4"              
    ##  [34] "tBodyAcc-arCoeff()-Z,1"              
    ##  [35] "tBodyAcc-arCoeff()-Z,2"              
    ##  [36] "tBodyAcc-arCoeff()-Z,3"              
    ##  [37] "tBodyAcc-arCoeff()-Z,4"              
    ##  [38] "tBodyAcc-correlation()-X,Y"          
    ##  [39] "tBodyAcc-correlation()-X,Z"          
    ##  [40] "tBodyAcc-correlation()-Y,Z"          
    ##  [41] "tGravityAcc-mean()-X"                
    ##  [42] "tGravityAcc-mean()-Y"                
    ##  [43] "tGravityAcc-mean()-Z"                
    ##  [44] "tGravityAcc-std()-X"                 
    ##  [45] "tGravityAcc-std()-Y"                 
    ##  [46] "tGravityAcc-std()-Z"                 
    ##  [47] "tGravityAcc-mad()-X"                 
    ##  [48] "tGravityAcc-mad()-Y"                 
    ##  [49] "tGravityAcc-mad()-Z"                 
    ##  [50] "tGravityAcc-max()-X"                 
    ##  [51] "tGravityAcc-max()-Y"                 
    ##  [52] "tGravityAcc-max()-Z"                 
    ##  [53] "tGravityAcc-min()-X"                 
    ##  [54] "tGravityAcc-min()-Y"                 
    ##  [55] "tGravityAcc-min()-Z"                 
    ##  [56] "tGravityAcc-sma()"                   
    ##  [57] "tGravityAcc-energy()-X"              
    ##  [58] "tGravityAcc-energy()-Y"              
    ##  [59] "tGravityAcc-energy()-Z"              
    ##  [60] "tGravityAcc-iqr()-X"                 
    ##  [61] "tGravityAcc-iqr()-Y"                 
    ##  [62] "tGravityAcc-iqr()-Z"                 
    ##  [63] "tGravityAcc-entropy()-X"             
    ##  [64] "tGravityAcc-entropy()-Y"             
    ##  [65] "tGravityAcc-entropy()-Z"             
    ##  [66] "tGravityAcc-arCoeff()-X,1"           
    ##  [67] "tGravityAcc-arCoeff()-X,2"           
    ##  [68] "tGravityAcc-arCoeff()-X,3"           
    ##  [69] "tGravityAcc-arCoeff()-X,4"           
    ##  [70] "tGravityAcc-arCoeff()-Y,1"           
    ##  [71] "tGravityAcc-arCoeff()-Y,2"           
    ##  [72] "tGravityAcc-arCoeff()-Y,3"           
    ##  [73] "tGravityAcc-arCoeff()-Y,4"           
    ##  [74] "tGravityAcc-arCoeff()-Z,1"           
    ##  [75] "tGravityAcc-arCoeff()-Z,2"           
    ##  [76] "tGravityAcc-arCoeff()-Z,3"           
    ##  [77] "tGravityAcc-arCoeff()-Z,4"           
    ##  [78] "tGravityAcc-correlation()-X,Y"       
    ##  [79] "tGravityAcc-correlation()-X,Z"       
    ##  [80] "tGravityAcc-correlation()-Y,Z"       
    ##  [81] "tBodyAccJerk-mean()-X"               
    ##  [82] "tBodyAccJerk-mean()-Y"               
    ##  [83] "tBodyAccJerk-mean()-Z"               
    ##  [84] "tBodyAccJerk-std()-X"                
    ##  [85] "tBodyAccJerk-std()-Y"                
    ##  [86] "tBodyAccJerk-std()-Z"                
    ##  [87] "tBodyAccJerk-mad()-X"                
    ##  [88] "tBodyAccJerk-mad()-Y"                
    ##  [89] "tBodyAccJerk-mad()-Z"                
    ##  [90] "tBodyAccJerk-max()-X"                
    ##  [91] "tBodyAccJerk-max()-Y"                
    ##  [92] "tBodyAccJerk-max()-Z"                
    ##  [93] "tBodyAccJerk-min()-X"                
    ##  [94] "tBodyAccJerk-min()-Y"                
    ##  [95] "tBodyAccJerk-min()-Z"                
    ##  [96] "tBodyAccJerk-sma()"                  
    ##  [97] "tBodyAccJerk-energy()-X"             
    ##  [98] "tBodyAccJerk-energy()-Y"             
    ##  [99] "tBodyAccJerk-energy()-Z"             
    ## [100] "tBodyAccJerk-iqr()-X"                
    ## [101] "tBodyAccJerk-iqr()-Y"                
    ## [102] "tBodyAccJerk-iqr()-Z"                
    ## [103] "tBodyAccJerk-entropy()-X"            
    ## [104] "tBodyAccJerk-entropy()-Y"            
    ## [105] "tBodyAccJerk-entropy()-Z"            
    ## [106] "tBodyAccJerk-arCoeff()-X,1"          
    ## [107] "tBodyAccJerk-arCoeff()-X,2"          
    ## [108] "tBodyAccJerk-arCoeff()-X,3"          
    ## [109] "tBodyAccJerk-arCoeff()-X,4"          
    ## [110] "tBodyAccJerk-arCoeff()-Y,1"          
    ## [111] "tBodyAccJerk-arCoeff()-Y,2"          
    ## [112] "tBodyAccJerk-arCoeff()-Y,3"          
    ## [113] "tBodyAccJerk-arCoeff()-Y,4"          
    ## [114] "tBodyAccJerk-arCoeff()-Z,1"          
    ## [115] "tBodyAccJerk-arCoeff()-Z,2"          
    ## [116] "tBodyAccJerk-arCoeff()-Z,3"          
    ## [117] "tBodyAccJerk-arCoeff()-Z,4"          
    ## [118] "tBodyAccJerk-correlation()-X,Y"      
    ## [119] "tBodyAccJerk-correlation()-X,Z"      
    ## [120] "tBodyAccJerk-correlation()-Y,Z"      
    ## [121] "tBodyGyro-mean()-X"                  
    ## [122] "tBodyGyro-mean()-Y"                  
    ## [123] "tBodyGyro-mean()-Z"                  
    ## [124] "tBodyGyro-std()-X"                   
    ## [125] "tBodyGyro-std()-Y"                   
    ## [126] "tBodyGyro-std()-Z"                   
    ## [127] "tBodyGyro-mad()-X"                   
    ## [128] "tBodyGyro-mad()-Y"                   
    ## [129] "tBodyGyro-mad()-Z"                   
    ## [130] "tBodyGyro-max()-X"                   
    ## [131] "tBodyGyro-max()-Y"                   
    ## [132] "tBodyGyro-max()-Z"                   
    ## [133] "tBodyGyro-min()-X"                   
    ## [134] "tBodyGyro-min()-Y"                   
    ## [135] "tBodyGyro-min()-Z"                   
    ## [136] "tBodyGyro-sma()"                     
    ## [137] "tBodyGyro-energy()-X"                
    ## [138] "tBodyGyro-energy()-Y"                
    ## [139] "tBodyGyro-energy()-Z"                
    ## [140] "tBodyGyro-iqr()-X"                   
    ## [141] "tBodyGyro-iqr()-Y"                   
    ## [142] "tBodyGyro-iqr()-Z"                   
    ## [143] "tBodyGyro-entropy()-X"               
    ## [144] "tBodyGyro-entropy()-Y"               
    ## [145] "tBodyGyro-entropy()-Z"               
    ## [146] "tBodyGyro-arCoeff()-X,1"             
    ## [147] "tBodyGyro-arCoeff()-X,2"             
    ## [148] "tBodyGyro-arCoeff()-X,3"             
    ## [149] "tBodyGyro-arCoeff()-X,4"             
    ## [150] "tBodyGyro-arCoeff()-Y,1"             
    ## [151] "tBodyGyro-arCoeff()-Y,2"             
    ## [152] "tBodyGyro-arCoeff()-Y,3"             
    ## [153] "tBodyGyro-arCoeff()-Y,4"             
    ## [154] "tBodyGyro-arCoeff()-Z,1"             
    ## [155] "tBodyGyro-arCoeff()-Z,2"             
    ## [156] "tBodyGyro-arCoeff()-Z,3"             
    ## [157] "tBodyGyro-arCoeff()-Z,4"             
    ## [158] "tBodyGyro-correlation()-X,Y"         
    ## [159] "tBodyGyro-correlation()-X,Z"         
    ## [160] "tBodyGyro-correlation()-Y,Z"         
    ## [161] "tBodyGyroJerk-mean()-X"              
    ## [162] "tBodyGyroJerk-mean()-Y"              
    ## [163] "tBodyGyroJerk-mean()-Z"              
    ## [164] "tBodyGyroJerk-std()-X"               
    ## [165] "tBodyGyroJerk-std()-Y"               
    ## [166] "tBodyGyroJerk-std()-Z"               
    ## [167] "tBodyGyroJerk-mad()-X"               
    ## [168] "tBodyGyroJerk-mad()-Y"               
    ## [169] "tBodyGyroJerk-mad()-Z"               
    ## [170] "tBodyGyroJerk-max()-X"               
    ## [171] "tBodyGyroJerk-max()-Y"               
    ## [172] "tBodyGyroJerk-max()-Z"               
    ## [173] "tBodyGyroJerk-min()-X"               
    ## [174] "tBodyGyroJerk-min()-Y"               
    ## [175] "tBodyGyroJerk-min()-Z"               
    ## [176] "tBodyGyroJerk-sma()"                 
    ## [177] "tBodyGyroJerk-energy()-X"            
    ## [178] "tBodyGyroJerk-energy()-Y"            
    ## [179] "tBodyGyroJerk-energy()-Z"            
    ## [180] "tBodyGyroJerk-iqr()-X"               
    ## [181] "tBodyGyroJerk-iqr()-Y"               
    ## [182] "tBodyGyroJerk-iqr()-Z"               
    ## [183] "tBodyGyroJerk-entropy()-X"           
    ## [184] "tBodyGyroJerk-entropy()-Y"           
    ## [185] "tBodyGyroJerk-entropy()-Z"           
    ## [186] "tBodyGyroJerk-arCoeff()-X,1"         
    ## [187] "tBodyGyroJerk-arCoeff()-X,2"         
    ## [188] "tBodyGyroJerk-arCoeff()-X,3"         
    ## [189] "tBodyGyroJerk-arCoeff()-X,4"         
    ## [190] "tBodyGyroJerk-arCoeff()-Y,1"         
    ## [191] "tBodyGyroJerk-arCoeff()-Y,2"         
    ## [192] "tBodyGyroJerk-arCoeff()-Y,3"         
    ## [193] "tBodyGyroJerk-arCoeff()-Y,4"         
    ## [194] "tBodyGyroJerk-arCoeff()-Z,1"         
    ## [195] "tBodyGyroJerk-arCoeff()-Z,2"         
    ## [196] "tBodyGyroJerk-arCoeff()-Z,3"         
    ## [197] "tBodyGyroJerk-arCoeff()-Z,4"         
    ## [198] "tBodyGyroJerk-correlation()-X,Y"     
    ## [199] "tBodyGyroJerk-correlation()-X,Z"     
    ## [200] "tBodyGyroJerk-correlation()-Y,Z"     
    ## [201] "tBodyAccMag-mean()"                  
    ## [202] "tBodyAccMag-std()"                   
    ## [203] "tBodyAccMag-mad()"                   
    ## [204] "tBodyAccMag-max()"                   
    ## [205] "tBodyAccMag-min()"                   
    ## [206] "tBodyAccMag-sma()"                   
    ## [207] "tBodyAccMag-energy()"                
    ## [208] "tBodyAccMag-iqr()"                   
    ## [209] "tBodyAccMag-entropy()"               
    ## [210] "tBodyAccMag-arCoeff()1"              
    ## [211] "tBodyAccMag-arCoeff()2"              
    ## [212] "tBodyAccMag-arCoeff()3"              
    ## [213] "tBodyAccMag-arCoeff()4"              
    ## [214] "tGravityAccMag-mean()"               
    ## [215] "tGravityAccMag-std()"                
    ## [216] "tGravityAccMag-mad()"                
    ## [217] "tGravityAccMag-max()"                
    ## [218] "tGravityAccMag-min()"                
    ## [219] "tGravityAccMag-sma()"                
    ## [220] "tGravityAccMag-energy()"             
    ## [221] "tGravityAccMag-iqr()"                
    ## [222] "tGravityAccMag-entropy()"            
    ## [223] "tGravityAccMag-arCoeff()1"           
    ## [224] "tGravityAccMag-arCoeff()2"           
    ## [225] "tGravityAccMag-arCoeff()3"           
    ## [226] "tGravityAccMag-arCoeff()4"           
    ## [227] "tBodyAccJerkMag-mean()"              
    ## [228] "tBodyAccJerkMag-std()"               
    ## [229] "tBodyAccJerkMag-mad()"               
    ## [230] "tBodyAccJerkMag-max()"               
    ## [231] "tBodyAccJerkMag-min()"               
    ## [232] "tBodyAccJerkMag-sma()"               
    ## [233] "tBodyAccJerkMag-energy()"            
    ## [234] "tBodyAccJerkMag-iqr()"               
    ## [235] "tBodyAccJerkMag-entropy()"           
    ## [236] "tBodyAccJerkMag-arCoeff()1"          
    ## [237] "tBodyAccJerkMag-arCoeff()2"          
    ## [238] "tBodyAccJerkMag-arCoeff()3"          
    ## [239] "tBodyAccJerkMag-arCoeff()4"          
    ## [240] "tBodyGyroMag-mean()"                 
    ## [241] "tBodyGyroMag-std()"                  
    ## [242] "tBodyGyroMag-mad()"                  
    ## [243] "tBodyGyroMag-max()"                  
    ## [244] "tBodyGyroMag-min()"                  
    ## [245] "tBodyGyroMag-sma()"                  
    ## [246] "tBodyGyroMag-energy()"               
    ## [247] "tBodyGyroMag-iqr()"                  
    ## [248] "tBodyGyroMag-entropy()"              
    ## [249] "tBodyGyroMag-arCoeff()1"             
    ## [250] "tBodyGyroMag-arCoeff()2"             
    ## [251] "tBodyGyroMag-arCoeff()3"             
    ## [252] "tBodyGyroMag-arCoeff()4"             
    ## [253] "tBodyGyroJerkMag-mean()"             
    ## [254] "tBodyGyroJerkMag-std()"              
    ## [255] "tBodyGyroJerkMag-mad()"              
    ## [256] "tBodyGyroJerkMag-max()"              
    ## [257] "tBodyGyroJerkMag-min()"              
    ## [258] "tBodyGyroJerkMag-sma()"              
    ## [259] "tBodyGyroJerkMag-energy()"           
    ## [260] "tBodyGyroJerkMag-iqr()"              
    ## [261] "tBodyGyroJerkMag-entropy()"          
    ## [262] "tBodyGyroJerkMag-arCoeff()1"         
    ## [263] "tBodyGyroJerkMag-arCoeff()2"         
    ## [264] "tBodyGyroJerkMag-arCoeff()3"         
    ## [265] "tBodyGyroJerkMag-arCoeff()4"         
    ## [266] "fBodyAcc-mean()-X"                   
    ## [267] "fBodyAcc-mean()-Y"                   
    ## [268] "fBodyAcc-mean()-Z"                   
    ## [269] "fBodyAcc-std()-X"                    
    ## [270] "fBodyAcc-std()-Y"                    
    ## [271] "fBodyAcc-std()-Z"                    
    ## [272] "fBodyAcc-mad()-X"                    
    ## [273] "fBodyAcc-mad()-Y"                    
    ## [274] "fBodyAcc-mad()-Z"                    
    ## [275] "fBodyAcc-max()-X"                    
    ## [276] "fBodyAcc-max()-Y"                    
    ## [277] "fBodyAcc-max()-Z"                    
    ## [278] "fBodyAcc-min()-X"                    
    ## [279] "fBodyAcc-min()-Y"                    
    ## [280] "fBodyAcc-min()-Z"                    
    ## [281] "fBodyAcc-sma()"                      
    ## [282] "fBodyAcc-energy()-X"                 
    ## [283] "fBodyAcc-energy()-Y"                 
    ## [284] "fBodyAcc-energy()-Z"                 
    ## [285] "fBodyAcc-iqr()-X"                    
    ## [286] "fBodyAcc-iqr()-Y"                    
    ## [287] "fBodyAcc-iqr()-Z"                    
    ## [288] "fBodyAcc-entropy()-X"                
    ## [289] "fBodyAcc-entropy()-Y"                
    ## [290] "fBodyAcc-entropy()-Z"                
    ## [291] "fBodyAcc-maxInds-X"                  
    ## [292] "fBodyAcc-maxInds-Y"                  
    ## [293] "fBodyAcc-maxInds-Z"                  
    ## [294] "fBodyAcc-meanFreq()-X"               
    ## [295] "fBodyAcc-meanFreq()-Y"               
    ## [296] "fBodyAcc-meanFreq()-Z"               
    ## [297] "fBodyAcc-skewness()-X"               
    ## [298] "fBodyAcc-kurtosis()-X"               
    ## [299] "fBodyAcc-skewness()-Y"               
    ## [300] "fBodyAcc-kurtosis()-Y"               
    ## [301] "fBodyAcc-skewness()-Z"               
    ## [302] "fBodyAcc-kurtosis()-Z"               
    ## [303] "fBodyAcc-bandsEnergy()-1,8"          
    ## [304] "fBodyAcc-bandsEnergy()-9,16"         
    ## [305] "fBodyAcc-bandsEnergy()-17,24"        
    ## [306] "fBodyAcc-bandsEnergy()-25,32"        
    ## [307] "fBodyAcc-bandsEnergy()-33,40"        
    ## [308] "fBodyAcc-bandsEnergy()-41,48"        
    ## [309] "fBodyAcc-bandsEnergy()-49,56"        
    ## [310] "fBodyAcc-bandsEnergy()-57,64"        
    ## [311] "fBodyAcc-bandsEnergy()-1,16"         
    ## [312] "fBodyAcc-bandsEnergy()-17,32"        
    ## [313] "fBodyAcc-bandsEnergy()-33,48"        
    ## [314] "fBodyAcc-bandsEnergy()-49,64"        
    ## [315] "fBodyAcc-bandsEnergy()-1,24"         
    ## [316] "fBodyAcc-bandsEnergy()-25,48"        
    ## [317] "fBodyAcc-bandsEnergy()-1,8"          
    ## [318] "fBodyAcc-bandsEnergy()-9,16"         
    ## [319] "fBodyAcc-bandsEnergy()-17,24"        
    ## [320] "fBodyAcc-bandsEnergy()-25,32"        
    ## [321] "fBodyAcc-bandsEnergy()-33,40"        
    ## [322] "fBodyAcc-bandsEnergy()-41,48"        
    ## [323] "fBodyAcc-bandsEnergy()-49,56"        
    ## [324] "fBodyAcc-bandsEnergy()-57,64"        
    ## [325] "fBodyAcc-bandsEnergy()-1,16"         
    ## [326] "fBodyAcc-bandsEnergy()-17,32"        
    ## [327] "fBodyAcc-bandsEnergy()-33,48"        
    ## [328] "fBodyAcc-bandsEnergy()-49,64"        
    ## [329] "fBodyAcc-bandsEnergy()-1,24"         
    ## [330] "fBodyAcc-bandsEnergy()-25,48"        
    ## [331] "fBodyAcc-bandsEnergy()-1,8"          
    ## [332] "fBodyAcc-bandsEnergy()-9,16"         
    ## [333] "fBodyAcc-bandsEnergy()-17,24"        
    ## [334] "fBodyAcc-bandsEnergy()-25,32"        
    ## [335] "fBodyAcc-bandsEnergy()-33,40"        
    ## [336] "fBodyAcc-bandsEnergy()-41,48"        
    ## [337] "fBodyAcc-bandsEnergy()-49,56"        
    ## [338] "fBodyAcc-bandsEnergy()-57,64"        
    ## [339] "fBodyAcc-bandsEnergy()-1,16"         
    ## [340] "fBodyAcc-bandsEnergy()-17,32"        
    ## [341] "fBodyAcc-bandsEnergy()-33,48"        
    ## [342] "fBodyAcc-bandsEnergy()-49,64"        
    ## [343] "fBodyAcc-bandsEnergy()-1,24"         
    ## [344] "fBodyAcc-bandsEnergy()-25,48"        
    ## [345] "fBodyAccJerk-mean()-X"               
    ## [346] "fBodyAccJerk-mean()-Y"               
    ## [347] "fBodyAccJerk-mean()-Z"               
    ## [348] "fBodyAccJerk-std()-X"                
    ## [349] "fBodyAccJerk-std()-Y"                
    ## [350] "fBodyAccJerk-std()-Z"                
    ## [351] "fBodyAccJerk-mad()-X"                
    ## [352] "fBodyAccJerk-mad()-Y"                
    ## [353] "fBodyAccJerk-mad()-Z"                
    ## [354] "fBodyAccJerk-max()-X"                
    ## [355] "fBodyAccJerk-max()-Y"                
    ## [356] "fBodyAccJerk-max()-Z"                
    ## [357] "fBodyAccJerk-min()-X"                
    ## [358] "fBodyAccJerk-min()-Y"                
    ## [359] "fBodyAccJerk-min()-Z"                
    ## [360] "fBodyAccJerk-sma()"                  
    ## [361] "fBodyAccJerk-energy()-X"             
    ## [362] "fBodyAccJerk-energy()-Y"             
    ## [363] "fBodyAccJerk-energy()-Z"             
    ## [364] "fBodyAccJerk-iqr()-X"                
    ## [365] "fBodyAccJerk-iqr()-Y"                
    ## [366] "fBodyAccJerk-iqr()-Z"                
    ## [367] "fBodyAccJerk-entropy()-X"            
    ## [368] "fBodyAccJerk-entropy()-Y"            
    ## [369] "fBodyAccJerk-entropy()-Z"            
    ## [370] "fBodyAccJerk-maxInds-X"              
    ## [371] "fBodyAccJerk-maxInds-Y"              
    ## [372] "fBodyAccJerk-maxInds-Z"              
    ## [373] "fBodyAccJerk-meanFreq()-X"           
    ## [374] "fBodyAccJerk-meanFreq()-Y"           
    ## [375] "fBodyAccJerk-meanFreq()-Z"           
    ## [376] "fBodyAccJerk-skewness()-X"           
    ## [377] "fBodyAccJerk-kurtosis()-X"           
    ## [378] "fBodyAccJerk-skewness()-Y"           
    ## [379] "fBodyAccJerk-kurtosis()-Y"           
    ## [380] "fBodyAccJerk-skewness()-Z"           
    ## [381] "fBodyAccJerk-kurtosis()-Z"           
    ## [382] "fBodyAccJerk-bandsEnergy()-1,8"      
    ## [383] "fBodyAccJerk-bandsEnergy()-9,16"     
    ## [384] "fBodyAccJerk-bandsEnergy()-17,24"    
    ## [385] "fBodyAccJerk-bandsEnergy()-25,32"    
    ## [386] "fBodyAccJerk-bandsEnergy()-33,40"    
    ## [387] "fBodyAccJerk-bandsEnergy()-41,48"    
    ## [388] "fBodyAccJerk-bandsEnergy()-49,56"    
    ## [389] "fBodyAccJerk-bandsEnergy()-57,64"    
    ## [390] "fBodyAccJerk-bandsEnergy()-1,16"     
    ## [391] "fBodyAccJerk-bandsEnergy()-17,32"    
    ## [392] "fBodyAccJerk-bandsEnergy()-33,48"    
    ## [393] "fBodyAccJerk-bandsEnergy()-49,64"    
    ## [394] "fBodyAccJerk-bandsEnergy()-1,24"     
    ## [395] "fBodyAccJerk-bandsEnergy()-25,48"    
    ## [396] "fBodyAccJerk-bandsEnergy()-1,8"      
    ## [397] "fBodyAccJerk-bandsEnergy()-9,16"     
    ## [398] "fBodyAccJerk-bandsEnergy()-17,24"    
    ## [399] "fBodyAccJerk-bandsEnergy()-25,32"    
    ## [400] "fBodyAccJerk-bandsEnergy()-33,40"    
    ## [401] "fBodyAccJerk-bandsEnergy()-41,48"    
    ## [402] "fBodyAccJerk-bandsEnergy()-49,56"    
    ## [403] "fBodyAccJerk-bandsEnergy()-57,64"    
    ## [404] "fBodyAccJerk-bandsEnergy()-1,16"     
    ## [405] "fBodyAccJerk-bandsEnergy()-17,32"    
    ## [406] "fBodyAccJerk-bandsEnergy()-33,48"    
    ## [407] "fBodyAccJerk-bandsEnergy()-49,64"    
    ## [408] "fBodyAccJerk-bandsEnergy()-1,24"     
    ## [409] "fBodyAccJerk-bandsEnergy()-25,48"    
    ## [410] "fBodyAccJerk-bandsEnergy()-1,8"      
    ## [411] "fBodyAccJerk-bandsEnergy()-9,16"     
    ## [412] "fBodyAccJerk-bandsEnergy()-17,24"    
    ## [413] "fBodyAccJerk-bandsEnergy()-25,32"    
    ## [414] "fBodyAccJerk-bandsEnergy()-33,40"    
    ## [415] "fBodyAccJerk-bandsEnergy()-41,48"    
    ## [416] "fBodyAccJerk-bandsEnergy()-49,56"    
    ## [417] "fBodyAccJerk-bandsEnergy()-57,64"    
    ## [418] "fBodyAccJerk-bandsEnergy()-1,16"     
    ## [419] "fBodyAccJerk-bandsEnergy()-17,32"    
    ## [420] "fBodyAccJerk-bandsEnergy()-33,48"    
    ## [421] "fBodyAccJerk-bandsEnergy()-49,64"    
    ## [422] "fBodyAccJerk-bandsEnergy()-1,24"     
    ## [423] "fBodyAccJerk-bandsEnergy()-25,48"    
    ## [424] "fBodyGyro-mean()-X"                  
    ## [425] "fBodyGyro-mean()-Y"                  
    ## [426] "fBodyGyro-mean()-Z"                  
    ## [427] "fBodyGyro-std()-X"                   
    ## [428] "fBodyGyro-std()-Y"                   
    ## [429] "fBodyGyro-std()-Z"                   
    ## [430] "fBodyGyro-mad()-X"                   
    ## [431] "fBodyGyro-mad()-Y"                   
    ## [432] "fBodyGyro-mad()-Z"                   
    ## [433] "fBodyGyro-max()-X"                   
    ## [434] "fBodyGyro-max()-Y"                   
    ## [435] "fBodyGyro-max()-Z"                   
    ## [436] "fBodyGyro-min()-X"                   
    ## [437] "fBodyGyro-min()-Y"                   
    ## [438] "fBodyGyro-min()-Z"                   
    ## [439] "fBodyGyro-sma()"                     
    ## [440] "fBodyGyro-energy()-X"                
    ## [441] "fBodyGyro-energy()-Y"                
    ## [442] "fBodyGyro-energy()-Z"                
    ## [443] "fBodyGyro-iqr()-X"                   
    ## [444] "fBodyGyro-iqr()-Y"                   
    ## [445] "fBodyGyro-iqr()-Z"                   
    ## [446] "fBodyGyro-entropy()-X"               
    ## [447] "fBodyGyro-entropy()-Y"               
    ## [448] "fBodyGyro-entropy()-Z"               
    ## [449] "fBodyGyro-maxInds-X"                 
    ## [450] "fBodyGyro-maxInds-Y"                 
    ## [451] "fBodyGyro-maxInds-Z"                 
    ## [452] "fBodyGyro-meanFreq()-X"              
    ## [453] "fBodyGyro-meanFreq()-Y"              
    ## [454] "fBodyGyro-meanFreq()-Z"              
    ## [455] "fBodyGyro-skewness()-X"              
    ## [456] "fBodyGyro-kurtosis()-X"              
    ## [457] "fBodyGyro-skewness()-Y"              
    ## [458] "fBodyGyro-kurtosis()-Y"              
    ## [459] "fBodyGyro-skewness()-Z"              
    ## [460] "fBodyGyro-kurtosis()-Z"              
    ## [461] "fBodyGyro-bandsEnergy()-1,8"         
    ## [462] "fBodyGyro-bandsEnergy()-9,16"        
    ## [463] "fBodyGyro-bandsEnergy()-17,24"       
    ## [464] "fBodyGyro-bandsEnergy()-25,32"       
    ## [465] "fBodyGyro-bandsEnergy()-33,40"       
    ## [466] "fBodyGyro-bandsEnergy()-41,48"       
    ## [467] "fBodyGyro-bandsEnergy()-49,56"       
    ## [468] "fBodyGyro-bandsEnergy()-57,64"       
    ## [469] "fBodyGyro-bandsEnergy()-1,16"        
    ## [470] "fBodyGyro-bandsEnergy()-17,32"       
    ## [471] "fBodyGyro-bandsEnergy()-33,48"       
    ## [472] "fBodyGyro-bandsEnergy()-49,64"       
    ## [473] "fBodyGyro-bandsEnergy()-1,24"        
    ## [474] "fBodyGyro-bandsEnergy()-25,48"       
    ## [475] "fBodyGyro-bandsEnergy()-1,8"         
    ## [476] "fBodyGyro-bandsEnergy()-9,16"        
    ## [477] "fBodyGyro-bandsEnergy()-17,24"       
    ## [478] "fBodyGyro-bandsEnergy()-25,32"       
    ## [479] "fBodyGyro-bandsEnergy()-33,40"       
    ## [480] "fBodyGyro-bandsEnergy()-41,48"       
    ## [481] "fBodyGyro-bandsEnergy()-49,56"       
    ## [482] "fBodyGyro-bandsEnergy()-57,64"       
    ## [483] "fBodyGyro-bandsEnergy()-1,16"        
    ## [484] "fBodyGyro-bandsEnergy()-17,32"       
    ## [485] "fBodyGyro-bandsEnergy()-33,48"       
    ## [486] "fBodyGyro-bandsEnergy()-49,64"       
    ## [487] "fBodyGyro-bandsEnergy()-1,24"        
    ## [488] "fBodyGyro-bandsEnergy()-25,48"       
    ## [489] "fBodyGyro-bandsEnergy()-1,8"         
    ## [490] "fBodyGyro-bandsEnergy()-9,16"        
    ## [491] "fBodyGyro-bandsEnergy()-17,24"       
    ## [492] "fBodyGyro-bandsEnergy()-25,32"       
    ## [493] "fBodyGyro-bandsEnergy()-33,40"       
    ## [494] "fBodyGyro-bandsEnergy()-41,48"       
    ## [495] "fBodyGyro-bandsEnergy()-49,56"       
    ## [496] "fBodyGyro-bandsEnergy()-57,64"       
    ## [497] "fBodyGyro-bandsEnergy()-1,16"        
    ## [498] "fBodyGyro-bandsEnergy()-17,32"       
    ## [499] "fBodyGyro-bandsEnergy()-33,48"       
    ## [500] "fBodyGyro-bandsEnergy()-49,64"       
    ## [501] "fBodyGyro-bandsEnergy()-1,24"        
    ## [502] "fBodyGyro-bandsEnergy()-25,48"       
    ## [503] "fBodyAccMag-mean()"                  
    ## [504] "fBodyAccMag-std()"                   
    ## [505] "fBodyAccMag-mad()"                   
    ## [506] "fBodyAccMag-max()"                   
    ## [507] "fBodyAccMag-min()"                   
    ## [508] "fBodyAccMag-sma()"                   
    ## [509] "fBodyAccMag-energy()"                
    ## [510] "fBodyAccMag-iqr()"                   
    ## [511] "fBodyAccMag-entropy()"               
    ## [512] "fBodyAccMag-maxInds"                 
    ## [513] "fBodyAccMag-meanFreq()"              
    ## [514] "fBodyAccMag-skewness()"              
    ## [515] "fBodyAccMag-kurtosis()"              
    ## [516] "fBodyBodyAccJerkMag-mean()"          
    ## [517] "fBodyBodyAccJerkMag-std()"           
    ## [518] "fBodyBodyAccJerkMag-mad()"           
    ## [519] "fBodyBodyAccJerkMag-max()"           
    ## [520] "fBodyBodyAccJerkMag-min()"           
    ## [521] "fBodyBodyAccJerkMag-sma()"           
    ## [522] "fBodyBodyAccJerkMag-energy()"        
    ## [523] "fBodyBodyAccJerkMag-iqr()"           
    ## [524] "fBodyBodyAccJerkMag-entropy()"       
    ## [525] "fBodyBodyAccJerkMag-maxInds"         
    ## [526] "fBodyBodyAccJerkMag-meanFreq()"      
    ## [527] "fBodyBodyAccJerkMag-skewness()"      
    ## [528] "fBodyBodyAccJerkMag-kurtosis()"      
    ## [529] "fBodyBodyGyroMag-mean()"             
    ## [530] "fBodyBodyGyroMag-std()"              
    ## [531] "fBodyBodyGyroMag-mad()"              
    ## [532] "fBodyBodyGyroMag-max()"              
    ## [533] "fBodyBodyGyroMag-min()"              
    ## [534] "fBodyBodyGyroMag-sma()"              
    ## [535] "fBodyBodyGyroMag-energy()"           
    ## [536] "fBodyBodyGyroMag-iqr()"              
    ## [537] "fBodyBodyGyroMag-entropy()"          
    ## [538] "fBodyBodyGyroMag-maxInds"            
    ## [539] "fBodyBodyGyroMag-meanFreq()"         
    ## [540] "fBodyBodyGyroMag-skewness()"         
    ## [541] "fBodyBodyGyroMag-kurtosis()"         
    ## [542] "fBodyBodyGyroJerkMag-mean()"         
    ## [543] "fBodyBodyGyroJerkMag-std()"          
    ## [544] "fBodyBodyGyroJerkMag-mad()"          
    ## [545] "fBodyBodyGyroJerkMag-max()"          
    ## [546] "fBodyBodyGyroJerkMag-min()"          
    ## [547] "fBodyBodyGyroJerkMag-sma()"          
    ## [548] "fBodyBodyGyroJerkMag-energy()"       
    ## [549] "fBodyBodyGyroJerkMag-iqr()"          
    ## [550] "fBodyBodyGyroJerkMag-entropy()"      
    ## [551] "fBodyBodyGyroJerkMag-maxInds"        
    ## [552] "fBodyBodyGyroJerkMag-meanFreq()"     
    ## [553] "fBodyBodyGyroJerkMag-skewness()"     
    ## [554] "fBodyBodyGyroJerkMag-kurtosis()"     
    ## [555] "angle(tBodyAccMean,gravity)"         
    ## [556] "angle(tBodyAccJerkMean),gravityMean)"
    ## [557] "angle(tBodyGyroMean,gravityMean)"    
    ## [558] "angle(tBodyGyroJerkMean,gravityMean)"
    ## [559] "angle(X,gravityMean)"                
    ## [560] "angle(Y,gravityMean)"                
    ## [561] "angle(Z,gravityMean)"

    names(Act_Labels) <- c("Activity","ActivityName")
    head(Act_Labels)

    ##   Activity       ActivityName
    ## 1        1            WALKING
    ## 2        2   WALKING_UPSTAIRS
    ## 3        3 WALKING_DOWNSTAIRS
    ## 4        4            SITTING
    ## 5        5           STANDING
    ## 6        6             LAYING

2. Extracts only the measurements on the mean and standard deviation for each measurement
=========================================================================================

    d <- d_Feat[,grep("mean\\(\\)|std\\(\\)",d_Feat_Names[,2])]
    names(d)

    ##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
    ##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
    ##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
    ##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
    ##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
    ## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
    ## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
    ## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
    ## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
    ## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
    ## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
    ## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
    ## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
    ## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
    ## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
    ## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
    ## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
    ## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
    ## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
    ## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
    ## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
    ## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
    ## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
    ## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
    ## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
    ## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
    ## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
    ## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
    ## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
    ## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
    ## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
    ## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
    ## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"

Marge data by comlumns
----------------------

    d <- cbind(d,d_Sub,d_Act)
    names(d)

    ##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
    ##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
    ##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
    ##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
    ##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
    ## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
    ## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
    ## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
    ## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
    ## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
    ## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
    ## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
    ## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
    ## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
    ## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
    ## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
    ## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
    ## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
    ## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
    ## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
    ## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
    ## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
    ## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
    ## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
    ## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
    ## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
    ## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
    ## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
    ## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
    ## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
    ## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
    ## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
    ## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 
    ## [67] "Subject"                     "Activity"

    rm(list=c("d_Feat","d_Sub","d_Act","d_Feat_Names"))

3. Uses descriptive activity names to name the activities in the data set
=========================================================================

    d <- merge(x=d,y=Act_Labels,by="Activity")
    str(d)

    ## 'data.frame':    10299 obs. of  69 variables:
    ##  $ Activity                   : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ tBodyAcc-mean()-X          : num  0.269 0.262 0.238 0.245 0.249 ...
    ##  $ tBodyAcc-mean()-Y          : num  0.00789 -0.01622 0.0021 -0.03155 -0.02112 ...
    ##  $ tBodyAcc-mean()-Z          : num  -0.0507 -0.1145 -0.0499 -0.1814 -0.1249 ...
    ##  $ tBodyAcc-std()-X           : num  -0.264 -0.415 -0.338 -0.311 -0.491 ...
    ##  $ tBodyAcc-std()-Y           : num  0.0324 0.1461 0.0563 0.0977 -0.1977 ...
    ##  $ tBodyAcc-std()-Z           : num  0.10128 -0.10997 0.00291 0.09829 -0.58428 ...
    ##  $ tGravityAcc-mean()-X       : num  0.959 0.847 0.969 0.958 0.945 ...
    ##  $ tGravityAcc-mean()-Y       : num  -0.184 -0.384 -0.183 -0.184 -0.237 ...
    ##  $ tGravityAcc-mean()-Z       : num  -0.00944 -0.23933 -0.00224 -0.00334 0.10031 ...
    ##  $ tGravityAcc-std()-X        : num  -0.985 -0.99 -0.969 -0.989 -0.988 ...
    ##  $ tGravityAcc-std()-Y        : num  -0.99 -0.989 -0.9 -0.991 -0.974 ...
    ##  $ tGravityAcc-std()-Z        : num  -0.957 -0.976 -0.941 -0.935 -0.976 ...
    ##  $ tBodyAccJerk-mean()-X      : num  0.3385 0.0133 0.3759 -0.2658 0.132 ...
    ##  $ tBodyAccJerk-mean()-Y      : num  -0.5209 0.3167 0.0819 0.1414 0.2389 ...
    ##  $ tBodyAccJerk-mean()-Z      : num  0.0602 -0.1015 -0.0292 0.318 -0.0623 ...
    ##  $ tBodyAccJerk-std()-X       : num  -0.268 -0.307 -0.346 -0.354 -0.493 ...
    ##  $ tBodyAccJerk-std()-Y       : num  0.0823 0.1793 0.0613 0.1009 -0.2339 ...
    ##  $ tBodyAccJerk-std()-Z       : num  -0.158 -0.362 -0.28 -0.145 -0.7 ...
    ##  $ tBodyGyro-mean()-X         : num  -0.10582 0.02902 0.20912 -0.04965 -0.00734 ...
    ##  $ tBodyGyro-mean()-Y         : num  -0.0136 -0.098 -0.1452 -0.0874 -0.1364 ...
    ##  $ tBodyGyro-mean()-Z         : num  0.1441 0.029 -0.0385 0.0581 0.0996 ...
    ##  $ tBodyGyro-std()-X          : num  -0.456 -0.431 -0.416 -0.452 -0.653 ...
    ##  $ tBodyGyro-std()-Y          : num  -0.174 -0.414 -0.149 -0.136 -0.55 ...
    ##  $ tBodyGyro-std()-Z          : num  -0.348 -0.25 -0.397 -0.394 -0.575 ...
    ##  $ tBodyGyroJerk-mean()-X     : num  -0.0497 -0.054 -0.2218 -0.1815 -0.0812 ...
    ##  $ tBodyGyroJerk-mean()-Y     : num  -0.4349 -0.0727 -0.2108 0.3012 0.031 ...
    ##  $ tBodyGyroJerk-mean()-Z     : num  0.21371 -0.095621 0.05902 -0.000464 -0.001021 ...
    ##  $ tBodyGyroJerk-std()-X      : num  -0.0468 -0.1447 -0.1348 -0.061 -0.4653 ...
    ##  $ tBodyGyroJerk-std()-Y      : num  -0.0638 -0.5364 -0.1239 -0.0829 -0.7853 ...
    ##  $ tBodyGyroJerk-std()-Z      : num  -0.325 -0.441 -0.365 -0.381 -0.683 ...
    ##  $ tBodyAccMag-mean()         : num  -0.0527 -0.1468 -0.1175 -0.0683 -0.3928 ...
    ##  $ tBodyAccMag-std()          : num  -0.191 -0.354 -0.231 -0.184 -0.516 ...
    ##  $ tGravityAccMag-mean()      : num  -0.0527 -0.1468 -0.1175 -0.0683 -0.3928 ...
    ##  $ tGravityAccMag-std()       : num  -0.191 -0.354 -0.231 -0.184 -0.516 ...
    ##  $ tBodyAccJerkMag-mean()     : num  -0.151 -0.135 -0.215 -0.163 -0.439 ...
    ##  $ tBodyAccJerkMag-std()      : num  0.0756 -0.1427 -0.0429 0.0328 -0.4684 ...
    ##  $ tBodyGyroMag-mean()        : num  -0.278 -0.278 -0.196 -0.269 -0.52 ...
    ##  $ tBodyGyroMag-std()         : num  -0.0832 -0.433 -0.1161 -0.0676 -0.647 ...
    ##  $ tBodyGyroJerkMag-mean()    : num  -0.228 -0.417 -0.27 -0.222 -0.662 ...
    ##  $ tBodyGyroJerkMag-std()     : num  0.1026 -0.46407 0.00768 0.0401 -0.74075 ...
    ##  $ fBodyAcc-mean()-X          : num  -0.277 -0.408 -0.329 -0.294 -0.471 ...
    ##  $ fBodyAcc-mean()-Y          : num  0.0391 0.1639 0.1228 0.1135 -0.2011 ...
    ##  $ fBodyAcc-mean()-Z          : num  0.00668 -0.25762 -0.08493 0.02308 -0.60115 ...
    ##  $ fBodyAcc-std()-X           : num  -0.259 -0.418 -0.341 -0.318 -0.499 ...
    ##  $ fBodyAcc-std()-Y           : num  -0.0365 0.0637 -0.0485 0.0195 -0.2463 ...
    ##  $ fBodyAcc-std()-Z           : num  0.0664 -0.1017 -0.0279 0.053 -0.6074 ...
    ##  $ fBodyAccJerk-mean()-X      : num  -0.337 -0.342 -0.377 -0.38 -0.483 ...
    ##  $ fBodyAccJerk-mean()-Y      : num  0.01362 0.07445 0.02506 0.00876 -0.32625 ...
    ##  $ fBodyAccJerk-mean()-Z      : num  -0.0791 -0.336 -0.2238 -0.0366 -0.659 ...
    ##  $ fBodyAccJerk-std()-X       : num  -0.261 -0.332 -0.371 -0.384 -0.552 ...
    ##  $ fBodyAccJerk-std()-Y       : num  0.0863 0.2162 0.0291 0.1292 -0.1848 ...
    ##  $ fBodyAccJerk-std()-Z       : num  -0.235 -0.384 -0.333 -0.253 -0.742 ...
    ##  $ fBodyGyro-mean()-X         : num  -0.218 -0.19 -0.185 -0.241 -0.539 ...
    ##  $ fBodyGyro-mean()-Y         : num  -0.0692 -0.3884 -0.0481 -0.0403 -0.6357 ...
    ##  $ fBodyGyro-mean()-Z         : num  -0.253 -0.243 -0.31 -0.327 -0.548 ...
    ##  $ fBodyGyro-std()-X          : num  -0.534 -0.51 -0.491 -0.52 -0.689 ...
    ##  $ fBodyGyro-std()-Y          : num  -0.252 -0.434 -0.223 -0.208 -0.507 ...
    ##  $ fBodyGyro-std()-Z          : num  -0.441 -0.321 -0.483 -0.473 -0.623 ...
    ##  $ fBodyAccMag-mean()         : num  -0.163 -0.361 -0.148 -0.166 -0.463 ...
    ##  $ fBodyAccMag-std()          : num  -0.333 -0.45 -0.402 -0.32 -0.623 ...
    ##  $ fBodyBodyAccJerkMag-mean() : num  0.07021 -0.21814 -0.02705 -0.00175 -0.50183 ...
    ##  $ fBodyBodyAccJerkMag-std()  : num  0.0781 -0.0583 -0.068 0.068 -0.4311 ...
    ##  $ fBodyBodyGyroMag-mean()    : num  -0.0327 -0.4858 -0.0451 -0.0359 -0.6719 ...
    ##  $ fBodyBodyGyroMag-std()     : num  -0.287 -0.494 -0.333 -0.258 -0.69 ...
    ##  $ fBodyBodyGyroJerkMag-mean(): num  0.0127 -0.5613 -0.0222 -0.0623 -0.7403 ...
    ##  $ fBodyBodyGyroJerkMag-std() : num  0.1383 -0.3929 -0.0248 0.0916 -0.7591 ...
    ##  $ Subject                    : int  7 21 7 7 18 7 7 7 11 21 ...
    ##  $ ActivityName               : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...

4. Appropriately labels the data set with descriptive variable names.
=====================================================================

Rename columns:  
. t -\> time  
. f -\> frequency  
. Acc -\> Accelerometer  
. BodyBody -\> Body  
. Gyro -\> Gyroscope  
. Mag -\> Magnitude

    names(d)<-gsub("^t", "time", names(d))            # t -> time
    names(d)<-gsub("^f", "frequency", names(d))       # f -> frequency
    names(d)<-gsub("Acc", "Accelerometer", names(d))  # Acc -> Accelerometer
    names(d)<-gsub("BodyBody", "Body", names(d))      # BodyBody -> Body
    names(d)<-gsub("Gyro", "Gyroscope", names(d))     # Gyro -> Gyroscope
    names(d)<-gsub("Mag", "Magnitude", names(d))      # Mag -> Magnitude
    str(d)

    ## 'data.frame':    10299 obs. of  69 variables:
    ##  $ Activity                                      : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ timeBodyAccelerometer-mean()-X                : num  0.269 0.262 0.238 0.245 0.249 ...
    ##  $ timeBodyAccelerometer-mean()-Y                : num  0.00789 -0.01622 0.0021 -0.03155 -0.02112 ...
    ##  $ timeBodyAccelerometer-mean()-Z                : num  -0.0507 -0.1145 -0.0499 -0.1814 -0.1249 ...
    ##  $ timeBodyAccelerometer-std()-X                 : num  -0.264 -0.415 -0.338 -0.311 -0.491 ...
    ##  $ timeBodyAccelerometer-std()-Y                 : num  0.0324 0.1461 0.0563 0.0977 -0.1977 ...
    ##  $ timeBodyAccelerometer-std()-Z                 : num  0.10128 -0.10997 0.00291 0.09829 -0.58428 ...
    ##  $ timeGravityAccelerometer-mean()-X             : num  0.959 0.847 0.969 0.958 0.945 ...
    ##  $ timeGravityAccelerometer-mean()-Y             : num  -0.184 -0.384 -0.183 -0.184 -0.237 ...
    ##  $ timeGravityAccelerometer-mean()-Z             : num  -0.00944 -0.23933 -0.00224 -0.00334 0.10031 ...
    ##  $ timeGravityAccelerometer-std()-X              : num  -0.985 -0.99 -0.969 -0.989 -0.988 ...
    ##  $ timeGravityAccelerometer-std()-Y              : num  -0.99 -0.989 -0.9 -0.991 -0.974 ...
    ##  $ timeGravityAccelerometer-std()-Z              : num  -0.957 -0.976 -0.941 -0.935 -0.976 ...
    ##  $ timeBodyAccelerometerJerk-mean()-X            : num  0.3385 0.0133 0.3759 -0.2658 0.132 ...
    ##  $ timeBodyAccelerometerJerk-mean()-Y            : num  -0.5209 0.3167 0.0819 0.1414 0.2389 ...
    ##  $ timeBodyAccelerometerJerk-mean()-Z            : num  0.0602 -0.1015 -0.0292 0.318 -0.0623 ...
    ##  $ timeBodyAccelerometerJerk-std()-X             : num  -0.268 -0.307 -0.346 -0.354 -0.493 ...
    ##  $ timeBodyAccelerometerJerk-std()-Y             : num  0.0823 0.1793 0.0613 0.1009 -0.2339 ...
    ##  $ timeBodyAccelerometerJerk-std()-Z             : num  -0.158 -0.362 -0.28 -0.145 -0.7 ...
    ##  $ timeBodyGyroscope-mean()-X                    : num  -0.10582 0.02902 0.20912 -0.04965 -0.00734 ...
    ##  $ timeBodyGyroscope-mean()-Y                    : num  -0.0136 -0.098 -0.1452 -0.0874 -0.1364 ...
    ##  $ timeBodyGyroscope-mean()-Z                    : num  0.1441 0.029 -0.0385 0.0581 0.0996 ...
    ##  $ timeBodyGyroscope-std()-X                     : num  -0.456 -0.431 -0.416 -0.452 -0.653 ...
    ##  $ timeBodyGyroscope-std()-Y                     : num  -0.174 -0.414 -0.149 -0.136 -0.55 ...
    ##  $ timeBodyGyroscope-std()-Z                     : num  -0.348 -0.25 -0.397 -0.394 -0.575 ...
    ##  $ timeBodyGyroscopeJerk-mean()-X                : num  -0.0497 -0.054 -0.2218 -0.1815 -0.0812 ...
    ##  $ timeBodyGyroscopeJerk-mean()-Y                : num  -0.4349 -0.0727 -0.2108 0.3012 0.031 ...
    ##  $ timeBodyGyroscopeJerk-mean()-Z                : num  0.21371 -0.095621 0.05902 -0.000464 -0.001021 ...
    ##  $ timeBodyGyroscopeJerk-std()-X                 : num  -0.0468 -0.1447 -0.1348 -0.061 -0.4653 ...
    ##  $ timeBodyGyroscopeJerk-std()-Y                 : num  -0.0638 -0.5364 -0.1239 -0.0829 -0.7853 ...
    ##  $ timeBodyGyroscopeJerk-std()-Z                 : num  -0.325 -0.441 -0.365 -0.381 -0.683 ...
    ##  $ timeBodyAccelerometerMagnitude-mean()         : num  -0.0527 -0.1468 -0.1175 -0.0683 -0.3928 ...
    ##  $ timeBodyAccelerometerMagnitude-std()          : num  -0.191 -0.354 -0.231 -0.184 -0.516 ...
    ##  $ timeGravityAccelerometerMagnitude-mean()      : num  -0.0527 -0.1468 -0.1175 -0.0683 -0.3928 ...
    ##  $ timeGravityAccelerometerMagnitude-std()       : num  -0.191 -0.354 -0.231 -0.184 -0.516 ...
    ##  $ timeBodyAccelerometerJerkMagnitude-mean()     : num  -0.151 -0.135 -0.215 -0.163 -0.439 ...
    ##  $ timeBodyAccelerometerJerkMagnitude-std()      : num  0.0756 -0.1427 -0.0429 0.0328 -0.4684 ...
    ##  $ timeBodyGyroscopeMagnitude-mean()             : num  -0.278 -0.278 -0.196 -0.269 -0.52 ...
    ##  $ timeBodyGyroscopeMagnitude-std()              : num  -0.0832 -0.433 -0.1161 -0.0676 -0.647 ...
    ##  $ timeBodyGyroscopeJerkMagnitude-mean()         : num  -0.228 -0.417 -0.27 -0.222 -0.662 ...
    ##  $ timeBodyGyroscopeJerkMagnitude-std()          : num  0.1026 -0.46407 0.00768 0.0401 -0.74075 ...
    ##  $ frequencyBodyAccelerometer-mean()-X           : num  -0.277 -0.408 -0.329 -0.294 -0.471 ...
    ##  $ frequencyBodyAccelerometer-mean()-Y           : num  0.0391 0.1639 0.1228 0.1135 -0.2011 ...
    ##  $ frequencyBodyAccelerometer-mean()-Z           : num  0.00668 -0.25762 -0.08493 0.02308 -0.60115 ...
    ##  $ frequencyBodyAccelerometer-std()-X            : num  -0.259 -0.418 -0.341 -0.318 -0.499 ...
    ##  $ frequencyBodyAccelerometer-std()-Y            : num  -0.0365 0.0637 -0.0485 0.0195 -0.2463 ...
    ##  $ frequencyBodyAccelerometer-std()-Z            : num  0.0664 -0.1017 -0.0279 0.053 -0.6074 ...
    ##  $ frequencyBodyAccelerometerJerk-mean()-X       : num  -0.337 -0.342 -0.377 -0.38 -0.483 ...
    ##  $ frequencyBodyAccelerometerJerk-mean()-Y       : num  0.01362 0.07445 0.02506 0.00876 -0.32625 ...
    ##  $ frequencyBodyAccelerometerJerk-mean()-Z       : num  -0.0791 -0.336 -0.2238 -0.0366 -0.659 ...
    ##  $ frequencyBodyAccelerometerJerk-std()-X        : num  -0.261 -0.332 -0.371 -0.384 -0.552 ...
    ##  $ frequencyBodyAccelerometerJerk-std()-Y        : num  0.0863 0.2162 0.0291 0.1292 -0.1848 ...
    ##  $ frequencyBodyAccelerometerJerk-std()-Z        : num  -0.235 -0.384 -0.333 -0.253 -0.742 ...
    ##  $ frequencyBodyGyroscope-mean()-X               : num  -0.218 -0.19 -0.185 -0.241 -0.539 ...
    ##  $ frequencyBodyGyroscope-mean()-Y               : num  -0.0692 -0.3884 -0.0481 -0.0403 -0.6357 ...
    ##  $ frequencyBodyGyroscope-mean()-Z               : num  -0.253 -0.243 -0.31 -0.327 -0.548 ...
    ##  $ frequencyBodyGyroscope-std()-X                : num  -0.534 -0.51 -0.491 -0.52 -0.689 ...
    ##  $ frequencyBodyGyroscope-std()-Y                : num  -0.252 -0.434 -0.223 -0.208 -0.507 ...
    ##  $ frequencyBodyGyroscope-std()-Z                : num  -0.441 -0.321 -0.483 -0.473 -0.623 ...
    ##  $ frequencyBodyAccelerometerMagnitude-mean()    : num  -0.163 -0.361 -0.148 -0.166 -0.463 ...
    ##  $ frequencyBodyAccelerometerMagnitude-std()     : num  -0.333 -0.45 -0.402 -0.32 -0.623 ...
    ##  $ frequencyBodyAccelerometerJerkMagnitude-mean(): num  0.07021 -0.21814 -0.02705 -0.00175 -0.50183 ...
    ##  $ frequencyBodyAccelerometerJerkMagnitude-std() : num  0.0781 -0.0583 -0.068 0.068 -0.4311 ...
    ##  $ frequencyBodyGyroscopeMagnitude-mean()        : num  -0.0327 -0.4858 -0.0451 -0.0359 -0.6719 ...
    ##  $ frequencyBodyGyroscopeMagnitude-std()         : num  -0.287 -0.494 -0.333 -0.258 -0.69 ...
    ##  $ frequencyBodyGyroscopeJerkMagnitude-mean()    : num  0.0127 -0.5613 -0.0222 -0.0623 -0.7403 ...
    ##  $ frequencyBodyGyroscopeJerkMagnitude-std()     : num  0.1383 -0.3929 -0.0248 0.0916 -0.7591 ...
    ##  $ Subject                                       : int  7 21 7 7 18 7 7 7 11 21 ...
    ##  $ ActivityName                                  : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
=================================================================================================================================================

Convert to long format

    d_rows <-  melt(d, id=c("Activity","ActivityName","Subject"))
    names(d_rows)

    ## [1] "Activity"     "ActivityName" "Subject"      "variable"    
    ## [5] "value"

Compute means

    d_avg  <-  dcast(data = d_rows, formula = Activity+ActivityName+Subject~variable, fun.aggregate = mean)
    names(d_avg)

    ##  [1] "Activity"                                      
    ##  [2] "ActivityName"                                  
    ##  [3] "Subject"                                       
    ##  [4] "timeBodyAccelerometer-mean()-X"                
    ##  [5] "timeBodyAccelerometer-mean()-Y"                
    ##  [6] "timeBodyAccelerometer-mean()-Z"                
    ##  [7] "timeBodyAccelerometer-std()-X"                 
    ##  [8] "timeBodyAccelerometer-std()-Y"                 
    ##  [9] "timeBodyAccelerometer-std()-Z"                 
    ## [10] "timeGravityAccelerometer-mean()-X"             
    ## [11] "timeGravityAccelerometer-mean()-Y"             
    ## [12] "timeGravityAccelerometer-mean()-Z"             
    ## [13] "timeGravityAccelerometer-std()-X"              
    ## [14] "timeGravityAccelerometer-std()-Y"              
    ## [15] "timeGravityAccelerometer-std()-Z"              
    ## [16] "timeBodyAccelerometerJerk-mean()-X"            
    ## [17] "timeBodyAccelerometerJerk-mean()-Y"            
    ## [18] "timeBodyAccelerometerJerk-mean()-Z"            
    ## [19] "timeBodyAccelerometerJerk-std()-X"             
    ## [20] "timeBodyAccelerometerJerk-std()-Y"             
    ## [21] "timeBodyAccelerometerJerk-std()-Z"             
    ## [22] "timeBodyGyroscope-mean()-X"                    
    ## [23] "timeBodyGyroscope-mean()-Y"                    
    ## [24] "timeBodyGyroscope-mean()-Z"                    
    ## [25] "timeBodyGyroscope-std()-X"                     
    ## [26] "timeBodyGyroscope-std()-Y"                     
    ## [27] "timeBodyGyroscope-std()-Z"                     
    ## [28] "timeBodyGyroscopeJerk-mean()-X"                
    ## [29] "timeBodyGyroscopeJerk-mean()-Y"                
    ## [30] "timeBodyGyroscopeJerk-mean()-Z"                
    ## [31] "timeBodyGyroscopeJerk-std()-X"                 
    ## [32] "timeBodyGyroscopeJerk-std()-Y"                 
    ## [33] "timeBodyGyroscopeJerk-std()-Z"                 
    ## [34] "timeBodyAccelerometerMagnitude-mean()"         
    ## [35] "timeBodyAccelerometerMagnitude-std()"          
    ## [36] "timeGravityAccelerometerMagnitude-mean()"      
    ## [37] "timeGravityAccelerometerMagnitude-std()"       
    ## [38] "timeBodyAccelerometerJerkMagnitude-mean()"     
    ## [39] "timeBodyAccelerometerJerkMagnitude-std()"      
    ## [40] "timeBodyGyroscopeMagnitude-mean()"             
    ## [41] "timeBodyGyroscopeMagnitude-std()"              
    ## [42] "timeBodyGyroscopeJerkMagnitude-mean()"         
    ## [43] "timeBodyGyroscopeJerkMagnitude-std()"          
    ## [44] "frequencyBodyAccelerometer-mean()-X"           
    ## [45] "frequencyBodyAccelerometer-mean()-Y"           
    ## [46] "frequencyBodyAccelerometer-mean()-Z"           
    ## [47] "frequencyBodyAccelerometer-std()-X"            
    ## [48] "frequencyBodyAccelerometer-std()-Y"            
    ## [49] "frequencyBodyAccelerometer-std()-Z"            
    ## [50] "frequencyBodyAccelerometerJerk-mean()-X"       
    ## [51] "frequencyBodyAccelerometerJerk-mean()-Y"       
    ## [52] "frequencyBodyAccelerometerJerk-mean()-Z"       
    ## [53] "frequencyBodyAccelerometerJerk-std()-X"        
    ## [54] "frequencyBodyAccelerometerJerk-std()-Y"        
    ## [55] "frequencyBodyAccelerometerJerk-std()-Z"        
    ## [56] "frequencyBodyGyroscope-mean()-X"               
    ## [57] "frequencyBodyGyroscope-mean()-Y"               
    ## [58] "frequencyBodyGyroscope-mean()-Z"               
    ## [59] "frequencyBodyGyroscope-std()-X"                
    ## [60] "frequencyBodyGyroscope-std()-Y"                
    ## [61] "frequencyBodyGyroscope-std()-Z"                
    ## [62] "frequencyBodyAccelerometerMagnitude-mean()"    
    ## [63] "frequencyBodyAccelerometerMagnitude-std()"     
    ## [64] "frequencyBodyAccelerometerJerkMagnitude-mean()"
    ## [65] "frequencyBodyAccelerometerJerkMagnitude-std()" 
    ## [66] "frequencyBodyGyroscopeMagnitude-mean()"        
    ## [67] "frequencyBodyGyroscopeMagnitude-std()"         
    ## [68] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
    ## [69] "frequencyBodyGyroscopeJerkMagnitude-std()"

Write the file
--------------

    write.table(x = d_avg, file = "Dataset_out.txt", row.names = FALSE)

END
---
