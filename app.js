const mongoose = require('mongoose');
const express = require('express');
const bodyparser =require('body-parser');
const path =require('path');
const location=require('./models/location');
const app = express();

app.get('/loaddata',async (req,res)=>{
    let coords = [req.query.lat,req.query.lng];
    let range = req.query.range || 500;
    let docs = await location.find({
        coordinates:{
            $near:{
                $geometry:{
                    type:'Point',
                    coordinates:coords,
                },
                $maxDistance:range,
                $minDistance:0,
            }
        }
    });
    res.json(docs);
})



mongoose.set('strictQuery', false);
mongoose.connect('mongodb://0.0.0.0:27017/CDNS').then(()=>{
    app.listen(8080);
    console.log("SERVER STARTED");
}).catch((err)=>{
    console.error(err);
});
