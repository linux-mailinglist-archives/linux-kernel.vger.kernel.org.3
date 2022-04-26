Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83050EDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiDZAk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiDZAkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:40:23 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CA54579B;
        Mon, 25 Apr 2022 17:37:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id u17-20020a9d4d91000000b00605a73abac1so3996715otk.7;
        Mon, 25 Apr 2022 17:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lK+eIk1pRtY5GikN3iWfniyadAU39HFHNcjIw4NQ/6g=;
        b=Lw8i5P8orJNxY+qHhpz2i1VkKUeUhowhsMrvB2oZpX9BPRGKMipAmn50A+rCJXaThV
         Le6Ne6k7u9Cci4r/r4QfYjW502q1GBSdsjjHVk+j2LPg6y1ebNq9HkDDR99cG5MiScLl
         iAAif9qUwFBmkXJKc8The1wZdh6icBTdYSQ4jn8eohHdINHUK2UN34r+3W4tNnixLaQF
         0fOsK2RnMiDZH311aSN52Vu7VxhIWw1U699NOIA3z5xSgF0dDGRcDwKbxvsQBW2jgb5Q
         LJMkByDyRzgWtBv6qcUD8G4yOPOrKNDf22NHcwSYbyxzNpP+Myw17pk0J/fiMyuPu7Px
         /ZEA==
X-Gm-Message-State: AOAM533XsLT+GPwCxtcj7CaWGZAsnIAr9w1DzpzBjrhbJpZuhih0+RQ4
        P361mkuJfvhD1Nm7mMq39A==
X-Google-Smtp-Source: ABdhPJyBk7ikJpYLxe9p5mtk1adbzHY3MMut8ywboltTmLhn5jcIyQQlHjrhHDsqiz1kscFyhdaaaQ==
X-Received: by 2002:a05:6830:18cf:b0:605:5075:c26a with SMTP id v15-20020a05683018cf00b006055075c26amr7549485ote.260.1650933435500;
        Mon, 25 Apr 2022 17:37:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a3-20020a9d5c83000000b006054c7ecfb6sm4385923oti.34.2022.04.25.17.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:37:15 -0700 (PDT)
Received: (nullmailer pid 628165 invoked by uid 1000);
        Tue, 26 Apr 2022 00:37:14 -0000
Date:   Mon, 25 Apr 2022 19:37:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419150828.191933-2-cosmin.tanislav@analog.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 06:08:27PM +0300, Cosmin Tanislav wrote:
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
>  .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
>  1 file changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
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
> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4130-8-16-lfcsp
> +      - adi,ad4130-8-16-wlcsp
> +      - adi,ad4130-8-24-lfcsp
> +      - adi,ad4130-8-24-wlcsp

What is lfcsp? wlcsp seems to be the package type which generally 
shouldn't be part of the compatible.

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

Don't need '|' if there is no formatting to preserve.

> +      Specify which interrupt pin should be configured as Data Ready / FIFO
> +      interrupt.
> +      Default if not supplied is dout-int.

       default: dout-int

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

       unevaluatedProperties: false

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
> +        compatible = "adi,ad4130-8-24-wlcsp";
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
> 2.35.3
> 
> 
