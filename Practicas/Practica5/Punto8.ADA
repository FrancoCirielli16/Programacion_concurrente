8.  Una  empresa  de  limpieza  se  encarga  de  recolectar  residuos  en  una  ciudad  por  medio  de  3 
camiones.  Hay  P  personas  que  hacen  continuos  reclamos  hasta  que  uno  de  los  camiones 
pase por su casa. Cada persona hace un reclamo, espera a lo sumo 15 minutos a que llegue 
un camión y si no vuelve a hacer el reclamo y a esperar a lo sumo 15 minutos a que llegue 
un  camión  y  así  sucesivamente  hasta  que  el  camión  llegue  y  recolecte  los  residuos;  en  ese 
momento deja de hacer reclamos y se va. Cuando un camión está libre la empresa lo envía a 
la  casa  de  la  persona  que  más  reclamos  ha  hecho  sin  ser  atendido.  Nota:  maximizar  la 
concurrencia. 
 
 
 Procedure empresa is


    task type camion; 

    task cordinador is
        entry reclamar (idPersona : in Integer);
        entry nuevoDestino (idPersona : out Integer);
        entry cerrarReclamo (idPersona : in Integer);
    end cordinador;

    task type persona is
        entry atender;
        entry id(id IN integer);
    end persona;

    task body camion is
    begin
        loop
            cordinador.nuevoDestino(destino);
            -- atender
            persona(destino).atender;
            -- se atiende
            cordinador.cerrarReclamo(destino);
        end loop;
    end camion;


    task body persona is
        miID : integer;
    begin
        accept id(id: IN integer)do 
            miID = id;
        end id;

        loop    
            cordinador.reclamar(miID);
            SELECT 
                accept atender do 
                    meAtendio = True;
                end atender;
            OR  
                OR(delay 60 * 15);
                meAtendio = False;
            end SELECT;
            exit when meAtendio;
        end loop; 
    end persona;

    task body cordinador is
        Reclamos : array(1..P) of integer;
        Atendidas : array(1..P) of Boolean;
    begin
        for i in P loop
            persona(i).id(i);
            Reclamos(i) = 0;
            Atendidas(i) = False;
        end loop;

        loop
            SELECT
                accept reclamar(id:IN integer)do
                    Reclamos(i)++;
                    PersonaAtender = IndexMax(Atendidas) -- Saca la persona que hizo mas reclamos si son todos 0 retorna 0
                end reclamar; 
            OR when PersonaAtender > 0 =>
                accept nuevoDestino(destino: OUT integer)do
                    destino = PersonaAtender;
                    Atendidas[destino] = True;
                    Reclamos(destino) = 0;
                    PersonaAtender = IndexMax(Atendidas)
                end nuevoDestino;
            OR 
                accept cerrarReclamo(id: INT integer) do
                    Atendidas[id] = False;
                end cerrarReclamo;
        end loop;
    end cordinador;

    Personas : array(1..P) of Persona;
    Camiones : array(1..3) of Camion;

begin
    null
 end empresa;




