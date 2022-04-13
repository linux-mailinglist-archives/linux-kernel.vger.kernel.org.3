Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930D4FF6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiDMMeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiDMMeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:34:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C843CFCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:31:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g18so3588597ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Lvd9vJ22XsJxh5wTqoaXDSfIwOkDHmJ22hAwLpW3BR4=;
        b=hjy2sSVw7elKKyHz6mzhXN40yuRJcqMwSGsakM5IxrXzjVIejdTlqU+BfK/cwCtCsY
         vwe2o/RWaf8W9S4UCgY4vOBOL86mmFdn9rdfICs/cbQytON/B4PgyPpdWtlycm0MbY4l
         eV/7LWdb4+v58fI3yP26zEvAmP6ZgbU2lEFhMuzIzZF20ppiUacyDkGH/RnI7qrJpDKm
         1rvmsR3Pl1a5MH309EjSG3qlJyErU+a/itGy/U2JzgJULnvSH7Hm6ap8r9/f+xHVIkFg
         2TvyyC79SWYNBotIKKvUMWFdUZLA3wN7V8thSy9SA4zXizpjGVBB68f5Yb8KDQ/uUcM2
         Q4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lvd9vJ22XsJxh5wTqoaXDSfIwOkDHmJ22hAwLpW3BR4=;
        b=3JUJ3j52+nSnKbAppH7yKEFpocj9Ivw2Bai2Kq7FgYqFUf2ldy2cdbPQ2mKSHskGJS
         qU7IfnJsbfUT1wFQUt+rvF8rOU2az3sw2swXoh42BnHnLF82kLc1DL3cc5G86F1BuzYH
         6mtWuFVf5VLY42FkzFXx7jIWKUMQ5U4Ev9QP1Yuf8gAdBAAnwlA8Wpe1mLy2ycyLFZcv
         iMRDHnH8GC2ubCyUgxUkGamH74XHdw/WYGnolCz9W4t/RBjpbM7ilr75/pnAC2vkUXdb
         nkqr1/Ua7obW60rJp1z6XNHYd1pI6rboqOk+x5Ft9h+ueTzwzAisREY750r0M+88AzWP
         CyOw==
X-Gm-Message-State: AOAM530ph8WrT0bPL/ZddKR8KJy5EHkZUNia7d0PDuBHx3b/6SPmXw0G
        65bXASh/X0ypWmrvgI7x0jf6zQ==
X-Google-Smtp-Source: ABdhPJxaPZnPEmt9ZRLE/nD1VWEp1YfjMr5hnvMPDUvHs/qIEm5F+RB3FkGayjaWEfx/38Lw1k/Nuw==
X-Received: by 2002:a17:907:728e:b0:6e8:9863:558a with SMTP id dt14-20020a170907728e00b006e89863558amr11503106ejc.205.1649853106315;
        Wed, 13 Apr 2022 05:31:46 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm1061489edv.65.2022.04.13.05.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:31:45 -0700 (PDT)
Message-ID: <06852353-9ca1-6f61-7447-b5f1d64ead25@linaro.org>
Date:   Wed, 13 Apr 2022 14:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
 <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
 <fdafb49b-9349-087b-f483-4da888193683@kernel.org>
 <f2b7b48f-906e-3445-3861-dcdd4f6551e3@linaro.org>
 <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <605268c7-9d0f-83d5-d7e6-850dabb380f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 13:56, Roger Quadros wrote:
> 
> 
> On 13/04/2022 14:47, Krzysztof Kozlowski wrote:
>> On 13/04/2022 13:33, Roger Quadros wrote:
>>>> Previously it was building with COMPILE_TEST on sparc, so what else changed?
>>>>
>>> Previously it was like so
>>>
>>> 	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>>> 	depends on OF_ADDRESS
>>>
>>> Means it won't build if OF_ADDRESS is not set even if COMPILE_TEST is set.
>>>
>>> And OF_ADDRESS is not set for sparc
>>>
>>
>> Ah, yes, so dropping COMPILE_TEST seems the solution. There are no other
>> "depends" here.
> 
> But the build failed at irq_domain_remove() which is only available if IRQ_DOMAIN
> is enabled.
> 
> It could be possible that OF_ADDRESS is enabled but IRQ_DOMAIN is not right?

I must admit I did not dig this that much. OF_ADDRESS has !SPARC
dependency, so after removing COMPILE_TEST the issue should not happen
on SPARC. What about other platforms? They should behave I think the
same as before - fail if they were failing. Nothing gets worse which is
my main concern here.

If you have spare time, maybe you could investigate the compile testing
on other platforms as well and if something fails, fix it. But it seems
it is separate problem.

Best regards,
Krzysztof
