package models

// Domain : struct
type Domain struct {
	ID              int64    `sql:",pk,unique,notnull"`
	Servers         []Server `json:"servers"`
	ServerChanged   bool     `json:"servers_changed"`
	SslGrade        string   `json:"ssl_grade"`
	PreviusSslGrade string   `json:"previus_ssl_grade"`
	Logo            string   `json:"logo"`
	Title           string   `json:"title"`
	IsDown          bool     `json:"is_down"`
}
