# Transactions

GitHub-like contribution graph to displaying a grid of blocks representing transactions each day over the past year.

## How to setup the project?

- Clone the repository to your system
- Open the project in a code editor of choice
- Run `flutter pub get` to get the required packages
- Launch an emulator or connect a pysical device
- Run `flutter run` to launch the app

## Process
I started by evaluating the data that is generally needed to depict credit card transactions.  For this, I looked at some of the open datasets on Credit Card Transactions on Kaggle such as this [one](https://www.kaggle.com/datasets/ealtman2019/credit-card-transactions). 

The said dataset had a lot of fields such as User, Card, Year, Month, Day, Time, Amount, Use Chip, Merchant Name, Merchant City, Merchant State, Zip, MCC, Errors, and Is Fraud. For simplicity I decided to go with a `DailyTransactions` that would nest a list of transactions with the amount spent and category it was spent on such as: Food, Shopping, Travel, Entertainment, etc.

The `DailyTransactions` also has some other fields such as the date and the total amount spent that day.

Using a function, I generated some mock data to display in GitHub-like contribution graph fashion. The grid itself is built using a GridView.builder and I have used [Riverpod](riverpod.dev/docs/essentials/first_request) for state management.

Finally, I have tested the app on both mobile device (Android Emulator) and a larger screen (as a MacOS app). For responsiveness, I have chosen to restrict the width on larger screens to keep the grid intact and much more presentable.



https://github.com/adityathakurxd/transactions/assets/53579386/67f637f4-2510-46f5-9b13-d07a08bf30db



Bonus: The ThemeData uses the company color picked from the website to generate a Material 3 compatible color scheme.

```
ThemeData.from(
		colorScheme: ColorScheme.fromSeed(
		seedColor: const Color(0xFFFE480F),
	),
),
```

Please feel free to share any feedback and what improvements can be made to the project. Thanks!

