// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
// casa.wlk
object casa {
    var gastosMes = 0
    var cuentaGestion = cuentaCorriente
    var viveres = 0
    var reparacion =  0

    method reparacion(){
        return reparacion
    }

    method registrarReparacionNecesaria(monto){
        reparacion += monto
    }

    method realizarTodasLasReparaciones(){
        self.gastar(reparacion)
        reparacion = 0
    }

    method tieneViveresSuficientes(){
        return viveres >= 40
    }

    method hayQueHacerReparaciones(){
        return reparacion > 0
    }

    method estaEnOrden(){
        return !(self.hayQueHacerReparaciones()) && self.tieneViveresSuficientes()
    }
        
    // porcentajeAComprar debe ser un numero entero de 1 al 100
    method comprarViveres(porcentajeAComprar, calidad){
        self.validarPorcentajeViveres(porcentajeAComprar)
        self.gastar(self._calculoViveres(porcentajeAComprar, calidad))
        viveres += porcentajeAComprar
    }

    method _calculoViveres(porcentajeAComprar, calidad) {
      return porcentajeAComprar * calidad
    }

    method validarPorcentajeViveres(porcentajeAComprar) {
      if (porcentajeAComprar + self.viveres() > 100){
        self.error("porcentaje a comprar supera la capacidad maxima de almacenamiento")
      }
    }

    method viveres(){
        return viveres
    }

    method viveres(_viveres){
        viveres = _viveres
    }

    method gastar(monto){
        cuentaGestion.extraer(monto)
        gastosMes += monto
    }

    method gastos(){
        return gastosMes
    }

    method cuentaGestion(){
        return cuentaGestion
    }

    method cuentaGestion(_cuenta) {
        cuentaGestion = _cuenta
    }

    method cambiarElMes(){
        gastosMes = 0
    }
}

//Tipo cuenta

object cuentaCorriente {
    var saldo = 0

    method saldo(){
        return saldo
    }

    method extraer(monto){
        saldo = saldo - monto
    }

    method depositar(monto){
        saldo = saldo + monto
    }
}

object cuentaCorrienteClonTest { //al no tener intancias y necesitar numeros redondos para test, tuve que crear esto
    var saldo = 0

    method saldo(){
        return saldo
    }

    method extraer(monto){
        saldo = saldo - monto
    }

    method depositar(monto){
        saldo = saldo + monto
    }
}

object cuentaConGastos {
    var costoOperacion = 0
    var saldo = 0

    method costoOperacion(_costoOperacion){
        costoOperacion = _costoOperacion
    }

    method costoOperacion(){
        return costoOperacion
    }

    method saldo(){
        return saldo
    }

    method extraer(monto){
        saldo -= monto
    }

    method depositar(monto){
        self.validarDeposito(monto)
        saldo += self.calcularMontoReal(monto)
    }

    method validarDeposito(monto) {
        if (monto <= costoOperacion) {
            self.error("Monto menor o igual al costo de operación.")
        }
    }

    method calcularMontoReal(monto) {
        return monto - costoOperacion
    }
}


// ejercicio 2

object cuentaCombinada{
    var cuentaSecundaria = cuentaCorriente
    var cuentaPrimaria = cuentaCorrienteClonTest

    method cuentaPrimaria(_cuenta) {
      cuentaPrimaria = _cuenta
    }

    method cuentaSecundaria(_cuenta){
        cuentaSecundaria = _cuenta
    }

    method cuentaPrimaria() {
      return cuentaPrimaria
    }

    method cuentaSecundaria(){
        return cuentaSecundaria
    }

    method saldo(){
        return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo())
    }

    method extraer(monto){
        self.validarExtraccion(monto)
        if (monto <= cuentaPrimaria.saldo()){
            cuentaPrimaria.extraer(monto)
        } else {
            cuentaSecundaria.extraer(monto-cuentaPrimaria.saldo())
            cuentaPrimaria.extraer(cuentaPrimaria.saldo())
        }
    }

    method validarExtraccion(monto){
        if (monto > self.saldo()){
            self.error("Balance insufiente para esta extraccion")
        }
    }

    method depositar(monto){
        cuentaPrimaria.depositar(monto)
    }
}


//ejercicio 3

