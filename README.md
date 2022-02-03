# 20220201-SantanuPoddar-NYCSchools
## NYCSchools Data project

## Description

The NYCSchools mobile project is built on the MVVM architecture is based on single responsibility principle which leads to a clean architecture. In clean swift architecture, project structure is built around modules. we will have a set of components for each module that will work for our controller. Following are the components:

####	1) View
####	2) Interactor
####	3) Presenter
####	4) Model (Request models, Response models and View Models)
####	5) Router
####	6) Worker/Helper / Extension (Utility)
####	7) Core/Network (Utility)

### Communication

The communication between the components is done through protocols. Each component will contain protocols which will be used for receiving and passing data between them.  

### Component description

### View: 
The responsibility of the view is to send the user actions to the Interactor and display the data in the application user interface using the view model received from presenter layer.

### Interactor: 
This is the backbone of an application as it contains the business logic. It calls the backend service to get the JSON response. Interactor calls core network related library comprised with commands to execute the service API and pass the response model to Presenters to build the View Models. 

### Presenter: 
Its responsibility is to get the response model received from the interactor and forms the view model to render the data in the application user interface. it sends the view model to the view as UI expects to show. 

### Model: 
It contains basic model objects conforming the codable protocol. Model object can be Request, Response or View Model.

### Router: 
It has all navigation logic for describing which screens are to be shown when. 

### Worker/Helper/Extension (Utility):
All the common function used across the project are kept under the Utility class. 

### Core/Network (Utility):
All the files required to communicate with API layer using URLSession are kept under this folder. 
