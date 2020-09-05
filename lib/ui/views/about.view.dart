import 'package:flutter/material.dart';
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
                    InkWell(
                      child: _profilePicture(viewModel.profilePictureLink),
                      onTap: () {
                        viewModel.openWebBrowser(viewModel.profileLink);
                      },
                    ),
                    _name(viewModel.name),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _profilePicture(String url) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null ? child : CircularProgressIndicator(),
    );
  }

  Widget _name(String name) {
    return Text(name);
  }
}
