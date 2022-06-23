class DataNode{

  final String name;
  final String sahitya;
  final String kruti;

  DataNode({required this.name,required this.sahitya,required this.kruti});

  DataNode.fromMap(Map<String , dynamic> res) :
  name = res['name'],
  sahitya = res['sahitya'],
  kruti = res['kruti'];

  Map<String,Object?> toMap(){

    return{
      'name' : name,
      'sahitya' : sahitya,
      'kruti' : kruti
    };
  }

}