module Views.Operator.Common exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)


viewOperator : Operator -> Html Msg
viewOperator operator =
    div []
        [ text ("Operator name: " ++ operator.name)
        ]
