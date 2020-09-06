import 'package:flutter/material.dart';
import 'package:pomodoro_timer/ui/shared/asset.constant.dart';
import 'package:pomodoro_timer/ui/viewmodels/about.viewmodel.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';
import 'package:pomodoro_timer/ui/views/base.view.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AboutViewModel>(
      onInit: (viewModel) {
        viewModel.initProfile();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('About Me'),
        ),
        body: Container(
          child: viewModel.state == ViewState.BUSY
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    viewModel.profilePictureLink == null
                        ? _profilePicture(AssetConstant.PROFILE_IMAGE, true)
                        : _profilePicture(viewModel.profilePictureLink, false,
                            onTap: () {
                            viewModel.openWebBrowser(viewModel.profileLink);
                          }),
                    _name(viewModel.name),
                    _email(viewModel.email, onTap: () {
                      viewModel.openEmailApp(viewModel.email);
                    }),
                    _socialMedia(viewModel.socialMediaList,
                        onTap: (url) => viewModel.openWebBrowser(url)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _profilePicture(String path, bool asset, {VoidCallback onTap}) {
    return InkWell(
      child: asset
          ? Image.asset(path)
          : Image.network(
              path,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : CircularProgressIndicator(),
            ),
      onTap: onTap,
    );
  }

  Widget _name(String name) {
    return Text(name);
  }

  Widget _email(String email, {VoidCallback onTap}) {
    return InkWell(
      child: Text(email),
      onTap: onTap,
    );
  }

  Widget _socialMedia(List<Map<String, dynamic>> socialMediaList,
      {Function(String url) onTap}) {
    List<Widget> socialMediaListWidget = [];

    socialMediaList.forEach((element) {
      socialMediaListWidget.add(
        InkWell(
            child: Image.asset(
              element['iconPath'],
              width: 50,
              height: 50,
            ),
            onTap: () {
              onTap(element['profileLink']);
            }),
      );
    });

    return Row(
      children: socialMediaListWidget,
    );
  }
}
