package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAddNum(t *testing.T) {
	t1, t2 := 3, 4
	r := AddNum(t1, t2)
	assert.Equal(t, 7, r, "should be returns 7")
}
