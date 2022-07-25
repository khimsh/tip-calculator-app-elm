module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


headerComponent =
    header [ class "app-header" ]
        [ div []
            [ img [ src "/assets/images/SPLITTER.svg" ] []
            ]
        ]


bill =
    div []
        [ h2 [ class "label" ] [ text "Bill" ]
        , div []
            [ input [ type_ "number", placeholder "0", value "142.55" ] []
            ]
        ]


selectTip =
    div [ class "app-select-tip" ]
        [ h2 [ class "label" ] [ text "Select Tip %" ]
        , div []
            [ radioButton "5%" "5" "five"
            , radioButton "10%" "10" "ten"
            , radioButton "15%" "15" "fifteen"
            , radioButton "25%" "25" "twentyfive"
            , radioButton "50%" "50" "fifty"
            , input [ type_ "number", placeholder "Custom" ] []
            ]
        ]


radioButton labelText optionValue optionId =
    div []
        [ input [ type_ "radio", id optionId, value optionValue, name "tipPercent" ] []
        , label [ for optionId ] [ text labelText ]
        ]


numberPeople =
    div []
        [ h2 [ class "label" ] [ text "Number of People" ]
        , div []
            [ input [ type_ "number", placeholder "0", value "5" ] []
            ]
        ]


calculator =
    div []
        [ bill
        , selectTip
        , numberPeople
        ]


calculatedTip =
    div []
        [ div []
            [ h2 [] [ text "Tip Amount" ]
            , p [] [ text "/ person" ]
            ]
        , div [ class "returned-amount" ] [ text "$0.00" ]
        ]


calculatedTotal =
    div []
        [ div []
            [ h2 [] [ text "Total" ]
            , p [] [ text "/ person" ]
            ]
        , div [ class "returned-amount" ] [ text "$0.00" ]
        ]


result =
    div [ class "app-result" ]
        [ div [ class "app-result-amount" ]
            [ calculatedTip
            , calculatedTotal
            ]
        , button [ class "btn-reset", type_ "reset" ] [ text "reset" ]
        ]


main =
    div [ class "app-container" ]
        [ headerComponent
        , div [ class "app" ]
            [ Html.form []
                [ calculator
                , result
                ]
            ]
        ]
