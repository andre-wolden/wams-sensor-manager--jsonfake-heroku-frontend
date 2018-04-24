module Views.Project.ById exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)
import RemoteData exposing (WebData)
import Views.Project.Common exposing (..)


viewProjectById : WebData Projects -> String -> Html Msg
viewProjectById projects projectIdString =
    case projects of
        RemoteData.NotAsked ->
            text "Initialising"

        RemoteData.Loading ->
            text "Loading"

        RemoteData.Failure error ->
            text ("Error: " ++ toString error)

        RemoteData.Success projects ->
            let
                projectId =
                    String.toInt projectIdString
            in
                case projectId of
                    Ok id ->
                        let
                            maybeProject =
                                projects
                                    |> List.filter (\project -> project.id == id)
                                    |> List.head
                        in
                            case maybeProject of
                                Just project ->
                                    viewProject project

                                Nothing ->
                                    text "No project with this ID number"

                    Err error ->
                        text "error"
