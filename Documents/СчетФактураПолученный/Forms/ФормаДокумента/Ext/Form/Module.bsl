﻿
&НаСервере
Процедура PAPI_НеВыгружатьБКПриИзмененииПослеНаСервере()
	
	Объект.PAPI_НеВыгружатьБК = НеВыгружатьБК;
	
КонецПроцедуры

&НаКлиенте
Процедура PAPI_НеВыгружатьБКПриИзмененииПосле(Элемент)
	
	PAPI_НеВыгружатьБКПриИзмененииПослеНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура PAPI_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	НеВыгружатьБК = Объект.PAPI_НеВыгружатьБК;
	
КонецПроцедуры
