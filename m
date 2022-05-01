Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646BF516513
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbiEAQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiEAQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:05:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB13EF30;
        Sun,  1 May 2022 09:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 763B4B80E3D;
        Sun,  1 May 2022 16:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA12C385AA;
        Sun,  1 May 2022 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651420893;
        bh=VLJEHa16TVc+vX5edi/ofAzdG45hQazjw0LxPffBsaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NCqDKpOX8UCo8nQpJo3HVwc0eJ8YRt6NMMKqBSnvYfM04a4stpMftg/X9VHLtrkEJ
         4hhNReWJdNwxcHVRJsM4XbTVM76GJlMM0EdfB+a+Xk78eZwLqx0otD2y6++9hsiwfC
         LshhvUBmGFUnslt7d+dnaj43gPzYIsPYepK39y7EWu6usca2ZLJcWAg3CnSJnC0WrI
         FpI5WLSf5gszr8dedufo7B+es2RfLwnekCcS2p0dtX/WBKtFpGJ12LlqSFO0xCP+75
         Glwa5OGZEYLQ7SITKRA/+W+gmcRxoi35BB3QpgytuGYEigBf/jLAepckx3Q/SRdtWQ
         R7Be8MLh3HP+A==
Date:   Sun, 1 May 2022 17:09:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <20220501170906.02281a82@jic23-huawei>
In-Reply-To: <20220419150828.191933-2-cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
        <20220419150828.191933-2-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 18:08:27 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>=20
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Hi Cosmin,

A few things inline to add to fixing the lack of detail Rob highlighted.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
>  1 file changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> new file mode 100644
> index 000000000000..32996b62cd20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -0,0 +1,264 @@
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
> +    maxItems: 1
> +
> +  interrupt-names:
> +    description: |
> +      Specify which interrupt pin should be configured as Data Ready / F=
IFO
> +      interrupt.
> +      Default if not supplied is dout-int.
> +    enum:
> +      - dout-int
> +      - clk
> +      - p2
> +      - dout
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
> +
> +  iovdd-supply:
> +    description: IOVDD voltage supply. Used for the chip interface.
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  adi,int-clk-out:
> +    description: Specify if the internal clock should be exposed on the =
CLK pin.
> +    type: boolean
> +
> +  adi,ext-clk-freq:
> +    description: Specify the frequency of the external clock.

Units?  Even better if we can map this to one of the standard unit types and
include the unit in the name.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [76800, 153600]
> +    default: 76800
> +
> +  adi,bipolar:
> +    description: Specify if the device should be used in bipolar mode.
> +    type: boolean
> +
> +  adi,vbias-pins:
> +    description: Analog inputs to apply a voltage bias of (AVDD =E2=88=
=92 AVSS) / 2 to.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 16
> +    items:
> +      minimum: 0
> +      maximum: 15
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

This isn't used explicitly in the driver. I'm wondering
if perhaps it should be rather than using the order in which the
child nodes are found...

The driver would then need to cope with potential holes however
(or just reject a binding where they occur?).=20

> +        items:
> +          minimum: 0
> +          maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          Besides the analog inputs available, internal inputs can be us=
ed.
> +          16: Internal temperature sensor.
> +          17: AVSS
> +          18: Internal reference
> +          19: DGND
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
> +        items:
> +          minimum: 0
> +          maximum: 29
> +
> +      adi,reference-select:
> +        description: |
> +          Select the reference source to use when converting on the
> +          specific channel. Valid values are:
> +          0: REFIN1(+)/REFIN1(=E2=88=92)
> +          1: REFIN2(+)/REFIN2(=E2=88=92)
> +          2: REFOUT/AVSS (Internal reference)
> +          3: AVDD/AVSS
> +          If not specified, REFIN1 is used.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +
> +      adi,excitation-pin-0:
> +        description: |
> +          Analog input to apply excitation current to while the channel
> +          is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
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
> +
> +          adi,reference-select =3D <2>;
> +
> +          /* AIN8, AIN9 */
> +          diff-channels =3D <8 9>;
> +        };
> +
> +        channel@1 {
> +          reg =3D <1>;
> +
> +          adi,reference-select =3D <2>;
> +
> +          /* AIN10, AIN11 */
> +          diff-channels =3D <10 11>;
> +        };
> +
> +        channel@2 {
> +          reg =3D <2>;
> +
> +          adi,reference-select =3D <2>;
> +
> +          /* Temperature Sensor, DGND */
> +          diff-channels =3D <16 19>;
> +        };
> +
> +        channel@3 {
> +          reg =3D <3>;
> +
> +          adi,reference-select =3D <2>;
> +
> +          /* Internal reference, DGND */
> +          diff-channels =3D <18 19>;
> +        };
> +
> +        channel@4 {
> +          reg =3D <4>;
> +
> +          adi,reference-select =3D <2>;
> +
> +          /* DGND, DGND */
> +          diff-channels =3D <19 19>;
> +        };
> +      };
> +    };

