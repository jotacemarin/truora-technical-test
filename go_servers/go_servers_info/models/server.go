package models

// Server : struct
type Server struct {
	Domain   int    `json:"domain"`
	Address  string `json:"address"`
	SslGrade string `json:"ssl_grade"`
	Country  string `json:"country"`
	Owner    string `json:"owner"`
}
