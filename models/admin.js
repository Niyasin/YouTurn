const mongoose =require('mongoose');


const adminSchema =new mongoose.Schema({
    uid:{type:String},
});


module.exports =new mongoose.model('admin',adminSchema);