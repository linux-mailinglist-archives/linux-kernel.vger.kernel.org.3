Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3C504789
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiDQKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiDQKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:19:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28825EBD;
        Sun, 17 Apr 2022 03:16:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bv19so22469381ejb.6;
        Sun, 17 Apr 2022 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UYe07PNBLRxCxCEqLuavnWGb3HlH32JJiMGy4PnwOPs=;
        b=Igd32dpxHGuHz7DJ9NDCGnBuicFC/j0mffzs5KXTgyyGMhh7dHGQQBWVt5Ps85GCwz
         u9sktDYRy0VYv4JGtNek8GoWYQsqJrxJNa2Mn4bDPlYGu5lbSr0Sq2ggZBoJRh/t02i5
         Zcvw3TrV1VgIpOM+l5k4bx1RI7twcsv5lfERonOQ62Cf1kKvUtp9GLN3h2mB9n0dUNyZ
         52J9yIy3PaqvmBr1e8UN1E8RNI+nLSEkxN8R3yeOT4MmwH1wBU03EJlWm//hNTTgEwZE
         gZKc3gHg3A75ZI8846z1zy3IqBfhT+2UY8or6nLJjSn91B9DVcWQlMNhTD1l4QZzpjTc
         BZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UYe07PNBLRxCxCEqLuavnWGb3HlH32JJiMGy4PnwOPs=;
        b=S6JQC00e+Je+UJCRXuERbVpl94ikLPb4s3Qa8IFi+BpZI9HDvGKzUIPFK5hmKYAPtA
         KG5MhdzbyG/Ptx9Uwh4B9r6Na2tbg5/+GgF0lahv8pzVoF5/Uvud7WRw6hMhUVEV5nuc
         nmuL8McnY0ecKOYVFL15Rj+ZSADdT3T+hh0xKQuptGY5KXz2BOIT3fGvlixu7p59VVUs
         6YOLW5PtSQiL4xERRgoUyRHeOnQ26kfTTWCFhIZ98RdwusHdl9LvsgQ/UckLcCVTGAv9
         nRvdDMYdefNNNhD95q8x6JE83qVx/PWznz+JKkGcS5zw4iV4Hq5Q4QazmqKpqiPA4vvA
         n+Hw==
X-Gm-Message-State: AOAM530K8P0feOATrujrS61qVABl5Xmvw6DFFiRqHdGwVI4UHO8f1PqT
        lXWHs6R1hzJWZCd811Q51nU=
X-Google-Smtp-Source: ABdhPJzUcAJBONWTtgEUtX3g8b7lNuV4fdBQU8XR18R2uPVolAoyW/iqw8EQB6po7+gMXP6k9alRIg==
X-Received: by 2002:a17:907:86ab:b0:6e8:d60e:d6c3 with SMTP id qa43-20020a17090786ab00b006e8d60ed6c3mr5251761ejc.346.1650190614594;
        Sun, 17 Apr 2022 03:16:54 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906408600b006e87d654270sm3437383ejj.44.2022.04.17.03.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 03:16:53 -0700 (PDT)
Message-ID: <f0f90430-fa90-129e-77bc-f5594206b76d@gmail.com>
Date:   Sun, 17 Apr 2022 13:16:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220416160040.7e0d6015@jic23-huawei>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <20220416160040.7e0d6015@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/22 18:00, Jonathan Cameron wrote:
> On Wed, 13 Apr 2022 12:40:09 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
>> AD4130-8 is an ultra-low power, high precision,
>> measurement solution for low bandwidth battery
>> operated applications.
>>
>> The fully integrated AFE (Analog Front-End)
>> includes a multiplexer for up to 16 single-ended
>> or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip
>> reference and oscillator, selectable filter
>> options, smart sequencer, sensor biasing and
>> excitation options, diagnostics, and a FIFO
>> buffer.
> 
> Hi Cosmin,
> 
> Please wrap at around 70-75 chars for patch descriptions.  That
> leaves a bit of room for indenting due to automated tooling
> / email threads before we hit 80 chars.  Definitely don't need
> 30 chars of room for it!
> 

Yeah, I'll do it.

> It seems you hit a lot of things that Rob's bot had found that
> you would have seen on doing a build test.  Please make sure
> you do one in future to save time!
> 

Yeah, sorry. I already fixed them for V2.

> Please use a cover letter for a series like this. It provides several
> advantages:
> 
> 1) Somewhere to add a brief introduction to the whole series.
> 2) Place for people to give tags for whole series that the b4 tool
>     I use to pick up patches can then automatically find them from.
> 3) Gives series a nice unified name in patchwork ;)
> https://patchwork.kernel.org/project/linux-iio/list/?series=631830
> 

Sure thing. I'll have it there for V2 anyway.

>>
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad4130.yaml          | 255 ++++++++++++++++++
>>   1 file changed, 255 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> new file mode 100644
>> index 000000000000..e9dce54e9802
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>> @@ -0,0 +1,255 @@
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
> What are the variants?   They look to possibly be package differences?
> + resolution differences.
> They definitely need some description here.
> It may make more sense to have one compatible and then some extra
> booleans to say what it supported.
>

Packaging + available interrupt pins + resolution. Is having extra
booleans to describe what is supported really the best approach?
It's not really about how the hardware is configured anymore, is it?
They're different chips.

> Long shot, but do the different packages have different model IDs?
> The datasheet says
> Model ID: 24-bit WLCSP Model ID. These bits are set by default for each model and
> are read only.  If there is one for each of these models then it would be
> better to have a single compatible and do the detection of variant in
> the driver.
> 
> I'm not immediately spotting the resolution information in the data sheet.
> It is marked Preliminary but if there are details missing, please mention
> in cover letter so we don't go looking for information that doesn't exist.
>

I don't have enough information about the other models to know what
Model IDs they will have. That's why I took this approach.

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
>> +    minItems: 1
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 1
>> +    description:
>> +      Default if not supplied is dout-int.
>> +    items:
>> +      enum:
>> +        - dout-int
>> +        - clk
>> +        - p1
> 
> This is unusual.  It is probably helpful to add more description to
> explain that the data ready/ fifo interrupt can be routed to any of these
> pins.

Is it unusual? ADIS16480 follows a similar approach.

description: |
   Specify which interrupt pin should be configured as Data Ready / FIFO
   interrupt.
   Default if not supplied is dout-int.

How does this sound?

> 
>> +        - dout
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
> 
> Whilst these are optional in theory, you should call out that they must be
> provided if any of the channels use them as a reference.
> 

I thought that "Can be used as reference for conversion." + it being an
option in adi,reference-select property would make it obvious, no?

>> +
>> +  iovdd-supply:
>> +    description: IOVDD voltage supply. Used for the chip interface.
>> +
>> +  spi-max-frequency:
>> +    maximum: 5000000
>> +
>> +  adi,mclk-sel:
>> +    description: |
>> +      Select the clock.
>> +      0: Internal 76.8kHz clock.
>> +      1: Internal 76.8kHz clock, output to the CLK pin.
>> +      2: External 76.8kHz clock.
>> +      3. External 153.6kHz clock.
> 
> For the external clocks, can we use the fact that one is supplied
> as enough to tell us we should be using them?  Then query the
> frequency directly from that clock?
> 

Aren't we supposed to set the frequency of that clock ourselves,
in the driver?

> If no clock provided then clearly internal.  All that is
> necessary after that is a boolean to control if the CLK output
> is enabled or not (and ideally constrain that to only be possible
> if in internal clock mode).
> 

Well...

So, mclk present => external, not present => internal.
adi,int-clk-out-enable to specify if the internal clock should be
exposed? adi,ext-clk-freq to specify the desired clock speed of the
external clk?

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    default: 0
>> +
>> +  adi,int-ref-en:
> 
> Mentioned below...
> 
>> +    description: |
>> +      Specify if internal reference should be enabled.
>> +    type: boolean
>> +    default: true
>> +
>> +  adi,bipolar:
>> +    description: Specify if the device should be used in bipolar mode.
>> +    type: boolean
>> +    default: false
>> +
>> +  adi,vbias-pins:
>> +    description: Analog inputs to apply a voltage bias of (AVDD − AVSS) / 2 to.
>> +    items:
>> +      minimum: 0
>> +      maximum: 15
> 
> If I read things correctly VBIAS_CONTROL is a bitmap across the 16 input lines.
> So why use a single value rather than either a list of pins, or a bitmap?
> 

Umm. Isn't this a list of pins? That's why everything is plural here.
I guess I should add `maxItems: 16`?
I already added `$ref: /schemas/types.yaml#/definitions/uint32-array`.

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
>> +          17: AVss
>> +          18: Internal reference.
>> +          19: DGND.
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
>> +        $ref: adc.yaml
>> +        items:
>> +          minimum: 0
>> +          maximum: 29
> 
> Interesting. So we have a part that has a 16 channel sequencer, but
> can you have more channels as long as you don't want them all at once?
> For example, I doubt anyone wants to permanently configure a device to monitor
> the various supplies, but they will want to occasionally.
> 
> As such, perhaps we need to treat this device more flexibly?
> There are obviously contraints on what channels + references make sense
> but maybe we should allow more than 16 to be specified?
> 

Ehhhhh. Look at the driver. It's already pushing 2k+ lines with
the 8 setups for 16 channels situation + all the extra options the
chip provides. If we also make it so that channels are rewritten at
runtime, it will turn into a mess. Or at least I don't see a clean
way of adding that. Besides, then I'd have to do all these extra
allocations depending on the number of channels in the device tree...
It gets complicated. If a customer expresses his interest in this,
I guess I'll have to add it.
Also, presumably the extra inputs are marketed as diagnostics.

>> +
>> +      adi,reference-select:
>> +        description: |
>> +          Select the reference source to use when converting on the
>> +          specific channel. Valid values are:
>> +          0: REFIN1(+)/REFIN1(−).
>> +          1: REFIN2(+)/REFIN2(−).
>> +          2: REFOUT/AVSS (Internal reference)
>> +          3: AVDD/AVSS
>> +          If not specified, internal reference is used.
> 
> That's not a good idea if it might be turned off...
> Perhaps a better approach would be to drop the int_ref_en and
> simply walk the channels to find out if any of them use it.
> If they don't turn it off, otherwise leave it on.
> 

Yeah, I guess I could do that.

>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        enum: [0, 1, 2, 3]
>> +        default: 2
>> +
>> +      adi,excitation-pin-0:
>> +        description: |
>> +          Analog input to apply excitation current to while the channel
>> +          is active.
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
>> +          /* AIN8, AIN9 */
>> +          diff-channels = <8 9>;
>> +        };
>> +
>> +        channel@1 {
>> +          reg = <1>;
>> +          /* AIN10, AIN11 */
>> +          diff-channels = <10 11>;
>> +        };
>> +
>> +        channel@2 {
>> +          reg = <2>;
>> +          /* Temperature Sensor, DGND */
>> +          diff-channels = <16 19>;
>> +        };
>> +
>> +        channel@3 {
>> +          reg = <3>;
>> +          /* Internal reference, DGND */
>> +          diff-channels = <18 19>;
>> +        };
>> +
>> +        channel@4 {
>> +          reg = <4>;
>> +          /* DGND, DGND */
>> +          diff-channels = <19 19>;
>> +        };
>> +      };
>> +    };
> 
