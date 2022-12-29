import 'package:scoped_model/scoped_model.dart';
import 'photos/Photo.dart';

class BaseModel extends Model
{
  int stackIndex = 0;
  Map<int, dynamic> entityMapList = {};
  List entityList = [];
  var entityBeingEdited;
  String chosenDate = '';

  void setStackIndex(int inStackIndex)
  {
    stackIndex = inStackIndex;
    notifyListeners();
  }

  void triggerRebuild() {
    notifyListeners();
  }

  void loadData() async
  {
    entityList = [];
    Photo photo = Photo();
    photo.id = 1;
    photo.name = 'Cleem';
    photo.author = 'John';
    photo.url = 'https://eleksun.com.ua/sites/default/files/styles/product_main/public/product_img/304120.jpg';
    entityMapList[photo.id] = photo;
    entityList.add(photo);
    notifyListeners();
  }

  Future<Photo> get(int inID) async {
    return entityMapList[inID];
  }
}

BaseModel baseModel = BaseModel();