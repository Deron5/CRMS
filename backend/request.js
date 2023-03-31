const http = require('http')
const fs = require('fs')
const url = require('url')
const RequestHandler = require('./RequestHandler')
const qs = require('querystring')
const query = new RequestHandler();

const INDEX_FILE =  "../index.html"
const PORT = 8080;

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
    console.log(req.headers.cookie)
    let data = "";
    
    req.on('data',(chunk)=>{
        data+=chunk;
    })

    req.on('end',()=>{
        if(data){

            data = JSON.parse(data)
            try{
                switch (data["func"]) {
                    case "login":
                        query["login"](data["params"]).then(data=>{
                            res.writeHead(200,{
                                'Set-Cookie': `role:${JSON.parse(data)["role"]};httpOnly:true`
                            }).end(JSON.stringify({redirect:`http://localhost:${PORT}/index.html`}));
                        }).catch(err=>{
                            console.log(err)
                            res.setHeader('Content-Type','application/json');
                            res.end(JSON.stringify({error:"Invalid Login Credentials"}));
                        })
                        break;
                
                    default:
                        res.setHeader('Content-Type','application/json');
                        let returndata = query[data["func"]](data["params"]);
                        returndata.then(data=>{
                            res.end(data)
                        })
                        break;
                }
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
    

}).listen(PORT);