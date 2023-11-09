2.  Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar 
un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de 
acuerdo  con  el  orden  de  llegada.  Los  clientes  llegan  y  si  esperan  más  de  10  minutos  se 
retiran sin realizar el pago.




Procedure Punto1 is
    Task Puente is
        Entry Auto ();
        Entry Camioneta ();
        Entry Camion ();
        Entry Salida (P: IN INT);
    End Puente;

   

    Task Body Puente is
        int cant = 0;

        Begin
            loop
                SELECT
                    when(cant + 1 < 5) =>
                        accept Auto() do
                            cant + 1;
                    end Auto;
                OR
                    when(cant + 2 < 5) =>
                        accept Camioneta() do
                            cant + 2;
                    end Auto;
                OR
                    when(cant + 3 < 5) =>
                        accept Camion() do
                            cant + 3;
                    end Auto;
                OR
                    accept Salida(P: IN INT)do
                        cant - P;
                    end Salida;
                end SELECT;
            end loop;
        end Puente;
    

    Task type Vehículos;

    Task Body vehículo is
        tipo:string;
        
        if(tipo = "Auto")then
            Puente.Auto();
        if(tipo = "Camioneta")then
            Puente.Camioneta();
        if(tipo = "Camion")then
            Puente.Camion();
        end if;


        if(tipo = "Auto")then
            Puente.Salida(1);
        if(tipo = "Camioneta")then
            Puente.Salida(2);
        if(tipo = "Camion")then
            Puente.Salida(3);
        end if;
    end vehículo;


End Punto1;
