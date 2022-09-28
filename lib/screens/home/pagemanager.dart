import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:muse/services/notifiers/play_button_notifier.dart';
import 'package:muse/services/notifiers/progress_notifier.dart';
import 'package:muse/services/notifiers/repeat_button_notifier.dart';

class PageManager {
  final selectedPlaylist;
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;
  var fireplay;

  PageManager({required this.selectedPlaylist}) {
    _init();
    
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    _setFirebasePlaylist();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  // TODO: set playlist
  void _setInitialPlaylist() async {
    const prefix = 'https://www.soundhelix.com/examples/mp3';
  final song1 = Uri.parse('$prefix/SoundHelix-Song-1.mp3');
  final song2 = Uri.parse('$prefix/SoundHelix-Song-2.mp3');
  final song3 = Uri.parse('$prefix/SoundHelix-Song-3.mp3');
  _playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(song1, tag: 'Song 1'),
    AudioSource.uri(song2, tag: 'Song 2'),
    AudioSource.uri(song3, tag: 'Song 3'),
  ]);
  await _audioPlayer.setAudioSource(_playlist);
  }

  void _setFirebasePlaylist() async {
    print(selectedPlaylist.toString());
    fireplay = ConcatenatingAudioSource(children: []);
    fireplay.addAll(selectedPlaylist.map((song){
      AudioSource.uri(Uri.parse(song['song']),
      tag: AudioMetadata(title: song['name'], artwork: song['image']));
    }).toList());
        // fireplay = ConcatenatingAudioSource(children: selectedPlaylist.map((song) {
    //   AudioSource.uri(Uri.parse(song['song']), tag: AudioMetadata(title: song['name'], artwork: song['image'],));
    // }).toList());
    await _audioPlayer.setAudioSource(fireplay);
    print('playlist set');
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
    if (sequenceState == null) return;
    // TODO: update current song title
    final currentItem = sequenceState.currentSource;
final title = currentItem?.tag as String?;
currentSongTitleNotifier.value = title ?? '';
    // TODO: update playlist
    final playlist = sequenceState.effectiveSequence;
final titles = playlist.map((item) => item.tag as String).toList();
playlistNotifier.value = titles;

    // TODO: update shuffle mode
    isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;
    // TODO: update previous and next buttons
    if (playlist.isEmpty || currentItem == null) {
  isFirstSongNotifier.value = true;
  isLastSongNotifier.value = true;
} else {
  isFirstSongNotifier.value = playlist.first == currentItem;
  isLastSongNotifier.value = playlist.last == currentItem;
}
  });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onRepeatButtonPressed() {
    // TODO
    repeatButtonNotifier.nextState();
  switch (repeatButtonNotifier.value) {
    case RepeatState.off:
      _audioPlayer.setLoopMode(LoopMode.off);
      break;
    case RepeatState.repeatSong:
      _audioPlayer.setLoopMode(LoopMode.one);
      break;
    case RepeatState.repeatPlaylist:
      _audioPlayer.setLoopMode(LoopMode.all);
  }
  }

  void onPreviousSongButtonPressed() {
    // TODO
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    // TODO
    _audioPlayer.seekToNext();
  }

  void onShuffleButtonPressed() async {
    // TODO
    final enable = !_audioPlayer.shuffleModeEnabled;
  if (enable) {
    await _audioPlayer.shuffle();
  }
  await _audioPlayer.setShuffleModeEnabled(enable);
  }

  void addSong() {
    // TODO
  }

  void removeSong() {
    // TODO
  }
}
class AudioMetadata {
  final String title;
  final String artwork;

  AudioMetadata({
    required this.title,
    required this.artwork,
  });
}