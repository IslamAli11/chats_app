abstract class ChatAppStates{}
class InitialAppState extends ChatAppStates{}

class SendMessageSuccessState extends ChatAppStates{}
class SendMessageErrorState extends ChatAppStates{}

class GetMessageSuccessState extends ChatAppStates{}

class LoadingSearchState extends ChatAppStates{}
class SearchSuccessState extends ChatAppStates{}
class SearchErrorState extends ChatAppStates{}

class LoadingGetUserState extends ChatAppStates{}
class GetUserSuccessState extends ChatAppStates{}
class GetUserErrorState extends ChatAppStates{}

class SignOutSuccessState extends ChatAppStates{}
class SignOutErrorState extends ChatAppStates{}

class GetImageProfileSuccessState extends ChatAppStates{}
class GetImageProfileErrorState extends ChatAppStates{}


class UploadImageProfileSuccessState extends ChatAppStates{}
class UploadImageProfileErrorState extends ChatAppStates{}

class LoadingUpDateImageProfileState extends ChatAppStates{}
class UpDateImageProfileSuccessState extends ChatAppStates{}
class UpDateImageProfileErrorState extends ChatAppStates{}

