module Reactor exposing (Model, initModel)


type alias Model =
    { enabled : Bool
    , fuelLevel : Int
    , maxFuel : Int
    , workLevel : Int
    , waterWarning : Bool
    }


initModel : Model
initModel =
    { enabled = False
    , fuelLevel = 0
    , maxFuel = 0
    , workLevel = 0
    , waterWarning = False
    }
