package main

import (
	"fmt"
	"os"
	"sort"
	"strings"
)

const (
	groupLen   = 5
	offSeq     = groupLen     // +5
	offLength  = groupLen + 1 // +6
	offPayload = groupLen + 2 // +7
	headerLen  = groupLen + 2
)

type packet struct {
	group   string
	offset  int
	seq     byte
	payload string
}

func groupKey(name string) string {

	var b strings.Builder

	for _, r := range strings.ToLower(name) {

		switch r {
		case 'á':
			r = 'a'
		case 'é':
			r = 'e'
		case 'í':
			r = 'i'
		case 'ó':
			r = 'o'
		case 'ú':
			r = 'u'
		case 'ñ':
			r = 'n'
		}

		b.WriteRune(r)

		if b.Len() >= groupLen {
			break
		}
	}

	return b.String()
}

func searchPackages(frames []byte, target string) []int {

	offsets := []int{}
	n := len(target)

	for i := 0; i+n <= len(frames); i++ {

		if string(frames[i:i+n]) == target {

			offsets = append(offsets, i)
		}
	}

	return offsets
}

func readPacket(frames []byte, offset int, group string) (packet, error) {

	if offset+headerLen > len(frames) {

		return packet{}, fmt.Errorf("header incompleto en el offset %d", offset)
	}

	length := int(frames[offset+offLength])
	start := offset + offPayload
	end := start + length

	if end > len(frames) {

		return packet{}, fmt.Errorf(
			"payload truncado en el offset %d: LENGTH dice %d bytes y quedan %d",
			offset, length, len(frames)-start)
	}

	return packet{
		group:   group,
		offset:  offset,
		seq:     frames[offset+offSeq],
		payload: string(frames[start:end]),
	}, nil
}

func searchPayloads(groupsNames []string, frames []byte) ([]packet, []string) {

	packets := []packet{}
	missing := []string{}

	for _, name := range groupsNames {

		offsets := searchPackages(frames, groupKey(name))

		if len(offsets) == 0 {

			missing = append(missing, name)
			continue
		}

		for _, offset := range offsets {

			p, err := readPacket(frames, offset, name)

			if err != nil {

				fmt.Fprintf(os.Stderr, "%s: %v\n", name, err)
				continue
			}

			packets = append(packets, p)
		}
	}

	return packets, missing
}

func printable(s string) bool {

	for i := 0; i < len(s); i++ {

		if s[i] < 32 || s[i] > 126 {

			return false
		}
	}

	return true
}

func main() {

	// Lista de la planilla compartida: 24 grupos.
	// "Bitless" no tiene ninguna trama en frames.bin y falta el grupo de la
	// trama con SEQ 6, cuya etiqueta en el archivo es "ferne".
	//
	// groupsNames := []string{
	// 	"#hiddenSSID",
	// 	"Auracast",
	// 	"Bitless",
	// 	"ClickByte",
	// 	"Death Net",
	// 	"Grupo",
	// 	"LA LA LAN",
	// 	"LAN-gustia",
	// 	"Los Red(ondos)",
	// 	"Los simuLANdores",
	// 	"Los-Tios-Networks",
	// 	"Lost-Pointer-2.4",
	// 	"MACac OS",
	// 	"MiLANesas",
	// 	"NetRunners",
	// 	"Ping Floyd",
	// 	"Red Hot Chilli Packets",
	// 	"TCPánico",
	// 	"WAN-direction",
	// 	"WireGuardians",
	// 	"PandaBasic",
	// 	"Group Not Found :(",
	// 	"BitBros",
	// 	"Los_CondIPcionales",
	// }

	// Grupos que realmente tienen trama en frames.bin (25 tramas: NetRunners
	// aporta la 18 y la 19).
	groupsNames := []string{
		"#hiddenSSID",
		"Auracast",
		"BitBros",
		"ClickByte",
		"Death Net",
		"ferne", // grupo sin nombre en la planilla, solo se conoce su etiqueta
		"Group Not Found :(",
		"Grupo",
		"LA LA LAN",
		"LAN-gustia",
		"Los Red(ondos)",
		"Los simuLANdores",
		"Los_CondIPcionales",
		"Los-Tios-Networks",
		"Lost-Pointer-2.4",
		"MACac OS",
		"MiLANesas",
		"NetRunners",
		"PandaBasic",
		"Ping Floyd",
		"Red Hot Chilli Packets",
		"TCPánico",
		"WAN-direction",
		"WireGuardians",
	}

	frames, err := os.ReadFile("frames.bin")

	if err != nil {

		fmt.Fprintf(os.Stderr, "Hubo un error al abrir el archivo frames.bin: %v\n", err)
		os.Exit(1)
	}

	packets, missing := searchPayloads(groupsNames, frames)

	fmt.Printf("%-24s %-8s %8s %5s %6s  %s\n", "GRUPO", "GROUP", "OFFSET", "SEQ", "LENGTH", "PAYLOAD")

	for _, p := range packets {

		fmt.Printf("%-24s %-8q %8d %5d %6d  %q\n",
			p.group, groupKey(p.group), p.offset, p.seq, len(p.payload), p.payload)
	}

	if len(missing) > 0 {

		fmt.Printf("\nSin trama en frames.bin: %v\n", missing)
	}

	sort.SliceStable(packets, func(i, j int) bool { return packets[i].seq < packets[j].seq })

	var message strings.Builder
	seen := map[byte]packet{}
	maxSeq := byte(0)

	for _, p := range packets {

		if !printable(p.payload) {

			fmt.Fprintf(os.Stderr, "aviso: %s (SEQ %d) tiene un payload no imprimible, se descarta\n",
				p.group, p.seq)
			continue
		}

		if before, dup := seen[p.seq]; dup {

			fmt.Fprintf(os.Stderr, "aviso: SEQ %d repetido entre %s (%q) y %s (%q)\n",
				p.seq, before.group, before.payload, p.group, p.payload)
		}

		seen[p.seq] = p

		if p.seq > maxSeq {
			maxSeq = p.seq
		}

		message.WriteString(p.payload)
	}

	for seq := byte(1); seq < maxSeq; seq++ {

		if _, ok := seen[seq]; !ok {

			fmt.Fprintf(os.Stderr, "aviso: falta la trama con SEQ %d\n", seq)
		}
	}

	fmt.Println(message.String())
}
