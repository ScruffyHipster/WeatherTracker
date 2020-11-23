# Welcome to Weather Tracker

The app allows users to search locations, favourite different locations and view current forecast information for a particular area. The app on launch will also pull information regarding the local conditions to the user and display this on launch.

The app version is set to iOS 14. This isn't due to any technology used in app, purely the default version it was built with. 

The app makes use of SFFonts which does impose a n version of iOS 13 on the app. I opted to use these for speed and availablity out the box. 

Please see also **TODO** section below for further expansion of the app, known issues and 'next steps'.

# Technologies 

### Design patterns

The application is built using the following architecture patterns;

 - Coordinator 
 - MVVM

I chose these to combine these two as I feel it allows for clear seperation of concerns and promotes testability and maintainability. 

Most of the classes have `init(someDep: DEP = DEP())` methods which take parameters, these parameters refelct dependancies for which the class requires to function. 

By exposing these dependancies the class becomes more testable as a result. Classes can be further broken down into more manageable groups of objects to further reduce the responsibilites of any one class.

By having these use default arguments we needn't worry about passing the object the required dependancies if we don't want to, it just allows the class to configure itself. 

### Persistence

The app uses user defaults to store the favourite locations. 

As the app is relatively small it made sense to use this as to persist data between app quits and launches for the pusposes of this tech test. 

Other options like Core data would've added 'future' proofing such as using iCloud to sync content across the users devices.

This could be further expanded by looking to make a persistence manager class which accepts a type which conforms to a `Database` protocol. Then with that layer technically any persistence store could be implemented. 

### Networking

I opted to use Alamofire for this as its a tried and (well) tested library. While I understand its a wrapper for `URLSession` and the app only makes one call, should the app be expanded upon. The use of this library will allow for further expansion with little effort. 

Networking is handled by the `ResultsManagerProtocol` which has a call back which passes back the `Codable` type the object is created with. 
Inside this manager there is a `NetworkRequestor` that is configured with an enviroment which contains `apiKeys`, `baseUrl` for a particular api. From here requests are executed and passed back in a callback handler.


### Third party dependancies

The app makes use of the following third party dependancies using Swift package manager;

 - Alamofire
 - Mocker

# Usage of the app

The app requires the user location to determine the current forecast of the current location. Please select 'Use once' when opening the app to gain enough priviliedges to use this feature. 

## Home page

The home page featuers the current location cell at the top of the table view and the favourites section. 

<p float="left">
<img src="https://user-images.githubusercontent.com/14076860/99994599-1b92d100-2db1-11eb-9c1f-402bf4e9724f.png" width="200" />
<img src="https://user-images.githubusercontent.com/14076860/99994689-3feead80-2db1-11eb-890e-bb9634dd3fa9.png" width="200" />
<img src="https://user-images.githubusercontent.com/14076860/99994716-4aa94280-2db1-11eb-87f7-89ebaf7fa59d.png" width="200" />
</p>

#### No favourites

The favourites section will show an instructional cell when no favourites are stored. 

To search a user will be presented with the search bar when they pull down on the table view. From here a city name can be entered for search. 

On a successful search the user will be directed to the 'details controller' which will present the location, current forecast and a like button.

#### Favourites 

With favourties, the second section of the table view will be populated. 

From here the user can tap on a cell and view that saved information.

## Details page

#### From search

This page presents the returned information from the OpenWeather API for the searched for city name. 

Upon tapping the like button the location will be persisted and appear on the home page when the details view is dismissed. 

The user will now see this in the favourites section.

 #### From selecting favourite

The information presented will be that of when orginally requesting this information from the API. 

The user can un-favourite the location and it will be removed upon dismissing the details view in both instances. 

## TODO

Due to time constraints the app has some issues that I will address in this section.

- Auto update current location information on home page periodically.

- Currently when a user searches for a location they have no prompt to suggest an action is occuring. A loading spinner would be implemented to facilitate this. 

- Display future forcast information for a location from the api.

- More tests would be required and nessecary. 

- Images for the locations would be a nice addition. 

- Animations using Lottie for wind speed, direction and current weather.
