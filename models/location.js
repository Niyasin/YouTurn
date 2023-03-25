const mongoose =require('mongoose');


const locationSchema =new mongoose.Schema({
    coordinates:[{type:String}],
    type:{type:String}
});

module.exports =new mongoose.model('location',locationSchema);