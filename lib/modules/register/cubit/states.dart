abstract class RegisterStates{}
class InitialRegisterState extends RegisterStates{}

class UserCreateSuccessState extends RegisterStates{}
class UserCreateErrorState extends RegisterStates{}


class LoadingRegisterState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{}

class EyePasswordChangState extends RegisterStates{}


class LoadingGetUserDataState extends RegisterStates{}
class GetUserDataSuccessState extends RegisterStates{}
class GetUserDataErrorState extends RegisterStates{}