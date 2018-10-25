#!/usr/bin/perl
print "Content-Type: text/html\n\n";

use Redis; #uso de la herramienta redis
$redis = new Redis;

sub cortar {
                #----------------------------------------------------------------------------#
                # Foreach que corta los parametors recogidos por el metodo GET y los procesa #
                #----------------------------------------------------------------------------# 

                 @pairs = split(/&/, $ENV{'QUERY_STRING'});
                 
                 foreach $pair (@pairs) {
                 ($name, $value) = split(/=/, $pair);
                 $value =~ tr/+/ /;
                 $value =~ s/%(..)/pack("C", hex($1))/eg;
                 $FORM{$name} = $value;
                }
                #-------------------------------------------#
                # Asignacion de datos en la base de datos   #
                #-------------------------------------------#
                $redis -> set  ('nombre' => $FORM{nombre});
                $redis -> set  ('apellido' => $FORM{apellido});
                #---------------------------------------------------------------------#
                # Variables que almacena el resultado optenido de la base de datos    #
                #---------------------------------------------------------------------#
                $nombre=$redis->get('nombre');
                $apellido=$redis->get('apellido');


}

#----------------------------------------------------------------------------------------------------------------------------------#
# Condicion que valora si el $ENV{'QUERY_STRING'} es nulo, sí esta condicion se cumple ejecuta el bloque y muestra un formulario   #
#----------------------------------------------------------------------------------------------------------------------------------#

if($ENV{'QUERY_STRING'} eq "") {
 print "<FORM name=\"Enviar\" method = \"GET\">";
 print "Nombre:  <input type = \"text\" name = \"nombre\">  <br>";
 print "Apellido: <input type = \"text\" name = \"apellido\">";

 print "<input type=\"submit\" value=\"Enviar\">";

 print "</FORM>";

}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# Condicion que valora si el $ENV{'QUERY_STRING'} contiene valores, sí esta condicion se cumple ejecuta el bloque y muestra un saludo con los datos del formulario   #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#

if($ENV{'QUERY_STRING'} ne "") {
  &cortar;
 
  print "<h3>Hola $nombre $apellido</h3>";
}


