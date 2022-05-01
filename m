Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52EA5162E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiEAIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbiEAIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:39:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879025C71
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:36:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k27so13528281edk.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T37Co2YaIoPdJaFzSuKUExm6NVIOKmiWi9ktB2H7iXc=;
        b=pRNaTUB3lHhU1S9qBs3tRXjsJM8qagB1/eF+S1HB1JhV517rz+YMpK8Yld04gfMAUa
         H4F+LnyxpSs51dQe+CWCH9w1XiU//tLDAc5JBv+/a18uz3J2BtpFllOaKs9RX7AbHgaM
         /Ctbxl9VwVT10mBGnv99RFKzQJqMpz6nu+S0xTHIBMFzH7jvWBX2ZVEXifI1UZhrZzpI
         8IJ0EzfGj8SvRSIsH5k5asWw2bFMHP5NWwQ0nAkZp/9PFSvjZ8fAEYpDsbnL8W5B8c1X
         yafASvFEHszNXWaprcPj/wCNt1WGYNpedKFxwl1gIwHRjI3g0Ebq00pBqSGPI+echDt7
         WrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T37Co2YaIoPdJaFzSuKUExm6NVIOKmiWi9ktB2H7iXc=;
        b=ZIDQiNF7LHVgsMZ4T3MG3enVfzBaaLl8NMdyppA7HATKIa6Zs875aBlrNalIBOiBrF
         KzL0r39rj3oS5XsdsRaHPCHvPYGOPA1qPBh8U3Wvk+VBHLSEtblDLHE6B8CgNpgx9nuQ
         fGc96nJ3En88dtX06Z8cGINVHzYsDPD2w40UE+K+QOlkweM2gtk3OJvXAKICtk3AWhfk
         Md2JDUEr6Skb+AjhRPGGqrqzjeWxWt0XQcZaVitta4zQAtdOzMuMn6mhHsyWGsXx7XGS
         1JbJQR098bzhoYqCvMH47hh5uzAHmNS8lA0uPpm3f4OuAhyfU/8WKhh+4tmRgBvcoDi+
         QeBg==
X-Gm-Message-State: AOAM531Jy3EuKxEZKZNtGNR4VuJwS1uboy9ItDinz/bDtZxbRsBfEV2G
        iwKoG22/uzcVH0dVtncICcVz0g==
X-Google-Smtp-Source: ABdhPJyjbqMC3Hj6jQ6IPfDo57Yfjo2x2RX+5fmzz3mh2Oi00xy5UmJkCEkiWwOpNvfQpLrbWSiYnA==
X-Received: by 2002:a05:6402:40c9:b0:426:2b19:a4be with SMTP id z9-20020a05640240c900b004262b19a4bemr7923489edb.380.1651394179215;
        Sun, 01 May 2022 01:36:19 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm2385905ejc.43.2022.05.01.01.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:36:18 -0700 (PDT)
Message-ID: <e68f9371-e111-d357-c224-a0067774db73@linaro.org>
Date:   Sun, 1 May 2022 10:36:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm: hisi: enable Hi3521a soc
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220501051020.2432338-1-hanetzer@startmail.com>
 <20220501051020.2432338-3-hanetzer@startmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501051020.2432338-3-hanetzer@startmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 07:10, Marty E. Plummer wrote:
> Enable Hisilicon Hi3521A/Hi3520DCV300 SoC. This SoC series includes
> hardware mutlimedia codec cores, commonly used in consumer cctv/dvr
> security systems and ipcameras. The arm core is a Cortex A7.
> 
> Add hi3521a.dtsi and hi3521a-rs-dm290e.dts for RaySharp CCTV systems,
> marketed under the name Samsung SDR-B74301N.

Where?

> 
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> ---
>  arch/arm/boot/dts/Makefile | 2 ++
>  arch/arm/mach-hisi/Kconfig | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7c16f8a2b738..535cef3b14ab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -242,6 +242,8 @@ dtb-$(CONFIG_ARCH_GEMINI) += \
>  	gemini-ssi1328.dtb \
>  	gemini-wbd111.dtb \
>  	gemini-wbd222.dtb
> +dtb-$(CONFIG_ARCH_HI3521A) += \
> +	hi3521a-rs-dm290e.dtb

There is no such DTS.


Best regards,
Krzysztof
