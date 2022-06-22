 class SearchModel{
 late String name;
 late String message;
SearchModel.fromJson(Map<String , dynamic>json){
  name = json['name'];
  message = json['bio'];
}

Map<String , dynamic> toMap(){
  return{
    'name':name,
    'bio':message,

  };
}
 }