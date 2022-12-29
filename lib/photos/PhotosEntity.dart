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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (inModel.entityBeingEdited != null && inModel.entityBeingEdited.id != null)
                        ? Image.network(inModel.entityBeingEdited.url)
                        : Image.network('https://eleksun.com.ua/sites/default/files/banners/Component%204.png'),
                     Spacer(),
                    TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          inModel.setStackIndex(0);
                        },
                        child: const Text("Cancel")
                    )
                  ],
                ),
              ),
            );
          }
      )
    );
  }
}