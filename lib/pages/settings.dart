import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _downloadURL = '';

  @override
  void initState() {
    super.initState();

    User? user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
      _nameController.text = user.displayName ?? '';
      _ageController.text = '';
    }
  }

  Future<void> _updateProfilePicture() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      File file = File(pickedFile.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profil_fotografi.png');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadURL = downloadURL;
        _isLoading = false;
      });
    }
  }

  Future<void> _updateEmail() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        await user.updateEmail(_emailController.text.trim());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Başarılı'),
              content: const Text('E-posta adresi güncellendi.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content:
                  const Text('E-posta adresi güncellenirken bir hata oluştu.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Kullanıcının Firestore'daki belgesini alın
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Belgeyi güncelleyin
        await snapshot.reference
            .update({'First Name': _nameController.text.trim()});

        // Kullanıcının ismini güncelleyin
        await user.updateDisplayName(_nameController.text.trim());

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Başarılı'),
              content: const Text('İsim güncellendi.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: const Text('İsim güncellenirken bir hata oluştu.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateAge() async {}

  Future<void> _updatePassword() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        await user.updatePassword(_passwordController.text.trim());
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Başarılı'),
              content: const Text('Şifre güncellendi.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: const Text('Şifre güncellenirken bir hata oluştu.'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Profil Fotoğrafı',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildProfilePicture(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfilePicture,
              child: const Text('Profil Fotoğrafını Güncelle'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'E-posta Adresi',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'E-posta adresinizi girin',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateEmail,
              child: const Text('E-posta Adresini Güncelle'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'İsim',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'İsminizi girin',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateName,
              child: const Text('İsmi Güncelle'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Yaş',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                hintText: 'Yaşınızı girin',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateAge,
              child: const Text('Yaşı Güncelle'),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Şifre',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Yeni şifrenizi girin',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updatePassword,
              child: const Text('Şifreyi Güncelle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    } else if (_downloadURL.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(_downloadURL),
        radius: 50.0,
      );
    } else {
      return const CircleAvatar(
        child: Icon(Icons.person),
        radius: 50.0,
      );
    }
  }
}
