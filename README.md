# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Arhitecture](#arhitecture)
4. [Structure](#structure)
5. [Deployment](#deployment)

# OCS Coding Test
OCS Coding Test Project which shows list of Olympic Games with Athletes participated and details of athelets

# Description
<p>The OCS Coding Test Project is a simple iOS application which shows listing of all olympic games fetched from server and all the athletes participated in each olympic game.<br>
It has details of each athlete view which contains details of athlete i.e. name, DOB, weight, Height and list of medals athlete got in olympic game and the bio of athlete<br> 
</p>

# Getting started
<p>
1. Make sure you have the latest Xcode version 14.2 on your computer.<br>
2. Download the OCS Coding Test Project from the repository.<br>
5. To Open the project double click OBSCodingTest.xcodeproj file, and it will open project in xcode<br>
6. Review the code and make sure you understand what it does.<br>
7. Run the active scheme.<br>
8. Make sure you have active internet connected on your computer.<br>
9. Make sure you have installed clean swift architure template added in your xcode. To install clean swift architecure template please refer to this link (https://medium.com/swift2go/installing-the-clean-swift-template-in-xcode-6b4367006827 "Clean Swift Architecture")
You should see the first screen which has listing of the olympic games with their title and with carousal containing athletes participated in each olympic game<br>
</p>

# Architecture
* OCS Coding Test Project is implemented using the <strong>Clean Swift Architecture</strong> architecture pattern.
* View: This layer represents the user interface (UI) of the app. It is responsible for displaying data to the user and receiving user input. It communicates with the Presenter layer to update the UI based on the data provided.
* Interactor: This layer contains the business logic of the app. It is responsible for fetching data from the data source, processing it, and passing it to the Presenter layer. It communicates with the Presenter layer to update the UI based on the processed data.
* Presenter: This layer acts as a mediator between the View and the Interactor layers. It receives data from the Interactor layer and formats it in a way that can be easily displayed by the View layer. It also receives user input from the View layer and passes it to the Interactor layer for processing.
* Worker: Worker is a component responsible for handling asynchronous tasks or performing time-consuming operations outside the main thread.
* Routing: This layer is responsible for managing the navigation between different screens or modules of the app. It communicates with the View layer to initiate navigation and with the Presenter layer to pass data between screens.<br><br>

# Structure 
* "App": Contains App delegate and scene delegate classes and app level classes.
* "Assets": Contains assets".
* "Extensions": Contains extensions required. 
* "Models": All the models taht are used to parse web services response.
* "Services": This contains all the classes responsible for Network/API calling.
* "Stories": All the scenes/stories we have for this project
* "Views": Contains storyboards, xib files.

# Deployment
Keep in mind that deploying an iOS app to the App Store requires having an Apple Developer account.

1. Click on the "Product" menu in Xcode and select "Archive." This will create an archive of your project.
2. Once the archive has been created, select it in the Organizer window and click on the "Validate" button to perform some preliminary tests on the app.
3. Once validation is complete, click on the "Distribute" button and select "Ad Hoc" or "App Store" distribution. 
This will create a signed IPA file that can be installed on iOS devices.
4. Follow the prompts in the distribution wizard to complete the distribution process.
5. Once the distribution is complete, you can use the IPA file to install the app on iOS devices
