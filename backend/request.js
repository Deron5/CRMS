const http = require('http')
const fs = require('fs')
const url = require('url')
const RequestHandler = require('./RequestHandler')
const qs = require('querystring')
const query = new RequestHandler();

const INDEX_FILE =  "../index.html"

const isEmpty = (obj)=>{
    for(var i in obj) return false;
    return true;
}

//loads the file based on the url
function loadFile(req,res,url_) {
    const re = new RegExp(".+[.].+");
    let type;
    let filePath;

    //determine file type and path
    if(re.test(url_.pathname)){
        filePath = `..${url_.pathname}`;
        type = filePath.substring(filePath.lastIndexOf(".")+1);
    }else{//default to html
        filePath = `..${req.url}.html`;
        type = "html";
    }

    //load file 
    if(req.url == "/favicon.ico"){
        res.writeHead(204);
        res.end();
    }else{
        fs.readFile(filePath, (err,data)=>{
            if(err){//file doesn't exist
                fs.readFile(INDEX_FILE, (err,data)=>{
                   //err should never happen
                    res.writeHead(400, { 'Content-Type': 'text/html' });
                    res.end(data);
                })
            }else{
                res.writeHead(200, { 'Content-Type': `text/${type}` });
                res.end(data);
            }
        })
    }
}


http.createServer((req, res) => {
    let data = "";
    
    req.on('data',(chunk)=>{
        data+=chunk;
    })

    req.on('end',()=>{
        if(data){
            data = JSON.parse(data)

            res.setHeader('Content-Type','application/json');
            
            //try calling the function passed as the func parameter
            //return the results of the function
            try {
                let returndata = query[data["func"]](data["params"]);
                returndata.then(data=>{
                    res.end(data)
                })
            } catch (error) {
                console.log(error)
                res.end(JSON.stringify({error:"Unknown Function"}));
            }
    
        }else
            loadFile(req,res,url_);
    })

    let url_ = new url.URL(`http://localhost:8080/${req.url}`)
    let params = url_.searchParams; 
    // if it has query parameters assume it is a  query
    

}).listen(8080);