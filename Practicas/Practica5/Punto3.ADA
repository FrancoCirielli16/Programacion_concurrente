3. Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se
comunican continuamente. Se requiere modelar su funcionamiento considerando las
siguientes condiciones:
- La central siempre comienza su ejecución tomando una señal del proceso 1; luego
toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una
señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
- Los procesos periféricos envían señales continuamente a la central. La señal del
proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. Si la
señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y
vuelve a mandarla (no se deshecha).


Procedure Sistema is  
    task Timer is
        Entry iniciar;
    end Timer;

    task central is
        Entry mensaje1(señal: IN integer);
        Entry mensaje2(señal: IN integer);
        Entry PararTimer;
    end central;

    task periférico1;
    task periférico2;

    task body Timer is
    Begin
        loop 
            accept Iniciar;
            delay 3 * 60;
            central.PararTimer;
        end loop;
    end Timer;  


    task body central is
        proceso2:boolean
    begin
        proceso2 = false;
        accept mensaje1(señal:in integer);

        loop
            select 
                when (PararTimer "Count = 0 and not proceso2) => 
                    accept mensaje1(señal:in Integer);
                or  
                    when(PararTimer "Count = 0) =>
                        accept mensaje2(señal:in Integer);
                        if(not proceso2)then 
                            proceso2 = True 
                            Timer.Iniciar;
                        end if;
                    end mensaje2;
                or  
                    accept PararTimer is    
                        proceso2 = false;
                    end PararTimer; 
                end select
            end loop;   
        end central;
    
    task body periférico1 is
        señal:integer;
    begin
        señal = obtenerSeñal();
        central.mensaje1(señal);

        loop    
            señal = obtenerSeñal();
            select 
                central.mensaje1(señal);
            or  
                delay(60 * 2);
            end select;
        end loop;
    end periférico1;

     task body periférico2 is
        señal:integer;
    begin


        loop    
            señal = obtenerSeñal();
            select 
                central.mensaje2(señal);
            else
                delay(60 * 1);
                central.mensaje2(señal);
            end select;
        end loop;
    end periférico2;
                    
