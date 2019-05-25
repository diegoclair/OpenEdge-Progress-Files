
//To export all fields of databases and create a snippet to vscode

USING Progress.Json.ObjectModel.JsonObject.

DEFINE VARIABLE father      AS JsonObject NO-UNDO.
DEFINE VARIABLE son         AS JsonObject NO-UNDO.


DEF VAR nm-banco-aux AS CHAR NO-UNDO.


father = NEW JsonObject().

// for each {database} name
for each srmovcon._file no-lock
    where _file._tbl-type = 'T',
    each srmovcon._field of srmovcon._file no-lock:
                                        
    &SCOPED-DEFINE escreve-json                                                             ~
                                                                                            ~
        /*Not export generic fields to a better performance (optional)*/                    ~
        if _field._field-name Begins('char-')                                               ~
        or _field._field-name Begins('int-')                                                ~
        or _field._field-name Begins('date-')                                               ~
        or _field._field-name Begins('log-')                                                ~
        or _field._field-name Begins('dec-')                                                ~
        or _field._field-name Begins('u-char-')                                             ~
        or _field._field-name Begins('u-date-')                                             ~
        or _field._field-name Begins('u-log-')                                              ~
        or _field._field-name Begins('u-int-')                                              ~
        or _field._field-name Begins('u-dec-')                                              ~
        then next.                                                                          ~
                                                                                            ~
        son = NEW JsonObject( ).                                                            ~
                                                                                            ~
        father:ADD( INPUT nm-banco-aux + '.' + _file._file-name + '.' + _field._field-name, ~
                    INPUT son).                                                             ~
                                                                                            ~
        son:ADD(INPUT "scope",                                                              ~
                INPUT "abl,abl" ).                                                          ~
                                                                                            ~
        son:ADD(INPUT "prefix",                                                             ~
                INPUT _file._file-name + '.' + _field._field-name).                         ~
                                                                                            ~
        son:ADD(INPUT "body",                                                               ~
                INPUT _file._file-name + '.' + _field._field-name).                         ~
                                                                                            ~
        son:ADD(INPUT "description",                                                        ~
                INPUT "Label: "                                                             ~
                    + (IF _field._label = ? THEN "" ELSE _field._label)                     ~
                    + CHR(10)                                                               ~
                    + "Data Type: "                                                         ~
                    + _field._data-type                                                     ~
                    + CHR(10)                                                               ~
                    + "Format: "                                                            ~
                    + _field._format                                                        ~
                    + CHR(10)                                                               ~
                    + "Description: "                                                       ~
                    + (IF _field._desc = ? THEN "" ELSE _field._desc)                       ~
                    + CHR(10)).

    ASSIGN nm-banco-aux = 'srmovcon'. {&escreve-json}

END.

//if you have more than 1 database
FOR EACH srcadger._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH srcadger._field OF srcadger._file NO-LOCK:
    ASSIGN nm-banco-aux = 'srcadger'. {&escreve-json}
END.
FOR EACH srmovfin._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH srmovfin._field OF srmovfin._file NO-LOCK:
    ASSIGN nm-banco-aux = 'srmovfin'. {&escreve-json}
END.
FOR EACH srmovfi1._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH srmovfi1._field OF srmovfi1._file NO-LOCK:
    ASSIGN nm-banco-aux = 'srmovfi1'. {&escreve-json}
END.
FOR EACH emsmov._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH emsmov._field OF emsmov._file NO-LOCK:
    ASSIGN nm-banco-aux = 'emsmov'. {&escreve-json}
END.
FOR EACH emscad._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH emscad._field OF emscad._file NO-LOCK:
    ASSIGN nm-banco-aux = 'emscad'. {&escreve-json}
END.
FOR EACH emsfnd._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH emsfnd._field OF emsfnd._file NO-LOCK:
    ASSIGN nm-banco-aux = 'emsfnd'. {&escreve-json}
END.
FOR EACH srmovben._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH srmovben._field OF srmovben._file NO-LOCK:
    ASSIGN nm-banco-aux = 'srmovben'. {&escreve-json}
END.
FOR EACH unimedsp._file NO-LOCK
    WHERE _file._tbl-type = 'T',
    EACH unimedsp._field OF unimedsp._file NO-LOCK:
    ASSIGN nm-banco-aux = 'unimedsp'. {&escreve-json}
END.



IF OPSYS = "UNIX" 
    THEN father:Writefile(INPUT '/home/abl-fields.code-snippets', FALSE). 
ELSE 
    father:Writefile(INPUT 'C:/documents/abl-fields.code-snippets', FALSE). 
