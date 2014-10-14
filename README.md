# Context Alias

Context Alias allows you to extend your zsh to include extra aliases in
sub-directories. This allows you to use the same alias'd commands in multiple
locations with different effects.

## Installation

In your .zshrc add:

    source /path/to/contextalias.zsh

Ensure this is done **after** your normal aliases are set up.

## Usage

Into any subdirectory you can put a `.contextalias.zsh` file, declaring the
aliases as usual. As you enter the directory or a subdirectory, the aliases will
be added to your shell, and removed as you move out of the directory.
