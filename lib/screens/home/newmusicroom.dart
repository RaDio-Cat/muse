import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:muse/screens/home/pagemanager.dart';
import 'package:muse/services/notifiers/play_button_notifier.dart';
import 'package:muse/services/notifiers/progress_notifier.dart';
import 'package:muse/services/notifiers/repeat_button_notifier.dart';
import 'package:muse/tools/customfont.dart';
import 'package:muse/tools/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class NewMusicRoom extends StatefulWidget {
  final List selectedPlaylist;
  const NewMusicRoom({Key? key, required this.selectedPlaylist}) : super(key: key);

  @override
  State<NewMusicRoom> createState() => _NewMusicRoomState();
}

 PageManager? _pageManager;

class _NewMusicRoomState extends State<NewMusicRoom> {
  
  @override
  void initState() {
    _pageManager ??= PageManager(selectedPlaylist: widget.selectedPlaylist );
     super.initState();
  }

  @override
  void dispose() {
    _pageManager!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: NetworkImage(
              'https://media.allure.com/photos/61d70fdd1ed267b491e946e0/3:4/w_1332,h_1776,c_limit/jenna%20ortega%20allure%20magazine%20february%202022.jpg'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          body: SafeArea(
            child: Column(
              children: [
                //appbar stuff
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 70,
                      child: InkWell(
                        child: const Icon(Icons.arrow_back_ios_new_outlined),
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //go back to previous page

                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 70,
                      child: InkWell(
                        child: Icon(Icons.favorite_border),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          //add to favourites playlist
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CurrentSongTitle(),
                  ],
                ),
                //image, artist and song name
                BackBox(
                    child: Image.network(
                        'https://media.allure.com/photos/61d70fdd1ed267b491e946e0/3:4/w_1332,h_1776,c_limit/jenna%20ortega%20allure%20magazine%20february%202022.jpg')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'domedezzy',
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: AudioProgressBar(),
                      ),
                      //controls
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AudioControlButtons(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.volume_down,
                    color: Colors.white,
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                )),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager!.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}
class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager!.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}
class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                  ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.playlist_remove,
                    color: Colors.white,
                  ),
                )),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager!.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager!.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RepeatButton(),
            ShuffleButton()
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:20.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PreviousSongButton(),
            PlayButton(),
            NextSongButton(),
          ],
      ),
        ),
      ],
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager!.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: _pageManager!.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed:
              (isFirst) ? null : _pageManager!.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager!.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager!.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager!.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : _pageManager!.onNextSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: _pageManager!.onShuffleButtonPressed,
        );
      },
    );
  }
}


