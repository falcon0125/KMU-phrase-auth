; TODO: fix logging
; Define the log function
Log(message)
{
    ; Get the current date and time
    datetime := A_Now

    ; Format the log message
    log_message = %datetime% - %message% `n

    ; Append the log message to the file
    FileAppend, %log_message%, "logfile.txt"
}

; Test the log function
;result:=auth(1100585)
;OutputDebug, %result%

auth(user){
    ; Read the CSV file into a variable
    csvFile = localauth.csv
    FileDelete, localauth.csv
    ToolTip, authentication start,
    sleep,1000
    UrlDownloadToFile, https://raw.githubusercontent.com/falcon0125/KMU-phrase-auth/master/auth.csv, localauth.csv
    if (ErrorLevel!=0){
        MsgBox, , authentication, Can not get authenitcation file, please check connection,
        Log("Can not get authenitcation file, please check connection")
        return False
    }
    FileRead, csvData, %csvFile%
    if (InStr(csvData, "404: Not Found")){
        MsgBox, , authentication, error 404: can not get authenitcation file, please check connection,
        Log("authentication, error 404: can not get authenitcation file, please check connection")
        return False
    }
    ToolTip, authentication list downloaded,
    sleep,1000
    ;TrayTip, authentication, authentication list downloaded, 1
    OutputDebug, % A_Now
    ; Specify the path to the CSV file

    ; Specify the value to search for in the CSV file

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
                Log(%user% pass authentication)
                return True
            } Else{
                MsgBox, %user% license expire at %ExpireDate%, please buy new license
                Log(%user% license expire at %ExpireDate%)
                return False
            }

        }
    }

    MsgBox, user %user% not allow to use, please buy new license
    Log("user %user% not allow to use, please buy new license")
    ; Show a message if no matching line was found
    return False
}

result:=auth(1100585)