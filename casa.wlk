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
    const costoOperacion = 20
    var saldo = 0

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

