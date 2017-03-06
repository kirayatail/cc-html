module ReactorCtrl exposing (main)

import Reactor
import Turbine
import Html exposing (Html, h1, div, text, button)
import Html.Events exposing (onClick)


type alias Model =
    { reactor : Reactor.Model
    , turbines : List Turbine.Model
    }


model : Model
model =
    { reactor = Reactor.initModel
    , turbines = [ Turbine.initModel, (Turbine.setId 1 Turbine.initModel) ]
    }


type Msg
    = TurbineMsg Int Turbine.Msg
    | ReactorMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TurbineMsg ident subMsg ->
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


changeAt : (a -> a) -> Int -> List a -> Result String (List a)
changeAt f i l =
    if i < 0 then
        Err "Negative Index"
    else
        case l of
            [] ->
                Err "Index out of bounds"

            x :: xs ->
                if i == 0 then
                    Ok <| f x :: xs
                else
                    Result.map ((::) x) <| changeAt f (i - 1) xs


incrementAt : Int -> List number -> List number
incrementAt id l =
    case changeAt ((+) 1) id l of
        Ok newList ->
            newList

        Err _ ->
            l


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello World!" ]
        ]
        ++ List.map Turbine.view model.turbines


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = ( model, Cmd.none )
        }
