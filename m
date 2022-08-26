Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B903F5A2DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbiHZRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiHZRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:38:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B765264
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:38:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q18so2228345ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hVv2xtEscyFntrXDnbpei4sjwnUpyNXGOcuaqpRAwaY=;
        b=vS8SExfcZQHCyp11tDc1Zq/QHXBKeWtdcgshHK9KRsaxDsup00AY6hDDp7vOmOW9Nq
         WsAydJYvqx9t2a0gSgAflER/oKOwbUTysCUqRNFQovcNKVqJGsQzTylNGz1pl1Dcbu7Q
         rZ3OlXqtsKJdCmInjS9Vrj1IEeJx8C5zV1HMTOQMQlpzqMT5YgH4fooSbz0p3pnAUtKR
         xJNTR9a3IaL2ZbdZ1hAY8ZmowyEZapoGK1qQdpoV4+SVT7/K5EpZxqtdgSGER0Ania03
         7cOr2SZOPHqq1+RmaptUlj/swW2rYcefKKbn9GeaBGwYSD2leLpLrQ4PA7Gkc1PqJ0ga
         4VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hVv2xtEscyFntrXDnbpei4sjwnUpyNXGOcuaqpRAwaY=;
        b=atqQg9fGGE1o3SrOXM0sk6WeMvKoQ/FhmPsGjknDaP4UKBrBuW1+1wgS6Qe5vCgab/
         biI5ixhngDDQlwBEtq9lZ4zLdAue8NeZ4JZXTfEcmElxH/72QckKNxigQviXUsXJz2pO
         lZN2UZQ+iRJWAkNy50pTeD0nnU+h+Rmojw4PUiQWNzZhDH0T2LMdlX+G4rBEZssG1b8g
         GkI9Q/LXKrmpTNvxwaj6yTxweiHwZJb3esqObRFLmCOqdr+fHUEKiHuoceY8nrzGlqcd
         rPDXGJN6gse2aUsbmZxtw4Og2WQ9oJqpOO8twpoJF4nrh0W+kGHRNEPmWlqDKRpT3t1C
         52iw==
X-Gm-Message-State: ACgBeo2hW0qYCAJzWhheHWSCjCcHbVEGfPSrQIJkWGBneBxvNN2eHjGF
        Gn9SZUOQz+ov70VVeQYL4b4JGw==
X-Google-Smtp-Source: AA6agR53vjYKoNPH5ayU6MuRyMLjlIpHOq5kRJdPSSdqIcSVIQBWTjD0tEE/n+RfBE+RJlZIbr2bEw==
X-Received: by 2002:a2e:a5c3:0:b0:261:ac2d:2820 with SMTP id n3-20020a2ea5c3000000b00261ac2d2820mr2751676ljp.243.1661535481694;
        Fri, 26 Aug 2022 10:38:01 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id f1-20020a2eb5a1000000b0025e01de57dcsm526955ljn.90.2022.08.26.10.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:37:59 -0700 (PDT)
Message-ID: <bb0331e7-2203-e8cb-70b6-5d43bf6a0aaf@linaro.org>
Date:   Fri, 26 Aug 2022 20:37:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
 <20220825204041.1485731-2-horatiu.vultur@microchip.com>
 <96da4897-7b55-84d5-8f1d-892e116153df@linaro.org>
 <20220826073103.kkotbaxc3latculo@soft-dev3-1.localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826073103.kkotbaxc3latculo@soft-dev3-1.localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 10:31, Horatiu Vultur wrote:
> The 08/26/2022 09:42, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: microchip,lan9662-otpc
>>> +      - const: microchip,lan9668-otpc
>>
>> Does not look like you tested the bindings. Please run `make
>> dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>
>> This won't work...
> 
> You are right. That was a silly mistake on my side.
> 
> It should be:
> ---
> properties:
>   compatible:
>     enum:
>       - microchip,lan9662-otpc
>       - microchip,lan9668-otpc
> ---
> Because what I want to achive is to be able to use any of
> string(microchip,lan9662-otpc or microchip,lan9668-otpc) as compatible
> string.
> 
> Or this is not the correct change?
> At least with this change dt_binding_check is happy.

This would be correct from syntax point of view, however maybe not the
best choice from functional point of view. How you wrote the driver and
bindings, these devices are compatible, so why this is not expressed as
compatible devices?

Best regards,
Krzysztof
