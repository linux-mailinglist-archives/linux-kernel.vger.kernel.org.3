Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40555E913
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbiF1Nrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346934AbiF1Nrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:47:37 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959512B19C;
        Tue, 28 Jun 2022 06:47:32 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id w10so8190721ilj.4;
        Tue, 28 Jun 2022 06:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mdgh0FPprIeUOtyoTIWGoo3tBFW6HponToZBl2Ks+E0=;
        b=CTGjnmXFi7rts7tjh7EY++EReSVsJ39YmGyhzCh1XthI94AqK6+y4fxrLYVetBQ9Hx
         74WCDBoaDq7q5hsO+T8m5Ig6Xr21/SuvQ/kI4lHloPWuDYq0zcoYPmq3nDQETwMkqAkV
         V4HX/SB1PUyJ03RSirpZcM7WPnpl3rXLAslpT58OOMZtmFJfB9JDmVdOObxNxhzdFAFO
         df82BQg+3buV28tra7q6B0ZEMClfBcsUJE89GiMxqfr47Vmmbb0kYvfB+K9SX/A9p0ei
         7NKWoXN6bJIfCwNz0L9R2kM+4Amke6CiVEn+dkLhwbrmM5RbNVMG8yyc3yEr+xPL4Skw
         qQOg==
X-Gm-Message-State: AJIora/+M1KXdDZONWnhvemGs64bHkYki+DJ7xRNSJug3t3YxvGYQx55
        nwBsQ4ii9lpJPFi7JPCIdw==
X-Google-Smtp-Source: AGRyM1u/CZtvwnAAV6atCWMAqxyoLlQtGmnMKkJs2jsP03c6Zbrl75e3i+mDqWJX/yWP0L1PbJ3Rpg==
X-Received: by 2002:a05:6e02:1d15:b0:2da:8628:fcc8 with SMTP id i21-20020a056e021d1500b002da8628fcc8mr8214290ila.49.1656424051706;
        Tue, 28 Jun 2022 06:47:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s10-20020a5ec64a000000b0067520155dedsm4736815ioo.15.2022.06.28.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:47:31 -0700 (PDT)
Received: (nullmailer pid 357097 invoked by uid 1000);
        Tue, 28 Jun 2022 13:47:28 -0000
Date:   Tue, 28 Jun 2022 07:47:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <20220628134728.GA349256-robh@kernel.org>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620162059.1097264-2-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 07:20:58PM +0300, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 259 ++++++++++++++++++
>  1 file changed, 259 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> new file mode 100644
> index 000000000000..b72f3da07309
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -0,0 +1,259 @@
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
> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4130
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
> +      Specify which interrupt pin should be configured as Data Ready / FIFO
> +      interrupt.
> +      Default if not supplied is int.
> +    enum:
> +      - int
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
> +    description: AVDD voltage supply. Can be used as reference for conversion.
> +
> +  iovdd-supply:
> +    description: IOVDD voltage supply. Used for the chip interface.
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  adi,int-clk-out:
> +    description: Specify if the internal clock should be exposed on the CLK pin.
> +    type: boolean
> +
> +  adi,ext-clk-freq-hz:
> +    description: Specify the frequency of the external clock.
> +    enum: [76800, 153600]
> +    default: 76800
> +
> +  adi,bipolar:
> +    description: Specify if the device should be used in bipolar mode.
> +    type: boolean
> +
> +  adi,vbias-pins:
> +    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
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

Normally, unit-addresses are in hex.

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        minimum: 0
> +        maximum: 15
> +
> +      diff-channels:
> +        description: |
> +          Besides the analog inputs available, internal inputs can be used.
> +          16: Internal temperature sensor.
> +          17: AVSS
> +          18: Internal reference
> +          19: DGND
> +          20: (AVDD − AVSS)/6+
> +          21: (AVDD − AVSS)/6-
> +          22: (IOVDD − DGND)/6+
> +          23: (IOVDD − DGND)/6-
> +          24: (ALDO − AVSS)/6+
> +          25: (ALDO − AVSS)/6-
> +          26: (DLDO − DGND)/6+
> +          27: (DLDO − DGND)/6-
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
> +          0: REFIN1(+)/REFIN1(−)
> +          1: REFIN2(+)/REFIN2(−)
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
> +      adi,excitation-current-0-nanoamp:

This needs a new unit suffix added to dtschema.

> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified in
> +          adi,excitation-pin-0 while this channel is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
> +        default: 0
> +
> +      adi,excitation-current-1-nanoamp:
> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified in
> +          adi,excitation-pin-1 while this channel is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
> +        default: 0
> +
> +      adi,burnout-current-nanoamp:
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +        compatible = "adi,ad4130";
> +        reg = <0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        spi-max-frequency = <5000000>;
> +        interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> +        interrupt-parent = <&gpio>;
> +
> +        channel@0 {
> +          reg = <0>;
> +
> +          adi,reference-select = <2>;
> +
> +          /* AIN8, AIN9 */
> +          diff-channels = <8 9>;
> +        };
> +
> +        channel@1 {
> +          reg = <1>;
> +
> +          adi,reference-select = <2>;
> +
> +          /* AIN10, AIN11 */
> +          diff-channels = <10 11>;
> +        };
> +
> +        channel@2 {
> +          reg = <2>;
> +
> +          adi,reference-select = <2>;
> +
> +          /* Temperature Sensor, DGND */
> +          diff-channels = <16 19>;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +
> +          adi,reference-select = <2>;
> +
> +          /* Internal reference, DGND */
> +          diff-channels = <18 19>;
> +        };
> +
> +        channel@4 {
> +          reg = <4>;
> +
> +          adi,reference-select = <2>;
> +
> +          /* DGND, DGND */
> +          diff-channels = <19 19>;
> +        };
> +      };
> +    };
> -- 
> 2.36.1
> 
> 
