# VineViewer_iOS Quick Overview:
- Connects to the social media Vine Rest API
- Downloads, plays, and streams media (movies + images) with HTTP requests
- Constructed under the Modal View Controller premise, with an emphasis in escapulation
- Features cocoa pods,  physics like animation, and media caching
- Committed using GIT


- Screen & graphics built to look natural on all iPhone screen sizes (3.5" to 5.5")

##How did I structure this application in terms of architecture?
From the beginning I wanted to construct this application with the guidelines set by the Modal View Controller architecture design pattern. But I also wanted to place an emphasis on escapulation, so the code would be easier to maintain and update.

I wanted everything to be organized and easy to read, so I divided the project's classes into folders. 
Screen 1 - Video List: holds the VideosTableViewController and CustomCell. This is the Table View Controller and it's custom table view cell, respectively. <br>
Screen 2 - Detail View: holds DetailViewController, the class responsible for showing the detail of the selected row & video.<br>
Categories - : Holds NSObject+ConnectionController and NSString+StringHelperMethods, the modal layer and methods used for strings throughout the app<br>

All logic for the Table View Controller happens in VideosTableViewController. The setting up of the individual Table View Cell happens in CustomCell. 

All network calls happen in the modal layer (NSObject+ConnectionController). Here it is easier to maintain all network calls that may enter. The exception to this rule is the network call made by the movie player. The reason the network call is not in the modal layer, is because MPMoviePlayerController's single line network call is already escapulated enough, and would be redudant to write more code. The other reason the media player's network call is in the DetailView class, is because the main point of the DetailView is to play and display the media. Having the code concise and maintainable is key.

##Exception Handling
Exception handling is very important. The user is alerted at any time if the data network fails, or is not working. This exception handling happens in the modal layer.

##Are there any external resources/libraries that can help?
Because this is a media extensive application, I wanted to cache media in order to save data and time. I used the dependency manager Cocoa Pods and installed "SAMCache" in order to do so. As far as shortening numbers (1000 into 1k), and manipulating date formats.. I created my own methods/solutions in StringHelperMethods.

