
Tests for mysql dialect parsing

> module Language.SQL.SimpleSQL.MySQL (mySQLTests) where

> import Language.SQL.SimpleSQL.TestTypes
> import Language.SQL.SimpleSQL.Syntax

> mySQLTests :: TestItem
> mySQLTests = Group "mysql dialect"
>     [backtickQuotes
>     ,limit]

backtick quotes

limit syntax

[LIMIT {[offset,] row_count | row_count OFFSET offset}]

> backtickQuotes :: TestItem
> backtickQuotes = Group "backtickQuotes" (map (uncurry (TestValueExpr MySQL))
>     [("`test`", Iden [DQName "`" "`" "test"])
>     ]
>     ++ [ParseValueExprFails SQL2011 "`test`"]
>     )

> limit :: TestItem
> limit = Group "queries" ( map (uncurry (TestQueryExpr MySQL))
>     [("select * from t limit 5"
>      ,sel {qeFetchFirst = Just (NumLit "5")}
>      )
>     ]
>     ++ [ParseQueryExprFails MySQL "select a from t fetch next 10 rows only;"
>        ,ParseQueryExprFails SQL2011 "select * from t limit 5"]
>     )
>   where
>     sel = makeSelect
>           {qeSelectList = [(Star, Nothing)]
>           ,qeFrom = [TRSimple [Name "t"]]
>           }
