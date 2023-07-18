void extensions() {
  //String extension
  print("ada".isPalindrome());

  //int extension
  print(3.isPrime());

  //DateTime extension
  DateTime date1 = DateTime(2021, 7, 1);
  DateTime date2 = DateTime(2023, 7, 10);
  int days = date1.daysBetween(date2);
  print('Days between: $days');

  //Boolean extension
  bool isPrime = true;
  print(isPrime.getInformation());

  //Set extension
  Set<String> knights = {'Arthur', 'Lancelot', 'Gawain', 'Percival', 'Galahad'};
  Set<String> complaints = {'Lancelot', 'Percival'};
  Set<String> remainingKnights = knights.removeComplaints(complaints);
  print('Remaining Knights: $remainingKnights');

  //Map extension
  Map<String, List<String>> families = {
    'Smith': ['John', 'Emily', 'Michael'],
    'Johnson': ['Robert', 'Jennifer'],
    'Brown': ['William', 'Sophia', 'Olivia', 'James'],
  };
  int totalPopulation = families.getPopulation();
  print('Total Population: $totalPopulation');
  Map<String, int> familyPopulation = families.getFamilyPopulation();
  print('Family Population: $familyPopulation');
}

//String extension
extension PalindromeExtension on String {
  bool isPalindrome() {
    String reversed = split('').reversed.join('');
    return toLowerCase() == reversed.toLowerCase();
  }
}

//int extension
extension PrimeNumberExtension on int {
  bool isPrime() {
    if (this <= 1) {
      return false;
    }
    for (int i = 2; i <= this / 2; i++) {
      if (this % i == 0) {
        return false;
      }
    }
    return true;
  }
}

//DateTime extension
extension DateTimeExtension on DateTime {
  int daysBetween(DateTime other) {
    final start = DateTime(year, month, day);
    final end = DateTime(other.year, other.month, other.day);
    final difference = end.difference(start);
    return difference.inDays;
  }
}

//Boolean extension
extension CitizenInformationExtension on bool {
  String getInformation() {
    if (this) {
      return "You have access to the information.";
    } else {
      return "You do not have access to the information.";
    }
  }
}

//Set extension
extension RemoveComplaintExtension<T> on Set<T> {
  Set<T> removeComplaints(Set<T> complaints) {
    return difference(complaints);
  }
}

//Map extension
extension FamilyPopulationExtension<T> on Map<String, List<T>> {
  int getPopulation() {
    int population = 0;
    values.forEach((members) {
      population += members.length;
    });
    return population;
  }

  Map<String, int> getFamilyPopulation() {
    Map<String, int> familyPopulation = {};
    forEach((surname, members) {
      familyPopulation[surname] = members.length;
    });
    return familyPopulation;
  }
}
