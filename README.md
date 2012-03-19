PureMVC for HumboldtJS
======================

## What is it?

It is the AS3 version of PureMVC packaged as a HumboldtJS compatible library.

## What do I do with it?

Usually you will only want the *bin/PureMVC.swc* and drop that into your 
existing HumboldtJS project. You can safely ignore the rest of this repository.
The rest is only needed if you want to fix bugs or want to upgrade the PureMVC
version or add a plugin.

Unless you want to do these things you are probably better off starting with
the HumboldJSEmpty project, which already includes PureMVC, so check that out first.

## How to build it?

After cloning this repository you can import the folder as an existing project
in Adobe Flash Builder. This may not be needed depending on your usage
scenario. Actually building the library is done by running the ant build
script in the *build* folder.

Note that you may need to update the *FLEX_HOME* path in the ant build.xml