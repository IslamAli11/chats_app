abstract class LoginStates{}
class InitialLoginState extends LoginStates{}

class LoadingLoginState extends LoginStates{}
class UserLoginSuccessState extends LoginStates{
  final String uId;
 UserLoginSuccessState(this.uId);

}
class UserLoginErrorState extends LoginStates{}

class EyeChangState extends LoginStates{}