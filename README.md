fc-reminder
===========

[![Build Status](https://travis-ci.org/kiela/fc-reminder.png)](https://travis-ci.org/kiela/fc-reminder)
[![Code Climate](https://codeclimate.com/github/kiela/fc-reminder.png)](https://codeclimate.com/github/kiela/fc-reminder)

Have you ever had a situation in which you forgot about an upcoming football match? Or any other match? Or event? Unfortunately me too.. That's why I created Football Continous Reminder - a standalone application which uses [Twilio](https://www.twilio.com/) to sent you a reminder SMS with a date of the next match of your favourite team!

## Instalation

As usual:

    $ gem install fc-reminder

## Usage

Before using the gem, you need to create an account on [Twilio](https://www.twilio.com/) and set system variables:

``` console
TWILIO_ACCOUNT_SID=<account_sid>
TWILIO_AUTH_TOKEN=<auth_token>
TWILIO_PHONE_NUMBER=<phone_number>
```

After installing the fc-reminder gem, you should be able to start it by simply running `fc-reminder` on the command line. 

    $ fc-reminder [options] start|stop|restart|run

### One start

If you want just check how it works type:

    $ fc-reminder -t Barcelona -r +1234567890 start

In order to stop application, just hit `CTRL + C`

### Daemon mode

However, if you like how it works and want to use it for some time, type:

    $ fc-reminder -t Barcelona -r +1234567890 -c 15:00 -D -l start

It starts fc-reminder as a `daemon` which exactly at `15:00` every day checks if `Barcelona` plays any match that day, sends SMS to `+1234567890` if yes and log everything to `~/fcreminder/log`

If you are tired of being informed all the time (or just do not like that team any more), just type:

    $ fc-reminder -t Barcelona stop

## Options

fc-reminder takes a number of options:

``` console
Usage: fc-reminder [options] start|stop|restart|run
    -t, --team STRING                Team name (required)
    -r, --recipient STRING           Recipient data (required)
    -c, --check HH:MM                Time at which presence of a match will be checked (default: 12:00)
    -D, --daemon                     Daemonize process (default: false)
    -d, --dir DIR                    Directory to change to once the process starts (default: ~/fcreminder)
    -i, --identifier STRING          An identifier for the process (default: value of --team)
    -l, --log                        Redirect both STDOUT and STDERR to a logfile named FCReminder.<team>.output in the directory defined in --log-dir (default: false)
        --log-dir DIR                A specific directory to put the log files into (default: ~/fcreminder/log
    -m, --monitor                    Start monitor process (default: false)

```

## TODO

* Add ability to config fc-reminder by using ~/.fc-reminder.conf or any other file
* Add more providers (sites from which scores can be fetched)
* Add ability to "send snitch" which will be sending SMS after a starting or finishing match/scoring gol/getting card in real time

## Copyright and License

Copyright (c) 2013, Kamil Kieliszczyk and Contributors. All Rights Reserved.

This project is licenced under the [BSD 3-Clause License](LICENSE).
