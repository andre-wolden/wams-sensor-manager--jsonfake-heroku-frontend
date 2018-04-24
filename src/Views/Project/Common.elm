module Views.Project.Common exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)


viewProject : Project -> Html Msg
viewProject project =
    div []
        [ text ("Project name: " ++ project.name)
        ]
