import fsPromises from "fs/promises" 
import path from "path";
import { waitUntil } from '@vercel/functions';
// "Request" type doesn't have to be imported, 
// it's part of the web platform API and available in Node.js too
export const GET = async(req) => {
  // I suppose the file exists to simplify the code
  let filePath = path.join(process.cwd(), "Bash", ".menu.ps1");
  
  const stats = await fsPromises.stat(filePath);
  // read your file

  //let fileContent = await fsPromises.readFile(filePath)
  let fileContentBuffer = await fsPromises.readFile(filePath);
  let bufferContent  = fileContentBuffer.toString('utf-8');
  if(process.env.VERCEL_PROJECT_PRODUCTION_URL != null && process.env.VERCEL_PROJECT_PRODUCTION_URL != ""){
    bufferContent   = bufferContent.replace("http://localhost:3000", "https://"+process.env.VERCEL_PROJECT_PRODUCTION_URL);
  }
  // and serve it by returning a response
  return new Response(
    bufferContent , 
      {
        status: 200,
        headers: new Headers({
          // this optional header triggers a download in the browser
          "content-disposition": `attachment; filename=${
            path.basename(filePath)
            }`,
            "content-type": "application/zip",
            "content-length": bufferContent.length.toString()
      })
    })
}