import 'dart:async';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'photos/Photo.dart';
import 'package:http/http.dart' as http;

class BaseModel extends Model
{
  int stackIndex = 0;
  Map<String, dynamic> entityMapList = {};
  List<Photo?> entityList = [];
  Photo? entityBeingEdited;
  int activePhoto = 0;

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
    dynamic photos = await fetchAlbum();

    if (photos.isNotEmpty) {
      for (var rawPhoto in photos) {
        Photo photo = Photo();
        photo.id = rawPhoto['id'];
        photo.name = (rawPhoto['description'] != null)
            ? rawPhoto['description'] : (rawPhoto['alt_description'] != null)
              ? rawPhoto['alt_description'] : '';
        photo.author = rawPhoto['user']['username'];
        photo.urls = rawPhoto['urls'];
        entityMapList[photo.id] = photo;
        entityList.add(photo);
      }
    }

    notifyListeners();
  }

  Future<Photo> get(String inID) async {
    return entityMapList[inID];
  }

  Future fetchAlbum() async {
    final response = await http.get(Uri.parse('https://api.unsplash.com/photos/?client_id=zRzvRQSJkzajAQar6YSWORPx7Ul4ZbKdyhT8Qb6FmLA'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("failed to load album");
    }
  }

  int getActivePhoto()
  {
    return activePhoto;
  }
}

BaseModel baseModel = BaseModel();