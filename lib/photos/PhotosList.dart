import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Photo.dart' show Photo;
import '../BaseModel.dart' show BaseModel, baseModel;

class PhotosList extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return ScopedModel(
        model: baseModel,
        child: ScopedModelDescendant<BaseModel>(
          builder: (BuildContext context, Widget? inChild, BaseModel inModel) {
            return Scaffold(
              body: ListView.builder(
                  itemCount: baseModel.entityList.length,
                  itemBuilder: (BuildContext inBuildContext, int inIndex){
                    Photo photo = baseModel.entityList[inIndex];
                    String photoFile = photo.url;
                    bool photoFileExists = photoFile.isNotEmpty;

                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            backgroundImage: photoFileExists ? NetworkImage(photoFile) : null,
                            child: photoFileExists ? null : const Text("No Photo"),
                          ),
                          title: Text(photo.name),
                          subtitle: Text(photo.author),
                          onTap: () async {
                             baseModel.entityBeingEdited = await baseModel.get(photo.id);
                             baseModel.setStackIndex(1);
                          },
                        ),
                      ],
                    );
                  }
              ),
            );
          }
        )
    );
  }
}