const express = require('express');
const app = express();
const fs = require('fs');
const qr = require('qrcode');
const ping = require('ping');
app.set('view engine', 'pug');
app.use(express.static(__dirname + '/public'));
const host = '10.64.0.1';
const server = app.listen(8099, () => {
  console.log(`Express running → PORT ${server.address().port}`);
});

app.get('/', (req, res) => {
	var user = fs.readFileSync('/user-id', 'utf8');
	var qrRequest = qr.toDataURL(user + '.oilab.ninja');
	qrRequest.then( value => {
			res.render('index', {
				url: value,
				state: false
			});
		}).catch(err => {
			res.render('error', {
				message: err.message
			})
		});
});

app.get('/ping', (req, res) => {
	var pingRequest = ping.promise.probe(host);
	pingRequest.then( result => {
		res.send(result);
	});
});
