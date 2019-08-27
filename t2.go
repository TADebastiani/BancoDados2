package main

import (
    "fmt"
    "log"
    
    _ "github.com/lib/pq"
    "github.com/jmoiron/sqlx"
)

var schema = `
CREATE TABLE IF NOT EXISTS person (
    first_name text not null,
    last_name text,
    email text
)`

type Person struct {
    FirstName string `db:"first_name"`
    LastName  string `db:"last_name"`
    Email     string
}

func main() {
    
    db, err := sqlx.Connect("postgres", "user=tiago dbname=golang sslmode=disable")
    if err != nil {
        log.Fatalln(err)
    }

    db.MustExec(schema)
    
    db.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "Jason", "Moiron", "jmoiron@jmoiron.net")

    tx := db.MustBegin()
    tx.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "John", "Doe", "johndoeDNE@gmail.net")
    tx.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "Jane", "Citizen", "jane.citzen@example.com")
    tx.Commit()

    tx = db.MustBegin()
    tx.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "JoÃO", "CICLANO", "joao@ciclano.net")
    tx.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "MARIA", "CICLANO", "maria@ciclano.net")
    tx.Rollback()

    tx = db.MustBegin()
    // tx.MustExec("INSERT INTO person (last_name, email) VALUES ($1, $2)", "CICLANO", "ze@ciclano.net")
    tx.Commit()

    person := Person{}
    rowsP, err := db.Queryx("SELECT * FROM person")
    for rowsP.Next() {
        err := rowsP.StructScan(&person)
        if err != nil {
            log.Fatalln(err)
        } 
        fmt.Printf("%#v\n", person)
    }
    fmt.Println();
}