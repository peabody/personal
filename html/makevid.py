#!/usr/bin/env python

# makevid.py - Make videos from a single image plus a sound file
# Copyright (C) 2007 Sam Peterson

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

"""
makevid.py by Sam Peterson <peabodyenator@gmail.com>

Latest version of script should be available at:
http://peabody.weeman.org/makevid.py

Requirements: mencoder

This script creates an avi divx video for uploading to YouTube given
only an mp3 and an image file.  I use it to create video reponses to
people on YouTube.  I have a microphone, but I currently don't have a
working video device.  Plus, if I did, I wouldn't use it anyway, as I
don't like to place my face in public Internet forums.  The script
requires a working mencoder in your PATH.

This script takes three command line arguments: a path to an image
file, a path to an audio file, and a number of seconds.  If everything
goes smoothly, a video file named output.avi will be written to the
current directory.  The file should play roughly as long as the number
of seconds specified.

Example:

makevid.py lebowski.jpg audio.mp3 20

Please email any bugs to peabodyenator@gmail.com.  The videos seems to
work well once uploaded, but seeking seems a little strange.  I'm open
to all suggestions.

Advice:
 * You should pre-scale your image file to 320x240, which is the YouTube
 video resolution.

 * To my knowledge, the audiofile doesn't have to be an mp3, but that's
 the recommended format on YouTube's website.

TODO: I think it should be possible to determine how long the video
needs to be from the audio file, but I'm not sure of the best way to
do this.  If it could be done it would eliminate the requirement of
manually passing the number of seconds to the script.
"""

import os, sys

fps = 30

if len(sys.argv) != 4:
    print "Usage: makevid.py imagefile audiofile seconds"
    sys.exit(1)

secs = int(sys.argv[3])
if secs < 0:
    print "Please pass a positive amount of seconds"
    sys.exit(1)
secs = 1 / float(secs)

filesexist = True
for each_file in sys.argv[1:2]:
    if not os.path.exists(each_file):
        print "%s doesn't exist" % each_file
        filesexist = False
if not filesexist: sys.exit(1)

mencoder_cmd = ('mencoder "mf://%s" -mf fps=%f -vf harddup -ovc lavc'\
    ' -lavcopts vbitrate=100 -audiofile "%s" -oac copy -ofps %d'\
    ' -o output.avi') % (sys.argv[1], secs, sys.argv[2], fps)

print "Starting mencoder"
os.system(mencoder_cmd)
print "Video is complete, output written to output.avi"
