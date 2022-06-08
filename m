Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D6542AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiFHJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiFHJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:10:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69733A3B;
        Wed,  8 Jun 2022 01:31:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so39979671eja.8;
        Wed, 08 Jun 2022 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=05Ze3w1gBUGg1JCmvF8rRzp+ctrPAl3NkBFWLSeQ24U=;
        b=baATDqfpfOzA5hCGslKv0amuCE4OEixmu00pLYI0MXoefT4arqenwxxjf/F3p8h77j
         IFsHzj+wT82Jl3/LFj7nqj9MqhvTbONf02ixYJcuyA1SS6C0j855eEyU8M4xprUkpTum
         uGY05NhvlZpx9Bmz260u1+50NUVFtvioOydpxYlRoHQXbBRk0vFFdewNtnMXlTDDE0j1
         KTzDKDWg83iaoMbHSpT8DJJtcBDqEy6yrAVnMSMBYZynEpXq0QkY4O3jM+e01ahkPuSC
         fLx0WRl2VQu/v078EAQfMyfHsWX77fYFMzLYWXlfP11cbmWDVSVj4UOk4snGMWaW9/Pl
         vVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=05Ze3w1gBUGg1JCmvF8rRzp+ctrPAl3NkBFWLSeQ24U=;
        b=gD6f8o/vNi8HB7EKf0ds4PFil0b+Oxlc1tuvB5oAIs4EgcvS2vXUDhn7ReZf6JdkwB
         yuonzy8A7jk58WMyTvNr+qJ2MkmTZztLyAVJ9pp4R3bHpmZYwwTooS10GidUsw9FHzia
         20JSj616Qe07o2tdUBKpuQDb/UaJ+2MiCCnToKIXg3/ZEDNKOYR6JCYhQzFLQRh28jsa
         xH90si5unDBqsWbwCfxPYe2goaUSWziy4M3edoSvr+eU+HqjutNlQV5s9nxYL3hzJ4PN
         WHkFaezvDbxeDo8BG0HwGwB30lyC8m16uANSpz00m+9tybLB3lzf7fV3zPkYZe7koz7Y
         zmeg==
X-Gm-Message-State: AOAM533Fb4Pojjq9OsYB9UpslaVwHyZVu2INYN0ypHkUwrhh/c3TJk/H
        7uH93+LX1nelryyK0bQZw0A=
X-Google-Smtp-Source: ABdhPJysrBVnztJ6h0FMq3PJy3ta7yFoNeenpRKOUyjER30umtjmp1zfqrsPea7D/ZIKw2XFO2YRUA==
X-Received: by 2002:a17:906:2cc8:b0:6fd:d8d8:b8f3 with SMTP id r8-20020a1709062cc800b006fdd8d8b8f3mr30721334ejr.384.1654677102016;
        Wed, 08 Jun 2022 01:31:42 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.112.100])
        by smtp.gmail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm5756616edx.81.2022.06.08.01.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:31:41 -0700 (PDT)
Message-ID: <67390b8c-c7d3-15d0-afcd-3b3356058624@gmail.com>
Date:   Wed, 8 Jun 2022 11:31:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-2-cosmin.tanislav@analog.com>
 <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/22 03:37, Rob Herring wrote:
> On Tue, Apr 19, 2022 at 06:08:27PM +0300, Cosmin Tanislav wrote:
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
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
>>   1 file changed, 264 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> new file mode 100644
>> index 000000000000..32996b62cd20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> @@ -0,0 +1,264 @@
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
>> +      - adi,ad4130-8-16-lfcsp
>> +      - adi,ad4130-8-16-wlcsp
>> +      - adi,ad4130-8-24-lfcsp
>> +      - adi,ad4130-8-24-wlcsp
> 
> What is lfcsp? wlcsp seems to be the package type which generally
> shouldn't be part of the compatible.
> 
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
> 
> Don't need '|' if there is no formatting to preserve.
> 
>> +      Specify which interrupt pin should be configured as Data Ready / FIFO
>> +      interrupt.
>> +      Default if not supplied is dout-int.
> 
>         default: dout-int
> 

By the way. interrupt-names cannot have a default value.

Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml:
properties:interrupt-names: Additional properties are not allowed
('default' was unexpected)
from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

>> +    enum:
>> +      - dout-int
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
>> +  adi,ext-clk-freq:
>> +    description: Specify the frequency of the external clock.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
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
>> +    type: object
>> +    $ref: adc.yaml
> 
>         unevaluatedProperties: false
> 
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          The channel number.
>> +        items:
>> +          minimum: 0
>> +          maximum: 15
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
>> +      adi,excitation-current-0-nanoamps:
>> +        description: |
>> +          Excitation current in nanoamps to be applied to pin specified in
>> +          adi,excitation-pin-0 while this channel is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
>> +        default: 0
>> +
>> +      adi,excitation-current-1-nanoamps:
>> +        description: |
>> +          Excitation current in nanoamps to be applied to pin specified in
>> +          adi,excitation-pin-1 while this channel is active.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 100, 10000, 20000, 50000, 100000, 150000, 200000]
>> +        default: 0
>> +
>> +      adi,burnout-current-nanoamps:
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
>> +        compatible = "adi,ad4130-8-24-wlcsp";
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
>> 2.35.3
>>
>>
