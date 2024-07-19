import           Control.Monad
import           Data.Colour
import           Data.Colour.Names
import           Data.Colour.SRGB
import           Data.List                (intercalate)
import           Data.Maybe
import           Data.Ratio
import           Sound.Tidal.Pattern

import qualified Graphics.Rendering.Cairo as C

cyclesperinch = 1

linewidth = 0.015
rowheight = 0.25
lh = linewidth/2
gap = linewidth
cellheight = rowheight-gap
cyclewidth = 0.4
  
dashedl = C.setDash [0.025, 0.05] 0.0375
dashedr = C.setDash [0.025, 0.05] 0

intersects a b = begin c < end c
  where c = intersect a b

layer :: [Event a] -> [[Event a]]
layer []     = []
layer (e:[]) = [[e]]
layer (e:es) = check $ layer es
  where fits e' es' = not $ or $ map (\e'' -> intersects (active e'') (active e')) es'
        check []       = [[e]]
        check (es':xs) | fits e es' = (e:es'):xs
                       | otherwise = es':(check xs)

main = do renderPattern 12 "fig1.svg" fig1
          renderPattern 12 "fig2.svg" fig2
          renderPattern 12 "fig3.svg" fig3
          renderPattern 12 "fig4.svg" fig4
          renderPattern 12 "fig5.svg" fig5
          renderPattern 12 "fig5b.svg" fig5b
          renderPattern 12 "fig6.svg" fig6
          renderPattern 12 "fig7.svg" fig7
          renderPattern 12 "fig8.svg" fig8
          renderPattern 12 "fig9.svg" fig9

renderPattern cycles name pat =
  do let events = query pat $ TimeSpan 0 (toRational cycles)
         eventses = map (map (drawEvent True)) $ layer $ reverse events
         layercount = length eventses
     C.withSVGSurface ("figures/" ++ name)  (72*cyclewidth*cycles) (72*((rowheight)*(fromIntegral layercount)+linewidth)) $ \surf ->
       C.renderWith surf $ do
         C.scale (cyclesperinch*72) (cyclesperinch*72)
         C.setOperator C.OperatorOver
         sequence $ intercalate [C.translate 0 rowheight] $ eventses

drawEvent _ (Event Nothing ts v) = drawEvent False $ Event (Just ts) ts v
drawEvent discrete (Event (Just (TimeSpan wb we)) (TimeSpan ab ae) v) =
  do let colour = v
         RGB r g b = toSRGB colour
         wb', we', ab', ae' :: Double
         wb' = fromRational wb * cyclewidth
         we' = fromRational we * cyclewidth
         ab' = fromRational ab * cyclewidth
         ae' = fromRational ae * cyclewidth
         lwb = wb' + lh
         lwe = we' - lh - gap
         lab = ab' + lh
         lae = ae' - lh - gap

     C.save

     -- draw rectangle
     let rectx = (ab')
         rectw = ae'-ab'-(lh)-gap
         gradientStart = fromRational $ 1 - 0.3*((ab-wb) / (we - wb))
         gradientStop = fromRational $ 1 - 0.3*((ae-wb) / (we - wb))
         RGB startr startg startb = toSRGB $ blend gradientStart colour white
         RGB stopr stopg stopb = toSRGB $ blend gradientStop colour white
         
     -- C.liftIO $ putStrLn $ show gradientStart ++ " -> " ++ show gradientStop
     C.withLinearPattern rectx 0 (rectx+rectw) 0 $ \pat -> do
       C.save
       C.patternAddColorStopRGBA pat 0 startr startg startb 1
       C.patternAddColorStopRGBA pat 1 stopr stopg stopb 1
       C.patternSetFilter pat C.FilterFast
       C.setSource pat
       C.rectangle rectx (0+lh) rectw (cellheight-linewidth)
       C.fill
       C.restore
         
     C.setLineWidth linewidth

     when discrete $ do 
         -- left edge
         if (wb' < ab') then do
           dashedl
           C.setSourceRGBA startr startg startb 1
           C.setLineCap C.LineCapSquare
           C.moveTo (lab-lh) lh
           C.lineTo (lab-lh) cellheight
           C.stroke
         else do
           C.setDash [] 0
           C.setSourceRGB 0 0 0
           C.setLineCap C.LineCapRound
           C.moveTo lab lh
           C.lineTo lab cellheight
           C.stroke
    
         -- right edge
         if (we' > ae') then do
           dashedr
           C.setSourceRGBA stopr stopg stopb 1
           C.setLineCap C.LineCapSquare
           C.moveTo lae lh
           C.lineTo lae cellheight
           C.stroke
         else do
           C.setDash [] 0
           C.setSourceRGB 0 0 0
           C.setLineCap C.LineCapRound
           C.moveTo lae lh
           C.lineTo lae cellheight
           C.stroke

     C.setLineCap C.LineCapRound
     C.setDash [] 0
     C.setSourceRGB 0 0 0

     -- top edge
     C.moveTo lab lh
     C.lineTo lae lh
     C.stroke

     -- bottom edge
     C.moveTo lab cellheight
     C.lineTo lae cellheight
     C.stroke


     C.restore

-- drawEventWithWhole (Event (Just (TimeSpan wb we)) (TimeSpan ab ae) v) =
--   do let colour = fromMaybe grey $ readColourName v
--          RGB r g b = toSRGB colour
--          RGB rl gl bl = toSRGB $ blend 0.3 colour white
--          wb', we', ab', ae' :: Double
--          wb' = fromRational wb
--          we' = fromRational we
--          ab' = fromRational ab
--          ae' = fromRational ae
--          lwb = wb' + lh
--          lwe = we' - lh
--          lab = ab' + lh
--          lae = ae' - lh

--      C.save
--      when (wb' < ab' || we' > ab') $ do
--        C.setSourceRGB rl gl bl
--        C.rectangle lwb 0 (we'-lwb) cellheight
--        C.fill
--      C.setSourceRGB r g b
--      C.rectangle ab' 0 (ae'-ab') cellheight
--      C.fill

--      -- top line
--      C.setSourceRGB 0 0 0
--      C.setLineWidth linewidth
--      C.setLineCap C.LineCapRound
--      C.moveTo (lab+lh) lh
--      C.lineTo (lae+lh) lh
--      C.stroke

--      -- bottom line
--      C.moveTo lab cellheight
--      C.lineTo lae cellheight
--      C.stroke

--      C.setDash [] 0
--      when (wb' < ab') dashed
--      C.moveTo lwb lh
--      C.lineTo lwb cellheight
--      C.stroke

--      C.setDash [] 0
--      when (we' > ae') dashed
--      C.moveTo lwe lh
--      C.lineTo lwe cellheight
--      C.stroke

--      when (wb' < ab') $ do
--        dashed
--        C.moveTo lwb lh
--        C.lineTo lab lh
--        C.stroke
--        C.moveTo lwb cellheight
--        C.lineTo lab cellheight
--        C.stroke

--      when (we' > ae') $ do
--        dashed
--        C.moveTo lae lh
--        C.lineTo lwe lh
--        C.stroke
--        C.moveTo lae cellheight
--        C.lineTo lwe cellheight
--        C.stroke
--      C.restore
