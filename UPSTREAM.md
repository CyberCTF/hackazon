# Upstream

| | |
| --- | --- |
| Project | Hackazon |
| Repository | https://github.com/rapid7/hackazon (archived) |
| Version | master (no releases) |
| Commit | 4e8197ec908413859ad75ba185c934144d43877c |
| Licence | Apache-2.0 |

`build/hackazon/app/` is that commit, unchanged, without its Git history (its Composer
dependencies are committed upstream in `vendor/`). Upstream has no Dockerfile:
`build/hackazon/Dockerfile` serves it on `php:5.6-apache` with `web/` as the document root and
mod_rewrite on, creates `db.php`, `email.php`, `parameters.php` and `rest.php` from upstream's
`*.sample.php` files (database host `db`, account hackazon / hackazon), and runs `install.sh` in
the background at start, which goes through upstream's install wizard once (admin password
`hackazon`). `build/db/Dockerfile` is MariaDB 10.11 with the database and account baked in and
MySQL 5.5's permissive SQL mode. To update, replace `build/hackazon/app/` with a newer commit,
then change this table.
