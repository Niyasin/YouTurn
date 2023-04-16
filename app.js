const mongoose = require('mongoose');
const express = require('express');
const bodyparser =require('body-parser');
const path =require('path');
require('dotenv').config();
const location=require('./models/location');
const firebaseAdmin=require('./firebase');
const admin = require('./models/admin');
const app = express();

app.use(express.static(path.join(__dirname,'client_web','build')));
app.use(bodyparser.urlencoded());
app.use(bodyparser.json());

app.post('/add',async(req,res)=>{
    console.log(req.body);
    let datetime=new Date();
    let range=(t)=>{
        if(t=='Tiger'){
            return 800
        }else if(t=='Road Block'){
            return 10
        }else if(t=='Landslide'){
            return 30
        }else if(t=='Downed powerline'){
            return 20
        }else{
            return 50
        }
    }

    console.log(req.body);
    if(req.body.lng && req.body.lat && req.body.type ){
        let data = {
            coordinates:[req.body.lat,req.body.lng],
            type:req.body.type,
            range:req.body.range || range(req.body.type),
            desc:req.body.desc || "",
            date:datetime,
            status:true,
            photos:req.body.photos || [],
            expires:new Date(datetime.getTime()+((req.body.expires || 12) * 60 * 60 * 1000)),
        }
        await location.create(data);
        res.send('success');
    }else{
        res.send("error");
    }
});

app.get('/',(req,res)=>{
    res.sendFile(path.join(__dirname,'client_web','build','index.html'));
})

app.post('/verify',async (req,res)=>{
    if(req.body.id){
        let doc = await location.findByIdAndUpdate(req.body.id,{verified:true});
        res.send(doc)
    }
});

app.post('/enable',async (req,res)=>{
    if(req.body.id){
        let doc = await location.findByIdAndUpdate(req.body.id,{status:true});

        res.send(doc)
        
    }
});

app.post('/disable',async (req,res)=>{
    if(req.body.id){
        let doc = await location.findByIdAndUpdate(req.body.id,{status:false});

        res.send(doc)
    }
});



app.post('/upvote',async (req,res)=>{
    if(req.body.lng && req.body.lat){
        let coords = [req.body.lat,req.body.lng];
        let doc = await location.findOneAndUpdate({coordinates:coords},{$push:{up:'1'}});
        res.send('sucess');
    }
});


app.post('/downvote',async (req,res)=>{
    if(req.body.lng && req.body.lat){
        let coords = [req.body.lat,req.body.lng];
        let doc = await location.findOneAndUpdate({coordinates:coords},{$push:{down:'1'}});
        res.send('sucess');
    }
});


app.get('/check',async (req,res)=>{
    try{
        let coords = [req.query.lat,req.query.lng];
        let e = await location.findOne({
            coordinates:coords,
        });
        if(e){
            res.send(JSON.stringify({
                lat:e.coordinates[0],
                lng:e.coordinates[1],
                range:e.range,
                type:e.type,
                user:e.user,
                desc:e.desc,
                date:e.date,
                expiring:e.expiring,
                verified:e.verified,
                photos:e.photos,
                up:e.up.length,
                down:e.down.length,
            }));
        }else{
            res.send('error');
        }

    }catch(e){
        res.send("error");
    }
});

app.get('/test',(req,res)=>{
    console.log("Test 😋");
    res.send("Test 😋");
})

app.get('/loaddata',async (req,res)=>{
    if(req.query.lat && req.query.lng){
        let coords = [req.query.lat,req.query.lng];
        console.log(coords);
        let range = req.query.range || 5000;
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
        let d=[];
        docs.forEach(e=>{
            d.push({
                lat:e.coordinates[0],
                lng:e.coordinates[1],
                range:e.range,
                type:e.type,
                user:e.user,
                desc:e.desc,
                date:e.date,
                expiring:e.expiring,
                verified:e.verified,
                photos:e.photos,
                up:e.up.length,
                down:e.down.length,
            });
        })
        console.log(d);
        res.json(d);
    }else{
        res.status(404);
    }
});


app.post('/signup',async()=>{
    try{
        let {uid,email,phone,name} = req.body;
        await user.create({
            uid,email,phone,name,
        });
    }catch(e){

    }
});

app.get('/getdata',async (req,res)=>{
    if(req.query.lat && req.query.lng){
        let coords = [req.query.lat,req.query.lng];
        console.log(coords);
        let range = req.query.range || 5000;
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
    }else{
        res.status(404);
    }
});

app.post('/admin',async(req,res)=>{
    let {token} =req.body;
    if(token){
        const decodedToken = await firebaseAdmin.auth().verifyIdToken(token);
        const uid = decodedToken.uid;
        console.log(uid);
        let user = await admin.findOne({uid});
        if(user){
            res.json({status:true})
        }else{
            res.json({status:false})
        }
    }else{
        res.json({status:false})
    }
})




mongoose.set('strictQuery', false);
mongoose.connect(process.env.DB).then(()=>{
    app.listen(process.env.PORT || 8080);
    console.log("SERVER STARTED");
}).catch((err)=>{
    console.error(err);
});
