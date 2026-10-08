# Hackazon

[Hackazon](https://github.com/rapid7/hackazon) by Rapid7: a vulnerable online store built like a
modern rich-client application, with an AJAX interface, strict shopping-cart workflows and a
RESTful API used by a companion mobile app. This repository runs it with
[Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the machines, and the
upstream source in [`build/hackazon/app/`](build/hackazon/app) is served by a PHP 5.6 / Apache
image written for it (upstream ships no Dockerfile), with the install wizard run at first start.

| Machine | Service |
| --- | --- |
| hackazon | Hackazon (PHP 5.6, Apache) on port 80, published on 8025 |
| db | MariaDB 10.11 on port 3306 |

## Run it

```bash
isoloom generate
isoloom run docker
```

Then open http://localhost:8025/ and log in as `test_user` / `123456`. The back office is
`/admin` (`admin` / `hackazon`) and the REST API is under `/api`. The same spec runs as Docker on
a local VM (`docker-vm`), on a cloud VM (`cloud-docker`) or on Kubernetes. Lab guide: the
[Hackazon wiki](https://github.com/rapid7/hackazon/wiki) and
[VULNERABILITIES.md](build/hackazon/app/VULNERABILITIES.md).

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

Apache-2.0, as Hackazon ([LICENSE](LICENSE)). This application is deliberately vulnerable: keep it
isolated.
