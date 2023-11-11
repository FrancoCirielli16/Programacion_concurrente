5. En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos
de U Usuarios de a uno a la vez y de acuerdo con el orden en que se hacen los pedidos.
Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la
respuesta de este que le indica si está todo bien o hay algún error. Mientras haya algún error,
vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le responde
que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera a lo sumo
2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto y vuelve a
intentarlo (usando el mismo documento).


Procedure sistema is

    task type Usuarios;
    
    task Servidor is
        EnviarPedido(p:IN String; esValido: OUT boolean);
    end Servidor;


    task body Servidor is
        doc:String
        EsValido:boolean
    begin
        loop
            accept EnviarPedido(doc:IN string; EsValido: OUT boolean) do 
                EsValido = ValidarDocumento(doc);
            end EnviarPedido;
        end loop;
    end Servidor;


    task body Usuarios is 
        doc:String;
        EsValido:boolean;
    begin
        EsValido = false;
        doc = generarDocumento();
        loop    
            select
                Servidor.EnviarPedido(doc,EsValido);
                if(not EsValido)then
                    docu = generarDocumento();
                end if;
            or delay(60*2);
                delay(60);
            end select
            existe when(EsValido);
        end loop;
    end Usuarios;
        
    Usuarios : array[1..U]of Usuario;
begin
    null
end sistema;