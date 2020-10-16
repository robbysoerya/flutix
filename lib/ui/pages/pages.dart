import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutix/bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';
import 'package:flutix/shared/shared.dart';
import 'package:flutix/ui/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_page.dart';
part 'main_page.dart';
part 'splash_page.dart';
part 'movies_page.dart';
part 'sign_up_page.dart';
part 'preference_page.dart';
part 'accountconf_page.dart';

Future<PickedFile> getImage() async {
  var image = await ImagePicker().getImage(source: ImageSource.gallery);
  return image;
}
