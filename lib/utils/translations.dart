class Translations {
  static final languages = <String>[
    'English',
    'Hindi',
    'Marathi',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Russian'
  ];

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
        case 'Hindi':
        return 'hi';
      case 'Marathi':
        return 'mr';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Russian':
        return 'ru';
      case 'Spanish':
        return 'es';
      case 'German':
        return 'de';
      default:
        return 'en';
    }
  }
}