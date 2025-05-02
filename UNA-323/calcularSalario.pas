program CalculoSalario;

var
horasTrabajadas, salarioBruto, impuestos, salarioNeto: real;
entradaUsuario: string;
esNumero: boolean;
i: integer;

const
TARIFA_NORMAL = 10; // Reemplaza con la tarifa normal adecuada

begin
repeat
esNumero := true;
Write('Ingrese el número de horas trabajadas: ');
ReadLn(entradaUsuario);

for i := 1 to Length(entradaUsuario) do
begin
if not (entradaUsuario[i] in ['0'..'9', '.']) then
begin
esNumero := false;
Break;
end;
end;

if esNumero then
begin

Val(entradaUsuario, horasTrabajadas);
if (horasTrabajadas <= 0) then
begin
esNumero := false;
Writeln('Error: Ingrese un número válido de horas (no negativo).');
end;
end
else
begin
Writeln('Error: Ingrese un número válido de horas.');
end;
until esNumero;

if horasTrabajadas <= 35 then
salarioBruto := horasTrabajadas * TARIFA_NORMAL
else
salarioBruto := 35 * TARIFA_NORMAL + (horasTrabajadas - 35) *
(TARIFA_NORMAL * 1.5);

if salarioBruto <= 50 then
impuestos := 0
else if salarioBruto <= 90 then
impuestos := (salarioBruto - 50) * 0.25
else
impuestos := 40 * 0.25 + (salarioBruto - 90) * 0.45;

salarioNeto := salarioBruto - impuestos;

Writeln('El salario neto semanal es: ', salarioNeto:0:2);
end.
