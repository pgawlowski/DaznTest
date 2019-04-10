# DaznTest
#Kilka słów wyjaśnień.

Aplikacja zbudowana w oparciu o architekturę VIPER w oparciu o pods'a Viperit, który całkiem ładnie opakowuje 
boiler-plate wynikający ze specyfiki VIPER + wydziela część zasadniczą do templatek. Jeśli chodzi o pods'a 
jestem w stałym kontakcie z jego twórcą więc mam pogląd na stabilność, rozwój i utrzymanie.

W odniesieniu do rozmowy telefonicznej, UI potraktowałem bardzo pobłażliwie. 
Button dropdown menu jest wpięty na sztywno, obecnie najprostszym rozwiązaniem, żeby dociagnąć go do krawędzi 
wydaje się edgeInsets na obrazku. Dawniej stosowane haki typu negative spacer od okolic 11+ nie działają.

Niestety z braku czasu nie pokryłem całości zadania testami. Mordercze tutaj okazały się przeróbki pod mocki ze względu na 
wykorzystany format wejściowy XML - do tej pory opierałem się o JSON-y i zbytnio usztywniłem strukturę testów, 
na której zwykle pracuje. Świetna nauka na przyszłość jak dużo muszę tam przerobić ;)
Wrzucony jest poglądowo NewsPresenterTest wraz ze strukturą mocków, gdzie testowana jest struktura Input, Output 
oraz nie działjący test NewsInteractorTest.
NewsInteractorTest - zostawiłem poglądowo, żeby pokazać jak wstawiane są stub-response, tu jednak położyły mnie problemy z XML,
których poprawianie już odpuściłem. 

Rx-owe podejście - stosuję bardziej intuicyjnie niż z pełną świadomością wszystkich potencjalnych efektów ubocznych,
niestety dopiero poznaję Rx'a, choć komercyjnie tworzyłem już na nim 2 projekty, niestety do tej pory działałem całkowicie 
samodzielnie w tym obszarze, więc nie miałem możliwości pozyskania konstruktywnego feedbacku bądź sugestii osób bardziej 
doświadczonych.

Ze swojej strony (niezależnie od pozytywnej bądź negatywnej oceny wykonania tego zadania), proszę o konstruktywny feedback 
wskazujący pole do poprawy, braki wiedzy lub nieprawidłowe wzorce.
