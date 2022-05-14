Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6045273EF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiENUWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiENUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 16:22:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376126AF0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:22:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m23so13997289ljc.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y5VRY1Vg5U7FZOYxaP3jhw1GgftqMUz+kaXgWZO/zzo=;
        b=a9IbvRUaYC8Wc0vyxgFwHAxgU9mSVnhYPrySypKYv+QMWSeS0lIY4wxVjb/+x54LWq
         Ldc1cXpfGj905mcwbZhrOB2SdRWkkkJTcN8XmsLxZM3o1iVoUToVGPQqNwOLRWQqNkFV
         hvbA4emBw/8q79PftXEPsH+kSyqRfafhujdgE+P8fJGteGOcK7xMkyuufwBAw8bIrRFa
         gJuSbkhJHloXm+OQ9D+IZ7DsfUCXfPkNBD+eHfglA2cDMFd0vT8MnG+Zmj8mMlPJwnb4
         yTLeFaHM+EYpglB82UoRIxyn6Isw1Z9/jYS70nsrx3FRo+XYLmINHoUjvQQkh8OJSE4S
         gzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y5VRY1Vg5U7FZOYxaP3jhw1GgftqMUz+kaXgWZO/zzo=;
        b=sm/awREErambxP6alztDmoak3vPsfp7gkj59pdgxdtN//Pz3/QfpH4nWR4BerlyUJB
         JopxGVRpx3h1dyCYlw5D41cGh2bju0yKYXH8C5hmiUNVUeJ5w+uls/+Z3jkAQ4AaP8MV
         h0OtlEWB3/fX4AgogClVFpKQcZCVb9LQ1uVNjuPLSH0dWBXzGsb3iSTzhJx/eggcPVAx
         wJJVB7QZn5LOGj5jaUlxp+Jtimgky45xthNBwstpPIMwo4XSeBqxuv6FtH8b6iMfKIml
         tt6yBsHT0alVtXF4BspLN7hukg50+cM8imFkPWgvefp041zFaRmLhvqaJ4H72FWavSRM
         NbDw==
X-Gm-Message-State: AOAM531/DVgpthOwtTXaf0rsV2p0hzx56KxYWuLyQIKCWdy+3horVviF
        LJ84tQU4YyQI+2ZM9C7J79/Tag==
X-Google-Smtp-Source: ABdhPJzLyuqdkaQnJF2ClXg0Jx1DgHwKnG2ziP/ISkfSmc674JtqB4hc3nDy/CLvL1Xr59yD6peNiw==
X-Received: by 2002:a05:651c:98d:b0:250:976b:4a0e with SMTP id b13-20020a05651c098d00b00250976b4a0emr6642090ljq.494.1652559718267;
        Sat, 14 May 2022 13:21:58 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e9b82000000b0024f3d1daeaesm942625lji.54.2022.05.14.13.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 13:21:57 -0700 (PDT)
Message-ID: <567d135b-3d40-9958-e000-1357020b5650@linaro.org>
Date:   Sat, 14 May 2022 22:21:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed udc
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>
Cc:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
References: <20220513065728.857722-1-neal_liu@aspeedtech.com>
 <20220513065728.857722-4-neal_liu@aspeedtech.com>
 <da78aaf6-c9ae-d591-fdc4-723f097ace2c@linaro.org>
 <HK0PR06MB3202679A7FABAF7D0D045F0880CA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <HK0PR06MB3202679A7FABAF7D0D045F0880CA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 17:39, Neal Liu wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Friday, May 13, 2022 5:07 PM
>> To: Neal Liu <neal_liu@aspeedtech.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>;
>> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley
>> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Felipe Balbi
>> <balbi@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian
>> König <christian.koenig@amd.com>; Geert Uytterhoeven <geert@linux-
>> m68k.org>; Li Yang <leoyang.li@nxp.com>
>> Cc: linux-aspeed@lists.ozlabs.org; linux-usb@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; linux-media@vger.kernel.org; dri-
>> devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; BMC-SW <BMC-
>> SW@aspeedtech.com>
>> Subject: Re: [PATCH 3/3] dt-bindings: usb: add documentation for aspeed
>> udc
>>
>> On 13/05/2022 08:57, Neal Liu wrote:
>>> Add device tree binding documentation for the Aspeed USB2.0 Device
>>> Controller.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> ---
>>>  .../devicetree/bindings/usb/aspeed,udc.yaml   | 52
>> +++++++++++++++++++
>>>  1 file changed, 52 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/usb/aspeed,udc.yaml
>>
>> Please name the file as first compatible, so "aspeed,ast2600-udc.yaml"
> 
> Okay, I could rename it for next patch if you preferred.
> But there are lots of yaml files which are not named as first compatible.

Yes, I know, I quite likely I also produced such bindings, but a
specific name is rather preferred. Otherwise you will have a difficult
naming choice when your next Aspeed UDC requires new bindings file
because of some differences (not yet known now).

> 
>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/aspeed,udc.yaml
>>> b/Documentation/devicetree/bindings/usb/aspeed,udc.yaml
>>> new file mode 100644
>>> index 000000000000..d1d2f77d1c54
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/aspeed,udc.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
>>> +(c) 2020 Facebook Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/usb/aspeed,udc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ASPEED USB 2.0 Device Controller
>>> +
>>> +maintainers:
>>> +  - Neal Liu <neal_liu@aspeedtech.com>
>>> +
>>> +description: |+
>>> +  The ASPEED USB 2.0 Device Controller implements 1 control endpoint
>>> +and
>>> +  4 generic endpoints for AST260x.
>>> +
>>> +  Supports independent DMA channel for each generic endpoint.
>>> +  Supports 32/256 stages descriptor mode for all generic endpoints.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - aspeed,ast2600-udc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>
>> No child properties? No ports or any other devices? No usb-hcd.yaml?
> 
> Aspeed udc only has 1 port, no need extra properties for now.

OK

> 
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/aspeed-clock.h>
>>> +    udc: udc@1e6a2000 {
>>
>> Node name: usb
>  
> "udc" is more recognizable than "usb" I think. "usb" is too general, can be various like host or device.

It's still required by schema for most of USB host controllers. Existing
USB device controllers use usb as well (except Atmel mentioning gadget)
Generic name is also expected by Devicetree spec and "udc" is not on a
list of examples of generic names (usb is).


Best regards,
Krzysztof
