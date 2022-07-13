Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D547573A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiGMP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiGMP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:26:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347A4D15C;
        Wed, 13 Jul 2022 08:26:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ss3so14444779ejc.11;
        Wed, 13 Jul 2022 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=kzxlcZi7f09uxzv1rHERdurRhsF4h+KpHejIZNkN6qs=;
        b=PsC622FxZFBDQOCQvYNUeIA/Yj2Pus0JFG2MtQUPE1AWqF/6SMV+HObPyO9XeBNBGV
         ETK6zX0s6ydwbz8LcNXgFngZHNMLf9PvTFCXAU4DZLyZW4WQ50LGvHFqaRFULVvjUhrJ
         xchpdta58xXRV8qL5fHWTWKnM4dy4JXCN3tASpkbyRbFKtQ1LMFS95e3j3shhwe7Gf8i
         f4pF7tzGCB9DzmLlZMbjwB4tXIIdRuJbk5hTee5rLiUCnOin8rX8cWNGZmX2QayoKYx7
         ++hFJ2xyxN7im6gf8eZhNA5kwIJyRbnp/GKsu7yB8yD6WLHqLKl4V7ND8GaWtkPIZKyY
         URow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kzxlcZi7f09uxzv1rHERdurRhsF4h+KpHejIZNkN6qs=;
        b=pGoe74Telgh5y1s1nMdeH0FZqzkw5B4xMQyL99vLb9+J06+RdMHCEbXd6gb1NX53p/
         0Hovee54rnvK59lb8PtO23632uOyKZ88q9FHLyen78Pkf84+YBB24PzN0Idh7OL3HeA/
         3EPji17GsD0oWy5f4G187a2hQfFYNBYn//O6C7tUkYmvdB+h6q61+5dGqjI4aiKcUGWh
         Dhlzhs599YI8bUi3o5eTJZm0z2H4M79kAIw/N9C4hNNtBevEyhI4dcKN6Ez9veE9ymYF
         rUP3jPpwWMiWrJeRNZenwv0eEVpd9I2FbJVA2QpNf08CjMamJCysBm5uo0LX+50SAz10
         7gwg==
X-Gm-Message-State: AJIora9T947Jt20HJ681giqKTBExnqjAlrwNIIhT0MWXBoAtJZYisQzV
        saufXRwtj4WRFtcOqDEf/xFR4L5JXXE=
X-Google-Smtp-Source: AGRyM1sFoaG6MHmbm4bR0mniczE6xP/FYB4PAOFc3Y1NHX7ZS+t/NGK9re79B7JJdKwLGBDyLh2qOw==
X-Received: by 2002:a17:906:58cf:b0:726:97db:4f6d with SMTP id e15-20020a17090658cf00b0072697db4f6dmr4031917ejs.261.1657726006002;
        Wed, 13 Jul 2022 08:26:46 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id ch15-20020a0564021bcf00b0043a71c376a2sm8116926edb.33.2022.07.13.08.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:26:45 -0700 (PDT)
Message-ID: <304678bb-f49c-9c3b-e15e-df6c9e8a4ea2@gmail.com>
Date:   Wed, 13 Jul 2022 17:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v2 2/8] ARM: dts: Move BCM963138DVT board dts to
 ARCH_BCMBCA
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        anand.gore@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20220707070037.261532-1-william.zhang@broadcom.com>
 <20220707070037.261532-3-william.zhang@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220707070037.261532-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.07.2022 09:00, William Zhang wrote:
> Use CONFIG_ARCH_BCMBCA to build all the BCMBCA SoC dts and remove
> CONFIG_ARCH_BCM_63XX from the makefile
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/boot/dts/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 38d9c60aece7..1bf8e2f8ee68 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -147,8 +147,6 @@ dtb-$(CONFIG_ARCH_BCM_53573) += \
>   	bcm47189-luxul-xap-810.dtb \
>   	bcm47189-tenda-ac9.dtb \
>   	bcm947189acdbmr.dtb
> -dtb-$(CONFIG_ARCH_BCM_63XX) += \
> -	bcm963138dvt.dtb
>   dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
>   	bcm911360_entphn.dtb \
>   	bcm911360k.dtb \
> @@ -184,6 +182,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>   	bcm7445-bcm97445svmb.dtb
>   dtb-$(CONFIG_ARCH_BCMBCA) += \
>   	bcm947622.dtb \
> +	bcm963138dvt.dtb \
>   	bcm963148.dtb \
>   	bcm963178.dtb \
>   	bcm96756.dtb \

Do we want to mix all that DT files? Are ARCH_BCM_63XX (ex-)users
interested in compiling all of them?

For IPROC SoCs we have separated symbols: ARCH_BCM_CYGNUS / ARCH_BCM_HR2
/ ARCH_BCM_NSP / ARCH_BCM_5301X and we compile arch specific DT files
only.
