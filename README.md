# CouchAPP Template

Install couchdb:

```sh
$ brew install couchdb
```

Publish to local repo:

```sh
$ make
```

The app is live.

Go to http://127.0.0.1:5984/_utils/config.html and select "Add a
new section" at bottom, section: `vhosts`, option: `localhost:5984`, value:
`/clog/\_design/clog/\_rewrite`, and hit "Create". Your site lives on
http://localhost:5984.

To publish to web, create an account on cloudant.com and update .couchapprc with:

```json
{
	"env": {
		"default": {"db": "http://127.0.0.1:5984/clog"},
		"cloudant": {
			"db": "https://<cloudant-user>:<cloudant-password>@<cloudant-user>.cloudant.com/clog"
		}
	}
}
```

Modify \<cloudant-user\> and \<cloudant-password\>. And then do a `make deploy`. On
Cloudant admin you can setup vhost by going to "Account" -> "Virtual Hosts". In
Hostname, pick any domain name you have control over, eg db.amitu.com, in path
use the same value we used locally: /clog/\_design/clog/\_rewrite.
