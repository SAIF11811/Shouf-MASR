 import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableOffersScreen extends StatefulWidget {
  final String destination;
  final String adults;
  final String children;
  final String dates;
  final String budget;

  const AvailableOffersScreen({
    super.key,
    required this.destination,
    required this.adults,
    required this.children,
    required this.dates,
    required this.budget,
  });

  @override
  State<AvailableOffersScreen> createState() => _AvailableOffersScreenState();
}

class _AvailableOffersScreenState extends State<AvailableOffersScreen>
    with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;
  bool _isLoading = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> offers = [
    // 1. Cairo
    {"title": "Cairo", "desc": "3 Days", "price": "\$400", "members": "20"},
    {"title": "Cairo", "desc": "5 Days", "price": "\$650", "members": "18"},
    {"title": "Cairo", "desc": "7 Days", "price": "\$950", "members": "12"},
    {"title": "Cairo", "desc": "10 Days", "price": "\$1350", "members": "8"},
    {"title": "Cairo", "desc": "14 Days", "price": "\$1850", "members": "5"},

    // 2. Luxor
    {"title": "Luxor", "desc": "3 Days", "price": "\$500", "members": "15"},
    {"title": "Luxor", "desc": "5 Days", "price": "\$800", "members": "12"},
    {"title": "Luxor", "desc": "7 Days", "price": "\$1100", "members": "9"},
    {"title": "Luxor", "desc": "10 Days", "price": "\$1500", "members": "6"},
    {"title": "Luxor", "desc": "14 Days", "price": "\$2000", "members": "4"},

    // 3. Aswan
    {"title": "Aswan", "desc": "3 Days", "price": "\$480", "members": "16"},
    {"title": "Aswan", "desc": "5 Days", "price": "\$750", "members": "12"},
    {"title": "Aswan", "desc": "7 Days", "price": "\$1050", "members": "9"},
    {"title": "Aswan", "desc": "10 Days", "price": "\$1450", "members": "6"},
    {"title": "Aswan", "desc": "12 Days", "price": "\$1750", "members": "4"},

    // 4. Sharm El-Sheikh
    {
      "title": "Sharm El-Sheikh",
      "desc": "4 Days",
      "price": "\$600",
      "members": "15",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "6 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "8 Days",
      "price": "\$1300",
      "members": "7",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "10 Days",
      "price": "\$1650",
      "members": "5",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "14 Days",
      "price": "\$2200",
      "members": "3",
    },

    // 5. Hurghada
    {"title": "Hurghada", "desc": "5 Days", "price": "\$700", "members": "10"},
    {"title": "Hurghada", "desc": "7 Days", "price": "\$1050", "members": "8"},
    {"title": "Hurghada", "desc": "10 Days", "price": "\$1500", "members": "5"},
    {"title": "Hurghada", "desc": "12 Days", "price": "\$1750", "members": "4"},
    {"title": "Hurghada", "desc": "14 Days", "price": "\$2100", "members": "2"},

    // 6. Alexandria
    {
      "title": "Alexandria",
      "desc": "2 Days",
      "price": "\$300",
      "members": "25",
    },
    {
      "title": "Alexandria",
      "desc": "4 Days",
      "price": "\$550",
      "members": "20",
    },
    {
      "title": "Alexandria",
      "desc": "6 Days",
      "price": "\$800",
      "members": "15",
    },
    {
      "title": "Alexandria",
      "desc": "8 Days",
      "price": "\$1050",
      "members": "12",
    },
    {
      "title": "Alexandria",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "9",
    },

    // 7. Giza
    {"title": "Giza", "desc": "1 Day", "price": "\$150", "members": "40"},
    {"title": "Giza", "desc": "3 Days", "price": "\$450", "members": "20"},
    {"title": "Giza", "desc": "5 Days", "price": "\$700", "members": "12"},
    {"title": "Giza", "desc": "7 Days", "price": "\$950", "members": "8"},
    {"title": "Giza", "desc": "10 Days", "price": "\$1350", "members": "6"},

    // 8. Siwa Oasis
    {"title": "Siwa Oasis", "desc": "4 Days", "price": "\$550", "members": "8"},
    {"title": "Siwa Oasis", "desc": "6 Days", "price": "\$780", "members": "6"},
    {
      "title": "Siwa Oasis",
      "desc": "8 Days",
      "price": "\$1100",
      "members": "4",
    },
    {
      "title": "Siwa Oasis",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "3",
    },
    {
      "title": "Siwa Oasis",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "2",
    },

    // 9. Dahab
    {"title": "Dahab", "desc": "3 Days", "price": "\$500", "members": "14"},
    {"title": "Dahab", "desc": "5 Days", "price": "\$750", "members": "10"},
    {"title": "Dahab", "desc": "7 Days", "price": "\$1050", "members": "6"},
    {"title": "Dahab", "desc": "9 Days", "price": "\$1300", "members": "5"},
    {"title": "Dahab", "desc": "12 Days", "price": "\$1700", "members": "3"},

    // 10. Marsa Alam
    {"title": "Marsa Alam", "desc": "5 Days", "price": "\$750", "members": "9"},
    {
      "title": "Marsa Alam",
      "desc": "7 Days",
      "price": "\$1100",
      "members": "7",
    },
    {
      "title": "Marsa Alam",
      "desc": "10 Days",
      "price": "\$1600",
      "members": "5",
    },
    {
      "title": "Marsa Alam",
      "desc": "12 Days",
      "price": "\$1850",
      "members": "4",
    },
    {
      "title": "Marsa Alam",
      "desc": "14 Days",
      "price": "\$2200",
      "members": "2",
    },
    // 11. Fayoum Oasis
    {
      "title": "Fayoum Oasis",
      "desc": "2 Days",
      "price": "\$350",
      "members": "18",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "4 Days",
      "price": "\$600",
      "members": "12",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "6 Days",
      "price": "\$850",
      "members": "8",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "8 Days",
      "price": "\$1100",
      "members": "6",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "10 Days",
      "price": "\$1400",
      "members": "4",
    },

    // 12. Abu Simbel
    {
      "title": "Abu Simbel",
      "desc": "2 Days",
      "price": "\$400",
      "members": "11",
    },
    {"title": "Abu Simbel", "desc": "3 Days", "price": "\$600", "members": "7"},
    {"title": "Abu Simbel", "desc": "5 Days", "price": "\$850", "members": "5"},
    {
      "title": "Abu Simbel",
      "desc": "7 Days",
      "price": "\$1150",
      "members": "3",
    },
    {
      "title": "Abu Simbel",
      "desc": "10 Days",
      "price": "\$1500",
      "members": "2",
    },

    // 13. Port Said
    {"title": "Port Said", "desc": "2 Days", "price": "\$350", "members": "15"},
    {"title": "Port Said", "desc": "4 Days", "price": "\$600", "members": "10"},
    {"title": "Port Said", "desc": "6 Days", "price": "\$850", "members": "8"},
    {"title": "Port Said", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {
      "title": "Port Said",
      "desc": "10 Days",
      "price": "\$1400",
      "members": "4",
    },

    // 14. Taba
    {"title": "Taba", "desc": "3 Days", "price": "\$500", "members": "12"},
    {"title": "Taba", "desc": "5 Days", "price": "\$750", "members": "9"},
    {"title": "Taba", "desc": "7 Days", "price": "\$1050", "members": "6"},
    {"title": "Taba", "desc": "9 Days", "price": "\$1350", "members": "4"},
    {"title": "Taba", "desc": "12 Days", "price": "\$1700", "members": "2"},

    // 15. Nuweiba
    {"title": "Nuweiba", "desc": "3 Days", "price": "\$480", "members": "10"},
    {"title": "Nuweiba", "desc": "5 Days", "price": "\$720", "members": "8"},
    {"title": "Nuweiba", "desc": "7 Days", "price": "\$1050", "members": "5"},
    {"title": "Nuweiba", "desc": "9 Days", "price": "\$1300", "members": "3"},
    {"title": "Nuweiba", "desc": "12 Days", "price": "\$1650", "members": "2"},

    // 16. Ismailia
    {"title": "Ismailia", "desc": "2 Days", "price": "\$300", "members": "20"},
    {"title": "Ismailia", "desc": "4 Days", "price": "\$550", "members": "15"},
    {"title": "Ismailia", "desc": "6 Days", "price": "\$800", "members": "10"},
    {"title": "Ismailia", "desc": "8 Days", "price": "\$1100", "members": "7"},
    {"title": "Ismailia", "desc": "10 Days", "price": "\$1400", "members": "5"},

    // 17. Ras Sudr
    {"title": "Ras Sudr", "desc": "3 Days", "price": "\$400", "members": "14"},
    {"title": "Ras Sudr", "desc": "5 Days", "price": "\$650", "members": "10"},
    {"title": "Ras Sudr", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Ras Sudr", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Ras Sudr", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 18. Minya
    {"title": "Minya", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Minya", "desc": "4 Days", "price": "\$550", "members": "12"},
    {"title": "Minya", "desc": "6 Days", "price": "\$800", "members": "9"},
    {"title": "Minya", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Minya", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 19. Beni Suef
    {"title": "Beni Suef", "desc": "2 Days", "price": "\$320", "members": "15"},
    {"title": "Beni Suef", "desc": "4 Days", "price": "\$580", "members": "11"},
    {"title": "Beni Suef", "desc": "6 Days", "price": "\$850", "members": "8"},
    {"title": "Beni Suef", "desc": "8 Days", "price": "\$1150", "members": "6"},
    {
      "title": "Beni Suef",
      "desc": "10 Days",
      "price": "\$1450",
      "members": "4",
    },

    // 20. Sohag
    {"title": "Sohag", "desc": "3 Days", "price": "\$450", "members": "12"},
    {"title": "Sohag", "desc": "5 Days", "price": "\$700", "members": "9"},
    {"title": "Sohag", "desc": "7 Days", "price": "\$1000", "members": "6"},
    {"title": "Sohag", "desc": "9 Days", "price": "\$1300", "members": "4"},
    {"title": "Sohag", "desc": "12 Days", "price": "\$1650", "members": "2"},

    // 21. Qena
    {"title": "Qena", "desc": "2 Days", "price": "\$320", "members": "14"},
    {"title": "Qena", "desc": "4 Days", "price": "\$600", "members": "10"},
    {"title": "Qena", "desc": "6 Days", "price": "\$880", "members": "7"},
    {"title": "Qena", "desc": "8 Days", "price": "\$1150", "members": "5"},
    {"title": "Qena", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 22. Kom Ombo
    {"title": "Kom Ombo", "desc": "2 Days", "price": "\$300", "members": "12"},
    {"title": "Kom Ombo", "desc": "4 Days", "price": "\$550", "members": "9"},
    {"title": "Kom Ombo", "desc": "6 Days", "price": "\$820", "members": "6"},
    {"title": "Kom Ombo", "desc": "8 Days", "price": "\$1100", "members": "4"},
    {"title": "Kom Ombo", "desc": "10 Days", "price": "\$1400", "members": "2"},

    // 23. Damietta
    {"title": "Damietta", "desc": "3 Days", "price": "\$400", "members": "18"},
    {"title": "Damietta", "desc": "5 Days", "price": "\$650", "members": "12"},
    {"title": "Damietta", "desc": "7 Days", "price": "\$950", "members": "8"},
    {"title": "Damietta", "desc": "9 Days", "price": "\$1250", "members": "6"},
    {"title": "Damietta", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 24. Mansoura
    {"title": "Mansoura", "desc": "2 Days", "price": "\$280", "members": "20"},
    {"title": "Mansoura", "desc": "4 Days", "price": "\$520", "members": "15"},
    {"title": "Mansoura", "desc": "6 Days", "price": "\$780", "members": "10"},
    {"title": "Mansoura", "desc": "8 Days", "price": "\$1050", "members": "7"},
    {"title": "Mansoura", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 25. Zagazig
    {"title": "Zagazig", "desc": "3 Days", "price": "\$350", "members": "16"},
    {"title": "Zagazig", "desc": "5 Days", "price": "\$600", "members": "12"},
    {"title": "Zagazig", "desc": "7 Days", "price": "\$900", "members": "8"},
    {"title": "Zagazig", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Zagazig", "desc": "12 Days", "price": "\$1550", "members": "3"},

    // 26. Suez
    {"title": "Suez", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Suez", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Suez", "desc": "6 Days", "price": "\$800", "members": "9"},
    {"title": "Suez", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Suez", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 27. Al Arish
    {"title": "Al Arish", "desc": "3 Days", "price": "\$420", "members": "15"},
    {"title": "Al Arish", "desc": "5 Days", "price": "\$680", "members": "11"},
    {"title": "Al Arish", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Al Arish", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Al Arish", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 28. Sinai
    {"title": "Sinai", "desc": "4 Days", "price": "\$600", "members": "14"},
    {"title": "Sinai", "desc": "6 Days", "price": "\$850", "members": "10"},
    {"title": "Sinai", "desc": "8 Days", "price": "\$1150", "members": "7"},
    {"title": "Sinai", "desc": "10 Days", "price": "\$1450", "members": "5"},
    {"title": "Sinai", "desc": "12 Days", "price": "\$1750", "members": "3"},

    // 29. El Alamein
    {
      "title": "El Alamein",
      "desc": "2 Days",
      "price": "\$400",
      "members": "20",
    },
    {
      "title": "El Alamein",
      "desc": "4 Days",
      "price": "\$650",
      "members": "15",
    },
    {
      "title": "El Alamein",
      "desc": "6 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "El Alamein",
      "desc": "8 Days",
      "price": "\$1200",
      "members": "6",
    },
    {
      "title": "El Alamein",
      "desc": "10 Days",
      "price": "\$1500",
      "members": "4",
    },

    // 30. Marsa Matruh
    {
      "title": "Marsa Matruh",
      "desc": "3 Days",
      "price": "\$450",
      "members": "18",
    },
    {
      "title": "Marsa Matruh",
      "desc": "5 Days",
      "price": "\$700",
      "members": "12",
    },
    {
      "title": "Marsa Matruh",
      "desc": "7 Days",
      "price": "\$950",
      "members": "8",
    },
    {
      "title": "Marsa Matruh",
      "desc": "9 Days",
      "price": "\$1250",
      "members": "6",
    },
    {
      "title": "Marsa Matruh",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "3",
    },

    // 31. Taba
    {"title": "Taba", "desc": "2 Days", "price": "\$380", "members": "16"},
    {"title": "Taba", "desc": "4 Days", "price": "\$620", "members": "12"},
    {"title": "Taba", "desc": "6 Days", "price": "\$900", "members": "8"},
    {"title": "Taba", "desc": "8 Days", "price": "\$1180", "members": "6"},
    {"title": "Taba", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 32. Nuweiba
    {"title": "Nuweiba", "desc": "3 Days", "price": "\$400", "members": "15"},
    {"title": "Nuweiba", "desc": "5 Days", "price": "\$650", "members": "11"},
    {"title": "Nuweiba", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Nuweiba", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Nuweiba", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 33. Fayoum
    {"title": "Fayoum", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Fayoum", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Fayoum", "desc": "6 Days", "price": "\$820", "members": "9"},
    {"title": "Fayoum", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Fayoum", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 34. Minya
    {"title": "Minya", "desc": "3 Days", "price": "\$370", "members": "20"},
    {"title": "Minya", "desc": "5 Days", "price": "\$620", "members": "15"},
    {"title": "Minya", "desc": "7 Days", "price": "\$880", "members": "10"},
    {"title": "Minya", "desc": "9 Days", "price": "\$1150", "members": "7"},
    {"title": "Minya", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 35. Beni Suef
    {"title": "Beni Suef", "desc": "2 Days", "price": "\$280", "members": "22"},
    {"title": "Beni Suef", "desc": "4 Days", "price": "\$520", "members": "16"},
    {"title": "Beni Suef", "desc": "6 Days", "price": "\$780", "members": "12"},
    {"title": "Beni Suef", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {
      "title": "Beni Suef",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "5",
    },

    // 36. Sohag
    {"title": "Sohag", "desc": "3 Days", "price": "\$360", "members": "18"},
    {"title": "Sohag", "desc": "5 Days", "price": "\$600", "members": "14"},
    {"title": "Sohag", "desc": "7 Days", "price": "\$880", "members": "9"},
    {"title": "Sohag", "desc": "9 Days", "price": "\$1150", "members": "6"},
    {"title": "Sohag", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 37. Quseir
    {"title": "Quseir", "desc": "2 Days", "price": "\$340", "members": "17"},
    {"title": "Quseir", "desc": "4 Days", "price": "\$580", "members": "13"},
    {"title": "Quseir", "desc": "6 Days", "price": "\$860", "members": "8"},
    {"title": "Quseir", "desc": "8 Days", "price": "\$1150", "members": "6"},
    {"title": "Quseir", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 38. Safaga
    {"title": "Safaga", "desc": "3 Days", "price": "\$420", "members": "16"},
    {"title": "Safaga", "desc": "5 Days", "price": "\$670", "members": "11"},
    {"title": "Safaga", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Safaga", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Safaga", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 39. Ras Sudr
    {"title": "Ras Sudr", "desc": "2 Days", "price": "\$310", "members": "20"},
    {"title": "Ras Sudr", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Ras Sudr", "desc": "6 Days", "price": "\$820", "members": "9"},
    {"title": "Ras Sudr", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Ras Sudr", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 40. Ismailia
    {"title": "Ismailia", "desc": "3 Days", "price": "\$400", "members": "18"},
    {"title": "Ismailia", "desc": "5 Days", "price": "\$650", "members": "12"},
    {"title": "Ismailia", "desc": "7 Days", "price": "\$920", "members": "8"},
    {"title": "Ismailia", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Ismailia", "desc": "12 Days", "price": "\$1550", "members": "3"},
    // 41. Dakhla Oasis
    {
      "title": "Dakhla Oasis",
      "desc": "3 Days",
      "price": "\$420",
      "members": "14",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "5 Days",
      "price": "\$680",
      "members": "10",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "7 Days",
      "price": "\$950",
      "members": "7",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "9 Days",
      "price": "\$1250",
      "members": "5",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "3",
    },

    // 42. Kharga Oasis
    {
      "title": "Kharga Oasis",
      "desc": "2 Days",
      "price": "\$350",
      "members": "16",
    },
    {
      "title": "Kharga Oasis",
      "desc": "4 Days",
      "price": "\$600",
      "members": "12",
    },
    {
      "title": "Kharga Oasis",
      "desc": "6 Days",
      "price": "\$880",
      "members": "8",
    },
    {
      "title": "Kharga Oasis",
      "desc": "8 Days",
      "price": "\$1150",
      "members": "6",
    },
    {
      "title": "Kharga Oasis",
      "desc": "10 Days",
      "price": "\$1450",
      "members": "4",
    },

    // 43. Marsa Matrouh
    {
      "title": "Marsa Matrouh",
      "desc": "3 Days",
      "price": "\$400",
      "members": "20",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "5 Days",
      "price": "\$650",
      "members": "15",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "7 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "9 Days",
      "price": "\$1200",
      "members": "7",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "12 Days",
      "price": "\$1550",
      "members": "4",
    },

    // 44. Alamein
    {"title": "Alamein", "desc": "2 Days", "price": "\$300", "members": "22"},
    {"title": "Alamein", "desc": "4 Days", "price": "\$520", "members": "16"},
    {"title": "Alamein", "desc": "6 Days", "price": "\$800", "members": "12"},
    {"title": "Alamein", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {"title": "Alamein", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 45. Damietta
    {"title": "Damietta", "desc": "3 Days", "price": "\$370", "members": "18"},
    {"title": "Damietta", "desc": "5 Days", "price": "\$600", "members": "14"},
    {"title": "Damietta", "desc": "7 Days", "price": "\$880", "members": "9"},
    {"title": "Damietta", "desc": "9 Days", "price": "\$1150", "members": "6"},
    {"title": "Damietta", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 46. Zagazig
    {"title": "Zagazig", "desc": "2 Days", "price": "\$280", "members": "25"},
    {"title": "Zagazig", "desc": "4 Days", "price": "\$520", "members": "18"},
    {"title": "Zagazig", "desc": "6 Days", "price": "\$780", "members": "12"},
    {"title": "Zagazig", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {"title": "Zagazig", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 47. Suez
    {"title": "Suez", "desc": "3 Days", "price": "\$420", "members": "20"},
    {"title": "Suez", "desc": "5 Days", "price": "\$670", "members": "14"},
    {"title": "Suez", "desc": "7 Days", "price": "\$940", "members": "10"},
    {"title": "Suez", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Suez", "desc": "12 Days", "price": "\$1550", "members": "4"},

    // 48. Mansoura
    {"title": "Mansoura", "desc": "2 Days", "price": "\$320", "members": "18"},
    {"title": "Mansoura", "desc": "4 Days", "price": "\$560", "members": "14"},
    {"title": "Mansoura", "desc": "6 Days", "price": "\$830", "members": "10"},
    {"title": "Mansoura", "desc": "8 Days", "price": "\$1100", "members": "7"},
    {"title": "Mansoura", "desc": "10 Days", "price": "\$1400", "members": "5"},

    // 49. Banha
    {"title": "Banha", "desc": "3 Days", "price": "\$360", "members": "16"},
    {"title": "Banha", "desc": "5 Days", "price": "\$600", "members": "12"},
    {"title": "Banha", "desc": "7 Days", "price": "\$870", "members": "8"},
    {"title": "Banha", "desc": "9 Days", "price": "\$1150", "members": "5"},
    {"title": "Banha", "desc": "12 Days", "price": "\$1500", "members": "3"},

    // 50. Qalyub
    {"title": "Qalyub", "desc": "2 Days", "price": "\$300", "members": "20"},
    {"title": "Qalyub", "desc": "4 Days", "price": "\$540", "members": "15"},
    {"title": "Qalyub", "desc": "6 Days", "price": "\$810", "members": "10"},
    {"title": "Qalyub", "desc": "8 Days", "price": "\$1080", "members": "6"},
    {"title": "Qalyub", "desc": "10 Days", "price": "\$1400", "members": "4"},
  ];
  @override
  Widget build(BuildContext context) {
    int? enteredBudget = int.tryParse(widget.budget);
    int totalTravelers =
        (int.tryParse(widget.adults) ?? 0) + (int.tryParse(widget.children) ?? 0);

    // Apply filters
    final filteredOffers = offers.where((offer) {
      // Parse price
      final price = int.tryParse(
        offer["price"].toString().replaceAll(RegExp(r'[^0-9]'), ""),
      ) ??
          0;

      final title = offer["title"].toString().toLowerCase();

      // Destination filter
      if (widget.destination.isNotEmpty &&
          widget.destination.toLowerCase() != "open" &&
          !title.contains(widget.destination.toLowerCase())) {
        return false;
      }

      // Budget filter
      if (enteredBudget != null && price > enteredBudget) {
        return false;
      }

      // Members filter
      final membersAvailable =
          int.tryParse(offer["members"].toString().split(" ").first) ?? 0;
      if (totalTravelers > 0 && totalTravelers > membersAvailable) {
        return false;
      }

      // Date filter
      if (widget.dates.isNotEmpty) {
        try {
          final datesParts = widget.dates.split("to").map((e) => e.trim()).toList();
          if (datesParts.length == 2) {
            final startDate = DateTime.parse(datesParts[0]);
            final endDate = DateTime.parse(datesParts[1]);

            final offerDate = DateTime.tryParse(offer["startDate"] ?? "") ??
                DateTime.now();

            if (offerDate.isBefore(startDate) || offerDate.isAfter(endDate)) {
              return false;
            }
          }
        } catch (_) {
          return false;
        }
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcdcc00),
        title: const Text("Available Offers"),
      ),
      backgroundColor: const Color(0xFFf5f5f5),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.travel_explore, color: Colors.orange, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          "Your Travel Plan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20, thickness: 1.2, color: Colors.grey),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.redAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.destination.isEmpty
                                ? "All Destinations"
                                : widget.destination,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.people, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          "${widget.adults} Adults, ${widget.children} Children",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          widget.dates,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          widget.budget,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: const Text(
                "Available Offers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredOffers.isEmpty
                  ? const Center(
                child: Text(
                  "No offers found for your criteria.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filteredOffers.length,
                itemBuilder: (context, i) {
                  final offer = filteredOffers[i];

                  // Slide animation
                  final animation = Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        i * 0.1,
                        1.0,
                        curve: Curves.easeOut,
                      ),
                    ),
                  );

                  return SlideTransition(
                    position: animation,
                    child: GestureDetector(
                      onTapDown: (_) => setState(() => _tappedIndex = i),
                      onTapUp: (_) => setState(() => _tappedIndex = -1),
                      onTapCancel: () => setState(() => _tappedIndex = -1),
                      child: AnimatedScale(
                        scale: _tappedIndex == i ? 0.97 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                offer['title'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.black54),
                                      const SizedBox(height: 4),
                                      Text(
                                        offer['desc'] as String,
                                        style:
                                        const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.attach_money,
                                          color: Colors.black54),
                                      const SizedBox(height: 4),
                                      Text(
                                        offer['price'] as String,
                                        style:
                                        const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.people,
                                          color: Colors.blue),
                                      const SizedBox(height: 4),
                                      Text(
                                        offer['members'] as String,
                                        style:
                                        const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              MaterialButton(
                                color: const Color(0xFFcdcc00),
                                minWidth: 120,
                                onPressed: () async {
                                  const url = 'https://www.pyramid-of-giza.com/tours/?ci=1&cm=22692823616_178125126421_c_g_egyptian%20pyramid%20tours_p_&gad_source=1&gad_campaignid=22692823616&gbraid=0AAAAACRC4b0mPfIwiT086U1-HakHmrF2e&gclid=EAIaIQobChMIlfWRzu_3jwMV66KDBx2KuivYEAAYAiAAEgLi-PD_BwE';
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Book Now",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
