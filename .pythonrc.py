import os
import sys
import atexit
from code import InteractiveConsole

try:
    import readline
except ImportError:
    print "Module readline is not available"
else:
    import rlcompleter
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind('bind ^I rl_complete')
    else:
        readline.parse_and_bind('tab: complete')


    # Command line history

    HIST_FILE = '{0}/.pyhistory'.format(os.environ['HOME'])

    # Read the existing history if there is one
    if os.path.exists(HIST_FILE):
        readline.read_history_file(HIST_FILE)

    # Set the maximum number of items to write to the history file
    readline.set_history_length(300)

    def save_history():
        readline.write_history_file(HIST_FILE)

    atexit.register(save_history)
