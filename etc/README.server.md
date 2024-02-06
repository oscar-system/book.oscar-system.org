# Technical info about the web server setup

This document describes how the OSCAR website hosting is set up, to help
people who need to troubleshoot it or migrate it to a new host.

## Required software on the server

To ensure the required software is installed on the server, run this
(assuming a Debian or Ubuntu based environment):

    apt install git bundler


## Where it is

The server can be reached via SSH:

    ssh www-oscar-book@www-admin12.rz.rptu.de

There is a dedicated user `www-oscar-book` who owns a clone of the book.oscar-system.org
repository at

    /srv/www/$USER/data/book.oscar-system.org

This clone is owned by user `www-oscar-book` and group `www-oscar-book`. If anything goes
wrong with these permissions, they can be fixed via

    chown -R $USER:$USER /srv/www/$USER/data/book.oscar-system.org

## Automatic updates via webhook

Whenever a change is pushed to the master branch of the book.oscar-system.org
repository, GitHub activates a webhook we provide via `webhook.php` at
<https://www.oscar-system.org/webhook.php>.

The crucial bit is at the end of this .php file, where an empty file
`/srv/www/$USER/data/book.oscar-system.org.trigger` is created. This is detected by a
systemd unit `~/.config/systemd/user/book.oscar-system.org.path` (a copy of this file is
in the `etc` directory of the book.oscar-system.org repository).

This then triggers `~/.config/systemd/user/book.oscar-system.org.service`
(a copy of this file is in the `etc` directory of the book.oscar-system.org repository).

This finally executes `etc/update.sh`, which runs jekyll.


For authentication, we set a secret token in `/srv/www/$USER/data/webhook.secret`
which looks like this:

    SetEnv GITHUB_WEBHOOK_SECRET "MY_SECRET"

with the actual secret key taking the place of `MY_SECRET`. The same value
must be entered in the GitHub settings at
<https://github.com/oscar-system/book.oscar-system.org/settings/hooks>.


## Troubleshooting

The following assumes you are logged in as root (resp. used `sudo` to become root)
on the webserver.

If updates stop working, a good first place to look at is this output of this:

    systemctl --user status book.oscar-system.org.service book.oscar-system.org.path

This prints a log with extra info. However, it might also say "service not
found". In that case, make sure that `book.oscar-system.org.service` and
`book.oscar-system.org.path` are installed and enabled:

    cp /srv/www/$USER/data/book.oscar-system.org/etc/book.oscar-system.org.* ~/.config/systemd/user
    systemctl --user enable book.oscar-system.org.service book.oscar-system.org.path

Also helpful is to study the log for the relevant systemd units

    journalctl --user -f -u "book.oscar-system.org.*"

A problem that sometimes happens (e.g. if one directly pokes into the git
clone) are broken file permissions which can impede further operations, such
as git pulling updates or jekyll updating the website. To fix these, run the
following as root:

    chown -R $USER:$USER /srv/www/$USER/data/book.oscar-system.org
    chown -R $USER:$USER /srv/www/$USER/data/http

    touch /srv/www/$USER/data/book.oscar-system.org.trigger
    chown $USER:$USER /srv/www/$USER/data/book.oscar-system.org.trigger
    chmod 0664 /srv/www/$USER/data/book.oscar-system.org.trigger


## Initial setup / what if the server VM is upgraded

### Requirements

- Ubuntu or Debian VM
- Apache 2 (`apt install apache2`)
- Ruby 2.7 or newer, including development headers, and bundler (`apt-get install bundler`)
- PHP (only for the webhook) (`apt install libapache2-mod-php ; a2enmod php7.4`)
- Jekyll (installed via `gem` and `bundler`, see below)


## Further steps as `root`

1. Set up a user `www-oscar-book` in group `www-oscar-book`

2. Set up an Apache2 site with data in `/srv/www/www-oscar-book/data/http/` (or modify the units
   here for alternate locations); ensure `www-oscar-book` owns it, i.e.

        chown -R www-oscar-book:www-oscar-book /srv/www/www-oscar-book/data/http

   In the config for that site, make sure to set `GITHUB_WEBHOOK_SECRET` as described
   elsewhere in this file, and enable PHP.
   Of course also set up SSL/TLS and a scheme to update the certificates.

3. Activate systemd user units:

        loginctl enable-linger www-oscar-book

## Further steps as `www-oscar-book`

As `www-oscar-book:www-oscar-book`  (`sudo -u www-oscar-book -g www-oscar-book bash`):

In the `$HOME` directory add a clone of the `book.oscar-system.org` git repository, i.e.,
in `/srv/www/$USER/data/book.oscar-system.org` (otherwise adjust `book.oscar-system.org.service`). Also do

    touch /srv/www/$USER/data/book.oscar-system.org.trigger
    chown $USER:$USER /srv/www/$USER/data/book.oscar-system.org.trigger
    chmod 0644 /srv/www/$USER/data/book.oscar-system.org.trigger

Next install and activate the systemd units:

    mkdir -p ~/.config/systemd/user/
    cp /srv/www/$USER/data/book.oscar-system.org/etc/book.oscar-system.org.* ~/.config/systemd/user/
    systemctl --user enable book.oscar-system.org.service book.oscar-system.org.path
    systemctl --user start book.oscar-system.org.service book.oscar-system.org.path


## On GitHub

Go to <https://github.com/oscar-system/book.oscar-system.org/settings/hooks> and
make sure the webhook there is setup right:

 - Payload URL: <https://www.oscar-system.org/webhook.php>
 - Content-type: `application/x-www-form-urlencoded` (TODO: switch to JSON at some point?)
 - Secret should of course match `GITHUB_WEBHOOK_SECRET` used elsewhere
 - enable SSL validation
 - trigger: "just the push event"
