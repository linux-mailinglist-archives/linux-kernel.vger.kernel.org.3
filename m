Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6353DC5C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbiFEOu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiFEOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:50:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6955F52
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 07:50:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 25so15449880edw.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n93enFeCwlBOT1IPLGGsCl2guLUAxzPd6f5EdOUxDVQ=;
        b=BiW7DWP5cVTfui0LTgjGTRGNlhtb3vhvuW33Gy5L2V2iLM2sV45X/hk7NSznTKZL3i
         yknzYNeJkuOaEciK4XB9SBjo8RaQB/lMgVFZ6HbHBGQ0osDViFZR/rVdjRF2touvCNVf
         fBOm2AQU3xMXblqrLfir8zh2fjvO+fMyCauJP1LvRtBJnIxai173aUCr03VIhPr8UQqX
         pVaiz24nOt7tGsD7jrAs3dlk0cw9u1JwaQyr19SmdtWWbUxIipLahrkep2AYgeB+J8bj
         k7OGslfvfq8qkM4ZJHupyT/sr3mWEjqKy2MSmylZ1fRkSOjAJmmh8VfpVaS3G0Y5Vtcf
         Uk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n93enFeCwlBOT1IPLGGsCl2guLUAxzPd6f5EdOUxDVQ=;
        b=sPyR2l1h6JxUeqaFTpXhyFhO7mZIYCyxoeDM6Q60YZ88rbsIurD4UA6h3o+byXBUte
         7hJOfR45uEw7/S0kr/uezbLkz1ALkfCPq03UBrRZuenPwGMFYBrGDJ2a1PsheuL/vPHa
         sFMHphOsnQkshLRvrGDYDVLX3nFFLQ0INVADIaflgRxEmuJsl1glqyBOqP1bdQ04b9yu
         vHG0d36z+Mc1rnzsLb0zmKoHNPi5Wtrp2kUKZIwGAH9mY6gbMKQTormbtIRDnUmAnzgV
         grjHvOXJJc2/A8Fpn13XyOHaoXHY8FlFocyTG5G3CY4c/iWmXvZpQ+h0Fe4bRGUPnrNz
         +OHg==
X-Gm-Message-State: AOAM531T4iyn5Cn9T5TevIoYVc/NEQKtt+TVP0EbzgSC4ExvjVFnNKqY
        7lGSzchA4JUgZGXaX27Wto2GUg==
X-Google-Smtp-Source: ABdhPJxhbBmfF6AIGg0aC+g3DWzMKlB5zF2M9iu4/Le02YRjP+qJC5IUvsf7s0nzOIIkry2n2CbnXA==
X-Received: by 2002:aa7:d143:0:b0:42d:ca9c:aa76 with SMTP id r3-20020aa7d143000000b0042dca9caa76mr21972291edo.163.1654440654909;
        Sun, 05 Jun 2022 07:50:54 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id my16-20020a1709065a5000b006fecf74395bsm5229671ejc.8.2022.06.05.07.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 07:50:54 -0700 (PDT)
Message-ID: <58b22f25-d5f1-efe2-f38f-a50c2dea0602@linaro.org>
Date:   Sun, 5 Jun 2022 16:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220527125633.GA5145@standask-GA-A55M-S2HP>
 <4bb8e18a-11d8-c617-7952-8887aa815301@linaro.org>
 <20220603121258.GA4919@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603121258.GA4919@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 14:12, Stanislav Jakubek wrote:
> On Sun, May 29, 2022 at 04:05:12PM +0200, Krzysztof Kozlowski wrote:
>> On 27/05/2022 14:56, Stanislav Jakubek wrote:
>>> Convert RDA Micro interrupt controller bindings to DT schema format.
>>>
>>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>>> ---
>>>
>>> Didn't know what to do about the interrupt sources listed in the original txt file,
>>> so I've split them off into a separate file. Hope that's okay.
>>
>> Interrupt sources are not kept in header files.
> 
> Ok, should I move them somewhere else or is it fine to drop them?

Either drop them or, if they are meaningful, keep in description. I
doubt that they are meaningful, but who knows...

> 
>> Additionally are you
>> sure this is a property of the interrupt controller, not a property of
>> SoC itself? I would assume that one interrupt controller implementation
>> (e.g. GIC) can be used in different SoCs and the sources are every time
>> different because they depend on the actual wiring...
>>
> 
> I honestly have no idea, I just wanted to make some YAML conversions.
> Maybe Mani could answer this?


Best regards,
Krzysztof
