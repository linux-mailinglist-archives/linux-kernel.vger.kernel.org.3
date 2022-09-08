Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D195B1B61
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIHL1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:27:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4880ACA29
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:27:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so27139114lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=324YOR1PCE5dxnfUe+4PTVGnNqdGB/dqbwqSI126RKw=;
        b=HIusbxjg7mCcRMNTgl0EfDiXnbFO00WdSVelUTAXDKbB9M5VKM2G7r/Y0jcCya2mGn
         qqiEjhbH3WXJhKGAAdbGEDWQzqRT08EOT9Y6L/Q98mJUC15uAGWuS93vD8NOO6BvZMPJ
         NDcp7XF6ja02fuZmDA8r18s6bQp4NvQ2Moy09fL74N9GmPrAyS75u8Yj8jOHP44KTswx
         4OKI8yTCEMk0Vh+uXSFWyYvN/pY9OBkywbmf9lPGN0VPBzSyrOJeWDDbV3zf1om7k1tM
         8gRb/kqno9r0qRbXNDnsgINZS7UvJ1mjIYK+eJ070Hb9ulejj2x0lahnZon/trepLJhT
         YxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=324YOR1PCE5dxnfUe+4PTVGnNqdGB/dqbwqSI126RKw=;
        b=apMXItseC+GHqVi1KRVZ4nEo9NyJIS+oFt8hiM3vDtbPbPxncd5Bv8YaugFUSVBFC3
         XE1QJD0ThWkzX7cHPedc+sMnY8UWJPrm6oQP0Or3wVuuh3LSB1HGWlRS4CylTC3X7al2
         xspWMlWkp/JLVZSiu2xGL9ubvN5B1f29C6znmeuTDUjDJ34JSZHEw+/tp62pyQPnwmRP
         DSeiVlUyr7Fhp8QdaCtXQL8vaNEcOTiq17P9ohv80agtT/VzBz6wny3WQ0sEk7bIJ1Jc
         6QBjQccIlb7cr71xeJ82QnqpK27dek6hfH3LtexsqcbZIWA2mNqiPKybbZwqh3fYqA3B
         et+w==
X-Gm-Message-State: ACgBeo2ieH5Nt8ebpKXsDAJz1rXx8pxCtYaP4SjmdNY2+VQnpnuf1bbN
        hWKX5aple//gJI6YD9UjKMf2CkjSrru05w==
X-Google-Smtp-Source: AA6agR46Zf2WKBxWQRhQ7sD8FP2Zo1esjq2RpMjqXiPjsdcreHxsvLc6q0MI2ehXSwhtMy+lHbbb6Q==
X-Received: by 2002:a05:6512:2307:b0:494:6afd:7b2 with SMTP id o7-20020a056512230700b004946afd07b2mr2713816lfu.559.1662636459128;
        Thu, 08 Sep 2022 04:27:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c14-20020a056512324e00b00491734dcb89sm2989667lfr.196.2022.09.08.04.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:27:38 -0700 (PDT)
Message-ID: <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
Date:   Thu, 8 Sep 2022 13:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
 <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 22:37, Larson, Bradley wrote:
> On 9/1/22 12:20 AM, Krzysztof Kozlowski wrote:
>> On 01/09/2022 02:01, Larson, Bradley wrote:
>>>>> +  is implemented by a sub-device reset-controller which accesses
>>>>> +  a CS0 control register.
>>>>> +
>>>>> +maintainers:
>>>>> +  - Brad Larson <blarson@amd.com>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - amd,pensando-elbasr
>>>>> +
>>>>> +  spi-max-frequency:
>>>>> +    description: Maximum SPI frequency of the device in Hz.
>>>> No need for generic descriptions of common properties.
>>> Changed to "spi-max-frequency: true" and moved to end of properties.
>> Then you should rather reference spi-peripheral-props just like other
>> SPI devices.
> 
> 
> Will look at this dependent on the result of below
> 
> 
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  '#address-cells':
>>>>> +    const: 1
>>>>> +
>>>>> +  '#size-cells':
>>>>> +    const: 0
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - spi-max-frequency
>>>>> +
>>>>> +patternProperties:
>>>>> +  '^reset-controller@[a-f0-9]+$':
>>>>> +    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +
>>>>> +    spi {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <0>;
>>>>> +        num-cs = <4>;
>>>>> +
>>>>> +        sysc: system-controller@0 {
>>>>> +            compatible = "amd,pensando-elbasr";
>>>>> +            reg = <0>;
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <0>;
>>>>> +            spi-max-frequency = <12000000>;
>>>>> +
>>>>> +            rstc: reset-controller@0 {
>>>>> +                compatible = "amd,pensando-elbasr-reset";
>>>>> +                reg = <0>;
>>>> What does 0 represent here? A register address within 'elbasr' device?
>>> Removed, I recall a check threw a warning or error without reg.
>>>
>>>> Why do you need a child node for this? Are there other sub-devices and
>>>> your binding is incomplete? Just put '#reset-cells' in the parent.
>>> Without a reset-controller node and booting the function
>>> __of_reset_control_get(...) fails to find a match in the list here
>> That's not actually the answer to the question. There was no concerns
>> whether you need or not reset controller. The question was why do you
>> need a child device instead of elbasr being the reset controller.
>>
>> Your answer does not cover this at all, so again - why do you need a
>> child for this?
>>
> 
> If the parent becomes a reset-controller compatible with
> "amd,pensando-elbasr-reset" then the /dev node will not be created

Why /dev node will not be created? How bindings affect having or not
having something in /dev ?

> as there is no match to "amd,pensando-elbasr" for cs0.  For cs0 internal
> to linux the reset-controller manages one register bit to hardware reset
> the mmc device.  A userspace application opens the device node to manage
> transceiver leds, system leds, reporting temps to host, other reset
> controls, etc.  Looking at future requirements there likely will be other
> child devices.

You mean "amd,pensando-elbasr" will instantiate some more devices? Why
you cannot add the binding for them now? This is actually important
because earlier we agreed you remove unit address from children.

> 
> Going down this path with one compatible should reset-elbasr.c just be
> deleted and fold it into the parent driver pensando-elbasr.c? Then I
> wonder if it even belongs in drivers/mfd and should just be modified
> and put in drivers/spi.

How is it related to bindings?

Best regards,
Krzysztof
