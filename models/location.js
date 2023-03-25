const mongoose =require('mongoose');


const locationSchema =new mongoose.Schema({
    coordinates:[{type:mongoose.Types.Decimal128}],
    type:{type:String},
    user:{type:String},
    desc:{type:String},
    photos:[{type:String}],
    expires:{type:Date},
    date:{type:Date},
    range:{type:Number},
    status:{type:Boolean}

});

module.exports =new mongoose.model('location',locationSchema);