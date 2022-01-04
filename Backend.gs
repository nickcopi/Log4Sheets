const key = 'Legitlogkey'

function doPost(e){
  const data = JSON.parse(e.postData.contents);
  if(data.key !== key) return ContentService.createTextOutput(JSON.stringify({
    success:false,
    message:"Unauthenticated"
  }));
  const dateData = new Date();
  const date = dateData.toLocaleDateString();
  const time = dateData.toLocaleTimeString();
  writeMessage('Hostname',data.hostname);
  writeMessage('Message',data.message);
  writeMessage('Date',date);
  writeMessage('Time',time);
  //writeMessage('Debug',JSON.stringify(e));
  return ContentService.createTextOutput(JSON.stringify({
    success:true,
    message:"Logged data!"
  }));
}

const writeMessage = (header,message,y)=>{
  const sheet = SpreadsheetApp.getActive().getSheets()[0];
  if(!sheet.getLastColumn())
    return [];
  const headers = sheet.getRange(1,1, 1, sheet.getLastColumn()).getValues().flat().filter(entry=>entry !== '');
  let columnNumber;
  if(headers.includes(header)) columnNumber = headers.indexOf(header)+1;
  else{
    return false;
  }
  let rowNumber = readColumn(columnNumber).length+1
  sheet.getRange(rowNumber, columnNumber).setValue(message);
  return true;
}

function readColumn(column){
  const sheet = SpreadsheetApp.getActive().getSheets()[0];
  if(!sheet.getLastRow())
    return [];
  return sheet.getRange(1,column, sheet.getLastRow(), 1).getValues().flat().filter(entry=>entry !== '');
}
