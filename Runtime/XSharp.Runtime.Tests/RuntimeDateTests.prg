﻿USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text
using Microsoft.VisualStudio.TestTools.UnitTesting
using static Microsoft.VisualStudio.TestTools.UnitTesting.Assert
using XSharp.Runtime


BEGIN NAMESPACE XSharp.Runtime.Tests

	[TestClass];
	CLASS RuntimeDateTests

		[TestMethod];
		METHOD CTODTest() as void
			var u := ctod("03/13/2016")
			AreEqual(__VODate{"20160101"} ,ctod("01/01/2016"))
			AreEqual(__VODate{"20160213"} ,ctod("13/02/2016"))
			AreEqual(__VODate{"00010101"} ,ctod("03/13/2016"))	
		RETURN

		[TestMethod];
		METHOD ElapTimeTest() as void
			AreEqual("11:23:34",elaptime("12:00:00","23:23:34"))
			AreEqual("-11:23:34",elaptime("23:23:34","12:00:00"))	
			AreEqual("",elaptime("29:23:34","12:00:00"))
		RETURN

		[TestMethod];
		METHOD STODTest() as void
			AreEqual(__VODate{"20160506"},STOD("20160506"))
		RETURN

		[TestMethod];
		METHOD CDOWTest() as void
			AreEqual("Dienstag",CDOW(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD CMonthTest() as void
			AreEqual("Mai",CMonth(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD DayTest() as void
			AreEqual((dword)24,Day(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD DOWTest() as void
			AreEqual((dword)2,DOW(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD DTOCTest() as void
			AreEqual("24.05.2016",DTOC(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD DTOSTest() as void
			AreEqual("20160524",DTOS(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD MonthTest() as void
			AreEqual((dword)5,MONTH(CTOD("24/05/2016")))
		RETURN

		[TestMethod];
		METHOD YearTest() as void
			AreEqual((dword)2016,YEAR(CTOD("24/05/2016")))
		RETURN
	END CLASS
END NAMESPACE // XSharp.Runtime.Tests