// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(user) => "Вітаю,\n${user}!";

  static String m1(time) => "Востаннє в мережі: ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "givePermission": MessageLookupByLibrary.simpleMessage("Надати права"),
        "helloUser": m0,
        "language": MessageLookupByLibrary.simpleMessage("Мова"),
        "lastSeen": m1,
        "online": MessageLookupByLibrary.simpleMessage("В мережі"),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Права відхилено"),
        "permissionDeniedForever": MessageLookupByLibrary.simpleMessage(
            "Права відхилено назавжди. Вам потрібно надати права самостійно через налаштування."),
        "profile": MessageLookupByLibrary.simpleMessage("Профіль"),
        "settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Увійти через Google"),
        "signOut": MessageLookupByLibrary.simpleMessage("Вийти")
      };
}
