import 'package:flutter/material.dart';
import 'dart:io';
import '/tabs/upload_video_tab/models/upload_data.dart';

class UploadTab extends StatelessWidget {
  final UploadData upload;
  const UploadTab(this.upload, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final selectedVideoName = upload.fileName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info tab'),
      ),
      body: Center(
        child: upload.isVideoSelected
            ?
            // this widget will be displayed after
            //video is selected by user
            Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Image.file(
                        //   new File(upload.videoPath),
                        //   scale: 1.0,
                        //   repeat: ImageRepeat.noRepeat,
                        // ),
                        Text('Selected video :${upload.selectedVideo.name}'),
                        TextButton.icon(
                          onPressed: upload.selectImage,
                          icon: Icon(upload.isImageSelected
                              ? Icons.image_rounded
                              : Icons.attach_file_outlined),
                          label: Text("select a thumbnail image"),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter the video Title'),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: "Enter Speaker's Name"),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Enter the Date'),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText:
                                'Enter the Brief Description about the video',
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            upload.isUploading
                                ? ElevatedButton(
                                    child: Text('Cancel upload'),
                                    onPressed: upload.cancelUploading,
                                  )
                                : ElevatedButton(
                                    child: Text('Upload'),
                                    onPressed: upload.uploadVideo,
                                  ),
                          ],
                        )
                      ],
                    ),
                  )),
                ),
              )
            : ElevatedButton(
                onPressed: upload.selectVideo,
                child: Text("Select a Video"),
              ),
      ),
    );
  }
}
