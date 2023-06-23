<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function test_1_equal_to_1(): void
    {
        $this->assertEquals(1,1, 'It Works');
    }

    public function test_1_not_equal_to_2() : void
    {
        $this->assertNotEquals(1, 2, 'It Works');
    }
}
