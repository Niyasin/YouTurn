const mongoose =require('mongoose');


const locationSchema =new mongoose.Schema({
    coordinates:[{type:Number}],
    type:{type:String},
    user:{type:String},
    desc:{type:String},
    photos:[{type:String}],
    expires:{type:Date},
    date:{type:Date},
    range:{type:Number},
    status:{type:Boolean},
    up:[{type:String}],
    down:[{type:String}],
    verified:{type:Boolean}
});


module.exports =new mongoose.model('location',locationSchema);