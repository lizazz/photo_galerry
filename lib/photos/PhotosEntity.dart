import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../BaseModel.dart' show BaseModel, baseModel;

class PhotosEntity extends StatelessWidget
{
  const PhotosEntity({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height - 50;
    return ScopedModel(
      model: baseModel,
      child: ScopedModelDescendant<BaseModel>(
          builder: (BuildContext context, Widget? inChild, BaseModel inModel)
          {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Container(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            children:[
                              TextButton(
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    inModel.setStackIndex(0);
                                  },
                                  child: const Icon(Icons.arrow_back)
                              ),
                              Flexible(child: Container(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  (inModel.entityBeingEdited != null && inModel.entityBeingEdited?.name != null)
                                      ? inModel.entityBeingEdited!.name : '',
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25
                                  ),
                                ),
                              ))
                            ]
                        ),
                        Expanded(
                            child: Container(
                              height: height * 0.8,
                              child: (inModel.entityBeingEdited != null && inModel.entityBeingEdited?.id != null)
                                  ? Image.network(inModel.entityBeingEdited!.urls['regular'])
                                  : Image.network('https://i.stack.imgur.com/kOnzy.gif'),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.4,
                              aspectRatio: 2/1,
                              initialPage: inModel.getActivePhoto()
                            ),
                            items: inModel.entityList.map((photo) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      height: height * 0.2,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                      child: GestureDetector(
                                        child: (photo!.urls['thumb'] != null) ?
                                          Image.network(photo.urls['thumb']) :
                                          Image.network('https://i.stack.imgur.com/kOnzy.gif'),
                                        onTap: () async {
                                          baseModel.entityBeingEdited = await baseModel.get(photo.id);
                                          baseModel.activePhoto = baseModel.entityList.indexOf(photo);
                                          baseModel.setStackIndex(1);
                                        },
                                      )
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            );
          }
      )
    );
  }
}