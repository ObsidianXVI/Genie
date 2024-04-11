part of genie;

class Triggers {
  static const greeting = [
    'hello',
    'hey',
    'hi',
    'wassup',
    'whats up',
    'whats popping',
    'hola',
    'yo',
    'whats good',
    'how are you',
  ];

  static bool checkIfTriggers(String str, List<String> triggers) {
    for (final tr in triggers) {
      if (str.contains(tr)) return true;
    }
    return false;
  }
}
