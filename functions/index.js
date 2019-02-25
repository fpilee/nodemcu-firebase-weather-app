require('dotenv').config();

const functions = require('firebase-functions');
const admin = require('firebase-admin');

var config = {
    apiKey: process.env.API_KEY,
    authDomain: process.env.AUTH_DOMAIN,
    databaseURL: process.env.DATABASE_URL,
    projectId: process.env.PROJECT_ID,
    storageBucket: process.env.STORAGE_BUCKET,
    messagingSenderId: process.env.MESSAGING_SENDER_ID
};

admin.initializeApp(config);

exports.saveClimate = functions.https.onRequest((req, res) => {

    if ('temp' in req.body === false || 'humidity' in req.body === false) {
        res.status(400).json({error: 'Missing fields in request'});
    }

    try {
        admin.database().ref('/climate').push().set(
            {
                temp: req.body.temp,
                humidity: req.body.humidity,
                ts: +new Date()
            }, (error) => {
                if (error) {
                    res.status(400).json({error: 'Error saving climate data to database'});
                } else {
                    res.status(200).json({message: 'climate reading saved'});
                }
            }
        )
    } catch (err) {
        res.status(400).json({error: err.name + ": " + err.message});
    }

});
