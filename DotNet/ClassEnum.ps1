class Fahrzeug
{
    [string]$Farbe
    [string]$Hersteller
    [int]$Sitzplätzle
}

class Auto : Fahrzeug
{
    [int]$Räder
    [string]$Modell
    [Antrieb]$Motor

    #Konstruktoren, werden ausgeführt beim Instanzieren der Klasse
    Auto()
    {#Dieser Konstrukt hat keine "Startwerte"

    }
    Auto([string]$Modell)
    {# Dieser Konstruktor übernimmt das Modell beim erstellen der Instanz
        $this.Modell = $Modell
    }
    Auto([string]$Modell,[int]$Räder)
    {# Dieser Konstruktor akzeptiert das Modell und die Räder beim erstellen der Instanz
        $this.Modell = $Modell
        $this.Räder = $Räder
    }

    #Hierbei handelt es sich um eine MEthode. Eine Methode innerhalb einer Klasse benötigt einen spezifizierten Rückgabewert,
    #ist kein Rückgabewert mögliche kann der "Typ" [void] verwendet werden
    [void]fahre([int]$strecke)
    {
        [string]$Fahrbahn = "🚗"
        for($i = 1; $i -lt $strecke; $i ++)
        {
            $Fahrbahn = "-" + $Fahrbahn
            Start-Sleep -Milliseconds 100
            Clear-Host                
            Write-Host -Object $Fahrbahn
        }
    }

    [string]ToString()
    {
        [string]$Ausgabe = "[ " + $this.Hersteller + " | " + $this.Modell + " ]"
        return $Ausgabe
    }
}

enum Antrieb
{
    Benzin
    Diesel
    Elektrisch
    Hybrid
    Wasserstoff
}

# $BMW = [Auto]::new()
# $BMW = [Auto]::new("F31")
$BMW = [Auto]::new("F31",4)
$BMW.Farbe = "Silber"
$BMW.Hersteller = "BMW"
$BMW.Sitzplätzle = 5
#$BMW.Räder = 4
#$BMW.Modell = "F31"

$BMW.Motor = [Antrieb]::Hybrid
$BMW

#$BMW.fahre(80)