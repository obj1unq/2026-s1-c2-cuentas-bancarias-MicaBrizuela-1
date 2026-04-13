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
        saldo -= monto
    }

    method despositar(monto){
        saldo += monto
    }
}

object cuentaConGastos {
    const costoOperacion = 200
    var saldo = 0

    method saldo(){
        return saldo
    }

    method extraer(monto){
        saldo -= monto
    }

    method despositar(monto){
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