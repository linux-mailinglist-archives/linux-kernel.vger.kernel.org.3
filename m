Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AE25B1554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiIHHDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIHHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:03:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257CC2EA6;
        Thu,  8 Sep 2022 00:03:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nc14so35844860ejc.4;
        Thu, 08 Sep 2022 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=02XXAQ3uOpN3dH9E7JIiJKNVPEVhN/C9uK0JMwrUFlA=;
        b=MYA/7io0JQzjMRQAtwYV8HWCMQnKfxlmg0EizInlFB7c/Nr4aLdcByGIU1U8ApReR3
         5G5R2GdXTrhvbmwOWzojZA4M1JFSJ2oHXKtje6lgsgOqE3XKWNIwM3gvvDM/kRpziKL4
         kgz7DPXnTVwXKtoIPJq4ivVLMePbTbHaGbufqhTfTvfXa6Zav7f8azD6oHDiP1AW2PsE
         GagivQG0BFf4FJczzHdGktl7rLMJVrja9nfuUU6PQPvc99o9+OERpVtHPDrxo0j/ch4t
         YCQ5xHAqUQ3xvmtJAbdbApKaQqnFdQEaaVSJ5s5oC9cEw5ZGqNXGAUWKz70VZ7V4tfWd
         08gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=02XXAQ3uOpN3dH9E7JIiJKNVPEVhN/C9uK0JMwrUFlA=;
        b=TTw/T5789m0aMbKvbHNdgOciiXS+Sq4efGr4WRcosshdLXBaGy+F7CYj8WiOuDYgHN
         hD0EYsn/V/GJ2X17taPRgV45DHjBlgVquoG7Fu3uBIg10TUmdwXDLrd9oZ0LVzs2tAqj
         gBIVRbpO/R8sdtXJvdmi/HBuj79AJejO+TrEManTmw3TXktdBMtSll2ITgzoVR4muoM0
         wk7RyWOZ9zxXNKwikvvCV9p5njtD98K/f8iyrEjpT67BNwEXDqPCVOdEuRPYeNz/TPnV
         MRjjL0Ou5eHQUWUP3TWDHF6dKoK4AeIfQjUT8e+G3zDsKNcUtLQVOhYvHaQOUj7OWLop
         TDNg==
X-Gm-Message-State: ACgBeo1mIEq4bhCQA8BppC/BCDZFJxmf3DkS1ay59nCnT76negxzlNlk
        9f984vOQHQxZUzp9PBUWu/E=
X-Google-Smtp-Source: AA6agR4hR5ICYTsCtOG7Yrfqdg2H6b2VHaWBOqzPTMELn6zg+HYHpK5WxgNPyjX4AVmBCRue6yaNcg==
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id qa7-20020a170907868700b007307c7bb9cemr4973642ejc.656.1662620615982;
        Thu, 08 Sep 2022 00:03:35 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.116.38])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7d497000000b0044ec3285b23sm5255480edr.58.2022.09.08.00.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:03:35 -0700 (PDT)
Message-ID: <06476041-e8d6-7030-2f46-ace964c42513@gmail.com>
Date:   Thu, 8 Sep 2022 10:03:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: adc: add AD4130
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh@kernel.org>
References: <20220715044948.434149-1-cosmin.tanislav@analog.com>
 <20220715044948.434149-2-cosmin.tanislav@analog.com>
 <CACRpkdZVkXM-8DZjTaOxnS05Wz5GHon0sK1g7hDbz5SDJf9A=A@mail.gmail.com>
Content-Language: en-US
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CACRpkdZVkXM-8DZjTaOxnS05Wz5GHon0sK1g7hDbz5SDJf9A=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/22 16:14, Linus Walleij wrote:
> Hi Cosmin,
> 
> thanks for your patch!
> 
> On Fri, Jul 15, 2022 at 6:50 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
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
>> Reviewed-by: Rob Herring <robh@kernel.org>
> (...)
> 
> This caught my eye:
> 
>> +  adi,int-clk-out:
>> +    description: Specify if the internal clock should be exposed on the CLK pin.
>> +    type: boolean
> 
> Okay, but would it not make more sense to just imply this if the clock
> on the CLK
> pin has any consumers? Like update this setting in hardware when the consumer
> does clk_prepare() or so on that externally routed clock?
> 

You're right, this is indeed fit for being implemented using the clock
framework.

>> +  adi,ext-clk-freq-hz:
>> +    description: Specify the frequency of the external clock.
>> +    enum: [76800, 153600]
>> +    default: 76800
> 
> This looks like cheating, i.e just outputting a clock on that pin
> and ignoring to model the consumer.

You got this wrong.

The chip has 4 operating modes regarding clocking.

Internal 76.8kHz clock (clkout can be used as an interrupt pin).
Internal 76.8kHz clock, available externally on the clkout pin (clkout
becomes an output).
External 76.8kHz clock (clkout is an input).
External 153.6kHz clock, internally divided by two (clkout is an input).

This property is used to choose between what frequency to set the
external clock up with. Indeed, if the external clock is not present,
then exposing the 76.8kHz clock using the clock framework would be fine.

Maybe you have a better suggestion about what to do with this?
How do I tell the chip what frequency the external clock is, but also
tell the clock what frequency to use? It's a bit of a conundrum for me.

> 
> Shouldn't this rather be a clkout subnode with 2 #clock-cells
> and the fequency set in a cell in a consumer phandle?
> Like how I did in
> commit 7335631fcd5eecfa84555bd57433e6446d06ad21
> "dt-bindings: clock: u8500: Add clkout clock bindings"
> 
> Usually it is the consumer that requests a specific clock and then the
> producer will respond.
> 
> Certainly whatever is consuming this clock needs to be in the device tree
> as well, and then this is the right pattern.
> 
> (In Linux you will then use the clk framework to manage the clock and callbacks
> but that is irrelevant for the DT bindings.)
> 
>> +  adi,bipolar:
>> +    description: Specify if the device should be used in bipolar mode.
>> +    type: boolean
> 
> Can you explain what this means? I don't understand what it would
> mean for an analog device / AFE to be in bipolar mode.
> 

Range becomes [-VRef, VRef], as opposed to [0, VRef], resolution is
halved.

> Other than that it looks very nice!
> 
> Yours,
> Linus Walleij
