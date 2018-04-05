
page 50127 NAVObjectPermissionsPage
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = NAVObjectPermissionsBuffer;    
    // Add Cloud properties
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All,Basic,Suite,Advanced;

    layout
    {
        area(content)
        {
            field("Info:";pagedescription)
            {
                Editable = false;
                ApplicationArea = All,Basic,Suite,Advanced;
            }

            field("Object Type";filterobjecttype)
            {
                ApplicationArea = All,Basic,Suite,Advanced;
            }
            field("Object ID";filterobjectid)
            {
                ApplicationArea = All,Basic,Suite,Advanced;
            }
            repeater(Group)
            {
                Editable = false;            
                
                field(Objecttype;Objecttype)
                {
                    Caption = 'ObjectType';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Modulename;Modulename)
                {
                    Caption = 'ModuleName';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Versionname;Versionname)
                {
                    Caption = 'VersionName';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }                
                field(Pread;Pread)
                {
                    Caption = 'Read';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Pinsert;Pinsert)
                {
                    Caption = 'Insert';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Pmodify;Pmodify)
                {
                    Caption = 'Modify';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Pdelete;Pdelete)
                {
                    Caption = 'Delete';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Pexecute;Pexecute)
                {
                    Caption = 'Execute';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }
                field(Productline;Productline)
                {
                    Caption = 'ProducLine';
                    ApplicationArea = All,Basic,Suite,Advanced;
                }                
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Search)
            {
                ApplicationArea = All,Basic,Suite,Advanced;
                trigger OnAction();
                begin
                    Buffer.DeleteAll;
                    textfilterobjecttype := '/'+Format(filterobjecttype)+'/';
                    textfilterobjectid :=  Format(filterobjectid);
                    Client.Get(WebApi+textfilterobjecttype+textfilterobjectid,Response);
                    Content := Response.Content;
                    Content.ReadAs(Json);
        
                    JArray.ReadFrom(Json);
                                             
                    for Index := 0 to JArray.Count-1 do begin
                        JArray.Get(Index,JToken);
                                        
                        JObject := JToken.AsObject;
                        Buffer.Init;

                        JObject.Get('dataid',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Dataid := JValue.AsInteger; 
                        
                        JObject.Get('objecttype',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Objecttype := JValue.AsText; 
                        
                        JObject.Get('modulename',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Modulename := JValue.AsText; 

                        JObject.Get('versionname',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Versionname := JValue.AsText; 

                        JObject.Get('pread',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Pread := JValue.AsText; 

                        JObject.Get('pinsert',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Pinsert := JValue.AsText; 

                        JObject.Get('pmodify',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Pmodify := JValue.AsText; 

                        JObject.Get('pdelete',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Pdelete := JValue.AsText; 

                        JObject.Get('pexecute',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Pexecute := JValue.AsText; 

                        JObject.Get('productline',JToken);
                        JValue := JToken.AsValue;
                        Buffer.Productline := JValue.AsText;                         

                        Buffer.Insert;                    
                    end;
                    
                end;
            }
            action(Clear)
            {
                ApplicationArea = All,Basic,Suite,Advanced;
                trigger OnAction();
                begin
                    Buffer.DeleteAll;
                end;
            }
        }
    }
    trigger OnInit();
    begin
        Buffer.DeleteAll;
        WebAPI := 'http://alfnavobjectpermissionsreportnetcorewebapi.azurewebsites.net/api/values';
        Client.Get(WebApi,Response);
        Content := Response.Content;
        Content.ReadAs(Json);
        pagedescription := Json+'  WebAPI: '+WebAPI+'/{type}/{id}';
    end;


    var
        filterobjecttype : Option TableData,TableDescription,Form,"Report",Dataport,"XMLport","Codeunit",MenuSuite,"Page";
        filterobjectid : BigInteger;
        Json: text;
        Client : HttpClient;
        Response : HttpResponseMessage;
        Content : HttpContent;
        Buffer: record NAVObjectPermissionsBuffer;
        JObject: JsonObject;
        JArray: JsonArray;
        JToken: JsonToken;
        JValue: JsonValue;
        Index: Integer;      
        WebAPI:Text;
        textfilterobjecttype:Text;
        textfilterobjectid:Text;
        pagedescription:Text;

}

