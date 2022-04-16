Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDA503731
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiDPOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiDPOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1CEF65CC;
        Sat, 16 Apr 2022 07:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4F560F55;
        Sat, 16 Apr 2022 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E0C385A3;
        Sat, 16 Apr 2022 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650120763;
        bh=nKIlFWYcb/c8ZvM5IEnibM3/TcPGuytknDEtHsQHQNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZEgJBpu5JaqqxZ2kAhJW5asdPp9/lsR+yQiLD+YcY1w4OObcr+6yRYV6k3PxqgVRt
         BfH2JyV/fwwdkRTH/QOra85YJWUQtwyKo4JI7W1E0aUdPW+FktoZUIHUj9UM7N4J65
         FfWdj9z6oiQQmsPyL1bBis2qNRwYFFKdwpHFaXk6dYP5aKgOgCAPBSapAintO6io6R
         1jiQebPh8EtgRm+4InLvYCWe+iIbwotDsmenRuTDMnNEEhRddB9GfbtqzWOqab8zz1
         cP/d9X4fUp9GaRAqvvV+Ane32x5KjbArW80Ya5om6/VIfRHw5TI2y+YPtyQbAzgjVP
         GC+6tP4IXZA6A==
Date:   Sat, 16 Apr 2022 16:00:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
Message-ID: <20220416160040.7e0d6015@jic23-huawei>
In-Reply-To: <20220413094011.185269-1-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:40:09 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
>=20
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.

Hi Cosmin,

Please wrap at around 70-75 chars for patch descriptions.  That
leaves a bit of room for indenting due to automated tooling
/ email threads before we hit 80 chars.  Definitely don't need
30 chars of room for it!

It seems you hit a lot of things that Rob's bot had found that
you would have seen on doing a build test.  Please make sure
you do one in future to save time!

Please use a cover letter for a series like this. It provides several
advantages:

1) Somewhere to add a brief introduction to the whole series.
2) Place for people to give tags for whole series that the b4 tool
   I use to pick up patches can then automatically find them from.
3) Gives series a nice unified name in patchwork ;)
https://patchwork.kernel.org/project/linux-iio/list/?series=3D631830

>=20
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 255 ++++++++++++++++++
>  1 file changed, 255 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> new file mode 100644
> index 000000000000..e9dce54e9802
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -0,0 +1,255 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4130 ADC device driver
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found her=
e:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4130-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4130-8-16-lfcsp
> +      - adi,ad4130-8-16-wlcsp
> +      - adi,ad4130-8-24-lfcsp
> +      - adi,ad4130-8-24-wlcsp

What are the variants?   They look to possibly be package differences?
+ resolution differences.
They definitely need some description here.
It may make more sense to have one compatible and then some extra
booleans to say what it supported.

Long shot, but do the different packages have different model IDs?
The datasheet says
Model ID: 24-bit WLCSP Model ID. These bits are set by default for each mod=
el and
are read only.  If there is one for each of these models then it would be
better to have a single compatible and do the detection of variant in
the driver.

I'm not immediately spotting the resolution information in the data sheet.
It is marked Preliminary but if there are details missing, please mention
in cover letter so we don't go looking for information that doesn't exist.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the master clock (mclk)
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 1
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 1
> +    description:
> +      Default if not supplied is dout-int.
> +    items:
> +      enum:
> +        - dout-int
> +        - clk
> +        - p1

This is unusual.  It is probably helpful to add more description to
explain that the data ready/ fifo interrupt can be routed to any of these
pins.

> +        - dout
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  refin1-supply:
> +    description: refin1 supply. Can be used as reference for conversion.
> +
> +  refin2-supply:
> +    description: refin2 supply. Can be used as reference for conversion.
> +
> +  avdd-supply:
> +    description: AVDD voltage supply. Can be used as reference for conve=
rsion.

Whilst these are optional in theory, you should call out that they must be
provided if any of the channels use them as a reference.

> +
> +  iovdd-supply:
> +    description: IOVDD voltage supply. Used for the chip interface.
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  adi,mclk-sel:
> +    description: |
> +      Select the clock.
> +      0: Internal 76.8kHz clock.
> +      1: Internal 76.8kHz clock, output to the CLK pin.
> +      2: External 76.8kHz clock.
> +      3. External 153.6kHz clock.

For the external clocks, can we use the fact that one is supplied
as enough to tell us we should be using them?  Then query the
frequency directly from that clock?

If no clock provided then clearly internal.  All that is
necessary after that is a boolean to control if the CLK output
is enabled or not (and ideally constrain that to only be possible
if in internal clock mode).

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +  adi,int-ref-en:

Mentioned below...

> +    description: |
> +      Specify if internal reference should be enabled.
> +    type: boolean
> +    default: true
> +
> +  adi,bipolar:
> +    description: Specify if the device should be used in bipolar mode.
> +    type: boolean
> +    default: false
> +
> +  adi,vbias-pins:
> +    description: Analog inputs to apply a voltage bias of (AVDD =E2=88=
=92 AVSS) / 2 to.
> +    items:
> +      minimum: 0
> +      maximum: 15

If I read things correctly VBIAS_CONTROL is a bitmap across the 16 input li=
nes.
So why use a single value rather than either a list of pins, or a bitmap?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +patternProperties:
> +  "^channel@([0-9]|1[0-5])$":
> +    type: object
> +    $ref: adc.yaml
> +
> +    properties:
> +      reg:
> +        description: |
> +          The channel number.
> +        items:
> +          minimum: 0
> +          maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          Besides the analog inputs available, internal inputs can be us=
ed.
> +          16: Internal temperature sensor.
> +          17: AVss
> +          18: Internal reference.
> +          19: DGND.
> +          20: (AVDD =E2=88=92 AVSS)/6+
> +          21: (AVDD =E2=88=92 AVSS)/6-
> +          22: (IOVDD =E2=88=92 DGND)/6+
> +          23: (IOVDD =E2=88=92 DGND)/6-
> +          24: (ALDO =E2=88=92 AVSS)/6+
> +          25: (ALDO =E2=88=92 AVSS)/6-
> +          26: (DLDO =E2=88=92 DGND)/6+
> +          27: (DLDO =E2=88=92 DGND)/6-
> +          28: V_MV_P
> +          29: V_MV_M
> +        $ref: adc.yaml
> +        items:
> +          minimum: 0
> +          maximum: 29

Interesting. So we have a part that has a 16 channel sequencer, but
can you have more channels as long as you don't want them all at once?
For example, I doubt anyone wants to permanently configure a device to moni=
tor
the various supplies, but they will want to occasionally.

As such, perhaps we need to treat this device more flexibly?
There are obviously contraints on what channels + references make sense
but maybe we should allow more than 16 to be specified?

> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the
> +          specific channel. Valid values are:
> +          0: REFIN1(+)/REFIN1(=E2=88=92).
> +          1: REFIN2(+)/REFIN2(=E2=88=92).
> +          2: REFOUT/AVSS (Internal reference)
> +          3: AVDD/AVSS
> +          If not specified, internal reference is used.

That's not a good idea if it might be turned off...
Perhaps a better approach would be to drop the int_ref_en and
simply walk the channels to find out if any of them use it.
If they don't turn it off, otherwise leave it on.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +        default: 2
> +
> +      adi,excitation-pin-0:
> +        description: |
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        minimum: 0
> +        maximum: 15
> +        default: 0
> +
> +      adi,excitation-pin-1:
> +        description: |
> +          Analog input to apply excitation current to while this channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 15
> +        default: 0
> +
> +      adi,excitation-current-0-nanoamps:
> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified =
in
> +          adi,excitation-pin-0 while this channel is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
> +        default: 0
> +
> +      adi,excitation-current-1-nanoamps:
> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified =
in
> +          adi,excitation-pin-1 while this channel is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
> +        default: 0
> +
> +      adi,burnout-current-nanoamps:
> +        description: |
> +          Burnout current in nanoamps to be applied for this channel.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 500, 2000, 4000]
> +        default: 0
> +
> +      adi,buffered-positive:
> +        description: Enable buffered mode for positive input.
> +        type: boolean
> +
> +      adi,buffered-negative:
> +        description: Enable buffered mode for negative input.
> +        type: boolean
> +
> +    required:
> +      - reg
> +      - diff-channels
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "adi,ad4130-8-24-wlcsp";
> +        reg =3D <0>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        spi-max-frequency =3D <5000000>;
> +        interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-parent =3D <&gpio>;
> +
> +        channel@0 {
> +          reg =3D <0>;
> +          /* AIN8, AIN9 */
> +          diff-channels =3D <8 9>;
> +        };
> +
> +        channel@1 {
> +          reg =3D <1>;
> +          /* AIN10, AIN11 */
> +          diff-channels =3D <10 11>;
> +        };
> +
> +        channel@2 {
> +          reg =3D <2>;
> +          /* Temperature Sensor, DGND */
> +          diff-channels =3D <16 19>;
> +        };
> +
> +        channel@3 {
> +          reg =3D <3>;
> +          /* Internal reference, DGND */
> +          diff-channels =3D <18 19>;
> +        };
> +
> +        channel@4 {
> +          reg =3D <4>;
> +          /* DGND, DGND */
> +          diff-channels =3D <19 19>;
> +        };
> +      };
> +    };

