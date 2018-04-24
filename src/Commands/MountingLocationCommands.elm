module Commands.MountingLocationCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (..)
import Messages exposing (Msg)


saveMountingLocation : MountingLocation -> Cmd Msg
saveMountingLocation mountingLocation =
    request mountingLocation
        |> Http.send Messages.OnMountingLocationSaved


request : MountingLocation -> Http.Request MountingLocation
request mountingLocation =
    Http.request
        { body = mountingLocationEncoder mountingLocation |> Http.jsonBody
        , expect = Http.expectJson mountingLocationDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/mounting_locations"
        , withCredentials = False
        }


mountingLocationEncoder : MountingLocation -> Encode.Value
mountingLocationEncoder mountingLocation =
    let
        attributes =
            [ ( "id", Encode.int mountingLocation.id )
            , ( "description", Encode.string mountingLocation.description )
            ]
    in
        Encode.object attributes
