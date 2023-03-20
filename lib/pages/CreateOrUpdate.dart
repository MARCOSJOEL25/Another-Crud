import 'package:crud/models/product.dart';
import 'package:crud/provider/provider_crud.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateOrEdit extends StatefulWidget {
  const CreateOrEdit({super.key});

  @override
  State<CreateOrEdit> createState() => _CreateOrEditState();
}

class _CreateOrEditState extends State<CreateOrEdit> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyFormState = GlobalKey<FormState>();
    TextEditingController Nombre = TextEditingController();
    TextEditingController Apellido = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Añadir nuevo producto')),
      body: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: keyFormState,
              child: Column(
                children: [
                  TextFormField(
                    controller: Nombre,
                    decoration: InputDecoration(hintText: 'Nombre'),
                    validator: (String? value) {
                      if (value!.isEmpty)
                        return "No estan permitidos campos vacios";
                    },
                  ),
                  TextFormField(
                      controller: Apellido,
                      decoration: InputDecoration(hintText: 'Apellido'),
                      validator: (String? value) {
                        if (value!.isEmpty)
                          return "No estan permitidos campos vacios";
                      }),
                  MaterialButton(
                    onPressed: () {
                      if (keyFormState.currentState!.validate()) {
                        setState(() {
                          Nombre.clear();
                          Apellido.clear();
                          // provider.CreateAndUpdateProduct(
                          //     Nombre.text, Apellido.text);
                          Navigator.pop(context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
