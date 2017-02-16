﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//

Enum Set
	MEMBER EXACT       := 1	
	MEMBER FIXED       := 2	
	MEMBER DECIMALS    := 3	
	MEMBER DATEFORMAT  := 4	
	MEMBER EPOCH       := 5	
	MEMBER PATH        := 6	
	MEMBER DEFAULT     := 7	
	MEMBER EXCLUSIVE   := 8	
	MEMBER SOFTSEEK    := 9	
	MEMBER UNIQUE      := 10	
	MEMBER DELETED     := 11	
	MEMBER CANCEL      := 12	
	MEMBER @@DEBUG     := 13	
	MEMBER TYPEAHEAD   := 14	
	MEMBER COLOR       := 15	
	MEMBER CURSOR      := 16	
	MEMBER CONSOLE     := 17	
	MEMBER ALTERNATE   := 18	
	MEMBER ALTFILE     := 19	
	MEMBER DEVICE      := 20	
	MEMBER EXTRA       := 21	
	MEMBER EXTRAFILE   := 22	
	MEMBER PRINTER     := 23	
	MEMBER PRINTFILE   := 24	
	MEMBER MARGIN      := 25	
	MEMBER BELL        := 26	
	MEMBER CONFIRM     := 27	
	MEMBER ESCAPE      := 28	
	MEMBER INSERT      := 29	
	MEMBER @@EXIT      := 30	
	MEMBER INTENSITY   := 31	
	MEMBER SCOREBOARD  := 32	
	MEMBER DELIMITERS  := 33	
	MEMBER DELIMCHARS  := 34	
	MEMBER WRAP        := 35	
	MEMBER MESSAGE     := 36	
	MEMBER MCENTER     := 37	
	MEMBER SCROLLBREAK := 38	

	MEMBER EVENTMASK   := 39  /* CA-Cl*pper 5.3 compatible */
	MEMBER VIDEOMODE   := 40  /* CA-Cl*pper 5.3 compatible */
	MEMBER MBLOCKSIZE  := 41  /* CA-Cl*pper 5.3 compatible */
	MEMBER MFILEEXT    := 42  /* CA-Cl*pper 5.3 compatible */
	MEMBER STRICTREAD  := 43  /* CA-Cl*pper 5.3 compatible */
	MEMBER OPTIMIZE    := 44  /* CA-Cl*pper 5.3 compatible */
	MEMBER AUTOPEN     := 45  /* CA-Cl*pper 5.3 compatible */
	MEMBER AUTORDER    := 46  /* CA-Cl*pper 5.3 compatible */
	MEMBER AUTOSHARE   := 47  /* CA-Cl*pper 5.3 compatible */ 		

	MEMBER DIGITS      := 50	// Vulcan had 39
	MEMBER NETERR      := 51	// Vulcan had 40
	MEMBER HPLOCK      := 52    // Vulcan had 41
	MEMBER ANSI        := 53	// Vulcan had 44
	MEMBER YIELD       := 54	// Vulcan had 45
	MEMBER LOCKTRIES   := 55	// Vulcan had 46
	MEMBER AmExt	   := 56
	MEMBER AmPm		   := 57
	MEMBER PmExt	   := 58

	MEMBER DICT        := 98	
	MEMBER INTL        := 99	

	MEMBER LANGUAGE       :=  100 /* Harbour extension */
	MEMBER IDLEREPEAT     :=  101 /* Harbour extension */
	MEMBER FILECASE       :=  102 /* Harbour extension */
	MEMBER DIRCASE        :=  103 /* Harbour extension */
	MEMBER DIRSEPARATOR   :=  104 /* Harbour extension */
	MEMBER EOF            :=  105 /* Harbour extension */
	MEMBER HARDCOMMIT     :=  106 /* Harbour extension */
	MEMBER FORCEOPT       :=  107 /* Harbour extension */
	MEMBER DBFLOCKSCHEME  :=  108 /* Harbour extension */
	MEMBER DEFEXTENSIONS  :=  109 /* Harbour extension */
	MEMBER EOL            :=  110 /* Harbour extension */
	MEMBER TRIMFILENAME   :=  111 /* Harbour extension */
	MEMBER HBOUTLOG       :=  112 /* Harbour extension */
	MEMBER HBOUTLOGINFO   :=  113 /* Harbour extension */
	MEMBER CODEPAGE       :=  114 /* Harbour extension */
	MEMBER OSCODEPAGE     :=  115 /* Harbour extension */
	MEMBER TIMEFORMAT     :=  116 /* Harbour extension */
	MEMBER DBCODEPAGE     :=  117 /* Harbour extension */ 

END Enum


DEFINE _SET_EXACT       := Set.Exact	AS LONG
DEFINE _SET_FIXED       := Set.Fixed 	AS LONG
DEFINE _SET_DECIMALS    := Set.Decimals	AS LONG
DEFINE _SET_DATEFORMAT  := Set.DATEFORMAT  	AS LONG
DEFINE _SET_EPOCH       := Set.EPOCH       	AS LONG
DEFINE _SET_PATH        := Set.PATH        	AS LONG
DEFINE _SET_DEFAULT     := Set.DEFAULT     	AS LONG

DEFINE _SET_EXCLUSIVE   := Set.EXCLUSIVE   	AS LONG
DEFINE _SET_SOFTSEEK    := Set.SOFTSEEK    	AS LONG
DEFINE _SET_UNIQUE      := Set.UNIQUE      	AS LONG
DEFINE _SET_DELETED     := Set.DELETED     	AS LONG

DEFINE _SET_CANCEL      := Set.CANCEL      	AS LONG
DEFINE _SET_DEBUG       := Set.DEBUG       	AS LONG
DEFINE _SET_TYPEAHEAD   := Set.TYPEAHEAD   	AS LONG

DEFINE _SET_COLOR       := Set.COLOR       	AS LONG
DEFINE _SET_CURSOR      := Set.CURSOR      	AS LONG
DEFINE _SET_CONSOLE     := Set.CONSOLE     	AS LONG
DEFINE _SET_ALTERNATE   := Set.ALTERNATE   	AS LONG
DEFINE _SET_ALTFILE     := Set.ALTFILE     	AS LONG
DEFINE _SET_DEVICE      := Set.DEVICE      	AS LONG
DEFINE _SET_EXTRA       := Set.EXTRA       	AS LONG
DEFINE _SET_EXTRAFILE   := Set.EXTRAFILE   	AS LONG
DEFINE _SET_PRINTER     := Set.PRINTER     	AS LONG
DEFINE _SET_PRINTFILE   := Set.PRINTFILE   	AS LONG
DEFINE _SET_MARGIN      := Set.MARGIN      	AS LONG

DEFINE _SET_BELL        := Set.BELL        	AS LONG
DEFINE _SET_CONFIRM     := Set.CONFIRM     	AS LONG
DEFINE _SET_ESCAPE      := Set.ESCAPE      	AS LONG
DEFINE _SET_INSERT      := Set.INSERT      	AS LONG
DEFINE _SET_EXIT        := Set.EXIT        	AS LONG
DEFINE _SET_INTENSITY   := Set.INTENSITY   	AS LONG
DEFINE _SET_SCOREBOARD  := Set.SCOREBOARD  	AS LONG
DEFINE _SET_DELIMITERS  := Set.DELIMITERS  	AS LONG
DEFINE _SET_DELIMCHARS  := Set.DELIMCHARS  	AS LONG

DEFINE _SET_WRAP        := Set.WRAP        	AS LONG
DEFINE _SET_MESSAGE     := Set.MESSAGE     	AS LONG
DEFINE _SET_MCENTER     := Set.MCENTER     	AS LONG
DEFINE _SET_SCROLLBREAK := Set.SCROLLBREAK 	AS LONG

DEFINE _SET_EVENTMASK   := Set.EVENTMASK   	AS LONG
DEFINE _SET_VIDEOMODE   := Set.VIDEOMODE   	AS LONG
DEFINE _SET_MBLOCKSIZE  := Set.MBLOCKSIZE  	AS LONG
DEFINE _SET_MFILEEXT    := Set.MFILEEXT    	AS LONG
DEFINE _SET_STRICTREAD  := Set.STRICTREAD  	AS LONG
DEFINE _SET_OPTIMIZE    := Set.OPTIMIZE    	AS LONG
DEFINE _SET_AUTOPEN     := Set.AUTOPEN     	AS LONG
DEFINE _SET_AUTORDER    := Set.AUTORDER    	AS LONG
DEFINE _SET_AUTOSHARE   := Set.AUTOSHARE   	AS LONG
						   					
DEFINE _SET_DIGITS      := Set.DIGITS      	AS LONG
DEFINE _SET_NETERR      := Set.NETERR      	AS LONG
DEFINE _SET_HPLOCK      := Set.HPLOCK      	AS LONG
DEFINE _SET_ANSI        := Set.ANSI        	AS LONG
DEFINE _SET_YIELD       := Set.YIELD       	AS LONG
DEFINE _SET_LOCKTRIES   := Set.LOCKTRIES   	AS LONG
DEFINE _SET_AMEXT		:= Set.AmExt		AS LONG
DEFINE _SET_AMPM		:= Set.AmPm			AS LONG
DEFINE _SET_PMEXT		:= Set.PmExt		AS LONG
											
DEFINE _SET_DICT        := Set.Dict			AS LONG
DEFINE _SET_INTL        := Set.Intl			AS LONG

DEFINE _SET_LANGUAGE       :=  Set.LANGUAGE      	AS LONG
DEFINE _SET_IDLEREPEAT     :=  Set.IDLEREPEAT    	AS LONG
DEFINE _SET_FILECASE       :=  Set.FILECASE      	AS LONG
DEFINE _SET_DIRCASE        :=  Set.DIRCASE       	AS LONG
DEFINE _SET_DIRSEPARATOR   :=  Set.DIRSEPARATOR  	AS LONG
DEFINE _SET_EOF            :=  Set.EOF           	AS LONG
DEFINE _SET_HARDCOMMIT     :=  Set.HARDCOMMIT    	AS LONG
DEFINE _SET_FORCEOPT       :=  Set.FORCEOPT      	AS LONG
DEFINE _SET_DBFLOCKSCHEME  :=  Set.DBFLOCKSCHEME 	AS LONG
DEFINE _SET_DEFEXTENSIONS  :=  Set.DEFEXTENSIONS 	AS LONG
DEFINE _SET_EOL            :=  Set.EOL           	AS LONG
DEFINE _SET_TRIMFILENAME   :=  Set.TRIMFILENAME  	AS LONG
DEFINE _SET_HBOUTLOG       :=  Set.HBOUTLOG      	AS LONG
DEFINE _SET_HBOUTLOGINFO   :=  Set.HBOUTLOGINFO  	AS LONG
DEFINE _SET_CODEPAGE       :=  Set.CODEPAGE      	AS LONG
DEFINE _SET_OSCODEPAGE     :=  Set.OSCODEPAGE    	AS LONG
DEFINE _SET_TIMEFORMAT     :=  Set.TIMEFORMAT    	AS LONG
DEFINE _SET_DBCODEPAGE     :=  Set.DBCODEPAGE    	AS LONG