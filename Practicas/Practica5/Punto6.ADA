6. En una playa hay 5 equipos de 4 personas cada uno (en total son 20 personas donde cada
una conoce previamente a que equipo pertenece). 
Cuando las personas van llegando esperan con los de su equipo hasta que el mismo esté completo (hayan llegado los 4
integrantes), a partir de ese momento el equipo comienza a jugar. 

El juego consiste en que cada integrante del grupo junt5 mona 1edas de a una en una playa (las monedas pueden ser
de 1, 2 o 5 pesos) y se suman los montos de las 60 monedas conseguidas en el grupo. Al
finalizar cada persona debe conocer el grupo que más dinero junto. Nota: maximizar la
concurrencia. Suponga que para simular la búsqueda de una moneda por parte de una
persona existe una función Moneda() que retorna el valor de la moneda encontrada.


Procedure playa is

    task type equipo is 
        entry jugadorListo(id:IN Integer);
        entry recibirMonedas(monedas: IN Integer);
    end equipo;

    task type jugador is
        entry empezarPartido;
        entry ganador(id:IN Integer);
    end jugador;

    task arbitro is
        entry terminarPartido(idEquipo:IN integer; monedas IN Integer); 
    end arbitro;

    task body jugador is
        miEquipo:Integer;
        miId:Integer;
        moneda:Integer;
        idganador:Integer;
    begin
        miId = Id;
        miEquipo = ObtenerEquipo();
        equipo(miEquipo).jugadorListo(miId);
        accept empezarPartido;
        moneda = 0;
        for in 1..15 loop
            moneda := moneda + Moneda();
        end loop;

        equipo(miEquipo).recibirMonedas(moneda);

        accept ganador(idganador:IN integer)do
            if(idganador = miEquipo)then
                --ganador
            else
                --perdi
            end if;
        end ganador;
    end jugador;

    task body equipo is
        idEquipo:integer;
        jugadores : array(1..4)of integer;
        totalMonedas: integer;
    begin
        idEquipo:=id
        for i : 1..4 loop
            accept jugadorListo(id:IN integer) do
                jugadores(i) = id;
            end jugadorListo;
        end loop;

        for i : 1..4 loop
            jugador(jugadores(i)).empezarPartido();
        end loop;

        totalMonedas: = 0;

        for i:1..4 loop
            accept recibirMonedas(monedas:IN integer)do
                totalMonedas:=totalMonedas + monedas;
            end recibirMonedas;
        end loop;

        arbitro.terminarPartido(idEquipo,totalMonedas);
    end equipo;



    task arbitro is

    begin
        MaxMoneda = 0;
        idganador = 0;
        for i : 1..5 loop
            accept terminarPartido(idEquipo:IN Integer,totalMonedas: IN integer)do
                if(totalMonedas>MaxMoneda)then
                    MaxMoneda:=totalMonedas;
                    idganador:=idEquipo;
                end if;
            end terminarPartido;
        end loop;

        for i:1..20 loop
            jugadores(i).ganador(idganador);
        end loop;

    end arbitro;

equipos : array(1..5)of equipo;
jugadores : array(1..20)of jugadores;

begin
    null
end playa;