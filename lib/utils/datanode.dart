class DataNode{

  final int? id ;
  final String title;
  final String subtitle;

  DataNode({this.id,required this.title,required this.subtitle});

  DataNode.fromMap(Map<String , dynamic> res) :
  id = res['id'],
  title = res['title'],
  subtitle =res['subtitle'];

  Map<String,Object?> toMap(){

    return{
      'id'  : id ,
      'title' : title,
      'subtitle' : subtitle
    };
  }

}