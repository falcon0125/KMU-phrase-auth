;TrayTip, authentication, getting authentication list, 1
ToolTip, authentication start,
sleep,1000
;UrlDownloadToFile, "", Filename
ToolTip, authentication list downloaded,
sleep,1000
;TrayTip, authentication, authentication list downloaded, 1
OutputDebug, % A_Now
; Specify the path to the CSV file
csvFile = auth.csv
; Specify the value to search for in the CSV file


auth(user){
    ; Read the CSV file into a variable
    global csvFile
    FileRead, csvData, %csvFile%

    ; Split the CSV data into lines and fields
    Loop, Parse, csvData, `r`n
    {
        ; Split the current line into fields
        currentLine := A_LoopField
        fields := StrSplit(currentLine, ",")

        ; Check if the current line matches the search value
        If fields[1] = user
        {
            ; Return the matched line
            ifields := StrSplit(currentLine, ",")
            ExpireDate:=ifields[2]
            result :=  A_now < ifields[2]
            OutputDebug, %user% %result%
            if (result){
                TrayTip, authentication, %user% pass authentication, 1
                return True
            } Else{
                MsgBox, %user% license expire at %ExpireDate%, please buy new license
                return False
            }

        }
    }

    MsgBox, user %user% not allow to use, please buy new license
    ; Show a message if no matching line was found
    return False
}

result:=auth(1100585)
OutputDebug, %result%