part of 'profile_page.dart';

class SuggestionPage extends StatefulWidget {
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  bool isUploading = false;
  TextEditingController postController = TextEditingController();
  TextEditingController postTitleController = TextEditingController();

  Future<void> uploadPost() async {
    setState(() {
      isUploading = true;
    });

    final alldocuments = await MyGlobals.suggestionCollection.get();
    final int length = alldocuments.docs.length;

    MyGlobals.suggestionCollection.doc('Post $length').set(
      {
        'id': 'Post $length',
        'authorsId': MyGlobals.firebaseCurrentUser.uid,
        'story': postController.text.trim(),
        'title': postTitleController.text.trim(),
        'time': Timestamp.now(),
      },
    ).whenComplete(() {
      MyWidgets.snackbar(
        title: 'Suggestion sent',
        message: 'Successful',
      );
    });

    setState(
      () {
        isUploading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isUploading
          ? Loading.spinKitThreeBounce()
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: Text('Tech Support', style: Styles.headlineText1),
                    automaticallyImplyLeading: false,
                    backgroundColor: Styles.canvasColor,
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: double.infinity,
                            child: Image.asset(
                              "assets/images/care.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: Container(
                color: Styles.backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        TextField(
                          controller: postTitleController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Title...',
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: postController,
                          maxLines: 20,
                          minLines: 10,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Make your suggestion/complain...',
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: isUploading
                              ? Loading.spinKitThreeBounce()
                              : MyWidgets.raisedButton(
                                  title: 'Send',
                                  onPressed: () => uploadPost(),
                                ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
