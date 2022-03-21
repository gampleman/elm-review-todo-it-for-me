module CodeGen.Builtin.ToString exposing (generic)

import CodeGenerator exposing (CodeGenerator)
import Elm.CodeGen as CG
import ResolvedType
import TypePattern exposing (TypePattern(..))


generic : CodeGenerator
generic =
    CodeGenerator.define "elm/core/ToString"
        "elm/core"
        (Function Target (Typed [ "String" ] "String" []))
        (\name -> "all" ++ name)
        [ CodeGenerator.custom
            (\t ->
                case t of
                    ResolvedType.CustomType _ _ ctors ->
                        if List.all (\( _, args ) -> List.isEmpty args) ctors then
                            Just (CG.list (List.map (\( ctor, _ ) -> CG.fqVal ctor.modulePath ctor.name) ctors))

                        else
                            Nothing

                    _ ->
                        Nothing
            )
        ]