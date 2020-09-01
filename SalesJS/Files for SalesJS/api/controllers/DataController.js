module.exports = {
    getUsers: async (req, res)=>{
	var users = await User.find();

	res.send(users);
    },
    createUser: async (req, res)=>{
	var header = req.headers;
	var username = header['username'];
	var password = header['password'];

	await User.create({username: username, password: password}).exec((err)=>{
	    if(err != null) { return res.send("FAIL") }
	    res.send("PASS");
	});
    },
    deleteUser: async (req, res)=>{
	var id =  req.headers['id'];
	
	await User.destroy({id: id}).exec((err)=>{
	    if(err != null) { return res.send("FAIL") }
	    res.send("PASS");
	})
    }
}