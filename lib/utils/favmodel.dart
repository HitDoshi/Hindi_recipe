class FavModel{

  final int? id;
  final String type_id;
  final String row_id;
  final String name;
  final String sahitya;
  final String kruti;
  final int fav;

  FavModel({this.id,required this.type_id,required this.row_id,required this.name,
    required this.sahitya,required this.kruti,required this.fav});

  FavModel.fromMap(Map<String , dynamic> res) :
        id = res['id'],
        type_id = res['type_id'],
        row_id = res['row_id'],
        name = res['name'],
        sahitya = res['sahitya'],
        kruti = res['kruti'],
        fav = res['fav'];

  Map<String,Object?> toMap(){

    return{
      'id' : id,
      'type_id' : type_id,
      'row_id' : row_id,
      'name' : name,
      'sahitya' : sahitya,
      'kruti' : kruti,
      'fav' : fav
    };
  }

}