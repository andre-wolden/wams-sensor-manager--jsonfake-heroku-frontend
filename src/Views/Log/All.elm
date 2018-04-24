module Views.Log.All exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Db.DbModels exposing (StatusLog, StatusLogItem)
import Messages exposing (..)
import CommonComponents.Spinner


viewLog : StatusLog -> Html Msg
viewLog log =
    div [ class "container" ]
        [ h3 [] [ text "LOG" ]
        , CommonComponents.Spinner.insertSpinner
        , img [ src "./assets/grandmaster2.jpg" ] []
        ]
