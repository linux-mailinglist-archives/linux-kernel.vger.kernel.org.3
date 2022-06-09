Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B630054561D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiFIVDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiFIVDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:03:47 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783F262E26;
        Thu,  9 Jun 2022 14:03:45 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id s23so23415547iog.13;
        Thu, 09 Jun 2022 14:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=by5YGyM5nsaylmOby7JhCd7PCoLNClphswYb2YEfmPA=;
        b=JcHo7DFKSc+vBsBMDHYP8dtzX/dtKr4uIeukyNz61grSQjft/1PkGkFwcWdSYPbflw
         +uNqJ0haB2Ubl9PuqHpAll4FC/ekjkukGwuIIMM6D0bJeimPO4xGKL9t3nPppRj4iZ4d
         Sf6/ynIkb/4G+DxU46cObmg36xhlaTcmowZmXtRCQB9GqnufasSp1u2CTzCrxVbaXkJi
         3WdeAZD3fFHIk+RgaE+hwV3Ir3nLRRxv6/wS5j4gc9zOgbN8o8TQq0a09jiSb9X1alpS
         8iI7C2wyNvaprnh2inJD9R+d58pMSBB3xuPem539egROjjG9QXfa/8WubJpYMjXPUx49
         XXMg==
X-Gm-Message-State: AOAM5308sTJUIasKwKOs4IIKVCBi3OzVZV3E0TFRW1YTe32T2Jh71b+d
        BeVvd43sZEmhV2S+DzOQfw==
X-Google-Smtp-Source: ABdhPJwjT3380Kgb8o+b69IUX4+LvhmbE+YFqpieIN7LxiPYOz6isdPECyCGg9l3L78euSlkKwj8yQ==
X-Received: by 2002:a05:6638:2722:b0:331:f878:e38b with SMTP id m34-20020a056638272200b00331f878e38bmr4382954jav.272.1654808624689;
        Thu, 09 Jun 2022 14:03:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e0212c600b002cde6e352c2sm10856542ilm.12.2022.06.09.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:03:44 -0700 (PDT)
Received: (nullmailer pid 95138 invoked by uid 1000);
        Thu, 09 Jun 2022 21:03:42 -0000
Date:   Thu, 9 Jun 2022 15:03:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <20220609210342.GA84096-robh@kernel.org>
References: <20220608091238.403897-1-cosmin.tanislav@analog.com>
 <20220608091238.403897-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608091238.403897-2-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:12:37PM +0300, Cosmin Tanislav wrote:
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
>  .../bindings/iio/adc/adi,ad4130.yaml          | 262 ++++++++++++++++++
>  1 file changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> new file mode 100644
> index 000000000000..c06b8a96d31e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -0,0 +1,262 @@
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

       default: int

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
> +  adi,ext-clk-freq:
> +    description: Specify the frequency of the external clock.
> +    $ref: /schemas/types.yaml#/definitions/uint32

-hz suffix and drop the type.

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
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: |

Don't need '|'.

> +          The channel number.
> +        items:
> +          minimum: 0
> +          maximum: 15

This allows for more than 1 channel to be listed in reg. Is that intent? 
If not, drop 'items'. If so and there a valid range, then add 
minItems/maxItems.

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
> +      adi,excitation-current-0-nanoamps:

Prior property was 'adi,excitation-current-nanoamp'. Please match 
'-nanoamp'.

> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified in
> +          adi,excitation-pin-0 while this channel is active.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
> +        default: 0
> +
> +      adi,excitation-current-1-nanoamps:
> +        description: |
> +          Excitation current in nanoamps to be applied to pin specified in
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
