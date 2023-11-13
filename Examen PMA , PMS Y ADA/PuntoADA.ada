Resolver con ADA la siguiente situación. 
En una obra social que tiene 15 sedes en diferentes lugares se tiene información de las enfermedades de cada uno de sus clientes (cada sede tiene sus propios datos). 
Se tiene una Central donde se hacen estadísticas, y para esto repetidamente elige una enfermedad y debe calcular la cantidad total de clientes que la han tenido. 
Esta información se la debe pedir a cada Sede. Maximizar la concurrencia.
Nota: existe una función ElegirEnfermos(e) que es llamada por cada Sede y devuelve la cantidad de clientes de esa sede que han tenido la enfermedad e.



Procedure obraSocial is

    task Central
        entry enfermadad(e: OUT string);
        entry enviarCant(c: IN int);
        entry siguiente;
    end Central;


    task type sede is 
        
    end sede;


    task body sede is
        enfermadadSolicitada:string;
    begin
        loop 
            
            Central.enfermadad(enfermadad);
            cantidad = ElegirEnfermos(enfermadadSolicitada);
            Central.enviarCant(cantidad);
            Central.siguiente();
            
        end loop;
    end sede;


    task body Central is
    begin
        loop
            enfermedadGenerada = generarEnfermedad(); 


            for i in 30 loop
                

                SELECT 
                    accept enfermadad(e: OUT string) do
                        e = enfermadaGenerada;
                    end enfermadad;
                OR 
                    accept enviarCant(cantidad: IN integer)do
                        cantidadTotal += cantidad;
                    end enviarCant
                end SELECT;

            end loop;
            
            for i in 15 loop
                accept siguiente();
            end loop;

        end loop;
    end Central;

    sedes : array[1..S]of sede;

begin
    null
end obraSocial;














2. Resolver  con  ADA  el  siguiente  problema.  

Se  quiere  modelar  el  funcionamiento  de  un  banco,  al  cual  llegan 
clientes que deben realizar un pago y llevarse su comprobante. Los clientes se dividen entre los regulares y los 
premium,  habiendo  R  clientes  regulares  y  P  clientes  premium.  Existe  un  único  empleado  en  el  banco,  el  cual 
atiende  de  acuerdo  al  orden  de  llegada,  pero  dando  prioridad  a  los  premium  sobre  los  regulares. 
 
Si  a  los  30  minutos de llegar un cliente regular no fue atendido, entonces se retira sin realizar el pago. Los clientes premium 
siempre esperan hasta ser atendidos



Procedure banco is

    task type premium;

    task type regulares;

    task empleado is
        entry llegarP(pago:in integer,comprobante: out string);
        entry llegarR(pago:in integer,comprobante: out string);
    end empleado

    task body regulares is 
        id:integer;
        comprobante:string;
    begin
        SELECT
            empleado.llegarR(id,comprobante);
        OR
            DELAY (60*30);
            null
    end regulares;

    task body premium is
        id:integer;
        comprobante:string;
    begin
        empleado.llegarP(id,comprobante);
    end premium;

    task body empleado is

    begin
        
        loop
            SELECT 
                accept llegarP(pago: in integer, comprobante: OUT string) do
                    comprobante = generarComprobante(pago);
                end llegarP;
            OR 
                when (llegarP `Count = 0) ==>
                    accept llegarR(pago: in integer, comprobante: OUT string) do
                    comprobante = generarComprobante(pago);
                    end llegarR;
        end loop;
    end empleado;

clientesRegulares :  array (1 .. R) of ClienteRegular;
clientesPremium : array(1..P) of ClientePremium;
    
begin
    null  
end banco;







Resolver con ADA el siguiente problema. Una empresa de venta de calzado cuenta con S sedes. En la oficina
central de la empresa se utiliza un sistema que permite controlar el stock de los diferentes modelos, ya que
cada sede tiene una base de datos propia. El sistema de control de stock funciona de la siguiente manera:

dado un modelo determinado, lo envía a las sedes para que cada una le devuelva la cantidad disponible en
ellas; al final del procesamiento, el sistema informa el total de calzados disponibles de dicho modelo. Una
vez que se completó el procesamiento de un modelo, se procede a realizar lo mismo con el siguiente modelo.
Nota: suponga que existe una función DevolverStock(modelo,cantidad) que utiliza cada sede donde recibe
como parámetro de entrada el modelo de calzado y retorna como parámetro de salida la cantidad de pares
disponibles. Maximizar la concurrencia y no generar demora innecesaria






Procedure empresa is 

    task type sedes; 
        
 


    task central is
        entry solicitarStock(modelo: OUT string);
        entry obtenerStock(cantidad: OUT integer);
        entry siguiente;
    end central;

    task body central is

    begin
        
        loop

            cantTotal = 0;
            for i in S*2 loop
                SELECT 
                    accept solicitarStock(modelo: OUT string)do
                        modelo = obtenerModelo();
                    end solicitarStock;
                OR
                    accept obtenerStock(cantidad: IN integer)do
                        cantidadTotal += cantidad;
                    end obtenerStock;
            end loop;

            for i in S loop
                accept siguiente();
            end;
        
        end loop;


    end central;

    task body sede is

    begin
        loop
            central.solicitarStock(modelo);
            DevolverStock(modelo,cantidad);
            central.obtenerStock(cantidad);
            Central.siguiente();
        end loop;
    end sede;

begin
    null
end empresa;


