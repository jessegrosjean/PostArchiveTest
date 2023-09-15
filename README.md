#  PostArchiveTest

My post build script only works if I either:

- Give Xcode full disk access
- OR don't use "Bike" as targets "Product Name".

To be clear the script works, without giving Xcode full disk access, for all other product names that I've tried. Must be something special about Bike, seems likely to be only a problem on my machine. Looking for hints on how to figure out what's wrong and how to fix. 

## First, this works...

Archive the app. After archive finishes the scheme has a post archive action. The action runs `Script/archive.sh`. That script creates a folder in temp, exports the app from the archive, and then creates `ThisWorks.dmg` with the app.

## Second, this doesn't work...

- Go to PostArchiveText taret
- Change "Product Name" to "Bike"
- Archive the app

Everything goes as above until the script calls `/usr/bin/hdiutil create` where it fails. I've included log at end.

I assume this problem must be local to my machine. I am developing an app named "Bike" in another project, but I have no idea what I might have done to make Bike special and fail. I thought maybe I already had a Bike volumn loaded somehow, but this is what I see:

```
% ls -al /Volumes
total 0
drwxr-xr-x   5 root  wheel  160 Sep 15 10:35 .
drwxr-xr-x  20 root  wheel  640 Sep  2 03:35 ..
drwxr-xr-x   3 root  wheel   96 Jun 14  2022 Data
lrwxr-xr-x   1 root  wheel    1 Sep 13 18:42 Macintosh HD -> /
drwxr-xr-x   3 root  wheel   96 Jun  7 11:34 SonomaApplications
```

And the build scripts error:

```
...
Begin hdiutil create
2023-09-15 10:35:40.676 diskimages-helper[72392:987989] *useEffectiveIDs**** euid/egid changed to 501,20 (uid/gid is 501,20)
2023-09-15 10:35:40.676 diskimages-helper[72392:987989] *useRealIDs******** euid/egid changed to 501,20 (uid/gid is 501,20)
Initializing…
2023-09-15 10:35:40.676 diskimages-helper[72392:987989] *useEffectiveIDs**** euid/egid changed to 501,20 (uid/gid is 501,20)
2023-09-15 10:35:40.679 copy-helper[72393:987991] estimating /private/tmp/Bike-3DEFB4DD-6734-4E4A-A55B-6FD4F4DB597A/Bike
2023-09-15 10:35:41.709 diskimages-helper[72392:987989] *useRealIDs******** euid/egid changed to 501,20 (uid/gid is 501,20)
Creating…
DIDiskImageCreatorProbe: interface  1, score    -1000, CSparseBundleDiskImage
DIDiskImageCreatorProbe: interface  2, score    -1000, CSparseDiskImage
DIDiskImageCreatorProbe: interface  3, score    -1000, CRawDiskImage
DIDiskImageCreatorProbe: interface  4, score     1000, CWOUDIFDiskImage
DIDiskImageCreateWithCFURL: CWOUDIFDiskImage
DIFileEncodingCreatorProbe: interface  0, score    -1000, CEncryptedEncoding
DIBackingStoreCreatorProbe: interface  0, score      300, CBSDBackingStore
DIBackingStoreCreatorProbe: interface  1, score    -1000, CBundleBackingStore
DIBackingStoreCreatorProbe: interface  2, score        0, CRAMBackingStore
DIBackingStoreCreatorProbe: interface  4, score     -100, CCURLBackingStore
DIBackingStoreCreateWithCFURL: CBSDBackingStore
DIBackingStoreCreateWithCFURL: creator returned 0
CUDIFFileAccess::createWithCFURL: kUDIFFileWithFooter
warning: no checksum present
CUDIFFileAccess::newWithCFURL: checking for header
CUDIFFileAccess::newWithCFURL: logEOFS64 is 0000000000000C70 (3184)
CUDIFFileAccess::newWithCFURL: header (at end of file) is recognized
DIDiskImageCreateWithCFURL: creator returned 0
DI_kextWaitQuiet: about to call IOServiceWaitQuiet...
DI_kextWaitQuiet: IOServiceWaitQuiet took 0.000005 seconds
DI_kextWaitQuiet: about to call IOServiceWaitQuiet...
DI_kextWaitQuiet: IOServiceWaitQuiet took 0.000005 seconds
2023-09-15 10:35:41.917 diskimages-helper[72392:988030] DIHelperHDID serveImage: attaching drive
{
    autodiskmount = 0;
    "hdiagent-drive-identifier" = "646825EA-6F05-4A50-B4B7-12477FF425E6";
    "skip-auto-fsck-for-system-images" = 1;
    "system-image" = 1;
    "unmount-timeout" = 0;
}
2023-09-15 10:35:41.928 diskimages-helper[72392:988030] DIHelperHDID serveImage: connecting to myDrive 0x4B1B
2023-09-15 10:35:41.928 diskimages-helper[72392:988030] DIHelperHDID serveImage: register _readBuffer 0x148b70000
2023-09-15 10:35:41.928 diskimages-helper[72392:988030] DIHelperHDID serveImage: activating drive port 19467
2023-09-15 10:35:41.928 diskimages-helper[72392:988030] DIHelperHDID serveImage: set cache enabled=TRUE returned FAILURE.
2023-09-15 10:35:41.933 diskimages-helper[72392:988030] DIHelperHDID serveImage: set on IO thread=TRUE returned SUCCESS.
2023-09-15 10:35:41.933 diskimages-helper[72392:988030] -processKernelRequest: will sleep received
2023-09-15 10:35:42.077 diskimages-helper[72392:987989] _mountDevEntries: disk15s1 aborting mountpoint postflight because disk image has no band size specified.
2023-09-15 10:35:42.078 diskimages-helper[72392:987989] *useEffectiveIDs**** euid/egid changed to 501,20 (uid/gid is 501,20)
2023-09-15 10:35:42.080 diskimages-helper[72392:987987] _postflightMountPointsAfterDAMount: disk14 aborting because no mount point found.
2023-09-15 10:35:42.080 diskimages-helper[72392:987987] _postflightMountPointsAfterDAMount: disk14s1 aborting because no mount point found.
2023-09-15 10:35:42.080 diskimages-helper[72392:987987] _postflightMountPointsAfterDAMount: disk15s1 aborting because disk image has no band size specified.
2023-09-15 10:35:42.081 diskimages-helper[72392:987987] _postflightMountPointsAfterDAMount: disk15 aborting because no mount point found.
2023-09-15 10:35:42.086 diskimages-helper[72392:987989] *useRealIDs******** euid/egid changed to 501,20 (uid/gid is 501,20)
Copying…
2023-09-15 10:35:42.086 diskimages-helper[72392:987989] *useEffectiveIDs**** euid/egid changed to 501,20 (uid/gid is 501,20)
2023-09-15 10:35:42.091 copy-helper[72409:988086] copying /private/tmp/Bike-3DEFB4DD-6734-4E4A-A55B-6FD4F4DB597A/Bike to /Volumes/Bike
2023-09-15 10:35:42.091 copy-helper[72409:988086] About to copy "/tmp/Bike-3DEFB4DD-6734-4E4A-A55B-6FD4F4DB597A/Bike".
2023-09-15 10:35:42.092 copy-helper[72409:988086] copy error (canceling): /Volumes/Bike/Bike.app: Operation not permitted
2023-09-15 10:35:42.092 copy-helper[72409:988086] Copy finished with error 1 (Operation not permitted).
Error 1 (Operation not permitted).
could not access /Volumes/Bike/Bike.app - Operation not permitted
Finishing…
2023-09-15 10:35:43.199 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.204 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.208 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.212 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.215 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.330 diskimages-helper[72392:988030] -processKernelRequest: flush received
2023-09-15 10:35:43.346 diskimages-helper[72392:987989] *useEffectiveIDs**** euid/egid changed to 501,20 (uid/gid is 501,20)
DIHLDiskImageCreate() returned 1
hdiutil: create: returning 1
hdiutil: create failed - Operation not permitted
End hdiutil create
```
