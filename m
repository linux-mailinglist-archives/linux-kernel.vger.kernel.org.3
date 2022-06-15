Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD754C8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347966AbiFOMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbiFOMnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:43:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F92F3AB;
        Wed, 15 Jun 2022 05:43:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so15919143edj.11;
        Wed, 15 Jun 2022 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GTvJGCJYQZvQ3rU+CccADUrm/b7qxrSE+8Z1G9IV6HQ=;
        b=iA8FaiZJtOY2UdVuXU7LEjeYdutcp3cXPtf8nq2DD4qJk154kCJ69KR9RyuOf6QKu4
         +K7rtMX7+TCGNy+qbGfFmmJntOAte59PlNZe7P4I2RBVsYEvLB57Ci1UaX86ClVImHSC
         BQhosFyQCdWAtWYYqiuBZLYJ31t3qwLf3tTYSVuwSFCL+p47RQq64u5K1HAQqFXcC9uw
         ajHqcqB3Uhfees0U71jiTNuCAfq38oP6jBy0lGKEk5A+edOtatISgAR+QWHqlm3haMsk
         tRr2spoNg6MzgNDMexqx7IIJgjAwzcMyIbV9AGCytoXwXHDhlHEoTTeFstHv+3dm52Kq
         zcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GTvJGCJYQZvQ3rU+CccADUrm/b7qxrSE+8Z1G9IV6HQ=;
        b=PSzn3rGPpygwkszrDBN4OCD3PqBLC2VxiH/kjFkUU1pdFKws85KJf31pjR+LO1dkk3
         uXK5oAeo1A8Q/G5WjlWpFtIn7GnCOQZAl84jKLgtr2zkkb/gLnSiu6Ijc+f2izqato4f
         3mDJSioFWd2Uf18dpx8idh/mONgSbSTZIVfeub4ZIC/Dps7ntShdAYUyymWMjcL+8/et
         B9HOF96m5X2+YfRtHeSFmtqXJGmLdhXixxyvjFWI9rQRSOw3JNxN0syXU4q8I8v8PtVT
         S7auv2wsVAwt9qCEpxUzYzLhYzl0x6o6kXOoMQsFBLF+g4WMllO8AqeDDKIA2MNw/69H
         eSHQ==
X-Gm-Message-State: AOAM531gc6fL5Qhh6YoYPcKK79Aj3Rd5EKSnSfXHr8xOJ82lNG7O0d1J
        Y1ODJ64XZzxZ1Zi24mEW3qM=
X-Google-Smtp-Source: ABdhPJyT8cM5cExqx5Z6GWj+iGpnlkatPQK7juFYKEAD9SBg+l2k6N65ctF820Z4/OcbKMf8nl2TVQ==
X-Received: by 2002:a05:6402:5193:b0:42e:2569:652c with SMTP id q19-20020a056402519300b0042e2569652cmr12442370edd.73.1655297001302;
        Wed, 15 Jun 2022 05:43:21 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.99.129])
        by smtp.gmail.com with ESMTPSA id yz15-20020a170906dc4f00b0070ad296e4b0sm6260538ejb.186.2022.06.15.05.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:43:20 -0700 (PDT)
Message-ID: <bbba32e8-4106-57f1-3065-bf646e16bcfe@gmail.com>
Date:   Wed, 15 Jun 2022 15:43:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220608091238.403897-1-cosmin.tanislav@analog.com>
 <20220608091238.403897-2-cosmin.tanislav@analog.com>
 <20220609210342.GA84096-robh@kernel.org>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220609210342.GA84096-robh@kernel.org>
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



On 6/10/22 00:03, Rob Herring wrote:
> On Wed, Jun 08, 2022 at 12:12:37PM +0300, Cosmin Tanislav wrote:
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
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 262 ++++++++++++++++++
>>   1 file changed, 262 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> new file mode 100644
>> index 000000000000..c06b8a96d31e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> @@ -0,0 +1,262 @@
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
> 
>         default: int

Violates string array schema. I'm pretty sure I've said this before.

> 
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
>> +  adi,ext-clk-freq:
>> +    description: Specify the frequency of the external clock.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> -hz suffix and drop the type.
> 
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
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        description: |
> 
> Don't need '|'.
> 
>> +          The channel number.
>> +        items:
>> +          minimum: 0
>> +          maximum: 15
> 
> This allows for more than 1 channel to be listed in reg. Is that intent?
> If not, drop 'items'. If so and there a valid range, then add
> minItems/maxItems.
> 
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
> 
> Prior property was 'adi,excitation-current-nanoamp'. Please match
> '-nanoamp'.
> 
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
