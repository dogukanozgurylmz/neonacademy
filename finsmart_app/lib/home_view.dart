import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, \nDoğukan Özgür",
                      style: textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                    const FlutterLogo(size: 28),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Bank accounts",
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      AccountWidget(
                        textTheme: textTheme,
                        accountTitle: "Ziraat Bank Account",
                        accountBalance: "Balance: 350₺",
                      ),
                      const SizedBox(width: 20),
                      AccountWidget(
                        textTheme: textTheme,
                        accountTitle: "Akbank Bank Account",
                        accountBalance: "Balance: 1100₺",
                      ),
                      const SizedBox(width: 20),
                      AccountWidget(
                        textTheme: textTheme,
                        accountTitle: "Vakıfbank Bank Account",
                        accountBalance: "Balance: 5000₺",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Credit cards",
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      CreditCardWidget(
                        textTheme: textTheme,
                        accountLimit: "3000₺",
                        accountTitle: "Ziraat Bank Account",
                      ),
                      const SizedBox(width: 20),
                      CreditCardWidget(
                        textTheme: textTheme,
                        accountLimit: "10000₺",
                        accountTitle: "Yapıkredi Bank Account",
                      ),
                      const SizedBox(width: 20),
                      CreditCardWidget(
                        textTheme: textTheme,
                        accountLimit: "6000₺",
                        accountTitle: "Akbank Bank Account",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Investment accounts",
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      InvestmentWidget(
                        textTheme: textTheme,
                        accountTitle: "Finans Bank Account",
                        accountInvestment: "1232₺",
                      ),
                      const SizedBox(width: 20),
                      InvestmentWidget(
                        textTheme: textTheme,
                        accountTitle: "Finans Bank Account",
                        accountInvestment: "533₺",
                      ),
                      const SizedBox(width: 20),
                      InvestmentWidget(
                        textTheme: textTheme,
                        accountTitle: "Finans Bank Account",
                        accountInvestment: "234₺",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: const Text(
                          "Add expenses",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        child: const Text(
                          "Fund Transfer",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InvestmentWidget extends StatelessWidget {
  const InvestmentWidget({
    super.key,
    required this.textTheme,
    required this.accountTitle,
    required this.accountInvestment,
  });

  final TextTheme textTheme;
  final String accountTitle;
  final String accountInvestment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 280,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.indigo.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            accountTitle,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Investment",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      accountInvestment,
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    super.key,
    required this.textTheme,
    required this.accountTitle,
    required this.accountLimit,
  });

  final TextTheme textTheme;
  final String accountTitle;
  final String accountLimit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 280,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            accountTitle,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remaining Credit Limit",
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      accountLimit,
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    required this.textTheme,
    required this.accountTitle,
    required this.accountBalance,
  });

  final TextTheme textTheme;
  final String accountTitle;
  final String accountBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 280,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            accountTitle,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  accountBalance,
                  style: textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
