Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6755E91F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbiF1Oax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbiF1Oav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:30:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4D3136F;
        Tue, 28 Jun 2022 07:30:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e40so17887002eda.2;
        Tue, 28 Jun 2022 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wUmuU1T09Y9A7wJ/J6R3aOq/9g1vAxt3wiOwowyk32c=;
        b=WL9Be7wsuM6t0JWMLBW0mha0F1hsUgW+2hy8OM5Q3KlB5vxly6XWqUrEvwYo7fwP4+
         OaQ/Gin6wKfcgj0mB9L81ZJQok7yWF4d60/lN6a483Rwmiap+wKjMA8uuv9zv3k6DO9r
         Z1x3lfBTEFL3N62wFuF6siz4RZhB96KopeTu8FKWBfYs/KJRIiufcHgsVSq/Jf8FvMcW
         mjXykhk8eqVkvgDc2v9EcXL5Lm18dv1Okwa2EoHSRL62PxHRNzCruV2OSLcN6qe7eDIC
         EUsO5gOLB8Z38vUPQXZv6WRXQPSFXigHuVgL9vFI+zSVL3PBz4cJy4ptKzRx7jI3GO3l
         XvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wUmuU1T09Y9A7wJ/J6R3aOq/9g1vAxt3wiOwowyk32c=;
        b=m43r3qstrXe5gLWJMYLibLt8Yx0UKGrsUNgK7ZaysItOsZkenMsQw/Jm63/F2WBt4M
         TZYrJWo8GnI/L/qzkCmM7a1D+IVVaUAqdPCpozmJayqQ7t7Jq2tDjj5pK3MGcfQW7RUa
         Yl1qWGRH+TITsVHhRUxHnqufGNcOvlcAV7yF3KSHGjOrtlm8o2T5XXTU1xzIvQaKgqN7
         9hlGSIKWumnEJvoqik99HNK2gyyCh5bSdGacrBaKvkCdky6v9SvCRitXoKE90wwzSLGM
         cm6sJsJSjG93WYoP6s+vm+iwIDdeMW3bhlH0JHFI0xQsF6iX5zNaZ24ZjJPi+nKaXjlL
         5Lwg==
X-Gm-Message-State: AJIora8cV7ZeKsCbKd5VvC6mGl43WoSRGTLnkTfLbRZuOWDb+07zmlwA
        coRwj8ozkr+ReLjGSPl0Ka147oMDb20=
X-Google-Smtp-Source: AGRyM1vY+endgF5kxPnRW8FK3DKzgLMxl5A3d0KiNMsMLC5/gf1LnaxDOOgyTe6ASwvKcUheuGkHQQ==
X-Received: by 2002:a05:6402:50c7:b0:435:923b:9b23 with SMTP id h7-20020a05640250c700b00435923b9b23mr24188285edb.336.1656426648713;
        Tue, 28 Jun 2022 07:30:48 -0700 (PDT)
Received: from [192.168.0.182] ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id b15-20020a50e38f000000b0042dc8dd59c7sm9775482edm.51.2022.06.28.07.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 07:30:48 -0700 (PDT)
Message-ID: <93ae6c3c-bfa8-115f-8062-2bb1b923eaf3@gmail.com>
Date:   Tue, 28 Jun 2022 17:30:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-2-cosmin.tanislav@analog.com>
 <20220628134728.GA349256-robh@kernel.org>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220628134728.GA349256-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/22 16:47, Rob Herring wrote:
> On Mon, Jun 20, 2022 at 07:20:58PM +0300, Cosmin Tanislav wrote:
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 259 ++++++++++++++++++
>>   1 file changed, 259 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> new file mode 100644
>> index 000000000000..b72f3da07309
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> @@ -0,0 +1,259 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2022 Analog Devices Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices AD4130 ADC device driver
>> +
>> +maintainers:
>> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
>> +
>> +description: |
>> +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ad4130
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: phandle to the master clock (mclk)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: mclk
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    description: |
>> +      Specify which interrupt pin should be configured as Data Ready / FIFO
>> +      interrupt.
>> +      Default if not supplied is int.
>> +    enum:
>> +      - int
>> +      - clk
>> +      - p2
>> +      - dout
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  refin1-supply:
>> +    description: refin1 supply. Can be used as reference for conversion.
>> +
>> +  refin2-supply:
>> +    description: refin2 supply. Can be used as reference for conversion.
>> +
>> +  avdd-supply:
>> +    description: AVDD voltage supply. Can be used as reference for conversion.
>> +
>> +  iovdd-supply:
>> +    description: IOVDD voltage supply. Used for the chip interface.
>> +
>> +  spi-max-frequency:
>> +    maximum: 5000000
>> +
>> +  adi,int-clk-out:
>> +    description: Specify if the internal clock should be exposed on the CLK pin.
>> +    type: boolean
>> +
>> +  adi,ext-clk-freq-hz:
>> +    description: Specify the frequency of the external clock.
>> +    enum: [76800, 153600]
>> +    default: 76800
>> +
>> +  adi,bipolar:
>> +    description: Specify if the device should be used in bipolar mode.
>> +    type: boolean
>> +
>> +  adi,vbias-pins:
>> +    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 16
>> +    items:
>> +      minimum: 0
>> +      maximum: 15
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +patternProperties:
>> +  "^channel@([0-9]|1[0-5])$":
> 
> Normally, unit-addresses are in hex.


Righhhht. Sorry about that.

There are other offenders from us too.

❯ rg -F "^channel@([0-9]|1[0-5])\$"
Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
49:  "^channel@([0-9]|1[0-5])$":

Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
65:  "^channel@([0-9]|1[0-5])$":

Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
73:  "^channel@([0-9]|1[0-5])$":

> 
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel number.
>> +        minimum: 0
>> +        maximum: 15
>> +
>> +      diff-channels:
>> +        description: |
>> +          Besides the analog inputs available, internal inputs can be used.
>> +          16: Internal temperature sensor.
>> +          17: AVSS
>> +          18: Internal reference
>> +          19: DGND
>> +          20: (AVDD − AVSS)/6+
>> +          21: (AVDD − AVSS)/6-
>> +          22: (IOVDD − DGND)/6+
>> +          23: (IOVDD − DGND)/6-
>> +          24: (ALDO − AVSS)/6+
>> +          25: (ALDO − AVSS)/6-
>> +          26: (DLDO − DGND)/6+
>> +          27: (DLDO − DGND)/6-
>> +          28: V_MV_P
>> +          29: V_MV_M
>> +        items:
>> +          minimum: 0
>> +          maximum: 29
>> +
>> +      adi,reference-select:
>> +        description: |
>> +          Select the reference source to use when converting on the
>> +          specific channel. Valid values are:
>> +          0: REFIN1(+)/REFIN1(−)
>> +          1: REFIN2(+)/REFIN2(−)
>> +          2: REFOUT/AVSS (Internal reference)
>> +          3: AVDD/AVSS
>> +          If not specified, REFIN1 is used.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 1, 2, 3]
>> +        default: 0
>> +
>> +      adi,excitation-pin-0:
>> +        description: |
>> +          Analog input to apply excitation current to while the channel
>> +          is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 15
>> +        default: 0
>> +
>> +      adi,excitation-pin-1:
>> +        description: |
>> +          Analog input to apply excitation current to while this channel
>> +          is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 0
>> +        maximum: 15
>> +        default: 0
>> +
>> +      adi,excitation-current-0-nanoamp:
> 
> This needs a new unit suffix added to dtschema.
> 
>> +        description: |
>> +          Excitation current in nanoamps to be applied to pin specified in
>> +          adi,excitation-pin-0 while this channel is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
>> +        default: 0
>> +
>> +      adi,excitation-current-1-nanoamp:
>> +        description: |
>> +          Excitation current in nanoamps to be applied to pin specified in
>> +          adi,excitation-pin-1 while this channel is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
>> +        default: 0
>> +
>> +      adi,burnout-current-nanoamp:
>> +        description: |
>> +          Burnout current in nanoamps to be applied for this channel.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 500, 2000, 4000]
>> +        default: 0
>> +
>> +      adi,buffered-positive:
>> +        description: Enable buffered mode for positive input.
>> +        type: boolean
>> +
>> +      adi,buffered-negative:
>> +        description: Enable buffered mode for negative input.
>> +        type: boolean
>> +
>> +    required:
>> +      - reg
>> +      - diff-channels
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    spi {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      adc@0 {
>> +        compatible = "adi,ad4130";
>> +        reg = <0>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        spi-max-frequency = <5000000>;
>> +        interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>> +        interrupt-parent = <&gpio>;
>> +
>> +        channel@0 {
>> +          reg = <0>;
>> +
>> +          adi,reference-select = <2>;
>> +
>> +          /* AIN8, AIN9 */
>> +          diff-channels = <8 9>;
>> +        };
>> +
>> +        channel@1 {
>> +          reg = <1>;
>> +
>> +          adi,reference-select = <2>;
>> +
>> +          /* AIN10, AIN11 */
>> +          diff-channels = <10 11>;
>> +        };
>> +
>> +        channel@2 {
>> +          reg = <2>;
>> +
>> +          adi,reference-select = <2>;
>> +
>> +          /* Temperature Sensor, DGND */
>> +          diff-channels = <16 19>;
>> +        };
>> +
>> +        channel@3 {
>> +          reg = <3>;
>> +
>> +          adi,reference-select = <2>;
>> +
>> +          /* Internal reference, DGND */
>> +          diff-channels = <18 19>;
>> +        };
>> +
>> +        channel@4 {
>> +          reg = <4>;
>> +
>> +          adi,reference-select = <2>;
>> +
>> +          /* DGND, DGND */
>> +          diff-channels = <19 19>;
>> +        };
>> +      };
>> +    };
>> -- 
>> 2.36.1
>>
>>
