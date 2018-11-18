#!/usr/bin/perl

print "Content-Type: text/html; charset=utf-8 \n\n";

#====================#
# USO DE DPENDENCIAS #
#====================# 

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

}
 
 sub form1 {
                
                #-------------------------------------------#
                # Asignacion de datos en la base de datos   #
                #-------------------------------------------#
                $redis -> set  ('telefono' => $FORM{telefono});
                $redis -> set  ('correo' => $FORM{correo});
                $redis -> set  ('direccion' => $FORM{direccion});
                #---------------------------------------------------------------------#
                # Variables que almacena el resultado optenido de la base de datos    #
                #---------------------------------------------------------------------#
                $telefono=$redis->get('telefono');
                $correo=$redis->get('correo');
                $direccion=$redis->get('direccion');
}             



#----------------------------------------------------------------------------------------------------------------------------------#
# Condicion que valora si el $ENV{'QUERY_STRING'} es nulo, sí esta condicion se cumple ejecuta el bloque y muestra un formulario   #
#----------------------------------------------------------------------------------------------------------------------------------#

if($ENV{'QUERY_STRING'} eq "") {
     
 print "<FORM name=\"Enviar\" method = \"GET\">";
 print "Usuario:  <input type = \"text\" name = \"usuario\">  <br>";
 print "Clave:   <input type = \"password\" name = \"clave\">";

 print "<input type=\"submit\" value=\"inicio\"> <br>";

 print "</FORM>";

}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# Condicion que valora si el $ENV{'QUERY_STRING'} contiene valores, sí esta condicion se cumple ejecuta el bloque y muestra un saludo con los datos del formulario   #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#

if($ENV{'QUERY_STRING'} ne "") {

    @arGet=split("=",$ENV{'QUERY_STRING'});
    if (@arGet[0] eq "usuario") {
        
        print "<h3>Hola complete el siguiente formulario</h3> \n";
        
        print "<FORM name=\"Enviar2\" method = \"GET\">";
        print "Telefono:  <input type = \"text\" name = \"telefono\">  <br>";
        print "Correo: <input type = \"email\" name = \"correo\">  <br>";
        print "Direccion: <input type = \"text\" name = \"direccion\">";
        
        print "<input type=\"submit\" value=\"Enviar\">";
        
        print "</FORM>";        

}
    &cortar;
    &form1;

}
         
    if ($correo ne "" || $direccion ne "" || $telefono ne "") {
   
    print "<h3>Ya sabemos que su telefono es $telefono su direcion es $direccion y su correo es $correo, Gracias </h3> \n";
       
    }

