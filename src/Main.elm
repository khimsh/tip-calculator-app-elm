module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Debug exposing (toString)


-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { billAmount : Float
    , peopleCount : Int
    , tipPercent : Float
    , calculatedTotal : Float
    , calculatedTip : Float
    }


init : Model
init =
    { billAmount = 0.0
    , peopleCount = 0
    , tipPercent = 0.0
    , calculatedTotal = 0.0
    , calculatedTip = 0.0
    }


billAmountPerPerson : Float -> Int -> Float
billAmountPerPerson billAmount peopleCount =
    billAmount / toFloat peopleCount


calculateTotalAmount : Float -> Int -> Float -> Float
calculateTotalAmount billAmount peopleCount tipPercent =
    billAmount + (billAmount * (tipPercent / 100)) / toFloat peopleCount


calculateTipAmount : Float -> Int -> Float -> Float
calculateTipAmount billAmount peopleCount tipPercent =
    (billAmount * (tipPercent / 100)) / toFloat peopleCount


-- UPDATE


type Msg
    = PeopleCount String
    | BillAmount String
    | UpdateTipPercent String
    | CalculateTotal Float Int Float
    | CalculateTipAmount Float Int Float


update : Msg -> Model -> Model
update msg model =
    case msg of
        PeopleCount people ->
            { model | peopleCount = String.toInt people |> Maybe.withDefault 0 }

        BillAmount billRaw ->
            { model | billAmount = String.toFloat billRaw |> Maybe.withDefault 0.0 }

        UpdateTipPercent percent -> 
            { model | tipPercent = String.toFloat percent |> Maybe.withDefault 0.0}

        CalculateTipAmount billAmount peopleCount tipPercent -> 
            { model | calculatedTip = calculateTipAmount billAmount peopleCount tipPercent  }
        
        CalculateTotal billAmount peopleCount tipPercent -> 
            { model | calculatedTotal = calculateTotalAmount billAmount peopleCount tipPercent }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "app-container" ]
        [ headerComponent
        , div [ class "app" ]
            [ Html.form []
                [ calculator model
                , result model
                ]
            ]
        ]


headerComponent : Html msg
headerComponent =
    header [ class "app-header" ]
        [ div []
            [ img [ src "/assets/images/SPLITTER.svg" ] []
            ]
        ]


bill : Model -> Html Msg
bill model =
    div []
        [ h2 [ class "label" ] [ text "Bill" ]
        , h3 [] [ text (toString model.billAmount) ]
        , div []
            [ input [ type_ "number", placeholder "0", onInput BillAmount ] []
            ]
        ]


numberPeople : Model -> Html Msg
numberPeople model =
    div []
        [ h2 [ class "label" ] [ text "Number of People" ]
        , h3 [] [ text (toString model.peopleCount) ]
        , div []
            [ input [ type_ "number", placeholder "0", onInput PeopleCount ] []
            ]
        ]

selectTip : Model -> Html Msg
selectTip model = 
    div [ class "app-select-tip" ]
        [ h2 [ class "label" ] [ text "Select Tip %" ]
        , h3 [] [ text (toString model.tipPercent) ]
        , div []
            [ div []
                    [
                    input [ type_ "radio", value "5", name "tipPercent", id "five", onClick (UpdateTipPercent "5.0") ] []
                ,   label [ for "five" ] [ text "5%" ]
                ] 
                , div []
                    [
                    input [ type_ "radio", value "10", name "tipPercent", id "ten", onClick (UpdateTipPercent "10.0") ] []
                ,   label [  for "ten" ] [ text "10%" ]
                ] 
                , div []
                    [
                    input [ type_ "radio", value "15", name "tipPercent", id "fifteen", onClick (UpdateTipPercent "15.0") ] []
                ,   label [  for "fifteen" ] [ text "15%" ]
                ] 
                , div []
                    [
                    input [ type_ "radio", value "25", name "tipPercent", id "twentyfive", onClick (UpdateTipPercent "25.0") ] []
                ,   label [  for "twentyfive" ] [ text "25%" ]
                ] 
                , div []
                    [
                    input [ type_ "radio", value "50", name "tipPercent", id "fifty", onClick (UpdateTipPercent "50.0") ] []
                ,   label [  for "fifty" ] [ text "50%" ]
                ] 
                , div []
                    [
                    input [ type_ "number", placeholder "custom", name "tipPercent", onInput UpdateTipPercent ] []
                ] 
            ]
        ]

calculator : Model -> Html Msg
calculator model =
    div []
        [ bill model
        , selectTip model
        , numberPeople model
        ]


calculatedTip : Model -> Html msg
calculatedTip model =
    div []
        [ div []
            [ h2 [] [ text "Tip Amount" ]
            , p [] [ text "/ person" ]
            ]
        , div [ class "returned-amount" ] [ text (toString model.calculatedTip)  ]
        ]


calculatedTotal : Model -> Html msg
calculatedTotal model =
    div []
        [ div []
            [ h2 [] [ text "Total" ]
            , p [] [ text "/ person" ]
            ]
        , div [ class "returned-amount" ] [ text (toString model.calculatedTotal) ]
        ]

result : Model -> Html Msg
result model =
    div [ class "app-result" ]
        [ div [ class "app-result-amount" ]
            [ calculatedTip model
            , calculatedTotal model
            ]
        , button [ class "btn-reset", type_ "reset" ] [ text "reset" ]
        ]
