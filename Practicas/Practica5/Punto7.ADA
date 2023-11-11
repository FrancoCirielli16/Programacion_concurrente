7. Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 Servidores
para realizar el reconocimiento, cada uno de ellos trabajando con una Base de Datos propia;
a su vez hay un Especialista que utiliza indefinidamente. 

El sistema funciona de la siguiente manera: el Especialista toma una imagen de una huella (TEST) y se la envía a los servidores
para que cada uno de ellos le devuelva el código y el valor de similitud de la huella que más
se asemeja a TEST en su BD; al final del procesamiento, el especialista debe conocer el
código de la huella con mayor valor de similitud entre las devueltas por los 8 servidores.

Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo.

Nota: suponga que existe una función Buscar(test, código, valor) que utiliza cada Servidor donde
recibe como parámetro de entrada la huella test, y devuelve como parámetros de salida el
código y el valor de similitud de la huella más parecida a test en la BD correspondiente.

Maximizar la concurrencia y no generar demora innecesaria



procedure policía is 

    task type Servidor is
        Entry recibirHuella(test: IN huella);
    end Servidores;

    task especialista is
        Entry recibirSimilitud(valor: IN integer,codigo: IN integer);
    end especialista;


    task body especialista is
        test:huella;
        valorMax: integer;
        codigoMax:integer;
    begin
        valorMax = 0;
        loop
            test = obtenerHuella();
            for i in 8 loop
                Servidor(i).recibirHuella(test);
            end loop;
            
            for i in 8 loop;
                accept recibirSimilitud(valor IN integer, codigo: IN integer) do
                    if(valorMax<valor)then
                        valorMax = valor;
                        idMax = id;
                end recibirSimilitud;
            end loop;
    end especialista;




    task body Servidor is
        RealizarTest : string;
        codigo : integer;
        valor : float; 
    begin
        loop
            SELECT accept recibirHuella(test:IN string)do
                RealizarTest = test;
            end recibirHuella;
            Buscar(RealizarTest,codigo,valor);
            especialista.recibirSimilitud(valor,codigo);
        end loop;
    end Servidor;


    Servidores: array (1..8) of Servidor;
begin
    null
end policía;


