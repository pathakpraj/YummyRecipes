### Summary: 
This is a recipe app that displays recipes from the provided API endpoint.
It shows a list of recipes with its Name, Cuisine, RecipeSmallImage and YouTube url to watch the recipe video.
App allows to refresh list of recipes by simply dragging down the list view. 
There are also sorting buttons at the top of the recipe list - for
-  sort by Name ( name and nameReversed)  
-  sort by Cuisine (cuisine and cuisine reversed). 

**App Screen Recording **
https://github.com/user-attachments/assets/fa0ba805-57c8-438c-aefb-ef2ae6887999

**Screen shots for sort by name, sort by quisine and images being downloaded or fetched from devide cache folder using file manager**
<img width="506" alt="Screenshot 2025-04-01 at 3 53 46 PM" src="https://github.com/user-attachments/assets/e93f5d3b-6ff2-47f6-a792-f0523598cc5c" />

**It meets following requirements**
1. Use of Swift concurrency
	App uses swift concurrency (async/ await) for fetching recipes from an API and also fetching recipe images. 
  2. No external dependencies 
	App does not use any external dependencies.
3. Efficient network usage
       It loads images only when they appear on UI. 
       Images are cached using file manager in device’s cache folder. So when the image is loaded again its loaded from cache and not downloaded from
       Network.
4. Testing
       App’s core logic to fetch recipe list and downloading / caching images is covered by unit test cases. 
       UI tests are not part of this solution.
5. SwiftUI
	App’s UI is built using SwiftUI.

If a recipe is malformed, app disregards the entire list of recipes and handles the error gracefully. If the recipes list is empty, the app displays an empty state to inform users that no recipes are available.
<img width="406" alt="Edge cases" src="https://github.com/user-attachments/assets/611d57bd-aad1-42a6-9dcc-990027c64897" />



### Focus Areas: 
creating simple UI using swiftUI
Implementing MVVM architecture
Using concurrency to fetch recipes list and images
Testing above core areas while keeping the code modular as much as possible.


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Total time spent was 15 hrs. Including implementation and testing.
Understanding the requirements - 1 hr
Planning the implementation - 2 hr
UI Implementation - 2 hrs
Implementing recipe fetching logic - 3 hr 
Implementing image fetching logic - 3 hr
Writing unit tests - 4 hr

### Trade-offs and Decisions: 
Implemented main features required for app to be fully functional.
Skipped UI testing as it was not priority for this assignment.
Skipped user login workflow as it was not priority here.

### Weakest Part of the Project: 
Weakest part of the project is network connectivity and data validity to fetch recipe list and images. 



