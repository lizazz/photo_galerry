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
              resizeToAvoidBottomInset : false,
              body: GridView.builder(
                  itemCount: baseModel.entityList.length,
                  gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2
                    ),
                    itemBuilder: (BuildContext inBuildContext, int inIndex){
                      Photo photo = baseModel.entityList[inIndex];
                      String photoFile = photo.urls['thumb'];

                      return GestureDetector(child: Card(
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: GridTile(
                              footer: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Container(
                                      color: Colors.black,
                                      child:Text(
                                        photo.author,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.white),
                                      )
                                  )
                              ),
                              child: Container(
                                  decoration:  BoxDecoration(
                                    image: DecorationImage(
                                        alignment: const Alignment(-.2, 0),
                                        image: NetworkImage(photoFile),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child:  FractionallySizedBox(
                                      widthFactor: 1, // between 0 and 1
                                      child: Container(
                                          color: Colors.black,
                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: Text(
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            photo.name,
                                            style: const TextStyle(color: Colors.white),
                                          )
                                      )
                                  )
                              ),
                            ),
                          )
                      ),
                      onTap: () async {
                        baseModel.entityBeingEdited = await baseModel.get(photo.id);
                        baseModel.setStackIndex(1);
                      });
                  }
              ),
            );
          }
        )
    );
  }
}