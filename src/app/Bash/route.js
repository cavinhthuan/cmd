import fsPromises from "fs/promises" 
import path from "path";
export const runtime = "nodejs";

export const GET = async (req) => {
 
  let filePath = path.join(process.cwd(), "Bash"); // Using path.join() for constructing file path
  const { searchParams } = new URL(req.url);
  const run = searchParams.get("run");
  
  const files = await fsPromises.readdir(filePath);
  
  if (!run) {
    try {
      // Read directory contents
      let filesArray = files.filter(f => !f.startsWith('.') && f.endsWith(".ps1")).map(x => { return { Name: x }; });

  let responseObject = {
    files: filesArray
  };

  let jsonResponse = JSON.stringify(responseObject);
  return new Response(jsonResponse, { 
    status: 200, 
    headers: { "Content-Type": "application/json" } 
  });
    } catch (error) {
      return new Response("Error reading directory", { status: 500 });
    }
  }


  
  filePath = path.join(filePath, run + ".ps1");
  console.log(filePath);
  try {
    const stats = await fsPromises.stat(filePath);
    const fileContent = await fsPromises.readFile(filePath);

    return new Response(fileContent, {
      status: 200,
      headers: new Headers({
        "content-disposition": `attachment; filename="${path.basename(filePath)}"`,
        "content-type": "application/octet-stream", // Setting appropriate content-type
        "content-length": stats.size.toString(),
      }),
    });
  } catch (error) {
    return new Response("File not found", { status: 404 });
  }
};
