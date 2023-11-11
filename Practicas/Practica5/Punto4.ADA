4. En una clínica existe un médico de guardia que recibe continuamente peticiones de
atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la
clínica ser atendidos.

Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo
haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del
médico. Si no es atendida tres veces, se enoja y se retira de la clínica.

Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente
le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el
momento que pueda (el pedido puede ser que el médico le firme algún papel). Cuando la
petición ha sido recibida por el médico o la nota ha sido dejada en el escritorio, continúa
trabajando y haciendo más peticiones.

El médico atiende los pedidos dándole prioridad a los enfermos que llegan para ser atendidos.
Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto tiempo. Cuando
está libre aprovecha a procesar las notas dejadas por las enfermeras.


Procedure clínica is

    
    task type enfermera;


    


    task consultorio is
        Entry dejarNota(nota: IN string);
        Entry agarrarNota(nota: OUT string);
    end consultorio;

    task medico is
        Entry atender(id:IN integer)
        Entry atencionEnfermera(pedido:IN String);
    end medico;

    task type Persona is
        entry pasa;
        entry resultado(resultado: OUT String);
    end Persona;

    task body consultorio is 
        notas:lista;
    begin
        loop    
            select 
                accept dejarNota(nota: IN String)do 
                    notas.push(nota);
                end dejarNota;
            or  
                when (not notas.isempty()) => 
                    accept agarrarNota(nota: OUT String) do  
                        nota:= notas.pop()
                    end agarrarNota;
            end select;
        end loop;
    end consultorio;

    task body enfermera is
        pedido:String
    begin
        loop
            pedido = generarPedido();
            select 
                Medico.atencionEnfermera(pedido);
            else    
                consultorio.dejarNota(pedido);
            end select;
        -- Trabajar 
        end loop;
    end enfermera;


    task body Medico is   
        idPaciente:integer;
        atencionPaciente:boolean;
        notaDeConsultorio, solicitud: String;
    begin
        atenciónPaciente = false;
        loop
            select 
                accept atender(id:IN Integer) do
                    idPaciente := id;
                    atendiendoPaciente := true;
                end atender;
                or when (atender'Count = 0 ) => 
                    accept atencionEnfermera(pedido:IN String) do
                        -- resuelve el pedido
                    end atencionEnfermera;
            else 
                select
                    Consultorio.agarrarNota(notaDeConsultorio);
                    -- resolver nota
                else
                    null;
            end select;

            if (atendiendoPaciente) then
                Persona(idPaciente).pasa();
                -- lo evalua
                Persona(idPaciente).resultado(resultado)
                atendiendoPaciente := false;
            end if;
            
        end loop;

    task body Persona is
        solicitudes:integer;
    begin
        solicitudes:=0;
        loop
            select
                Medico.atender(id);
                    solicitudes:= 0;
            or delay(60*5);
            solicitudes:=solicitudes+1
                if(solicitudes<3)then   
                    delay(60*10);

                end if;
            end select;
            exit when (solicitudes = 0 or solicitudes = 3);
        end loop;

        if(solicitudes = 0)then
            accept pasa();
            -- pasa
            accept resultado(resultado: OUT String) do
            -- recibe atencion
            end resultado
        elsif(solicitudes = 3)then
            --se enoja
        end if;

        --Se retira
    end Persona;

enfermeras : array (1..E) of Enfermera;
personas : array (1..P) of Persona;

begin
  null;
end Clinica;
