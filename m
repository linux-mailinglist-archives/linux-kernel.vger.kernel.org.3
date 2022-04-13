Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11854FF56E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiDMLIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiDMLHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:07:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB25883F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:05:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so3193226ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PS3VhaFtyBO9DatsV/CyvDlQh5hYtTRi+Z+F+oPBZHc=;
        b=aas+peqOgXfaDQtFGQ6PkUFndDFJ/bQN8deYk7uucLlWOQJY6St7o+wM/OMwlm8uMP
         iWI1BEYVY+4OFhXZ/hlyzNT7NBDbJJj4/ymrICSzMeaO/XTfcIIOzJp4ZDe+GmAXzNf3
         1+ljJRUBh8/C2Tj4bqZMwMfH6FYMTxaJC/2qL6KC7Xlhdj/MfJ+Ddzk6zysQpqTyTxHO
         n3qrIZMmGB3paCJZ8rpat4mGdtHncgcCJbpLPEdBbbt7G1W6PHMQM+MA7oUI3ITmIvSG
         4SfNuMxmrkQmFG9zPPbcvhXJrZJ5AUQFezhe8DhRw6dti5qCRPXWUg1K9OELvHrNpd6Q
         aiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PS3VhaFtyBO9DatsV/CyvDlQh5hYtTRi+Z+F+oPBZHc=;
        b=fdz115GeKs6icICfGg3KR52O9QbN01SYoYqBfWTM7w0vdR5SBHDQ74hYVlYltPqyHk
         61Tn9gWZhZrOoJbK7Q0ipMfjkbn78/mHV1yJqNMcxA9yGFwbA+9TRvedwS2w4oJPIkjP
         SCsynTwQj26Ab+L8YcNtymI8KJDXV0+GXy04yjo2ISuNB0U+LT7pBpmpNp/E+HMlCKgp
         V9/5Q1WyhQXAxP7ZHs0lo3MbHiHJGZQvtRyrjX2YhIB8DWFrd89N9xD87rNruP9xY0WE
         Qg0IzR9ac6Q6trb1xJ/aQddwRj6/AmPwOlMSXXG+tuzZkdo5dTBHM7NQt+Tk1F+7hS7v
         nlDg==
X-Gm-Message-State: AOAM532brtfp+MsfhrUB5i5uvk4ARfVAy13bYIzc0ffeyccUHsvN9v92
        yPvy2gqvj4U9HWJiIIN4nN1o2A==
X-Google-Smtp-Source: ABdhPJwK89+NCQ4gDvarGQBiLdX8MSJa2HxKL1uMkTJNddkeBUFdOy0KEsAj7r8eBxU+9poR0zRrEA==
X-Received: by 2002:a17:907:8a0e:b0:6e8:c5df:d9e with SMTP id sc14-20020a1709078a0e00b006e8c5df0d9emr2841387ejc.142.1649847931499;
        Wed, 13 Apr 2022 04:05:31 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm13972528ejc.197.2022.04.13.04.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:05:31 -0700 (PDT)
Message-ID: <68d16fbb-4250-73bd-b55e-a14db91abe8f@linaro.org>
Date:   Wed, 13 Apr 2022 13:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, krzk@kernel.org
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
 <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
 <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b38a717-ffce-0f06-1a77-6d2a114c7e11@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 13:01, Roger Quadros wrote:
>> https://krzk.eu/#/builders/63/builds/162
>>
>>
>>>  config OMAP_GPMC
>>> -	bool "Texas Instruments OMAP SoC GPMC driver" if COMPILE_TEST
>>> -	depends on OF_ADDRESS
>>> +	bool "Texas Instruments OMAP SoC GPMC driver"
>>> +	depends on OF_ADDRESS || COMPILE_TEST
> 
> 
> Looks like include/linux/irqdomain.h does not have fallbacks if
> CONFIG_IRQ_DOMAIN is not enabled.
> 
> I'll have to drop COMPILE_TEST and add depends on IRQ_DOMAIN.
> Is that OK?

Previously it was building with COMPILE_TEST on sparc, so what else changed?


Best regards,
Krzysztof
