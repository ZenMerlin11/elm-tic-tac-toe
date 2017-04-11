# Elm Tic-Tac-Toe
This is an elm implementation of tic tac toe.

## Getting Started
This build process for this application requires Node, Elm, and Gulp.
First, install Node. Next, either install Elm globally via npm:

    npm install elm -g

Alternatively, Windows and Mac installers are also available (although
I recommend installing through npm). You may also want to configure your
editor of choice with the appropriate Elm plugin. I also recommend
elm-format to keep your code style conformant. These tools are available
here: https://guide.elm-lang.org/install.html

Next you will need to install gulp globally to run the build system:

    npm install gulp -g

Once this is completed, you'll need to install the requisite elm and npm
packages:

    npm install
    elm package install

To start the build system, run gulp in the project root:

    gulp

This will start a server at http://localhost:3000/. Gulp will also setup
a watch to rebuild any files on saving.

Enjoy.


  
