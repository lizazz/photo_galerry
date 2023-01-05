import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'PhotosEntity.dart';
import '../BaseModel.dart' show BaseModel, baseModel;
import 'PhotosList.dart';

class Photos extends StatelessWidget
{
  Photos({Key? key}) : super(key: key)
  {
    baseModel.loadData();
  }

  Widget build(BuildContext context) {
    return ScopedModel<BaseModel>(
        model: baseModel,
        child: ScopedModelDescendant<BaseModel>(
          builder: (BuildContext context, Widget? inChild, BaseModel inModel)
          {
            return IndexedStack(
              index: inModel.stackIndex,
              children: [
                 PhotosList(),
                 PhotosEntity()
              ],
            );
          },
        )
    );
  }
}