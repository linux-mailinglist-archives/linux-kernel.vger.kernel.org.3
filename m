Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9157208F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiGLQQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGLQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:16:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC4CA6DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:16:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r9so10440327ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/lc42x2S5iJSZtOprR+CMbaoktIgAttRgPRI6xMmQxs=;
        b=YwFSdNJkyDbCZ2ONCSCipa6QAwGnYs5hKJXkEcrtgOdvsfYALK6sl7W39bSp93sF/u
         1Rc2kLomHhs5ERTE+nGL2qMhweIdg8jo/e3pAcW2EN/XW6fZZlJLtTvZTs6PP85xn1B8
         g+NJ+M+bUJdnEZUzr1/KsLOFFzJM8lc7PBv0y6wAo+j1bSMZeyk0EWBqMWV6cSyTgWyl
         HssJMKdX38tf3Zt2XjuodUZ4qvq0+pxYFODwSk+Bhh++e6UYxFEbS+BE/4VU7zOUn3QZ
         0Lmrhg34ZZwN0I+pCQ2wujVulHJBLqsw+oCRXf2ir2J3ivmpqcziOd8jmbPJ6lFYVbyK
         SGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/lc42x2S5iJSZtOprR+CMbaoktIgAttRgPRI6xMmQxs=;
        b=DiMQy76MOOqYQEQUoXg2KaFzJHYZPNB5ifRDHSkMoyyJySvjso96LeKU8Tpha+hWtK
         YoEFySFWCfjnTVELi9Ja2f22x8P6QnvtP9QTvT0uK62G0rzc+iBcmDBVIH/USQolKJcD
         neGcvTUR3xSAcxcUIF7PN09GiObwfdpMDUbuvFN72HYB9ePXxcfWVld4vSP9uAv/MP1K
         mldpcvTOUUHP8SSRUNKmWiUaSzMls2GVZEQxIudOqF8zEXlYNeuJBC9ZBVtHHhYM1XE7
         pV3oEFjuRNx1lXAH+I4jM3ha3TDhbgU3aJpgxxjfCYBwY0bpn9Cyelz4VLnuXF8YTvoJ
         N3rw==
X-Gm-Message-State: AJIora8sTOfhhHUvKsbF0tdCicnohwkSFuwm638PG+FDvAqb+zwd3iNn
        0lkuc+tNuTbmwxIS/dCnBq32Ww==
X-Google-Smtp-Source: AGRyM1sF8ov8rj7Y2Ae63OVly3gLaKTglxss18m1mdie5r+lXes5TejNt/sOJV6XLA5CERexM9aDww==
X-Received: by 2002:a2e:9109:0:b0:25d:66fe:eda5 with SMTP id m9-20020a2e9109000000b0025d66feeda5mr7858583ljg.385.1657642574085;
        Tue, 12 Jul 2022 09:16:14 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o21-20020a056512231500b0047f66471224sm2249161lfu.222.2022.07.12.09.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:16:13 -0700 (PDT)
Message-ID: <97c7abae-0be5-69cb-020d-b11948eb6e0c@linaro.org>
Date:   Tue, 12 Jul 2022 18:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/6] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630134835.592521-1-tommaso.merciai@amarulasolutions.com>
 <20220630134835.592521-6-tommaso.merciai@amarulasolutions.com>
 <20220711093659.mf7i4uqtrejtfong@uno.localdomain>
 <20220712152538.jh4ufxik7icllox6@uno.localdomain>
 <47aa4fbc-9cf4-7ac3-2fb4-2135a7703212@linaro.org>
 <20220712161236.le6wvdhdbleoxeyf@uno.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712161236.le6wvdhdbleoxeyf@uno.localdomain>
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

On 12/07/2022 18:12, Jacopo Mondi wrote:
> Hi Krzysztof
> 
> On Tue, Jul 12, 2022 at 05:32:45PM +0200, Krzysztof Kozlowski wrote:
>> On 12/07/2022 17:25, Jacopo Mondi wrote:
>>> Hi Krzysztof
>>>    could you have a look at the below question ?
>>
>> Sorry, there was a bunch of quoted text without end. When you reply
>> under quote, please remove the rest of the quote. None of us have a lot
>> of time to waste on scrolling emails...
>>
> 
> I should have kept a counter of the times I've been told "please do
> not remove context, I'm so busy I do not have time to read the whole
> thread" and "please remove context, I'm so busy I cannot read the
> whole email".
> 
> After 5 years of kernel development I would now know what to do.

I never got the first one, only the second nags. :)

(...)

>>>> Should supplies be made mandatory ? Sensors are often powered by fixed
>>>> rails. Do we want DTS writers to create "fixed-regulators" for all of
>>>> them ? The fact the regulator framework creates dummies if there's no
>>>> entry in .dts for a regulator makes me think it's fine to have them
>>>> optional, but I understand how Linux works should not be an indication
>>>> of how a bindings should look like.
>>>>
>>>
>>> This question ^ :)
>>
>> My generic answer for generic devices would be - if resource is
>> physically required (one need to connect the wire), I would say it
>> should be also required in the bindings. This also forces driver
>> developer to think about these resources and might result on
>> portable/better code.
>>
>> However your point is correct that it might create many "fake"
>> regulators, because pretty often these are fixed on the board and not
>> controllable. Therefore I am fine with not requiring them - to adjust
>> the bindings to real life cases.
> 
> Tommaso if you can re-send this one with the supplies dropped I think
> the series is still in time for being collected for this merge window
> (Sakari to confirm this).

Sure. In either case please keep my review-by tag.

Best regards,
Krzysztof
