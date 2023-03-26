# WalmrtTest

## Architecture

Application created on ```MVVM``` and with some additional layers from ```Clean architecture``` like usecases, domain etc., for more layer seggregation. 

- ```Controller``` creates/holds views and viewmodels. 

- ```ViewModel``` holds business logic, view properties, state, etc.,

- ```UseCase``` i.e domain Knows where to ask the data based on the use case.

- ```Repository``` does the request/response model preparation.

- ```Model``` plain model.

- ```Managers``` manging the save, read, delete from the local file.

- ```Apiclient``` for making api hit.

## Application Flow

**Controller** should have **Views** and **ViewModels**. The **ViewModel** asks the **Repository** with user inputs *(if it has any)* to provide data for specific action. **Repository** then perpares the request params and asks the **Manager** for the data. Then **Manager** consolidate the details like target URL, request params, headers and its encoding types and pass these information to **Apiclient** to fetch data.

Once received the response from server it pass back in the same flow as a **Result**. It has two cases **Success** and **Failure** with ***Parameters***. The response then pass as a parameter with the success/failure case, extracted in the **ViewModel** to populate data on **Views**.

The **Model** preparation done on the **Repository**. **Repository** has two tasks checking for cache if cache is available and not expired asks the **DBLayer** to provide the data else asks the manager fetch it from server.

Error handlers are prepared by **Apiclient**(*in case of server errors*) or **Repository**(*other errors*). **ViewModel** and **Controller** needs to be implemented with the appropriate methods.

If a module has multiple use cases then there will be a **Usecase** file else there would only be a **Repository**. 
**ViewModels** either holds a **Repository** instance or a **Usecase** instance.


## Unit Testing

- ```Mocking (Faking objects)``` Each Module’s data source either **Repository** class or **UseCase** class to which **ViewModel** interacts directly to get data, is mocked using swift protocol to provide data for both success and failure.
- ```Test Cases``` Test case class is written for **ViewModel** class considering  all the possible scenarios, which includes Asserts and other Xcode’s  Apis.

## Improvements 
- Still ```unit testing``` can be done in better way 
- Service giving ```video link``` as well, video player is not added to play the video 
- ```Refreshing feature``` can be added when we have error or no network connection 
