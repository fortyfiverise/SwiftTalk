import 'package:flutter/material.dart';
import 'package:swifttalk/components/toast.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'dart:math';

void chatOptionDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Chat Option'),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            newContactDialog(context);
          },
          child: const Text(
            'Add contact',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            createPartyDialog(context);
          },
          child: const Text(
            'Create party',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
            joinPartyDialog(context);
          },
          child: const Text(
            'Join party',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void createPartyDialog(BuildContext context) {
  final partyName = TextEditingController();
  final partyMembers = TextEditingController();
  final int groupId = Random().nextInt(900000) + 100000;
  String groupIdValue;
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Create party'),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: partyName,
            decoration: const InputDecoration(
              labelText: 'Party name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            maxLines: 2,
            keyboardType: TextInputType.number,
            controller: partyMembers,
            decoration: const InputDecoration(
              labelText: 'Party members',
              hintText:
                  'Enter the phone numbers of party members separated by comma (,)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (partyName.text.isNotEmpty &&
                      partyMembers.text.isNotEmpty) {
                    groupIdValue = groupId.toString();
                    ZIMKit()
                        .createGroup(
                      partyName.text,
                      partyMembers.text.split(','),
                      id: groupIdValue,
                    )
                        .then(
                      (String? conversationID) {
                        if (conversationID != null) {
                          showToast('Created party ID: $groupIdValue');
                        }
                      },
                    );
                  } else {
                    showToast('Please input all fields');
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void newContactDialog(BuildContext context) {
  final contactNumber = TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Add contact'),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: contactNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Contact Number',
              hintText: 'Enter the contact number you want to add',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (contactNumber.text.isNotEmpty) {
                    showToast("Added ${contactNumber.text}");
                  } else {
                    showToast("Please input phone number");
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void joinPartyDialog(BuildContext context) {
  final partyNumber = TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Join party'),
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: partyNumber,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Party Number',
              hintText: 'Enter party number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (partyNumber.text.isNotEmpty) {
                    ZIMKit().joinGroup(partyNumber.text).then(
                      (int errorCode) {
                        if (errorCode == 0) {
                          showToast('Joined party ID: ${partyNumber.text}');
                        }
                      },
                    );
                  } else {
                    showToast("Please input party number");
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
