class ChatMessage {
  final String text;
  final bool isSentByUser;

  ChatMessage({required this.text, required this.isSentByUser});
}

class ChatThread {
  final String userName;
  final String imageUrl;
  final List<ChatMessage> messages;

  ChatThread({
    required this.userName,
    required this.imageUrl,
    required this.messages,
  });
}

final List<ChatThread> chatThreads = [
  ChatThread(
    userName: 'Lena Pflanze',
    imageUrl:
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    messages: [
      ChatMessage(
        text: 'Deine Ringelblumen leuchten ja bis zur Nachbarschaft 😍',
        isSentByUser: false,
      ),
      ChatMessage(text: 'Danke 😉 Willst du Samen haben?', isSentByUser: true),
      ChatMessage(
        text: 'Unbedingt! Ich bring dir im Tausch ein paar Kornblumen mit.',
        isSentByUser: false,
      ),
    ],
  ),
  ChatThread(
    userName: 'Tom Gärtner',
    imageUrl:
        'https://st4.depositphotos.com/3648933/29274/i/450/depositphotos_292741036-stock-photo-handsome-gardender-standing-in-garden.jpg',
    messages: [
      ChatMessage(text: 'Ich habe noch Basilikum übrig!', isSentByUser: false),
      ChatMessage(
        text: 'Perfekt, ich hätte Thymian im Tausch.',
        isSentByUser: true,
      ),
      ChatMessage(
        text: 'Klingt gut, wann könnten wir tauschen?',
        isSentByUser: false,
      ),
    ],
  ),
  ChatThread(
    userName: 'Sandra Grün',
    imageUrl:
        'https://us.images.westend61.de/0001680144j/glueckliche-gaertnerin-mit-lockigem-haar-die-einen-bonsaibaum-in-der-baumschule-haelt-JCCMF06464.jpg',
    messages: [
      ChatMessage(text: 'Super, dann bis Freitag!', isSentByUser: false),
      ChatMessage(
        text: 'Ja! Treffpunkt wieder beim Flohmarkt?',
        isSentByUser: true,
      ),
      ChatMessage(
        text: 'Genau, gleiche Stelle wie letztes Mal 😊',
        isSentByUser: false,
      ),
    ],
  ),
  ChatThread(
    userName: 'Paul Bio',
    imageUrl:
        'https://st4.depositphotos.com/1017986/39200/i/450/depositphotos_392006782-stock-photo-happy-man-in-apron-at.jpg',
    messages: [
      ChatMessage(text: 'Gibt es noch Tomaten?', isSentByUser: false),
      ChatMessage(
        text: 'Ja klar! Welche Sorte möchtest du?',
        isSentByUser: true,
      ),
      ChatMessage(
        text: 'Am liebsten die San Marzano, wenn du hast.',
        isSentByUser: false,
      ),
    ],
  ),
];
