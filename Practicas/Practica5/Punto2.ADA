2.  Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar 
un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de 
acuerdo  con  el  orden  de  llegada.  Los  clientes  llegan  y  si  esperan  más  de  10  minutos  se 
retiran sin realizar el pago.




Procedure BancoCentral is
    Task empleado is
        Entry Pago(tramite: IN texto; C: OUT texto);
    End Puente;

   
    Task Body empleado is
        Begin
            loop
                accept Pago(tramite IN texto;C: OUT texto);
                    C = ProcesarPago(tramite)
                end Pago;
                end SELECT;
            end loop;
        end Puente;
    

    Task type clientes;

    clientes : array (1..C) of clientes;
    
    Task Body clientes is
        comprobante : texto;
        begin
            SELECT
                empleado.Pago("Datos",comprobante)
            OR delay 10 * 60;
        end select;
    end clientes;


End BancoCentral;
