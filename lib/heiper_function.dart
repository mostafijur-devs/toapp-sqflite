 import 'package:intl/intl.dart';

String? dateFormat(DateTime? date,{ String pattran ='yyy-MM-dd'}){
  if(date == null) return null;
  return DateFormat(pattran).format(date);
 }