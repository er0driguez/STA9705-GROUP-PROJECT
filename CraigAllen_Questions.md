# Do the olive oils have underlying patterns in their fatty acids that we can better explain using principal components? 

Based on the scree plot generated, there is an elbow at 4 eigenvalues so we will select three. Additionally, the first thre eigenvalues explain ~81% of the variance. 

The first factor appears to be detecting if the olive oil contains stearic acid and/or oleic acid or not.  The first principal component contains ~46.5% of the variance. 

The second factor separates palmitic, palmitoleic, and linoleic acids from other acids. The second principal component contains approximately 22% of the variance. 

The third factor is constructed with oliec, linoleic, linolenic, and arachidic fatty acids. The third principal component accounts for ~12.7% of the variance. 


Post varimax rotation, we see a different pattern. The first factor contains pleic, palmitic, palmitoleic, and linoleic acids.
The second factor contains linolenic, arachidic, and eicosenoic acids. The third factor is primarily constructed from stearic acid. 




# Can we predict where an olive oil is from just based on its fatty acid profile? 

The fatty acids within the olive oil very strongly predict the region that the oil was sourced from. 

From the acid profile alone, the quadratic disciminant analysis is able to perfectly separate the data into the three source regions in the olive oil data set with no mis classification errors. 

The cross validation performed also contributes significant evidence that the regions have oilve out with very distinct fatty acid profiles. 


Moving onto the more granular region, we must note that the region of Apulia from the south of Italy appears in ~200 of our 572 data points. 

During cross validation of the data, we see a total misclassification rate of ~3.38%.

Many of these misclassifications make sense geographically. The Coast of Sardinia and the Inland of Sardinia are on the same island. Sicily, South-Apulia, and Calabria are all in the south of Italy. 

The most interesting finding is the 0% misclassification rate of Umbria's olive oil. This suggests that the properties of Umbrian olive oil are distinct from olive oil from all other regions.
