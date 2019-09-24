# AppleMusicDemo
The user can use AppleMusicDemo search artist, download and play the preview of the artist's song by streaming or from offline.
## Prerequisites
Xcode 10.2+

Swift 5+

iOS 11.0+
## Installing
`git clone https://github.com/Xavierklop/AppleMusicDemo.git`
## Overview
The following features are provided by this app:

 1. Search for the artist's album by artist's name
 2. Select the relevant album to view the songs in the album.
 3. Download the essential information and preview of the song. The user can pause, resume, or cancel the preview being downloaded.
 5. The download progress of the song's preview will be displayed.
 4. Play the preview of the artist's song by streaming or from offline.
### Main View controllers
#### RootViewController
The root view controller of the app. In the future, you can add the function of login here.
#### SearchResultsController
The user can access the search view by search item in the tab bar. The user can search artist by artist's name. After the user type artist's name in the search field the App will call iTunes API to get all matched results and display results in the table view. The user can select a artist to check all albums of the artist.
#### AlbumListController
The AlbumListController display all albums of a artist. The user can select a album to check all songs of the album.
#### AlbumDetailController
The AlbumDetailController display all songs of a album. The user can download, pause, resume or cancel a song's preview. The user can view the download process of preview. If the preview is downloaded, user can play the preview.
#### DownloadedSongController
The DownloadedSongController display all downloaded song's preview. The user can play the preview offline here.
## Technical features
- Use Itunes API to search artist, album and song.
- Use URLSession to manager all API request and download audio and image in background.
- Use Decodable to parse JSON.
- Use Core Data to persistent song's preview, album image and song infomation. 
- All changes to the downloaded song's preview can be automatically made persistent.
- The audio files are storing in the local file system.
- Use AVPlayerViewController to play audio.
## License
This code may be used free of cost for a non-commercial purpose, provided the intended usage is notified to the owner via the below email address.
Any questions, please email wuhaocll@gmail.com
