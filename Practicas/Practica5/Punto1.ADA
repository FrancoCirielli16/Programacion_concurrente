/*

1. Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso.

El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2 unidades y cada camión 3 unidades.

Suponga que hay una cantidad innumerable de vehículos (A autos, B camionetas y C camiones). 

Analice el problema y defina qué tareas,recursos y sincronizaciones serán necesarios/convenientes para resolver el problema.

a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.

b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los vehículos.

*/


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
                    when(Auto "Count == 0 and cant + 2 < 5) =>
                        accept Camioneta() do
                            cant + 2;
                    end Auto;
                OR
                    when(Auto "Count == 0 and cant + 3 < 5) =>
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
        peso:integer;
    begin
        peso = 0;

        if(tipo = "Auto")then
            Puente.Auto();
            peso:= 1;
        if(tipo= "Camioneta")then
            Puente.Camioneta();
            peso:= 2;
        if(tipo = "Camion")then
            Puente.Camion();
            peso:= 3;
        end if;


        Puente.Salir(peso);
    end vehículo;



Vehiculos : array (1 .. (A + B + C)) of Vehiculo;

Begin 
 null
End Punto1;

//b

procedure Puente is
  PESO_MAXIMO : Integer := 5;

  task Administrador is
    entry Auto;
    entry Camioneta;
    entry Camion;
    entry Salir (peso : in Integer);
  end Administrador;

  task body Administrador is
    peso_actual : Integer;
  begin
    peso_actual := 0;

    loop
      select when (LlegaCamion'Count == 0 and (peso_actual + 1) < PESO_MAXIMO) =>
        accept LlegaAuto do
          peso_actual := peso_actual + 1;
        end LlegaAuto;

      or when (LlegaCamion'Count == 0 and (peso_actual + 2) < PESO_MAXIMO) =>
        accept LlegaCamioneta do
          peso_actual := peso_actual + 2;
        end LlegaCamioneta;

      or when ((peso_actual + 3) < PESO_MAXIMO) =>
        accept LlegaCamion do
          peso_actual := peso_actual + 3;
        end LlegaCamion;

      or when (peso_actual > 0 and Salir'Count > 0) =>
        accept Salir (peso : in Integer) do
          peso_actual := peso_actual - peso;
        end Salir;
      end select;

    end loop;
  end Administrador;

  task type Vehiculo;

  task body Vehiculo is
    peso : Integer;
  begin
    if ("Auto") then
      Administrador.Auto();
      peso := 1;
    elsif ("Camioneta") then
      Administrador.Camioneta();
      peso := 2;
    elsif ("Camion") then
      Administrador.Camion();
      peso := 3;
    end if;

    -- un delay para simular el tiempo que tarda en cruzar el puente
    Administrador.Salir (peso);
  end Vehiculo;

  Vehiculos : array (1 .. (A + B + C)) of Vehiculo;
begin
  null;
end Puente;