
# Test Directory
This is completely deticated to testing. From this commit forward we are
going to have testing for all scripts, this is mainly because most of my (TannerSchultz2006)'s
scripts have been pretty untestable.

## Unpack and run scripts
All of the scripts that move files have been changed to treat this directory as
if it is self contained. That being said stuff may fall thru the crack
and please be careful before running tests.

- Please use DEBUG=$(getconfigval DEBUG) in all scripts and parse the data
properly. This allows for a uniformed debugging experience.
