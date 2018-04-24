module Commands.ProjectCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (projectDecoder)
import Messages exposing (Msg)


saveProject : Project -> Cmd Msg
saveProject project =
    request project
        |> Http.send Messages.OnProjectSaved


request : Project -> Http.Request Project
request project =
    Http.request
        { body = projectEncoder project |> Http.jsonBody
        , expect = Http.expectJson projectDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/projects"
        , withCredentials = False
        }


projectEncoder : Project -> Encode.Value
projectEncoder project =
    let
        attributes =
            [ ( "id", Encode.int project.id )
            , ( "name", Encode.string project.name )
            , ( "customer", Encode.int project.customer )
            ]
    in
        Encode.object attributes
