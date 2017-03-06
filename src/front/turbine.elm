module Turbine exposing (Model, initModel, view, setLevel, setId)

import Messages exposing (Msg(..))
import Html exposing (Html, div, text, input, button)
import Html.Events exposing (onInput, onClick)
import Html.Attributes as H exposing (..)


type TurbineStatus
    = Warmup
    | Idle
    | Active
    | Off
    | ActiveCooling


type alias Model =
    { id : Int
    , outputEnabled : Bool
    , targetLevel : Int
    , steamWarn : Bool
    , status : TurbineStatus
    }


setLevel : String -> Model -> Model
setLevel v t =
    { t | targetLevel = String.toInt (Debug.log "" v) |> Result.withDefault 0 }


setId : Int -> Model -> Model
setId nId t =
    { t | id = nId }


initModel : Model
initModel =
    { id = 0
    , outputEnabled = False
    , targetLevel = 0
    , steamWarn = False
    , status = Off
    }


view : Model -> Html Msg
view t =
    div [] [ text "Apa" ]


rpmSlider : Model -> Html Msg
rpmSlider t =
    input
        [ type_ "range"
        , H.min "0"
        , H.max "2"
        , value <| toString t.targetLevel
        , onInput (Messages.SetLevel t.id)
        ]
        []
