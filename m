Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA694686A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385230AbhLDRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:42:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39290 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385211AbhLDRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:42:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345BCB80D39;
        Sat,  4 Dec 2021 17:38:57 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 26DFBC341C3;
        Sat,  4 Dec 2021 17:38:51 +0000 (UTC)
Date:   Sat, 4 Dec 2021 17:44:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: iio: add AD74413R
Message-ID: <20211204174401.464bf109@jic23-huawei>
In-Reply-To: <20211202232507.358113-3-cosmin.tanislav@analog.com>
References: <20211202232507.358113-1-cosmin.tanislav@analog.com>
        <20211202232507.358113-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Dec 2021 01:25:06 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The AD74412R and AD74413R are quad-channel, software configurable,
> input/output solutions for building and process control applications.
> 
> They contain functionality for analog output, analog input, digital input,
> resistance temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> 
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to
> provide four configurable input/output channels and a suite of diagnostic
> functions.
> 
> The AD74413R differentiates itself from the AD74412R by being
> HART-compatible.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

Some odd alignment in the header. Otherwise looks good to me.
Given I don't think anything much has changed, you should have
picked up Rob's tag from v7.  Please do so for v10 or call out why not in the change
log so Rob knows what to look at.

Thanks

Jonathan



> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 158 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
>  2 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> new file mode 100644
> index 000000000000..baa65a521bad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/addac/adi,ad74413r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD74412R/AD74413R device
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  The AD74412R and AD74413R are quad-channel software configurable input/output
> +  solutions for building and process control applications. They contain
> +  functionality for analog output, analog input, digital input, resistance
> +  temperature detector, and thermocouple measurements integrated
> +  into a single chip solution with an SPI interface.
> +  The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
> +  four configurable input/output channels and a suite of diagnostic functions.
> +  The AD74413R differentiates itself from the AD74412R by being HART-compatible.
> +    https://www.analog.com/en/products/ad74412r.html
> +    https://www.analog.com/en/products/ad74413r.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad74412r
> +      - adi,ad74413r
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpol: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  refin-supply: true
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt (sense) resistor value in micro-Ohms.
> +    default: 100000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpol
> +  - refin-supply
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    type: object
> +    description: Represents the external channels which are connected to the device.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> +        minimum: 0
> +        maximum: 3
> +
> +      adi,ch-func:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Channel function.
> +          HART functions are not supported on AD74412R.
> +          0 - CH_FUNC_HIGH_IMPEDANCE
> +          1 - CH_FUNC_VOLTAGE_OUTPUT
> +          2 - CH_FUNC_CURRENT_OUTPUT
> +          3 - CH_FUNC_VOLTAGE_INPUT
> +          4 - CH_FUNC_CURRENT_INPUT_EXT_POWER
> +          5 - CH_FUNC_CURRENT_INPUT_LOOP_POWER
> +          6 - CH_FUNC_RESISTANCE_INPUT
> +          7 - CH_FUNC_DIGITAL_INPUT_LOGIC
> +          8 - CH_FUNC_DIGITAL_INPUT_LOOP_POWER
> +          9 - CH_FUNC_CURRENT_INPUT_EXT_POWER_HART
> +          10 - CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
> +        minimum: 0
> +        maximum: 10
> +        default: 0
> +
> +      adi,gpo-comparator:
> +        type: boolean
> +        description: |
> +          Whether to configure GPO as a comparator or not.
> +          When not configured as a comparator, the GPO will be treated as an
> +          output-only GPIO.
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      cs-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> +      status = "okay";
> +
> +      ad74413r@0 {
> +        compatible = "adi,ad74413r";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        spi-cpol;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        interrupt-parent = <&gpio>;
> +        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
> +
> +        refin-supply = <&ad74413r_refin>;
> +
> +        channel@0 {
> +          reg = <0>;
> +
> +          adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +
> +          adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +
> +          adi,ch-func = <CH_FUNC_DIGITAL_INPUT_LOGIC>;
> +          adi,gpo-comparator;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +
> +          adi,ch-func = <CH_FUNC_CURRENT_INPUT_EXT_POWER>;
> +        };
> +      };
> +    };
> +...
> diff --git a/include/dt-bindings/iio/addac/adi,ad74413r.h b/include/dt-bindings/iio/addac/adi,ad74413r.h
> new file mode 100644
> index 000000000000..a43b010f974f
> --- /dev/null
> +++ b/include/dt-bindings/iio/addac/adi,ad74413r.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_ADI_AD74413R_H
> +#define _DT_BINDINGS_ADI_AD74413R_H
> +
> +#define CH_FUNC_HIGH_IMPEDANCE					0x0
> +#define CH_FUNC_VOLTAGE_OUTPUT					0x1
> +#define CH_FUNC_CURRENT_OUTPUT					0x2
> +#define CH_FUNC_VOLTAGE_INPUT					0x3

Something very odd going on with indenting in here. I can fix up whilst applying
if this is all that needs tidying up.

> +#define CH_FUNC_CURRENT_INPUT_EXT_POWER			0x4
> +#define CH_FUNC_CURRENT_INPUT_LOOP_POWER		0x5
> +#define CH_FUNC_RESISTANCE_INPUT				0x6
> +#define CH_FUNC_DIGITAL_INPUT_LOGIC				0x7
> +#define CH_FUNC_DIGITAL_INPUT_LOOP_POWER		0x8
> +#define CH_FUNC_CURRENT_INPUT_EXT_POWER_HART	0x9
> +#define CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART	0xA
> +
> +#define CH_FUNC_MIN		CH_FUNC_HIGH_IMPEDANCE
> +#define CH_FUNC_MAX		CH_FUNC_CURRENT_INPUT_LOOP_POWER_HART
> +
> +#endif /* _DT_BINDINGS_ADI_AD74413R_H */

