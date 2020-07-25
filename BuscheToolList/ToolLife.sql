select 
distinct OpDescription 
from 
(
	select 
	ti.CribToolID,ti.ToolType,ti.ToolDescription,ti.Manufacturer,ti.consumable,ti.QuantityPerCuttingEdge,ti.NumberOfCuttingEdges,ti.Quantity,
	tm.ProcessID,tm.OriginalProcessID,tm.Customer,tm.PartFamily,tm.OperationDescription,
	pn.PartNumbers, -- Don't collect this use Plex Part info instead
	tt.ToolID,tt.ToolNumber,tt.ToolOrder,tt.OpDescription,tt.AdjustedVolume
	from [ToolList Master] tm
	left outer join [ToolList PartNumbers] pn 
	on tm.processId= pn.processid  -- 1 to 1 in theory
	left outer join [ToolList Tool] tt
	on tm.ProcessID=tt.ProcessID  -- 1 to many
	left outer join [ToolList Item] ti 
	on tt.ToolID= ti.ToolID
	where tm.ProcessID = 61442
	-- order by tm.ProcessID,tt.ToolNumber
)s1

/*
1.25" HELICAL MILL            
10MM END MILL                 
135MM BACK CUTTER RH ONLY     
14.3MM DRILL/CHAMFER          
15.5MM DRILL/CHAMFER          
180MM BACK CUTTER RH PART ONLY
21MM DRILL/SPOTFACE           
8.2MM DRILL                   
85.24MM ROUGH BORE            
86.125MM PRE FINISH BORE      
86.925MM FINISH BORE          
ETCHER                        
 */
-- where pn.PartNumbers like '%51393%'  -- RDX 51393
--where customer = 'FCA'
--where tm.processid = '54614'

--insert into [ToolList PartNumbers] (ProcessId,PartNumbers)
values (54614,'68480625AA')

select distinct revofprocessid from [ToolList Master]

/*  Shortest toollife
16405     |INSERT         |CCC-32503-010/PCD       |COMPETITIVE CARBIDE |         1|                  5000|                   1|       2|    61442|            49396|SAT     |51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET|MILL COMPLETE       |51393-TJB-A040-M1|383263|         4|        9|21MM DRILL/SPOTFACE           |        
16406     |DRILL TIP      |HH-32503-21-AL          |COMPETITIVE CARBIDE |         1|                  5000|                   1|       1|    61442|            49396|SAT     |51393-TJB-A040-M1 RH RDX COMPLIANCE BRACKET|MILL COMPLETE       |51393-TJB-A040-M1|383263|         4|        9|21MM DRILL/SPOTFACE           |        
*/