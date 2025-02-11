import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:commerce/constants/images.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../components/app_regex.dart';
import '../../components/app_text_form_field.dart';
import '../../controllers/AuthentificationCtrl.dart';
import '../../utils/Routes.dart';
import '../../utils/helpers/snackbar_helper.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController lastNameController;
  late final TextEditingController firstNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController countryController;
  late final TextEditingController genreController;
  late final TextEditingController passwordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 6,
    )..forward();

    _blurAnimationController.addListener(() {
      setState(() {});
    });

    // Initialize controllers
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    countryController = TextEditingController();
    genreController=TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _blurAnimationController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    cityController.dispose();
    countryController.dispose();
    phoneController.dispose();
    genreController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  static const List<String> _sexe = [
    'Masculin',
    'Féminin'
  ];
  int? professionId;


  Future<void> _submitForm() async {
    FocusScope.of(context).requestFocus(FocusNode());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    Map<String, dynamic> userData = {
      "lastName": lastNameController.text,
      "firstName": firstNameController.text,
      "email":emailController.text,
      "phone":phoneController.text,
      "address":addressController.text,
      "city":cityController.text,
      "country":countryController.text,
      "genre":genreController.text,
      "password":passwordController.text
    };

    var ctrl = context.read<AuthentificationCtrl>();
    print("Voici les donnees $userData");
    var res = await ctrl.register(userData);
    await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).pop();

    print("Enregistrement ${res.status}");
    print("Enregistrement ${res.status.runtimeType}");

    if (res.data != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.purple.shade200,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.thumb_up, color: Colors.white, size: 60),
                SizedBox(height: 20),
                Text(
                  "Inscription réussie !",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, Routes.logInScreenRoute);
      });
    } else {
      SnackbarHelper.showSnackBar(res.data?['message'], isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.loginBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          _buildTitleText(context),
                          const SizedBox(height: 20),
                          AppTextFormField(
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            labelText: 'Nom',
                            validator: (value) => value!.isEmpty ? 'Entrer votre nom' : null,
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            controller: lastNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            labelText: 'Postnom',
                            validator: (value) => value!.isEmpty ? 'Entrer votre postnom' : null,
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: addressController,
                            labelText: 'Adresse',
                            validator: (value) => value!.isEmpty ? 'Entrer votre adresse' : null,
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: countryController,
                            labelText: 'Pays',
                            validator: (value) => value!.isEmpty ? 'Entrer votre pays' : null,
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: cityController,
                            labelText: 'Ville',
                            validator: (value) => value!.isEmpty ? 'Entrer votre ville' : null,
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            labelText: "Telephone",
                            controller: phoneController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Entrer un numero de telephone"
                                  : value.length >14
                                  ? "Entrer un numero de telephone valid"
                                  : null;
                            },
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            labelText: "Email",
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Entre votre email"
                                  : AppRegex.emailRegex.hasMatch(value)
                                  ? null
                                  : "Entre un email valid";
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2.0,
                              ),

                            ),
                            child: CustomDropdown<String>(
                              hintText: 'Genre',
                              items: _sexe,
                              decoration: CustomDropdownDecoration(
                                expandedBorder: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  genreController.text = value;
                                  print('changing value to: $value');
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          const SizedBox(height: 10),
                          ValueListenableBuilder<bool>(
                            valueListenable: passwordNotifier,
                            builder: (_, passwordObscure, __) {
                              return AppTextFormField(
                                obscureText: passwordObscure,
                                controller: passwordController,
                                labelText: "Mot de passe",
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                onChanged: (_) => _formKey.currentState?.validate(),
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Entrer votre mot de passe"
                                      : AppRegex.passwordRegex.hasMatch(value)
                                      ? null
                                      : "Entrer un mot de passe avec huit caracteres";
                                },
                                suffixIcon: Focus(
                                  /// If false,
                                  ///
                                  /// disable focus for all of this node's descendants
                                  descendantsAreFocusable: false,

                                  /// If false,
                                  ///
                                  /// make this widget's descendants un-traversable.
                                  // descendantsAreTraversable: false,
                                  child: IconButton(
                                    onPressed: () =>
                                    passwordNotifier.value = !passwordObscure,
                                    style: IconButton.styleFrom(
                                      minimumSize: const Size.square(48),
                                    ),
                                    icon: Icon(
                                      passwordObscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              child: const Text("S'inscrire", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Vous avez déjà un compte ? ',
                                      style: TextStyle(fontSize: 15, color: Colors.black54),
                                    ),
                                    TextSpan(
                                      text: 'Connectez-vous',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushReplacementNamed(context, Routes.logInScreenRoute);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Column _buildTitleText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bienvenue !',
          softWrap: true,
          style:
          TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Text(
          'Inscrivez-vous pour continuer',
          softWrap: true,
          style:
          TextStyle(fontSize: 20, color: Colors.black),
        ),
      ],
    );
  }
}