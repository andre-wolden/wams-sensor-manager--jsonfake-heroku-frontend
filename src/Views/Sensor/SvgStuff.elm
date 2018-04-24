module Views.Sensor.SvgStuff exposing (..)

import Html
import Html.Attributes
import Svg exposing (..)
import Svg.Attributes exposing (..)
import StatusCodes.StatusCodes as SC
import Models exposing (Model)
import Db.DbModels exposing (..)


type alias StartingPosition =
    { x : Int
    , y : Int
    }


startingPosition : StartingPosition
startingPosition =
    { x = 40
    , y = -40
    }


lengthBlackLine : Int
lengthBlackLine =
    80


radiusBlackCircle : Int
radiusBlackCircle =
    20


percentageLargerGreenThanBlack : Int
percentageLargerGreenThanBlack =
    20


lengthGreenLine : Int -> Int
lengthGreenLine lengthBlackLine =
    lengthBlackLine


radiusGreenCircle : Float -> Float -> Float
radiusGreenCircle radiusBlackCircle percentageLargerGreenThanBlack =
    radiusBlackCircle * (1 + (percentageLargerGreenThanBlack / 100))


blackLine : String -> String -> String -> String -> Svg.Svg msg
blackLine x_1 y_1 x_2 y_2 =
    line
        [ stroke "black"
        , strokeWidth "5"
        , x1 x_1
        , y1 y_1
        , x2 x_2
        , y2 y_2
        ]
        []


blackCircle : Int -> Int -> Int -> Svg msg
blackCircle c_x c_y r =
    circle
        [ cx (toString c_x)
        , cy (toString c_y)
        , color "black"
        , radius (toString r)
        ]
        []


greenLine : String -> String -> String -> String -> Svg.Svg msg
greenLine x_1 y_1 x_2 y_2 =
    line
        [ stroke "black"
        , strokeWidth "5"
        , x1 x_1
        , y1 y_1
        , x2 x_2
        , y2 y_2
        ]
        []


greenCircle : Int -> Int -> Int -> Svg.Svg msg
greenCircle posX posY r =
    circle
        [ cx (toString x)
        , cy (toString y)
        , radius (toString r)
        , fill "rgba(41, 213, 69, 1)"
        ]
        []


insertStatusDrawing : Model -> String -> Sensor -> Html.Html msg
insertStatusDrawing model w_class_name sensor =
    let
        n =
            sensor.current_status

        status_codes =
            SC.statusCodes
    in
        svg [ width "350", height "400", viewBox "0 0 350 400" ]
            (List.append
                [ text_ [ x "20", y "40" ] [ Svg.text "Status" ]
                ]
                (List.concat
                    (List.map (keyElement n) status_codes)
                )
            )


keyElement : Int -> SC.StatusCode -> List (Svg.Svg msg)
keyElement currentStep statusCode =
    let
        n =
            statusCode.id

        start =
            10 + (n * 40)

        y_1 =
            toString (start)

        y_2 =
            toString (start + 40)

        y_2_pluss =
            toString (start + 46)
    in
        if statusCode.id <= currentStep then
            [ line [ x1 "40", y1 y_1, x2 "40", y2 y_2, stroke "rgba(0, 255, 0, 1)", strokeWidth "16" ] []
            , circle [ cx "40", cy y_2, r "18", fill ("rgba(0, 255, 0, 1)") ] []
            , line
                [ stroke "black"
                , strokeWidth "6"
                , x1 "40"
                , y1 y_1
                , x2 "40"
                , y2 y_2
                ]
                []
            , circle [ cx "40", cy y_2, r "13" ] []
            , text_ [ x "65", y y_2_pluss ] [ Svg.text statusCode.status_description ]
            , text_ [ x "5", y y_2_pluss ] [ Svg.text (toString n) ]
            ]
        else
            [ line
                [ stroke "black"
                , strokeWidth "6"
                , x1 "40"
                , y1 y_1
                , x2 "40"
                , y2 y_2
                ]
                []
            , circle [ cx "40", cy y_2, r "13" ] []
            , text_ [ x "65", y y_2_pluss ] [ Svg.text statusCode.status_description ]
            , text_ [ x "5", y y_2_pluss ] [ Svg.text (toString n) ]
            ]



-- END
