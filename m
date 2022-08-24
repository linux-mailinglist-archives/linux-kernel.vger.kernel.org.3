Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148C059F403
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiHXHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiHXHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:12:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D294109
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:12:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bx38so15538075ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oz1fB+3kXBs8QJgrzWFnAfi9IHZCzH+0GYvh9BjYEfI=;
        b=fiPyIQA9TaaY3/cOteRdnvCXxGLmK/wfMKyGgUSCdNM+u50Y7HCnnG5ES1Fr2/Sap4
         QBAKiRkut2DZSDndJtQtuhSV5LogzxxpzVWKxT/aRMn4UZggaaLzm7wPf1ApK/jIaYg/
         0J3W2fQlinWcWjioABjZYqoQKL3ldA4NFNItzDRr1kPfHv1UXZqAxGZMzeSZ/GoEqrz2
         mlLlAC0v2MoosnMwZ80TtDkuaDjuhKKSFoUsjvLjAlVBAM5y++eUmOanOJZb6Xqk86He
         7WzvqKMI8vm+WOR/VLIRGbEHjrAGut/8oWEZa0bEzaRk403cRIttxQhgmJp1E1b0VnhD
         bHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oz1fB+3kXBs8QJgrzWFnAfi9IHZCzH+0GYvh9BjYEfI=;
        b=dsCMRpXxaChan4Mjn1DGGoTddyIJM9itSzWy071zg2wmJ7IEtvbgHgJd9NK8dVVDc8
         f/yhGw16ZUQlub5a2GpMN6CtxYudjrF7GE2CblqaWpTL9bCPQygPA7VYljhBDsW9G+of
         nOzT0UcH7kNDkTFncuLB4K+RVJkKRxjtb0jVD36/mPlXR9MncLvyU6Bm9xr1QEipuFKJ
         OjzcdWfGWvbsaEdfOKN0JYx8DtmTjYn5Tb6Qxy1rkyrRtrzeQMJyD1DXjdb1v+ZHRMAt
         iJBXXBqy7o4lzzNZQnYQdbNYtOge5h2FGNCFFtRHULCPYd5GkuorNQme5mW4mUMohLIO
         +4pw==
X-Gm-Message-State: ACgBeo1qjZvubBaih06bSm9Dbg8eUS41TULbEbV5Q9DoLIvQFX52Rf8x
        0hBBo7QX8YffErB1ZHbHhJ78EQ==
X-Google-Smtp-Source: AA6agR5+O+kkE9csXEWv5h4svRc0pDYE1xR24GwkPlBwsarwv9ryRHPEFTRmB7PfedrGP2pqKBvX9A==
X-Received: by 2002:a2e:910f:0:b0:261:ce88:76d2 with SMTP id m15-20020a2e910f000000b00261ce8876d2mr3134129ljg.410.1661325162921;
        Wed, 24 Aug 2022 00:12:42 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512074a00b0048af9576d30sm1610651lfs.83.2022.08.24.00.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 00:12:42 -0700 (PDT)
Message-ID: <81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org>
Date:   Wed, 24 Aug 2022 10:12:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] arch: arm64: ti: Add support for J784s4 EVM board
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Apurva Nandan <a-nandan@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
References: <20220819190054.31348-1-a-nandan@ti.com>
 <20220819190054.31348-5-a-nandan@ti.com>
 <6c89f254-185a-4046-2bf0-a9f85713858e@linaro.org>
 <20220824050627.nh7d4blrsfbxrvuh@clicker>
 <734b1e1c-2416-0684-287e-a96b86a416a2@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <734b1e1c-2416-0684-287e-a96b86a416a2@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 08:33, Vignesh Raghavendra wrote:
> Hi Krzysztof,
> 
> On 24/08/22 10:36, Nishanth Menon wrote:
>> On 13:21-20220823, Krzysztof Kozlowski wrote:
>>>> +
>>>> +/ {
>>>> +	compatible = "ti,j784s4-evm", "ti,j784s4";
>>>> +	model = "Texas Instruments J784S4 EVM";
>>>> +
>>>> +	chosen {
>>>> +		stdout-path = "serial2:115200n8";
>>>> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x2880000";
>>>
>>> earlycon is not a property of hardware. Console is defined in
> 
> earlycon is helpful for debugging early crashes. How is it any different
> from "console =" property as described in
> Documentation/devicetree/usage-model.rst?

choice of console is needed for basic operation and is chosen based on
current hardware setup. earlycon is purely for debugging and should be
enabled only when debugging is intended, not on mainline wide-available
sources.

> 
>>> stdout-path, so please drop entire bootargs.
>>
>> We will probably have to cleanup elsewhere as well - point noted.
>>
> 
> Whats the alternative to pass default bootargs to kernel if bootloader
> does not pass bootargs via cmdline? I see quite a few dts file use
> bootargs = "earlycon" at least

Uboot, your own out-of-tree testing patches? What's the point to have
earlycon available for every user which does not want to debug?

Sorry, but bootargs are not accepted in DTS. We have several discussions
around it over time...


Best regards,
Krzysztof
