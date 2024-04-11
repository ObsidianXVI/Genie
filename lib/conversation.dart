part of genie;

typedef Pair<A, B> = MapEntry<A, B>;
final Random rand = Random();

class Conversation {
  final Map<DeliveryIntent, int> intentsMap = {};
  final Map<DeliveryIntent, List<int>> chosenOptions = {};

  String selectResponseForDeliveryIntent(DeliveryIntent deliveryIntent) {
    String resp;
    // has been in convo before
    if (intentsMap.containsKey(deliveryIntent)) {
      int intensity = intentsMap[deliveryIntent]!;
      if (optionsAreExhausted(deliveryIntent, intensity)) {
        // can increment intensity
        if (intensity + 1 < deliveryIntent.responses.length) {
          intensity += 1;
          intentsMap[deliveryIntent] = intensity;
          chosenOptions[deliveryIntent]!.clear();
          resp = confirmSelection(deliveryIntent, intensity);
        } else {
          resp = confirmSelection(deliveryIntent, intensity);
        }
      } else {
        resp = confirmSelection(deliveryIntent, intensity);
      }
    } else {
      intentsMap[deliveryIntent] = 0;
      chosenOptions[deliveryIntent] = [];
      resp = confirmSelection(deliveryIntent, 0);
    }

    return resp;
  }

  String confirmSelection(
    DeliveryIntent deliveryIntent,
    int intensity,
  ) {
    final int randIndex = (deliveryIntent.responses[intensity]
        .randomNumberNotInList(chosenOptions[deliveryIntent]!));
    chosenOptions[deliveryIntent]!.add(randIndex);
    return deliveryIntent.responses[intensity][randIndex];
  }

  bool optionsAreExhausted(DeliveryIntent deliveryIntent, int intensity) {
    return (chosenOptions[deliveryIntent]!.length >=
        deliveryIntent.responses[intensity].length);
  }
}

class Intent {
  final int id;
  final DeliveryIntent deliveryIntent;

  const Intent.greeting()
      : id = 1,
        deliveryIntent = const DeliveryIntent.greeting();
  const Intent.unknown()
      : id = 2,
        deliveryIntent = const DeliveryIntent.unknown();

  @override
  bool operator ==(Object? other) => (other is Intent) && other.id == id;

  @override
  int get hashCode => id;
}

class DeliveryIntent {
  final int id;
  final List<List<String>> responses;

  const DeliveryIntent.greeting()
      : id = 1,
        responses = const [
          [
            "Hi!",
            "Hello! I'm Genie! I serve my creator by serving others 😁",
            "Was poppin",
            "Hola",
            "Was good",
          ],
          [
            "yeah yeah dawg wassup",
            "I believe we've greeted each other",
          ],
          [
            "mmkay thats enough",
          ],
        ];

  const DeliveryIntent.unknown()
      : id = 2,
        responses = const [
          [
            "Yo idk what to say to that, im kinda dumb rn",
            "Idk bruh",
            "What talking u",
            "wat",
          ],
          [
            "not cool bruh",
            "time to stop",
          ],
        ];

  @override
  bool operator ==(Object? other) =>
      (other is DeliveryIntent) && other.id == id;

  @override
  int get hashCode => id;
}

extension ListUtils on List {
  int randomNumberNotInList(List<int> list) {
    int randIndex = rand.nextInt(length);
    if (list.length == length) return randIndex;
    while (list.contains(randIndex)) {
      randIndex = rand.nextInt(length);
    }
    return randIndex;
  }
}
