import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import 'home_screen.dart';



class NoisePage extends StatefulWidget {
  const NoisePage({Key? key}) : super(key: key);

  @override
  State<NoisePage> createState() => _NoisePageState();
}

class _NoisePageState extends State<NoisePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("RC1 Rally1"),value: "RC1 Rally1"),
      const DropdownMenuItem(child: Text("RC2 Rally2"),value: "RC2 Rally2"),
      const DropdownMenuItem(child: Text("RC3 Rally 3"),value: "RC3 Rally 3"),
      const DropdownMenuItem(child: Text("NAT NR4"),value: "NAT NR4"),
      const DropdownMenuItem(child: Text("NAT N4"),value: "NAT N4"),
      const DropdownMenuItem(child: Text("NAT NR2"),value: "NAT NR2"),
    ];
    return menuItems;
  }

  late String? _carNumber;
  late String? _driverName;
  late String? _coDriverName;
  late String? _carMake;
  late String? _carModel;
  String? _rallyCategory;
  late String? _test1Value;
  late String? _test2Value;
  late String? _test3Value;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildCarNumberField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Number',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the rally car number';
        }
        return null;
      },
      onSaved: (value) {
        _carNumber = value;
      },
    );
  }

  Widget _buildDriverNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Driver Name',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter the Driver's Name";
        }
        return null;
      },
      onSaved: (value) {
        _driverName = value;
      },
    );
  }

  Widget _buildCoDriverNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Co-Driver Name',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Co-Driver\'s Name';
        }
        return null;
      },
      onSaved: (value) {
        _coDriverName = value;
      },
    );
  }

  Widget _buildCarMakeField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Make (i.e. Toyota, Hyundai, etc.)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the Car Make';
        }
        return null;
      },
      onSaved: (value) {
        _carMake = value;
      },
    );
  }

  Widget _buildCarModelField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Car Model',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your car model';
        }
        return null;
      },
      onSaved: (value) {
        _carModel = value;
      },
    );
  }

  Widget _buildRallyCategoryField(){
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Rally Category',
        prefixIcon: Icon(Icons.directions_car),
      ),
      value: _rallyCategory,
      items: dropdownItems,
      onChanged: (String? value) {
        setState(() {
          _rallyCategory = value;
        });
      },
    );
  }

  Widget _buildTest1Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 1 (0.5m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 1';
        }
        return null;
      },
      onSaved: (value) {
        _test1Value = value;
      },
    );
  }

  Widget _buildTest2Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 2 (2m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 2';
        }
        return null;
      },
      onSaved: (value) {
        _test2Value = value;
      },
    );
  }

  Widget _buildTest3Field() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Sound Test 3 (5m)',
        prefixIcon: Icon(Icons.directions_car),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter the value for Sound Test 3';
        }
        return null;
      },
      onSaved: (value) {
        _test3Value = value;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: const Text('Submit'),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          FirebaseFirestore.instance.collection('noisetestdata').add({
            'carNumber': _carNumber,
            'driverName': _driverName,
            'coDriverName': _coDriverName,
            'carMake': _carMake,
            'carModel': _carModel,
            'rallyCategory': _rallyCategory,
            'test1': _test1Value,
            'test2': _test2Value,
            'test3': _test3Value,
            'timestamp': DateTime.now(),
            'submitted by': '${loggedInUser.firstName} ${loggedInUser.secondName}',
          });

          Fluttertoast.showToast(msg: "Data submitted successfully");

          Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) =>  const HomeScreen()),
          (route) => false);

        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Test'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/2022-Badge.png'),
              ),
              _buildCarNumberField(),
              const SizedBox(height: 20),
              _buildDriverNameField(),
              const SizedBox(height: 20),
              _buildCoDriverNameField(),
              const SizedBox(height: 20),
              _buildCarMakeField(),
              const SizedBox(height: 20),
              _buildCarModelField(),
              const SizedBox(height: 20),
              _buildRallyCategoryField(),
              const SizedBox(height: 20),
              _buildTest1Field(),
              const SizedBox(height: 20),
              _buildTest2Field(),
              const SizedBox(height: 20),
              _buildTest3Field(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          )
        ),
      ),
    );
  }
}

