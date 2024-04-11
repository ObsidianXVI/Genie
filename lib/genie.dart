library genie;

import 'dart:math';

part './conversation.dart';
part './triggers.dart';

enum GenieModel {
  vanilla,
  tensorflow,
}

void main(List<String> args) {
  final List<String> prompts = args;
  final Genie genie = Genie(model: GenieModel.vanilla);
  for (final prompt in prompts) {
    print(genie.respondToPrompt(prompt));
  }
}

typedef SenderId = String;

class Genie {
  final GenieModel model;
  final Conversation conversation = Conversation();

  Genie({
    required this.model,
  });

  String respondToPrompt(String prompt) {
    if (model == GenieModel.vanilla) {
      final intent = detectIntent(prompt);
      return conversation
          .selectResponseForDeliveryIntent(intent.deliveryIntent);
    } else {
      throw "Genie Tensorflow not configured";
    }
  }

  Intent detectIntent(String prompt) {
    final String payload = prompt.trim();
    if (Triggers.checkIfTriggers(payload, Triggers.greeting)) {
      return Intent.greeting();
    } else {
      return Intent.unknown();
    }
  }
}
