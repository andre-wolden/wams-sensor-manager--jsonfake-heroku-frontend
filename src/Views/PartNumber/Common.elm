module Views.PartNumber.Common exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)


viewCustomer : Customer -> Html Msg
viewCustomer customer =
    div []
        [ text ("Customer name: " ++ customer.name)
        ]
