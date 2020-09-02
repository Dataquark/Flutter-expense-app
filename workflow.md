# Shop app

**App Structure so far**
.
└── lib
    ├── models
    │   └── Transaction(id, title, amount, date) - simple dart class
    ├── widgets
    │   ├── TransactionList(transactions)
    │   │   └── StatelessWidget: Container: ListView.builder: Card: Row: [Container: Text, Column: [Text, Text]]
    │   ├── NewTransaction(addNewTransaction function)
    │   │   └── StatelessWidget: Card: Container: Column: [TextField, TextField] -> Controllers, submitData()
    │   └── UserTransaction
    │       └── StatefullWidget: Column: [NewTransaction, TransactionList] -> addNewTransaction: setState()
    └── main.dart
        └── Scaffold: [Appbar:[Text, Button], body:[SingleScrollView:Column:[Container:Card:Text, UserTransaction]], FloatingButton]

**STEPS**

1. Create a new _transactions.dart_ file
    1.1 It will have a `Transactions` class
    1.2 All four properties are required - _id, title, amount, date_

2. In the _main.dart_ we create a simple flutter `Scaffold`
    2. It will have an `Appbar` and `body`

3. `body` will consist of a _Column_
    3.1 It will have two elemets: _Container_ for our future **chart**
        3.1.1 It will hold the dummy text in **Card** widget
    3.2 And another _Column_

4. The second _Column_ will have list of **Card** widgets
    4.1 They will be mapped from our fake `Transaction` class using ListView.builder()

5. Each _Card_ will have a **Row** widget
    5.1 _Row_ will consist of two elements: `Container`, which will hold the _price_ of transactions
    5.2 and another `Column`, which will have transaction's title and date on top of each other

**REFACTORING THE CODE**

6. We will create two folders: _models_ for having dart classes and _widgets_ for our widgets
    6.1 Move the `transaction.dart` to models

7. We will need three new files in _widgets_
    7.1 _Stateless_ `transaction_list.dart` - it will hold our Column (ListView.builder()) with all the transaction created as Rows
    7.2 _Stateless_ `new_transaction.dart` - it will hold our TextField widgets, where we can enter new stuff
    7.3 _Statefull_ `user_transaction.dart` - which will combine the previous two together using a Column widget

8. `user_transaction.dart` will also handle state
    8.1 It will have a method _addNewTransaction_ which will populate our `Transaction` dart class with new elements
    8.2 It will also **setState**, everytime there is a new element
    8.3. `TrasactionList` and `NewTransaction` widgets should have pointers in them


9. **ListView** vs **ListView.builder()**
    9.1 The former will hold all the items in the list in memory
    9.2 The latter will only render visible items on the screen, hence more optimized for large lists

10. To *new_transaction.dart* add `submitData()` function
    10.1 This function will check if the title and amount fields are not empty, fetches the text from controllers
    10.2 and passed it to `addNewTx` function to register a new _Transaction_ item

11. We should pass this new `submitData()` function to our two **TextFields** and **FlatButton**
    11.1 _FlatButton_ will have a pointer
    11.2 _TextField's_ `onSubmitted` will have an actual execution, however this onSubmitted will give an argument to
        the function which we do not use, hence we denote it as `(_)`

12. In the _main.dart_ we add two **IconButtons**
    12.1 One to the _Appbar_
    12.2 Second as a `FloatingActionButton` on the bottom


**ANOTHER REFACTOR**

13. We will have to transform main dart widget to _Statefull_ if we want to build `ModalBottomSheetView`
    13.1 `showModalBottomSheet` needs two arguments:
        13.1.1 _context_, which we provide by `BuildContext ctx` in our _startAddNewTransaction_ function
        13.1.2 _builder_, which should return a widget, which is our _NewTranscation()_ widgets
    13.2 Because _NewTransaction()_ needs a functon, we have to get our `addNewTransaction` function from _UserTransaction_ class
        13.2.1 It mean we will have to move the fake list of transaction, and _setState()_ to our `main.dart` class as well
    13.3 So at the end, we do not need *user_transaction.dart* file anymore
        13.3.1 and pass _TransactionList_ class directly to `main.dart` class

    13.4 **All in all, partly redo the previous refactoring. Teacher's way of teaching it is really weird.**
        13.4.1 *(BuildContext context) = _startAddNewTransaction(context)*: same context when passing the function to `onPressed` inside Icons

14. We do not need to wrap our _NewTransaction()_ class - inside the _showModalBottomSheet_ function with `GestureDetector` with _onTap: () {}_
    and _behaviour: HitTestBehavior.opaque_ as shown in the video - to avoid the sheet closing off with a tap
    14.1 Because the new Flutter has this behaviour by default: the sheet is not closed off


15. We have a problem of Modal sheet not keeping the values we pass into *title* and *amount* fields
    15.1 Because our _NewTransaction()_ class is _Stateless_: it does not keep the data internally
    15.2 We just have to transform it (refactoring tool) into _Statefull_ widget to fix this issue.

16. After the transformation, we can see Flutter added `widget` to our _addNewTx_ function
    16.1 `widget` helps us to access the properties and methods of the parent Widget class from inside of State class
    16.2 In our case, it is accessing a function (addNewTx) that is inside the _NewTransaction()_
         from _NewTransactionState()_ class
    16.3 This `widget` property is only available from within a State that is connected to Statefull Widget

17. If we want the modal sheet to close immeadiately after we submit a transaction
    17.1 We need to use _Navigator.of(context).pop()_ in the _NewTransaction_ class
    17.2 `context` is here similar to `widgets`, gives us an access to the internal context of the Widget
    17.3 Without it, Navigator would not know which modal sheet to pop after submitting the data

**THEMING**

18. We add the `theme` in the _main.dart_ to *MaterialApp*
    18.1 It will have `ThemeData()` class, which will have _primarySwatch_ (_accentColor_) and _primaryColor_
    18.2 The former generates different shades based on the latter
        18.2.1 We better use the former for global theming options

19. In the *transaction_list.dart*, set the colors of the text and border to primary color
    19.1 Use `Theme.of(context).primaryColor` to do so.
    19.2 We again using the `context` which gives us an access to global theming data of our Material app

**FONTS**

20. Create `assets/fonts` folder in the global directory and put all downloaded fonts from Google Fonts
    20.1 In `pubspec.yaml` file change the fonts

21. In the _main.dart_ `MaterialApp()` add
    21.1 _textTheme_ variable, which will be `ThemeData.light().textTheme.copyWith()`
        21.1.1 As its _headline6_ (which is the depreciated _title_), you can set a new _TextStyle()_
            21.1.1.1 This is used inside the *transaction_list.dart* as a the name of the new purchase (New shoes for instance)
                     You can access it via `Theme.of(context).textTheme.headline6`
    21.2 _appBarTheme_ variable which expects _AppBarTheme()_ object
        21.2.1 You can set the text theme for the app bar the same way you set the text theme for transaction list items as above.

**IMAGES**

22. In the _pubspec.yaml_ file, add images as `assets`
    22.1 Give full path to the images: assets/images/image-we-have
    22.2 _png, jpeg, jpg, gif_ are supported out of the box

23. Create a `ternary condition` in the _TrasnacionList_ class
    23.1 Return an image if the transactions list is empty
        23.1.1 Use *Column* to have *Text* and *Image.asset(full path)* above each other
        23.1.2 As a text style use global `textTheme.headline6`
    23.2 If not, then return the list.

**CREATING THE CHART**

24. Create *Chart()* class within _chart.dart_ file
    24.1 It is a stateless widget which returns Card -> Row -> Columns of bars with amount on top and weekday on the bottom

_We need to get the most recent transaction and sum their amounts, group by their dates_
    We can do it using _get_, which should return a list of maps
25. `List.generate(length, (index) {})` is a function that generates a list using the `function` over each element with `index`
    until `length` is reached
    25.1 For example `List.generate(5, (index) {return index * 2})` will result in `[0, 2, 4, 6, 8]`
    25.2 We use such generation inside the Chart class, to create a map (dict): `{'day':weekDay.date, 'amount':totalSum,}`
    25.3 We also reverse it by adding _reversed.toList()_ at the end of our return, to show the current day on the right side of the Chart

    25.3 Motivation behind it is to dynamically create a list of maps to pass into Row widgets
    25.4 Create a for loop, inside the _get_ - go through each transaction and check if the their date has the same day/month/year
        25.4.1 If true, `totalSum += recentTransaction['amount']`
26. Create a getter for `weeklyTotal` in _chart.dart_
    26. use `List.fold(initial_value (previous, element))` function to create a weekly sum from the _groupedTransactions_

27. Lists offer to `.where()` clause over each element inside and to keep the ones which pass certain condition
    into a new list using _getters_
    27.1 For example `[1, 2, 3, 4, 5].where((i) {return i <=3 })` will return a list of elements which are `<=3`
    27.2 We use this example in _main.dart_ to get _recentTransactions_
         List<Transaction> get _recentTransactions {
            return _userTransactions.where((element) {
            return element.date.isAfter(
                DateTime.now().subtract(
                Duration(days: 7),
                ),
            );
        }).toList();
        }

**DRAWING THE BARS**

28. Create *ChartBar()* class inside *chart_bar.dart* file
    28.1 Structure:
        .
        └── Column
            ├── Text(spendingAmount)
            ├── SizedBox(height: 4)
            ├── Container (width:10, height:60)
            │   └── Stack
            │       ├── Container -> decorations
            │       └── FractionalSizedBox(heightFactor: spendingPct)
            │           └── Container -> decorations
            ├── SizedBox(height: 4)
            └── Text(label=weekday)
    28.2 Use _BoxDecoration()_ to set the background *color*, *border width*, color and *borderRadius*

**REWRITE THE TRANSACTION LIST WITH ListTiles**


29. Inside the *transaction_list.dart* replace the **Card** within _Listview.builder_ with *ListTile* wrapped in a Card
    .
    └── Card
        └── ListTile
            ├── leading
            │   └── CirceAvatar
            ├── title
            │   └── Text
            └── subtitle
                └── Text
    29.1 We keep the original Card commented out for reference

30. Wrap the _FittedBox_ text in the *chart_bar.dart* with *Container*
    30.1 Give it a height of 20, to make the bars/days of week all aligned