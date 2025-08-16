import 'package:intl/intl.dart';

class TFormatter{
  static String formatdate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); //customize the date format as needed
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US',symbol: 'Ksh').format(amount); //currency and symbol
  }

  static String formatPhoneNumber(String phoneNumber){
    //Assuming a 10 digit us phone number format (123) 456-7890
    if(phoneNumber.length ==10){
      return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(3,6)}) ${phoneNumber.substring(6)})';
    }else if(phoneNumber.length == 11){
      return '(${phoneNumber.substring(0,4)}) ${phoneNumber.substring(4,7)}) ${phoneNumber.substring(7)})';
    }
    //add more custome phone number formatting
    return phoneNumber;
  }










}