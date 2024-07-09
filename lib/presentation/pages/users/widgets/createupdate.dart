import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:testing/core/components/button.dart';
import 'package:testing/core/components/textfield.dart';
import 'package:testing/core/utils/constants.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late UsersNotifier notifier;
  @override
  void initState() {
    notifier = context.read<UsersNotifier>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var params = ModalRoute.of(context)?.settings.arguments as String;
      if (params == 'edited'){
        notifier.autoFillData();
      }else{
        notifier.id = 0;
        notifier.textNameController.clear();
        notifier.textJobController.clear();
        notifier.textLastnameController.clear();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersNotifier>(
      builder: (context, notifier, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(notifier.id != 0 ? 'Update User' : 'Create User'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const CircleAvatar(
                backgroundColor: blackColor20,
                child: Icon(
                  Icons.close,
                  color: blackColor,
                ),
              ),
            ),
          ),
          body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                child: Form(
                  key: notifier.formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('FIRST NAME'),
                          TextFieldCustom(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'First Name is required'),
                            ]),
                            controller: notifier.textNameController,
                            keyboardType: TextInputType.text,
                            placeholder: 'FIRST NAME',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('LAST NAME'),
                          TextFieldCustom(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Last Name is required'),
                            ]),
                            controller: notifier.textLastnameController,
                            keyboardType: TextInputType.text,
                            placeholder: 'LAST NAME',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('JOB'),
                          TextFieldCustom(
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Job is required'),
                            ]),
                            controller: notifier.textJobController,
                            keyboardType: TextInputType.text,
                            placeholder: 'JOB',
                            readOnly: true,
                            onSubmitted: () => notifier.showButtomSheetInfoJobs(context),
                            suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: buttonColor(context, label: notifier.id != 0 ? 'UPDATE' : 'CREATE', onPressed: (){
              FocusScope.of(context).unfocus();
              if (notifier.formKey.currentState!.validate()) {
                if (notifier.id != 0){
                  notifier.update(context);
                }else{
                  notifier.create(context);
                }
                
              }
            }),
          ),
        );
      }
    );
  }
}
