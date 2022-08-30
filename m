Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818675A6075
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiH3KOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiH3KNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:13:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3141054F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:10:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id br21so9056280lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EgnDZawayll/TZ+ocCBlj4vzfhU1iWcXae1blePHBeI=;
        b=pQPWKaV07CHWz5hl5ve9Mj3xCOzwiOV/diab5zIdgaaw/UjGMdEIQqdvm5wj3cYvIX
         +Zm2hwL2j9HxaUayBUC3mHfqwsNUmQPJb6mh0oBOvqsT2e162F1rl+B3zZ9R+5m7rkqW
         M3MLbfrWoo8KUEQ/DL1Uf/9cr5vnrK58GEzm5lL6oi9FYWyDXU2waXoJz4YTVVufvmm5
         /oskk+OGSFfysz2tTxUQhUc+X3grEoBoS3P9Kt5HZQOQrai31SHdioBoJY6vRzAG9M7c
         jmj1uiIrdULzgMHvObn6jDBWz9aTrEU0phbNDPZMpJobT+fB+WeycnNC83rw/Bwsu5v2
         x3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EgnDZawayll/TZ+ocCBlj4vzfhU1iWcXae1blePHBeI=;
        b=kpWbuPe4XwJUgovTOY5QLm9mPX5Lm3C1iB2tRdXETsOMAJe3yXlQ+r+bFLm5uThbpe
         q4xzRDrgVZTZBWnSdVMrAX2v21GMHMX6z6IknvYM8YjpEkRDgErODxf2ewbse6M6+8sJ
         nHehygSVZar2dTxgOL3avWNhPP4vWdU9ggbvhpSSQo9Ly7kO348GyJKPd6vDvFKUdIlw
         gZKo+QzpqY5H0Psur50GUtK3kFsmvS/rNCFaiH641Tc7jEROv9b5iBelxV/JSqrVSB4F
         v3gOMwrcYPLNUIQxU0JwlmYpCcAUT4jNWJ/rYREa4vfIzwijtPpdrQ7//n1zYwM9intz
         mA9g==
X-Gm-Message-State: ACgBeo24GJooSb4Cohbs5RgUNV3YCMl/uvcIYRkQx0SYdwHCZiHNA++c
        xsA6Reo8DIkrymNgH0pMYNYO1w==
X-Google-Smtp-Source: AA6agR6abuAS5upLveqHIvJ7T72ZEkevibkm46Oky+6kWT+BFztbk1BBuuWRwkW4nBy132uOrL5irA==
X-Received: by 2002:ac2:52ad:0:b0:492:d8ae:364f with SMTP id r13-20020ac252ad000000b00492d8ae364fmr6919677lfm.249.1661854219242;
        Tue, 30 Aug 2022 03:10:19 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24249000000b00492f37e428asm1562479lfl.172.2022.08.30.03.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:10:18 -0700 (PDT)
Message-ID: <fa987e2a-cd48-b08b-d191-419624699dc9@linaro.org>
Date:   Tue, 30 Aug 2022 13:10:17 +0300
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
 <bb0331e7-2203-e8cb-70b6-5d43bf6a0aaf@linaro.org>
 <20220829063557.3ntgt6uqblgew3r3@soft-dev3-1.localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829063557.3ntgt6uqblgew3r3@soft-dev3-1.localhost>
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

On 29/08/2022 09:35, Horatiu Vultur wrote:
> The 08/26/2022 20:37, Krzysztof Kozlowski wrote:
>>
>> On 26/08/2022 10:31, Horatiu Vultur wrote:
>>> The 08/26/2022 09:42, Krzysztof Kozlowski wrote:
>>>
>>> Hi Krzysztof,
>>>
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - const: microchip,lan9662-otpc
>>>>> +      - const: microchip,lan9668-otpc
>>>>
>>>> Does not look like you tested the bindings. Please run `make
>>>> dt_binding_check` (see
>>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>>>
>>>> This won't work...
>>>
>>> You are right. That was a silly mistake on my side.
>>>
>>> It should be:
>>> ---
>>> properties:
>>>   compatible:
>>>     enum:
>>>       - microchip,lan9662-otpc
>>>       - microchip,lan9668-otpc
>>> ---
>>> Because what I want to achive is to be able to use any of
>>> string(microchip,lan9662-otpc or microchip,lan9668-otpc) as compatible
>>> string.
>>>
>>> Or this is not the correct change?
>>> At least with this change dt_binding_check is happy.
>>
>> This would be correct from syntax point of view, however maybe not the
>> best choice from functional point of view. How you wrote the driver and
>> bindings, these devices are compatible, so why this is not expressed as
>> compatible devices?
> 
> OK, so then it should be something like this?
> ---
> properties:
>   compatible:
>     items:
>        - const: microchip,lan9662-otpc
>        - const: microchip,lan9668-otpc
> ---
> 

I would expect:

oneOf:
  - items:
       - const: microchip,lan9668-otpc
       - const: microchip,lan9662-otpc
  - enum:
       - microchip,lan9662-otpc

(but you need to fix indentation)

Best regards,
Krzysztof
