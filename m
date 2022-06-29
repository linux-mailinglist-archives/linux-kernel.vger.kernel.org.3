Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723055FA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiF2IDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2IDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:03:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8232981A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:03:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so30910188ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cG3vzXy564NxPyQk6j0mH7QQcpmGhb7eglXugVj6hN8=;
        b=YPK4Y9MtYTlB+9uxDmydPXAD+nm40vRi5kfqNUZQCbI9XYMlU0HSOwbzR6G6bfbW4r
         F0Zn6240auG9wDCOE9n576wvCFBDgppCXYG/GGdNxBsOj22QcVc7t6BadRxqNBFanvmZ
         Hj53k762IYyi8RlPckGPXe0GiV3fZlE/f5hgZxLs3SHfwPyJi4N+lVi1HN+S2PINJ23v
         kp9yJ05aEzIO7rA8z5nrXEOU7q1BAXOszAd9SqDfvt6GNNB+XktIVwUkJTC5bAKL1kpy
         ZhhY/RXn66UpmjVKgVL/s3pDCyWB5ZJw9FC7ZT4el0lubErnU7RHGWnvC/2zexKIC71j
         ZQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cG3vzXy564NxPyQk6j0mH7QQcpmGhb7eglXugVj6hN8=;
        b=ZzfQ/gN297i9nbylRXXNVKfqHoyQYHThOL4o17yTjt0L8KhHtXBR+1InX6z0End0Z5
         0boSix8CpVAnxmxofJq87if3IVWvlToispCy25S0IFIVv3K4JhYR3J5U3AKoQWH0Pf0O
         RAW8Si7PCnFFZKGXX/LK8V7jeVGmR0yq8W5zZuNRPfz6+kl66RusCN8oBuZedzryjw8a
         8RPg9d9wNHI+O/nMFsObT3/wur8efQmjKZdC/srV3o3jy3oh49M70dIMcr8R/KmdaNTO
         Ub0VFkStuL4bSjfR3VQ/4ZHTOkfaG/8f7IgV9dUhg9DdGR7ij81Qlh4YtfQkGbpJsKjK
         cQyQ==
X-Gm-Message-State: AJIora/m60P4NrIUh/IIocnVhWcClRHffy8sFiPeTAdtRhaEIWdknKdR
        oESCXOIKjpCQEyd2CkObjl7e9A==
X-Google-Smtp-Source: AGRyM1vMLNNjC9XXtRvbH3wYlHBLBB1LEnGfbV9c7vENLF2zfPQTUdrjciEn2ZM1kvAcRAd4swllrQ==
X-Received: by 2002:a17:907:168f:b0:726:2bd0:1091 with SMTP id hc15-20020a170907168f00b007262bd01091mr2003312ejc.137.1656489821764;
        Wed, 29 Jun 2022 01:03:41 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d5d4000000b0042617ba63c2sm10991337edj.76.2022.06.29.01.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:03:40 -0700 (PDT)
Message-ID: <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
Date:   Wed, 29 Jun 2022 10:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
 <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 09:59, Neal Liu wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, June 29, 2022 1:58 PM
>> To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
>> <clabbe.montjoie@gmail.com>; Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
>> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
>> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
>> <dhphadke@microsoft.com>; Johnny Huang
>> <johnny_huang@aspeedtech.com>
>> Cc: linux-aspeed@lists.ozlabs.org; linux-crypto@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
>> Subject: Re: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE
>> reset definition
>>
>> On 29/06/2022 05:20, Neal Liu wrote:
>>> Add HACE reset bit definition for AST2500/AST2600.
>>>
>>> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
>>> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  include/dt-bindings/clock/aspeed-clock.h  | 3 ++-
>>> include/dt-bindings/clock/ast2600-clock.h | 1 +
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>> b/include/dt-bindings/clock/aspeed-clock.h
>>> index 9ff4f6e4558c..6e040f7c3426 100644
>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>> @@ -46,11 +46,12 @@
>>>  #define ASPEED_RESET_MCTP		1
>>>  #define ASPEED_RESET_ADC		2
>>>  #define ASPEED_RESET_JTAG_MASTER	3
>>> -#define ASPEED_RESET_MIC		4
>>> +#define ASPEED_RESET_HACE		4
>>
>> I did not ack such change. This is a significant change from previous version,
>> invalidating my previous ack.
>>
>> This breaks the ABI, so NAK without proper explanation why ABI break is
>> accepted.
> 
> I changed the original define (MIC) into different value (see below diff), and add a new define for HACE.
> How does that break the ABI? I'll be appreciated if you can explain it more details.
> And sorry for not remove ack with new change.

Yes, this breaks ABI. Previously the ASPEED_RESET_MIC define had value
of 4, now it has value of something else.

Best regards,
Krzysztof
