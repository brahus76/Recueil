class ChantFake {
  final int numero;
  final String titre;
  final int voix;
  const ChantFake(this.numero, this.titre, this.voix);
}

const chantsFr = [
  ChantFake(1, "Que ta grâce nous couvre", 4),
  ChantFake(2, "Vers toi monte ma louange", 3),
  ChantFake(3, "Dans la paix du soir", 4),
  ChantFake(4, "Seigneur, garde nos pas", 2),
  ChantFake(5, "Un même cœur, une même voix", 4),
  ChantFake(6, "Lumière sur le chemin", 3),
];

const chantsMoore = [
  ChantFake(1, "Titre en mooré — à compléter", 4),
  ChantFake(2, "Titre en mooré — à compléter", 3),
  ChantFake(3, "Titre en mooré — à compléter", 4),
];

List<ChantFake> demoChantsFor(String lang) => lang == 'fr' ? chantsFr : chantsMoore;