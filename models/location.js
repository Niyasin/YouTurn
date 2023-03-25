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
    votes:{type:Number}

});


module.exports =new mongoose.model('location',locationSchema);