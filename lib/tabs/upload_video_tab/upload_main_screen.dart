import 'package:flutter/material.dart';
import 'dart:io';
import '/tabs/upload_video_tab/models/upload_data.dart';

class UploadTab extends StatelessWidget {
  final UploadData upload;
  UploadTab(this.upload, {Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController videoTitle = TextEditingController();
  final TextEditingController speaker = TextEditingController();
  final TextEditingController videoDescription = TextEditingController();
  final TextEditingController videoDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final selectedVideoName = upload.fileName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info tab'),
      ),
      body: Center(
          child: !(upload.isVideoSelected) ||
                  upload.isUploadCancelled ||
                  upload.isUploadSuccessfull
              ? ElevatedButton(
                  onPressed: upload.selectVideo,
                  child: Text("Select a Video"),
                )
              :
              // this widget will be displayed after
              //video is selected by user
              Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Image.file(
                              //   new File(upload.videoPath),
                              //   scale: 1.0,
                              //   repeat: ImageRepeat.noRepeat,
                              // ),
                              Text(
                                  'Selected video :${upload.selectedVideo.name}'),
                              if (upload.isImageSelected)
                                Image.file(
                                  File(upload.selectedImagePath),
                                  width: 200,
                                  height: 100,
                                ),
                              TextButton.icon(
                                onPressed: upload.selectImage,
                                icon: Icon(upload.isImageSelected
                                    ? Icons.image_rounded
                                    : Icons.attach_file_outlined),
                                label: upload.isImageSelected
                                    ? Text('Thumbnail Image')
                                    : Text("select a thumbnail image    *"),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: videoTitle,
                                decoration: InputDecoration(
                                  hintText: 'Enter the video Title *',
                                ),
                                validator: ((value) {
                                  if (value == Null || value!.isEmpty)
                                    return 'Enter a Title';
                                  else
                                    return null;
                                }),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: speaker,
                                decoration: InputDecoration(
                                    hintText: "Enter Speaker's Name    *"),
                                validator: ((value) {
                                  if (value == Null || value!.isEmpty)
                                    return "Enter Speaker's Name  ";
                                  else
                                    return null;
                                }),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: videoDate,
                                decoration:
                                    InputDecoration(hintText: 'Enter the Date'),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: videoDescription,
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter the Brief Description about the video     *',
                                ),
                                validator: ((value) {
                                  if (value == Null || value!.isEmpty)
                                    return 'Enter a Description';
                                  else
                                    return null;
                                }),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  upload.isUploading
                                      ? Row(
                                          children: [
                                            ElevatedButton(
                                              child: Text('Cancel upload'),
                                              onPressed: () {
                                                upload.cancelUploading(context);
                                              },
                                            ),
                                            // upload.isPaused
                                            //     ? ElevatedButton(
                                            //         child:
                                            //             Text('resume upload'),
                                            //         onPressed:
                                            //             upload.resumeUploading,
                                            //       )
                                            //     : ElevatedButton(
                                            //         child: Text('pause upload'),
                                            //         onPressed:
                                            //             upload.pauseUploading,
                                            //       ),
                                            ElevatedButton(
                                              child: Text(
                                                  'Uploading Video ${upload.progress} %'),
                                              onPressed: () {},
                                            )
                                          ],
                                        )
                                      : ElevatedButton(
                                          child: Text('Upload'),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                upload.isImageSelected) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Uploading Video...'),
                                                ),
                                              );
                                              upload.uploadVideo(
                                                title: videoTitle.text,
                                                speaker: speaker.text,
                                                description:
                                                    videoDescription.text,
                                                date: videoDate.text == ""
                                                    ? DateTime.now().toString()
                                                    : videoDate.text,
                                                context: context,
                                              );
                                              if (upload.isUploadSuccessfull)
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Video Uploaded Successfully !',
                                                    ),
                                                  ),
                                                );
                                            }
                                          },
                                        ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                )
          //displayed if user didnot select any video yet
          //or video uploaded successfully or video cancelled by user

          ),
    );
  }
}
