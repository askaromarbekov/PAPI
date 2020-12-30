﻿
Функция ПолучитьСтруктураОтвет()
	
	СтруктураОтвет = Новый Структура;
	СтруктураОтвет.Вставить("ДанныеОтвета", "");
	СтруктураОтвет.Вставить("Отработало", Истина);
	СтруктураОтвет.Вставить("ТекстОшибки", "");
	СтруктураОтвет.Вставить("КодОтвета", 200);
	
	Возврат СтруктураОтвет;
	
КонецФункции	

Процедура ЗаполнитьСтруктуруОтвета(СтруктураОтвет, КодОтвета, ТекстОшибки, Отработало, ДанныеОтвета)
	
	СтруктураОтвет.КодОтвета 	= КодОтвета;
	СтруктураОтвет.ТекстОшибки	= ТекстОшибки;
	СтруктураОтвет.Отработало	= Отработало;
	СтруктураОтвет.ДанныеОтвета = ДанныеОтвета;	
	
КонецПроцедуры

Функция УпаковатьСообщение(Текст)
	
	Структура = Новый Структура;
	Структура.Вставить("Сообщение", Текст);
	
	Возврат ВернутьСтруктуруИлиМассивКакСтрокуJSON(Структура);
	
КонецФункции

Функция ЗаполнитьЗначениеРеквизита(знач значРеквизит, какСтрока = Ложь)
	
	Если какСтрока Тогда Возврат Строка(значРеквизит); КонецЕсли;
	
	Попытка
		значОбъект = значРеквизит.ПолучитьОбъект();
		СтруктураОбъекта = ПолучитьЗаголовокСтруктурыОбъекта(значОбъект);
	Исключение
		Возврат Строка(значРеквизит);
	КонецПопытки;
		
	Если ЭтоЗначениеКакСтруктура(значРеквизит) Тогда 
		
		Если ТипЗнч(значРеквизит) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда 
			Возврат ОбъектКакСтруктура(значОбъект, СтруктураОбъекта); 
		ИначеЕсли  ТипЗнч(значРеквизит) = Тип("ДокументСсылка.АктВыполненныхРабот") Тогда 
			Возврат ОбъектКакСтруктура(значОбъект, СтруктураОбъекта); 
		ИначеЕсли  ТипЗнч(значРеквизит) = Тип("ДокументСсылка.РасходнаяНакладная") Тогда 
			Возврат ОбъектКакСтруктура(значОбъект, СтруктураОбъекта); 
		ИначеЕсли  ТипЗнч(значРеквизит) = Тип("ДокументСсылка.ПриходнаяНакладная") Тогда 
			Возврат ОбъектКакСтруктура(значОбъект, СтруктураОбъекта); 
		Иначе 
			Возврат ОбъектКакСтруктура(значОбъект, СтруктураОбъекта, Истина); 
		КонецЕсли;
		
	Иначе 
		
		Если ТипЗнч(значРеквизит) = Тип("СправочникСсылка.Организации") или ТипЗнч(значРеквизит) = Тип("СправочникОбъект.Организации") Тогда 
			СтруктураОбъекта.Вставить("ИдентификационныйНомер", значРеквизит.ИдентификационныйНомер);
			Возврат СтруктураОбъекта; 
		ИначеЕсли ТипЗнч(значРеквизит) = Тип("СправочникСсылка.ФизическиеЛица") или ТипЗнч(значРеквизит) = Тип("СправочникОбъект.ФизическиеЛица") Тогда 
			СтруктураОбъекта.Вставить("ИдентификационныйНомер", значРеквизит.ИдентификационныйНомер);
			Возврат СтруктураОбъекта; 
		ИначеЕсли ТипЗнч(значРеквизит) = Тип("СправочникСсылка.Сотрудники") или ТипЗнч(значРеквизит) = Тип("СправочникОбъект.Сотрудники") Тогда 
			СтруктураОбъекта.Вставить("ТабельныйНомер", значРеквизит.Код);
			СтруктураОбъекта.Вставить("Физлицо", значОбъект.Физлицо.ИдентификационныйНомер); 
			Возврат СтруктураОбъекта; 
		ИначеЕсли ТипЗнч(значРеквизит) = Тип("СправочникСсылка.БанковскиеСчета") или ТипЗнч(значРеквизит) = Тип("СправочникОбъект.БанковскиеСчета") Тогда 
			СтруктураОбъекта.Вставить("НомерСчета", значРеквизит.НомерСчета);
			СтруктураОбъекта.Вставить("БИК", значОбъект.Банк.БИК); 
			Возврат СтруктураОбъекта; 
	    КонецЕсли;
		
	КонецЕсли;
	
	Возврат Строка(значРеквизит);
	
КонецФункции

Функция ЗначениеРеквизитаНеЗаполнено(значРеквизит)
	
	Если ПримитивныйТип(значРеквизит) Тогда 
		
		Если ТипЗнч(значРеквизит) = Тип("Булево") Тогда 
			Если Не значРеквизит Тогда 
				Возврат Истина;
			КонецЕсли;	
		КонецЕсли;
		Если ТипЗнч(значРеквизит) = Тип("Число") Тогда 
			Если значРеквизит = 0 Тогда 
				Возврат Истина;
			КонецЕсли;	
		КонецЕсли;	
		Если ТипЗнч(значРеквизит) = Тип("Строка") Тогда 
			Если ПустаяСтрока(СокрЛП(значРеквизит)) Тогда 
				Возврат Истина;
			КонецЕсли;	
		КонецЕсли;	
		Если ТипЗнч(значРеквизит) = Тип("Дата") Тогда 
			Если значРеквизит = Дата(1, 1, 1, 0, 0, 0) Тогда 
				Возврат Истина;
			КонецЕсли;
		КонецЕсли;	
		
	КонецЕсли;
	
	Если ТипЗнч(значРеквизит) = Тип("ХранилищеЗначения") Тогда 
		Возврат Истина;
	КонецЕсли;	
	
	Возврат Не ЗначениеЗаполнено(значРеквизит);
	
КонецФункции	

Функция ЭтоЗначениеКакСтруктура(вхЗначение)
	
	Соответствие = Новый Соответствие;
	Соответствие.Вставить(Тип("СправочникСсылка.Контрагенты"), 			Истина);
	Соответствие.Вставить(Тип("СправочникСсылка.Номенклатура"), 		Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.Организации"), 			Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.Сотрудники"), 			Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.ФизическиеЛица"), 		Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.Пользователи"), 		Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.БанковскиеСчета"), 		Истина);
	//Соответствие.Вставить(Тип("СправочникСсылка.Кассы"), 				Истина);
	Соответствие.Вставить(Тип("ДокументСсылка.ЗаказПокупателя"), 		Истина);
	Соответствие.Вставить(Тип("ДокументСсылка.АктВыполненныхРабот"), 	Истина);
	Соответствие.Вставить(Тип("ДокументСсылка.РасходнаяНакладная"), 	Истина);
	Соответствие.Вставить(Тип("ДокументСсылка.ПриходнаяНакладная"), 	Истина);
	
	Результат = Соответствие.Получить(ТипЗнч(вхЗначение));
	
	Если Результат = Неопределено Тогда 
		Возврат Ложь;
	Иначе 
		Возврат Результат;
	КонецЕсли;	
	
КонецФункции	

Функция ВходитВСписокВидовДокумента(вхВидДокумента)
	
	Соответствие = Новый Соответствие;
	Соответствие.Вставить("ПриходнаяНакладная", Истина);
	Соответствие.Вставить("СчетФактура", 		Истина);
	Соответствие.Вставить("СчетФактураПолученный", Истина);
	Соответствие.Вставить("ЗаказПокупателя", 	Истина);
	Соответствие.Вставить("РасходнаяНакладная", Истина);
	Соответствие.Вставить("АктВыполненныхРабот", Истина);
	Соответствие.Вставить("ПоступлениеВКассу", 	Истина);
	Соответствие.Вставить("РасходИзКассы", 		Истина);
	Соответствие.Вставить("ПоступлениеНаСчет", 	Истина);
	Соответствие.Вставить("РасходСоСчета", 		Истина);
		
	Результат = Соответствие.Получить(вхВидДокумента);
	Если Результат = Неопределено Тогда 
		Возврат Ложь;
	Иначе 
		Возврат Результат;
	КонецЕсли;
	
КонецФункции	

Функция ВходитВСписокМетодов(ИмяМетода)
	
	Соответствие = Новый Соответствие;
	Соответствие.Вставить("docs_list", Истина);
	Соответствие.Вставить("doc_body", Истина);
	Соответствие.Вставить("person_body", Истина);
	
	Результат = Соответствие.Получить(ИмяМетода);
	Если Результат = Неопределено Тогда 
		Возврат Ложь;
	Иначе 
		Возврат Результат;
	КонецЕсли;
	
КонецФункции	

Функция ЗапросСписокДокументов(ВидДокумента, Дата)
	
	МассивСсылокДокументов = Новый Массив;
	
	Выборка = Документы[ВидДокумента].Выбрать(НачалоДня(Дата), КонецДня(Дата));
	Пока Выборка.Следующий() Цикл 
		Если Не Выборка.Проведен Тогда Продолжить; КонецЕсли;
		СтруктураСсылкиДокумента = ПолучитьЗаголовокСтруктурыОбъекта(Выборка.Ссылка.ПолучитьОбъект());
		
		Попытка
			СтруктураСсылкиДокумента.Вставить("СуммаДокумента", Выборка.СуммаДокумента); Исключение КонецПопытки;
		Попытка
			СтруктураСсылкиДокумента.Вставить("Организация", Строка(Выборка.Организация)); Исключение КонецПопытки;
		Попытка
			СтруктураСсылкиДокумента.Вставить("ВидОперации", Строка(Выборка.ВидОперации)); Исключение КонецПопытки;
		Попытка
			Если ЗначениеЗаполнено(Выборка.Контрагент) Тогда СтруктураСсылкиДокумента.Вставить("Контрагент", Строка(Выборка.Контрагент)); КонецЕсли;	Исключение КонецПопытки;			
		Попытка
			Если ЗначениеЗаполнено(Выборка.Подотчетник) Тогда СтруктураСсылкиДокумента.Вставить("Подотчетник", Строка(Выборка.Подотчетник)); КонецЕсли;	Исключение КонецПопытки;			
		Попытка
			Если ЗначениеЗаполнено(Выборка.Касса) Тогда СтруктураСсылкиДокумента.Вставить("Касса", Строка(Выборка.Касса)); КонецЕсли;	Исключение КонецПопытки;			
		Попытка
			Если ЗначениеЗаполнено(Выборка.БанковскийСчет) Тогда СтруктураСсылкиДокумента.Вставить("БанковскийСчет", Строка(Выборка.БанковскийСчет)); КонецЕсли;	Исключение КонецПопытки;			
			
			
		МассивСсылокДокументов.Добавить(СтруктураСсылкиДокумента);
	КонецЦикла;
	
	Если МассивСсылокДокументов.Количество() = 0 Тогда 
		Возврат Неопределено;
	Иначе 
		Возврат МассивСсылокДокументов;
	КонецЕсли;	
	
КонецФункции	

Функция ПолучитьЗаголовокСтруктурыОбъекта(вхОбъект)
	
	СтруктураОбъекта = Новый Структура;
	СтруктураОбъекта.Вставить("Идентификатор", Строка(вхОбъект.Ссылка.УникальныйИдентификатор()));
	СтруктураОбъекта.Вставить("Мета", Строка(вхОбъект.Ссылка.Метаданные().Имя));
	СтруктураОбъекта.Вставить("МетаПредставление", Строка(вхОбъект.Ссылка.Метаданные().ПолноеИмя()));
	СтруктураОбъекта.Вставить("Представление", Строка(вхОбъект.Ссылка));
	
	Если Не СтрНайти(СтруктураОбъекта.МетаПредставление, "Документ.", , 1) = 0 Тогда 
		СтруктураОбъекта.Вставить("Номер", вхОбъект.Номер);
		СтруктураОбъекта.Вставить("Дата", вхОбъект.Дата);
	КонецЕсли;	
	Если Не СтрНайти(СтруктураОбъекта.МетаПредставление, "Справочник.", , 1) = 0 Тогда 
		СтруктураОбъекта.Вставить("Код", вхОбъект.Код);
		СтруктураОбъекта.Вставить("Наименование", вхОбъект.Наименование);		
	КонецЕсли;	
		
	Возврат СтруктураОбъекта;
	
КонецФункции	

Процедура ЗаполнитьРегистрыСведений(Объект, СтруктураОбъекта, ИмяРегистра, Набор)
	
	зпрРегистр = Новый Запрос;	
	зпрРегистр.Текст = "ВЫБРАТЬ * ИЗ РегистрСведений." + ИмяРегистра + ".СрезПоследних КАК Регистр ГДЕ Регистр.Физлицо = &Параметр1";	
	зпрРегистр.УстановитьПараметр("Параметр1", Объект.Ссылка);
	времТаблица = зпрРегистр.Выполнить().Выгрузить();
	Если Не времТаблица.Количество() = 0 Тогда 
		СтруктураОбъекта.Вставить("РС_" + ИмяРегистра, ТаблицаЗначенийКакСтруктура(времТаблица, Набор));
	КонецЕсли;
	
	времТаблица = Неопределено;
	
КонецПроцедуры

#Область Универсальные_Процедуры_И_Функции

Функция ПримитивныйТип(значРеквизит)
	
	Если ТипЗнч(значРеквизит) = Тип("Булево") 	Тогда Возврат Истина; КонецЕсли;
	Если ТипЗнч(значРеквизит) = Тип("Строка") 	Тогда Возврат Истина; КонецЕсли;
	Если ТипЗнч(значРеквизит) = Тип("Число") 	Тогда Возврат Истина; КонецЕсли;
	Если ТипЗнч(значРеквизит) = Тип("Дата") 	Тогда Возврат Истина; КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции	

Функция ТаблицаЗначенийКакСтруктура(вхТаблица, Набор)
	
	массивСтрок = Новый Массив;
	Для Каждого стрТаблица из вхТаблица Цикл 
		структураКолонок = Новый Структура;
		Для Каждого Колонка из вхТаблица.Колонки Цикл 
			ЗначениеРеквизита = стрТаблица[Колонка.Имя];
			Если ЗначениеРеквизитаНеЗаполнено(ЗначениеРеквизита) Тогда Продолжить; КонецЕсли;	
			структураКолонок.Вставить(Колонка.Имя, ?(ПримитивныйТип(ЗначениеРеквизита), ЗначениеРеквизита, ЗаполнитьЗначениеРеквизита(ЗначениеРеквизита, Набор)));
		КонецЦикла;	
		массивСтрок.Добавить(структураКолонок);
	КонецЦикла;	
	
	Возврат массивСтрок;
	
КонецФункции	

Функция ОбъектКакСтруктура(вхОбъект, СтруктураОбъекта = Неопределено, КакСтрока = Ложь)
	
	Если СтруктураОбъекта = Неопределено Тогда 
		СтруктураОбъекта = Новый Структура;
	КонецЕсли;	
	
	Для Каждого Реквизит из вхОбъект.Метаданные().Реквизиты Цикл 
		ЗначениеРеквизита = вхОбъект[Реквизит.Имя];
		Если ЗначениеРеквизитаНеЗаполнено(ЗначениеРеквизита) Тогда Продолжить; КонецЕсли;
		
		Попытка
			СтруктураОбъекта.Вставить(Реквизит.Имя, ?(ПримитивныйТип(ЗначениеРеквизита), ЗначениеРеквизита, ЗаполнитьЗначениеРеквизита(ЗначениеРеквизита, КакСтрока)));
		Исключение
			Возврат Неопределено;
		КонецПопытки;		
	КонецЦикла;	
	
	Для Каждого ТабЧасть из вхОбъект.Метаданные().ТабличныеЧасти Цикл 
		Если вхОбъект[ТабЧасть.Имя].Количество() = 0 Тогда Продолжить; КонецЕсли;
		Если ТабЧасть.Имя = "КонтактнаяИнформация" Тогда Продолжить; КонецЕсли;
		Если ТабЧасть.Имя = "ДополнительныеРеквизиты" Тогда Продолжить; КонецЕсли;
		МассивСтрокТабЧасть = Новый Массив;
		Для Каждого стрТабЧасть из вхОбъект[ТабЧасть.Имя] Цикл 
			СтруктураОбъектаТабЧасть = Новый Структура;
			Для Каждого РеквизитТабЧасть Из вхОбъект.Метаданные().ТабличныеЧасти[ТабЧасть.Имя].Реквизиты Цикл 
				ЗначениеРеквизита = стрТабЧасть[РеквизитТабЧасть.Имя];
				Если ЗначениеРеквизитаНеЗаполнено(ЗначениеРеквизита) Тогда Продолжить; КонецЕсли;
				Попытка
					СтруктураОбъектаТабЧасть.Вставить(РеквизитТабЧасть.Имя, ?(ПримитивныйТип(ЗначениеРеквизита), ЗначениеРеквизита, ЗаполнитьЗначениеРеквизита(ЗначениеРеквизита, КакСтрока)));
				Исключение
					Возврат Неопределено;
				КонецПопытки;	
			КонецЦикла;	
			МассивСтрокТабЧасть.Добавить(СтруктураОбъектаТабЧасть);
		КонецЦикла;	
		СтруктураОбъекта.Вставить("ТЧ_" + ТабЧасть.Имя, МассивСтрокТабЧасть);
	КонецЦикла;	
	
	Если ТипЗнч(вхОбъект) = Тип("СправочникСсылка.ФизическиеЛица") или ТипЗнч(вхОбъект) = Тип("СправочникОбъект.ФизическиеЛица") Тогда 
		ЗаполнитьРегистрыСведений(вхОбъект, СтруктураОбъекта, "ДокументыФизическихЛиц", КакСтрока);
		ЗаполнитьРегистрыСведений(вхОбъект, СтруктураОбъекта, "ФИОФизЛиц", КакСтрока);
	КонецЕсли;	
	
	Возврат СтруктураОбъекта;
	
КонецФункции

Функция ИИНБИНСоответствуетТребованиям(Знач ИдентификационныйНомер, ТекстСообщения)
	
	СоответствуетТребованиям = Истина;
	ТекстСообщения = НСтр("ru = 'Введенный ИИН / БИН корректен.'");
	
	ИдентификационныйНомер = СокрЛП(ИдентификационныйНомер);
	
	Если СтрДлина(ИдентификационныйНомер) <> 12 Тогда
		
		СоответствуетТребованиям = Ложь;
		ТекстСообщения = НСтр("ru = 'ИИН / БИН должен состоять из 12 цифр.'");
		
	ИначеЕсли НЕ СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ИдентификационныйНомер) Тогда
		
		СоответствуетТребованиям = Ложь;
		ТекстСообщения = НСтр("ru = 'ИИН / БИН должен состоять только из цифр.'");
		
	ИначеЕсли СтрЧислоВхождений(ИдентификационныйНомер, Лев(ИдентификационныйНомер, 1)) = 12 Тогда
		
		СоответствуетТребованиям = Ложь;
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Цифра %1 повторяется 12 раз.'"), Лев(ИдентификационныйНомер, 1));
		
	Иначе
		
		// а12 = (а1*b1+а2*b2+а3*b3+а4*b4+а5*b5+а6*b6+а7*b7+а8*b8+а9*b9+a10*b10+a11*b11) mod 11
		
		ПодстрокаИН11 = Лев(ИдентификационныйНомер,11);        // копируем первые 11 символов
		КонтрольноеЗначение = Прав(ИдентификационныйНомер, 1); // контрольная сумма ИИН/БИН
		
		// Разряд ИИН: 1 2 3 4 5 6 7 8 9 10 11
		// Вес разряда: 1 2 3 4 5 6 7 8 9 10 11
		
		СуммаРазрядов = 1 * Сред(ИдентификационныйНомер, 1, 1) + 2 * Сред(ИдентификационныйНомер, 2, 1) +
					    3 * Сред(ИдентификационныйНомер, 3, 1) + 4 * Сред(ИдентификационныйНомер, 4, 1) +
					    5 * Сред(ИдентификационныйНомер, 5, 1) + 6 * Сред(ИдентификационныйНомер, 6, 1) +
					    7 * Сред(ИдентификационныйНомер, 7, 1) + 8 * Сред(ИдентификационныйНомер, 8, 1) +
					    9 * Сред(ИдентификационныйНомер, 9, 1) + 10 * Сред(ИдентификационныйНомер, 10, 1) + 11 * Сред(ИдентификационныйНомер, 11, 1);
		ВычисленноеКонтрольноеЗначение = СуммаРазрядов - Цел(СуммаРазрядов / 11) * 11; // mod - остаток от деления Суммы разрядов на 11.
		
		Если ВычисленноеКонтрольноеЗначение = 10 Тогда
			
			// Разряд ИИН: 1 2 3 4 5 6 7 8 9 10 11 
			// Вес разряда: 3 4 5 6 7 8 9 10 11 1 2
			
			СуммаРазрядов = 3 * Сред(ИдентификационныйНомер, 1, 1) + 4 * Сред(ИдентификационныйНомер, 2, 1) +
						    5 * Сред(ИдентификационныйНомер, 3, 1) + 6 * Сред(ИдентификационныйНомер, 4, 1) +
						    7 * Сред(ИдентификационныйНомер, 5, 1) + 8 * Сред(ИдентификационныйНомер, 6, 1) +
						    9 * Сред(ИдентификационныйНомер, 7, 1) + 10 * Сред(ИдентификационныйНомер, 8, 1) +
						    11 * Сред(ИдентификационныйНомер, 9, 1) + 1 * Сред(ИдентификационныйНомер, 10, 1) + 2 * Сред(ИдентификационныйНомер, 11, 1);
			ВычисленноеКонтрольноеЗначение = СуммаРазрядов - Цел(СуммаРазрядов / 11) * 11;   
			
		КонецЕсли;
		
		Если ВычисленноеКонтрольноеЗначение <> Число(КонтрольноеЗначение) Тогда
			
			СоответствуетТребованиям = Ложь;
			ТекстСообщения = НСтр("ru = 'Введенный БИН / ИИН не корректен.'");
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат СоответствуетТребованиям;
	
КонецФункции

#КонецОбласти

#Область Служебные_Процедуры_И_Функции

Процедура ЗаписатьПротоколОшибки(ТекстОшибки, Вызов, КодОшибки, СтруктураОтвет = Неопределено)
	
	ЗаписьЖурналаРегистрации("PAPI",,,,Вызов + ": " + ТекстОшибки);
	Если Не СтруктураОтвет = Неопределено Тогда 
		ЗаполнитьСтруктуруОтвета(СтруктураОтвет, КодОшибки, УпаковатьСообщение(ТекстОшибки), Ложь, "");
	КонецЕсли;	
	
КонецПроцедуры	

Функция ТелоИнфо() Экспорт
	
	Возврат "
			|<html> 
			|<body> 
			|<b> API для обмена (УНФ-БК): </b></br>
			|</br>
			|Метод: POST</br>
			|Заголовок: Content-Type: application/json; charset=utf-8</br>
			|<ul>
			|<li>Список документов: 		http://{АдресСервера}/{ИмяПубликации}/hs/papi/v1/docs_list</li>
			|<li>Содержимое документа: 		http://{АдресСервера}/{ИмяПубликации}/hs/papi/v1/doc_body</li>
			|<li>Данные физ.лица (по ИИН): 	http://{АдресСервера}/{ИмяПубликации}/hs/papi/v1/person_body</li>
  			|</ul>
			|</body>
			|";
	
КонецФункции	

Функция СпецРеквизиты(ОбъектДокумент, ИмяДопРеквизита)
	
	ТЧ_ДР = ОбъектДокумент.Метаданные().ТабличныеЧасти.Найти("ДополнительныеРеквизиты");
	УНФ_ДопРеквизит = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", ИмяДопРеквизита);
	
	Если УНФ_ДопРеквизит.Пустая() Тогда 
		Сообщить("У документов 'Приходная накладная', не найден доп.реквизит: '" + ИмяДопРеквизита + "'.");
		Возврат Неопределено;
	КонецЕсли;	
		
	Если ТЧ_ДР = Неопределено Тогда 
		Возврат Неопределено;
	КонецЕсли;
	
	Если ОбъектДокумент.ДополнительныеРеквизиты.Количество() = 0 Тогда 
		Возврат Неопределено;
	КонецЕсли;
	
	для Каждого ДопРеквизит из ОбъектДокумент.ДополнительныеРеквизиты Цикл 
		Если ДопРеквизит.Свойство = УНФ_ДопРеквизит Тогда 
			Структура = Новый Структура;
			Структура.Вставить(ИмяДопРеквизита, Строка(ДопРеквизит.Значение));
			Возврат Структура;
		КонецЕсли;			
	КонецЦикла;	
	
	Возврат Неопределено;
	
КонецФункции	

#КонецОбласти

#Область Программный_Интерфейс

Функция ОбработкаМетодовHTTPСервис(СтруктураВхПараметров) Экспорт

	СтруктураОтвет = ПолучитьСтруктураОтвет();
		
	Если Не ВРег(СтруктураВхПараметров.HTTPМетод) = ВРег("POST") Тогда
		ТекстОшибки = "Не описанный HTTP-метод: " + ВРег(СтруктураВхПараметров.HTTPМетод);
		ЗаписатьПротоколОшибки(ТекстОшибки, "ОбработкаМетодовHTTPСервис", 405, СтруктураОтвет);
		Возврат СтруктураОтвет;
	КонецЕсли;
	
	Если Не ВходитВСписокМетодов(НРег(СтруктураВхПараметров.ИмяМетода)) Тогда
		ТекстОшибки = "Не допустимое имя метода: " + СтруктураВхПараметров.ИмяМетода;
		ЗаписатьПротоколОшибки(ТекстОшибки, "ОбработкаМетодовHTTPСервис", 405, СтруктураОтвет);
		Возврат СтруктураОтвет;
	КонецЕсли;
	
	Если Не ТипЗнч(СтруктураВхПараметров.Тело) = Тип("Структура") Тогда
		ТекстОшибки = "Переданные данные содержат не правильный формат данных: " + СтруктураВхПараметров.ТелоСтрока;
		ЗаписатьПротоколОшибки(ТекстОшибки, "ОбработкаМетодовHTTPСервис", 405, СтруктураОтвет);
		Возврат СтруктураОтвет;
	КонецЕсли;
	
	Если ВРег(СтруктураВхПараметров.ИмяМетода) = ВРег("docs_list") Тогда
		ПолучитьСписокДокументов(СтруктураОтвет, СтруктураВхПараметров.Тело);
	КонецЕсли;
		
	Если ВРег(СтруктураВхПараметров.ИмяМетода) = ВРег("doc_body") Тогда
		ПолучитьДокумент(СтруктураОтвет, СтруктураВхПараметров.Тело);
	КонецЕсли;
	
	Если ВРег(СтруктураВхПараметров.ИмяМетода) = ВРег("person_body") Тогда
		ПолучитьФизЛицо(СтруктураОтвет, СтруктураВхПараметров.Тело);
	КонецЕсли;
	
	Возврат СтруктураОтвет;
	
КонецФункции

Процедура ПолучитьСписокДокументов(СтруктураОтвет, СтруктураВхПараметров)
	
	Если Не СтруктураВхПараметров.Свойство("ВидДокумента") Тогда 	
		ТекстОшибки = "Тело данных запроса не содержит обязательный реквизит: ВидДокумента";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьСписокДокументов", 405, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	Если Не СтруктураВхПараметров.Свойство("Дата") Тогда 	
		ТекстОшибки = "Тело данных запроса не содержит обязательный реквизит: Дата";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьСписокДокументов", 405, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	ВидДокумента = СтруктураВхПараметров.ВидДокумента;
	Если Не ВходитВСписокВидовДокумента(ВидДокумента) Тогда 
		ТекстОшибки = "Переданный реквизит в теле данных запроса содержит не допустимое значение (ВидДокумента): " + ВидДокумента;
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьСписокДокументов", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;	
	
	СписокДокументов = ЗапросСписокДокументов(ВидДокумента, СтруктураВхПараметров.Дата);
	
	Если СписокДокументов = Неопределено Тогда 
		ТекстОшибки = "На заданную дату документов нет";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьСписокДокументов", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	Результат = ВернутьСтруктуруИлиМассивКакСтрокуJSON(СписокДокументов);
		
	СтруктураОтвет.ДанныеОтвета = Результат;
	
КонецПроцедуры

Процедура ПолучитьДокумент(СтруктураОтвет, СтруктураВхПараметров)
	
	Если Не СтруктураВхПараметров.Свойство("ВидДокумента") Тогда 	
		ТекстОшибки = "Тело не содержит обязательный реквизит: ВидДокумента";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 405, СтруктураОтвет); 
		Возврат;
	КонецЕсли;
	
	Если Не СтруктураВхПараметров.Свойство("Идентификатор") Тогда 	
		ТекстОшибки = "Тело не содержит обязательный реквизит: Идентификатор";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 405, СтруктураОтвет); 
		Возврат;
	КонецЕсли;
	
	Если Не СтруктураВхПараметров.Свойство("НомерСтроки") Тогда 	
		ТекстОшибки = "Тело не содержит обязательный реквизит: НомерСтроки";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 405, СтруктураОтвет); 
		Возврат;
	КонецЕсли;
	
	ВидДокумента = СтруктураВхПараметров.ВидДокумента;
	Если Не ВходитВСписокВидовДокумента(ВидДокумента) Тогда 
		ТекстОшибки = "Переданный реквизит в теле данных запроса содержит не допустимое значение (ВидДокумента): " + ВидДокумента;
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	Попытка
		УИ = Новый УникальныйИдентификатор(СтруктураВхПараметров.Идентификатор);
		Если Не ТипЗнч(УИ) = тип("УникальныйИдентификатор") Тогда 
			ТекстОшибки = "Полученный УникальныйИдентификатор: " + СтруктураВхПараметров.Идентификатор + " не соответсвует требуемому типу.";
			ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
			Возврат;
		КонецЕсли;	
	Исключение
		ТекстОшибки = "Ошибка получения УникальныйИдентификатор по переданному значению: " + СтруктураВхПараметров.Идентификатор + ", " + ОписаниеОшибки();
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
		Возврат;
	КонецПопытки;
	
	ОбъектДокумент = Неопределено;
	
	СсылкаДокумент = Документы[СтруктураВхПараметров.ВидДокумента].ПолучитьСсылку(УИ);
	Если Не СсылкаДокумент.Пустая() Тогда 
		Попытка
			ОбъектДокумент = СсылкаДокумент.ПолучитьОбъект();
		Исключение 
			ТекстОшибки = "Ошибка получения документа по ссылке (Идентификатор): " + СтруктураВхПараметров.Идентификатор + ", " + ОписаниеОшибки();
			ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	Если ОбъектДокумент = Неопределено Тогда 
		ТекстОшибки = "По заданным параметрам документ не найден";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	СтруктураДокумента = ПолучитьЗаголовокСтруктурыОбъекта(ОбъектДокумент);
	СтруктураОбъекта = ОбъектКакСтруктура(ОбъектДокумент, СтруктураДокумента);
	Если СтруктураОбъекта = Неопределено Тогда 
		ТекстОшибки = "Ошибка при преобразований объекта в структуру: " + ВидДокумента;
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьДокумент", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;	
		
	СтруктураОбъекта.Вставить("НомерСтроки", СтруктураВхПараметров.НомерСтроки);
	СтруктураОбъекта.Вставить("СпецРеквизиты", СпецРеквизиты(ОбъектДокумент, "УНФ_ВидОперации"));
	
	Результат = ВернутьСтруктуруИлиМассивКакСтрокуJSON(СтруктураОбъекта);
	СтруктураОтвет.ДанныеОтвета = Результат;
	
КонецПроцедуры

Процедура ПолучитьФизЛицо(СтруктураОтвет, СтруктураВхПараметров)
	
	Если Не СтруктураВхПараметров.Свойство("ИИН") Тогда 	
		ТекстОшибки = "Тело не содержит обязательный реквизит: ИИН";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьФизЛицо", 405, СтруктураОтвет); 
		Возврат;
	КонецЕсли;
	
	ИИН = СокрЛП(СтруктураВхПараметров.ИИН);
	
	ТекстОшибки = "";
	Если Не ИИНБИНСоответствуетТребованиям(ИИН, ТекстОшибки) Тогда 
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьФизЛицо", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;

	
	ОбъектСправочник = Неопределено;
	СсылкаСправочник = Справочники.ФизическиеЛица.НайтиПоРеквизиту("ИдентификационныйНомер", ИИН);
	Если Не СсылкаСправочник.Пустая() Тогда 
		Попытка
			ОбъектСправочник = СсылкаСправочник.ПолучитьОбъект();
		Исключение 
			ТекстОшибки = "Ошибка получения элемента справочника по ИИН: " + СтруктураВхПараметров.ИИН + ", " + ОписаниеОшибки();
			ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьФизЛицо", 404, СтруктураОтвет);
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	Если ОбъектСправочник = Неопределено Тогда 
		ТекстОшибки = "По заданному ИИН: " + ИИН + ", ФизЛицо не найдено.";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьФизЛицо", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	//НаборРеквизитов = Новый СписокЗначений;
	СтруктураСправочника = ПолучитьЗаголовокСтруктурыОбъекта(ОбъектСправочник);
	СтруктураОбъекта = ОбъектКакСтруктура(ОбъектСправочник, СтруктураСправочника);
	Если СтруктураОбъекта = Неопределено Тогда 
		ТекстОшибки = "Ошибка при преобразований объекта в структуру";
		ЗаписатьПротоколОшибки(ТекстОшибки, "ПолучитьФизЛицо", 404, СтруктураОтвет);
		Возврат;
	КонецЕсли;
	
	Результат = ВернутьСтруктуруИлиМассивКакСтрокуJSON(СтруктураОбъекта);
	СтруктураОтвет.ДанныеОтвета = Результат;
	
КонецПроцедуры	

#Область Работа_С_JSON

Функция ВернутьСтруктуруИлиМассивКакСтрокуJSON(СтруктураМассив) Экспорт 
	
	Попытка
		ЗаписьJSON = Новый ЗаписьJSON;
		ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(, Символы.Таб);
		ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
		Попытка
			ЗаписатьJSON(ЗаписьJSON, СтруктураМассив);		
			Возврат ЗаписьJSON.Закрыть();
		Исключение
			ТекстОписаниеОшибки = ОписаниеОшибки();
			ЗаписатьПротоколОшибки(ТекстОписаниеОшибки, "ВернутьСтруктуруИлиМассивКакСтрокуJSON", 503);
			Возврат Неопределено;
		КонецПопытки;			
	Исключение
		ТекстОписаниеОшибки = ОписаниеОшибки();
		ЗаписатьПротоколОшибки(ТекстОписаниеОшибки, "ВернутьСтруктуруИлиМассивКакСтрокуJSON", 503);
		Возврат Неопределено;
	КонецПопытки;	
	
КонецФункции

Функция ПолучитьСтруктуруИлиМассивИзСтрокиJSON(ТекстJSON) Экспорт 
	
	МассивДат = ПолучитьМассивДат();
	
	Попытка
		ЧтениеJSON = Новый ЧтениеJSON; 
		ЧтениеJSON.УстановитьСтроку(ТекстJSON); 	
		ДанныеИзТело = ПрочитатьJSON(ЧтениеJSON, Ложь, МассивДат, ФорматДатыJSON.ISO);	
		ЧтениеJSON.Закрыть();
	Исключение
		ЗаписатьПротоколОшибки(ОписаниеОшибки(), "ПолучитьСтруктуруИлиМассивИзСтрокиJSON", 503);
		Возврат Неопределено;
	КонецПопытки;	
	
	Возврат ДанныеИзТело;
	
КонецФункции	

Функция ПолучитьМассивДат() 
	
	МассивДат = Новый Массив;
	МассивДат.Добавить("Дата");
	МассивДат.Добавить("Период");
	МассивДат.Добавить("ДатаВыдачи");
	МассивДат.Добавить("СрокДействия");
	МассивДат.Добавить("ПериодРегистрации");
	МассивДат.Добавить("ДатаЗапросаДанных");
	
	Возврат МассивДат;
	
КонецФункции

#КонецОбласти

#КонецОбласти