import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../BaseModel.dart' show BaseModel, baseModel;

class PhotosEntity extends StatelessWidget
{
  Widget build(BuildContext context) {
    return ScopedModel(
      model: baseModel,
      child: ScopedModelDescendant<BaseModel>(
          builder: (BuildContext context, Widget? inChild, BaseModel inModel)
          {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: IntrinsicHeight(
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
                          )
                        ]
                      ),
                      Spacer(),
                      (inModel.entityBeingEdited != null && inModel.entityBeingEdited.id != null)
                          ? Image.network(inModel.entityBeingEdited.urls['regular'])
                          : Image.network('https://i.stack.imgur.com/kOnzy.gif')
                    ],
                  ),
                ),
              )
            );
          }
      )
    );
  }
}