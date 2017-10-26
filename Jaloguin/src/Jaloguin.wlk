//A. Sustos - D. Alimentacion

class Nene{
	var actitud
	var elementos = []
	var caramelos
	var estadoDeSalud = estadoSano
	constructor(valorActitud,listaElementos,caramelosBase){
		actitud = valorActitud
		elementos = listaElementos
		caramelos = caramelosBase
	}
	method capacidadSusto(){
		return elementos.sum({elemento => elemento.susto()})*actitud
	}
	method sumarCaramelos(caramelosASumar){
		caramelos += caramelosASumar
	}
	method caramelosARestar(caramelosARestar){
		caramelos -= caramelosARestar
	}
	method caramelosEnPosesion(){
		return caramelos
	}
	method elementosEnPosesion(){
		return elementos
	}
	method comerCaramelos(caramelosAComer){
		estadoDeSalud.comerCaramelos(self,caramelosAComer)
	}
	method cambiarEstado(nuevoEstado){
		estadoDeSalud = nuevoEstado
	}
	method modificarActitud(nuevaActitud){
		actitud = nuevaActitud
	}
	method actitud(){
		return actitud
	}
	method estadoActual(){
		return estadoDeSalud
	}
}

object maquillaje{
	var susto
	method susto(){
		return susto
	}
	method moficiarSusto(valor){
		susto = valor
	}
}

class TrajeTierno{
	method susto(){
		return 2
	}
}

class TrajeTerrorifico{
	method susto(){
		return 5
	}
}

class Adulto{
	var sustosConMasDe15 = 0
	var tolerancia = 10*sustosConMasDe15
	method modificarTolerancia(){
		tolerancia = 10*sustosConMasDe15
	}
	method seAsusta(nene){
		if(tolerancia < nene.capacidadSusto()){
			nene.sumarCaramelos(tolerancia/2)
			if(nene.caramelosEnPosesion()>15){
			sustosConMasDe15 += 1
			self.modificarTolerancia()}
			return true
		}
		else{
			if(nene.caramelosEnPosesion()>15){
			sustosConMasDe15 += 1
			self.modificarTolerancia()}
			return false
		}
	}
	
	method tolerancia(){
		return tolerancia
	}
}

class Abuelo inherits Adulto{
	override method seAsusta(nene){
		if(tolerancia < nene.capacidadSusto()){
			nene.sumarCaramelos(tolerancia/4)
			if(nene.caramelosEnPosesion()>15){
			sustosConMasDe15 += 1
			self.modificarTolerancia()}
			return true
		}
		else{
			if(nene.caramelosEnPosesion()>15){
			sustosConMasDe15 += 1
			self.modificarTolerancia()}
			return false
		}
	}
}

class Necio inherits Adulto{
	override method seAsusta(nene){
		return false
	}
}

//E. Indigestion (Bonus)
object estadoSano{
	method comerCaramelos(nene,caramelosAComer){
		if(caramelosAComer<=nene.caramelosEnPosesion()){
			nene.caramelosARestar(caramelosAComer) 
			
			if(caramelosAComer>=10){
			nene.cambiarEstado(estadoEmpachado)
			nene.modificarActitud(nene.actitud()/2)
			
			}
		}
		
		else{
			error.throwWithMessage("No tiene tantos caramelos para Comer!!")
		}
	}
}
object estadoEmpachado{
	method comerCaramelos(nene,caramelosAComer){
		if(caramelosAComer<=nene.caramelosEnPosesion()){
			nene.caramelosARestar(caramelosAComer) 
			
			if(caramelosAComer>=10){
			nene.cambiarEstado(estadoEnCama)
			nene.modificarActitud(0)
		}
		}
		
		else{
			error.throwWithMessage("No tiene tantos caramelos para Comer!!")
		}
	}
}
object estadoEnCama{
	method comerCaramelos(nene,caramelosAComer){
			error.throwWithMessage("No tiene tantos caramelos para Comer!!")
	}
}

//B.Legiones

class Legion{
	var miembros
	constructor(listaMiembros){
		if(listaMiembros.size() >= 2){
		miembros = listaMiembros}
		else{
			error.throwWithMessage("La Legion debe tener al menos 2 integrantes!!")
		}
	}
	method capacidadSusto(){
		return miembros.sum({miembro => miembro.capacidadSusto()})
	}
	method caramelosEnPosesion(){
		return miembros.sum({miembro => miembro.caramelosEnPosesion()})
	}
	method liderLegion(){
		return miembros.max({miembro => miembro.capacidadSusto()})
	}
	method sumarCaramelos(caramelosASumar){
		var lider = self.liderLegion()
		lider.sumarCaramelos(caramelosASumar)
	}
}

//D. Estadisticas Barriales

class Barrio{
	var integrantes
	constructor(listaIntegrantes){
		integrantes = listaIntegrantes
	}
	method los3ConMasCaramelos(){
		return integrantes.sortedBy({nene1, nene2 => nene1.caramelosEnPosesion() > nene2.caramelosEnPosesion()}).take(3) 
	}
	method elementosUsados(){
		var integrantesConMasDe10Caramelos
		integrantesConMasDe10Caramelos = integrantes.filter({nene => (nene.caramelosEnPosesion() > 10)})
		
		integrantesConMasDe10Caramelos = integrantesConMasDe10Caramelos.flatMap({nene => nene.elementosEnPosesion()})
		return integrantesConMasDe10Caramelos.asSet()
	}
}

