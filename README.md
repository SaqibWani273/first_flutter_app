## Application flow

App has four main tabs

###  Home
###  Videos
###  info 
###  profile

For now, working on profile tab ...

### Profile Tab execution flow

For user Authentication used **Providers** package ,
 a **State Management package**

 **********
 1. After clicking the profile tab, it goes to UserAuthentication class.
 2. There we've an enum ApplicationLoginState, which contains the different      states of the user.
 3. Using this enum we check the state of the current user (i.e. whether logged in, logged out,registered,etc) through a Switch Case block
 4. Then the user is sent to the corresponding **Screen** 
     - LoginScreen
     - SignUpScreen
     - ForgotPasswordScreen(when user presses forgot password button)
     - ... 
5. After filling  and upon submitting the form,
the corresponding function executes in **ApplicationState** class which is 
extended with **changeNotifiers** class.
6. After executing the function task **successfully** , the **ApplicationState** class changes the loginState and **notifies its listeners** which in case is our whole profile tab.

 ?(change it in future to alternative way)
Why passing errorCallBack(i.e. **Alert Dialog**)function from userAuthentication to Screens and then to ApplicationState instead instead why not to define it directly in ApplicationState class

### because alertdialog expects context as an argument
and in AppState we've no build function hence no buildcontext
           alternatively we coul've passed context from screens 
#### but just wanted to  learn how to use callback functions


 



