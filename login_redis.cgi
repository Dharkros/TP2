#!/usr/bin/perl

#use utf8; #Soluciona problemas de acentos
use CGI; #Usa modulo CGI
$query = new CGI;
use Redis; #uso de la herramienta redis
$redis = new Redis;



#Link a GITHUB: https://github.com/Dharkros/hello_user_redis.pl/blob/master/hello_user_redis.pl

#============================================================================================================================================#
# NUEVA VERSION LA ANTIGUA ESTA DEBAJO DE ESTE CODIGO (EL ANTIGUO NO FUNCIONA (NO SE PORQUE NO FUNCIONA EL RESULTADO DEL SEGUNDO FORMULARIO) #
#============================================================================================================================================# 

print $query->header("text/html;charset=UTF-8");
#print $query->header(-type=>'UTF-8');
print $query->start_html('hello_user_redis');


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

if(!$query->param) {
	print $query->start_form(-method => 'GET');
	print $query->b('Usuario '),$query->textfield(-name=>'usuario',-value=>'usuario',-size=>15);
	print $query->br;
	print $query->b('Clave '),$query->password_field(-name=>'clave',-size=>15);
    print $query->submit(-name=>'Inicio',-value=>'ok');
    print $query->end_form;
print $query->br;


}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# Condicion que valora si el $ENV{'QUERY_STRING'} contiene valores, sí esta condicion se cumple ejecuta el bloque y muestra un saludo con los datos del formulario   #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#

if ($query->param('Inicio') eq "ok") {
	print $query->h3('Hola complete el siguiente formulario');
	print $query->br;
	print $query->start_form(-method  => 'GET');
	print $query->b('Telefono '),$query->textfield(-name=>'telefono',-size=>15);
	print $query->br;
	print $query->b('Correo '),$query->textfield(-name=>'correo',-size=>15);
	print $query->br;
	print $query->b('Direccion '),$query->textfield(-name=>'direccion',-size=>15);
    print $query->submit(-name=>'Enviar');
    print $query->end_form;
	print $query->br;

   
}
    &cortar;
    &form1;
         
 if ($correo ne "" || $direccion ne "" || $telefono ne "") {
   
 print "<h3>Ya sabemos que su telefono es $telefono su direcion es $direccion y su correo es $correo, Gracias </h3> \n";
       
 }
