# Marley Spoon

This repository contains a simple app displaying a list of recipes and details for these recipes.
The project was done using Xcode 11.2 and the target iOS version is 13.\n
The project includes a dependency -> SDWebImage (https://github.com/SDWebImage/SDWebImage) used to download and cache images.\n
The project includes a submodule -> NetworkLayer (https://github.com/adriana-elizondo/networklayer) used for networking.\n
To run the project:

1. Clone the repository.
2. Inside the root folder run, git submodule init, then git submodule update, to download the NetworkLayer submodule.
3. Open MarleySpoon.xcodeproj using Xcode and wait until all the dependencies are loaded.
4. Select the MarleySpoon target and run in the simulator of your choice.
5. Tap any recipe to see more details.

