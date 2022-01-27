Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589549E5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiA0PSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiA0PSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:18:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90743C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:18:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso3473061wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i/4aHvLx0xlbDSqE5Ac8Q/MRCnzzAZwCoPVM4qh+V4w=;
        b=FdlX2cAa7CE60w67jBg6HmtvKc522BNrx0l5/2tRysWxW0cNYpAb64ydNIshwNPuTd
         uxrL5qiIeadcTJYyAi8luphU/iB2wmS2vmTXY6O17gq7nFGs+w1rvKQXcNb/6uMUuscI
         /ulkX6vF3MLTbtT0fwQwEByn8zVwz1cBgwR1uVuMFya9EgKviwKkzkVCtmdtrcSQtlT/
         jd+KSPnvl8NhhDt/rFqWA1wYgTnbjIAFRbaGBYXaFEP5GP9A5R6e3gRcleChZxdHMhPL
         tIdICe8JGho+oSLYj7ziMHqWpnOWafyNPs2M0hGJ98mbMo3qToD3gVacyxJEmHH/n/Er
         yZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i/4aHvLx0xlbDSqE5Ac8Q/MRCnzzAZwCoPVM4qh+V4w=;
        b=VtEu9rLb2uuni7cOYiZb5zctxHXDtiOPL6BpQgJEzvXOiUASycqDw6oSAAss+Nfdux
         GypzHDlKkITY4I0nQ1iw+7pet17ubX473tqToxdj0E94AzsE+u03C7FIgAOh78gu8KWd
         Xk92gBH/bq5y65ORfxbnGHnK6Chv9xyxvTBOCVM2YZabuFLOaCpW6lm+ggvzONn/A+uL
         TjHKBIfxtSAiQkD1AIcoTCL8pT8aS3qS/7GyVlht3axp4ydkF7KxI0Nw2Lr7aSvDN5Lq
         PlOHiWH+slGAuC1FXffC0n5eM4f+V/lqES5984sJrYm5CUtOX9HeWgVP2pVXBV8X5Mjj
         ntgA==
X-Gm-Message-State: AOAM530kWoeMUOTUvk1CPUxljlUl6t8Ny5nK6qTuGQPKdEwNfgE3smMT
        VK1JcMiJlmnge5/1n07Tx9ANVkMUTUCkew==
X-Google-Smtp-Source: ABdhPJxCtaI6rDdSrWhgGXAU48ojSnr/s7UKOh8uTG3JXRhqdw26prPvM1Sx1LN+Lig1Hi2yFiTrKg==
X-Received: by 2002:a05:600c:4e90:: with SMTP id f16mr943648wmq.175.1643296678696;
        Thu, 27 Jan 2022 07:17:58 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id d9sm2544985wrp.14.2022.01.27.07.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:17:58 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain
 for GPIOE_2
To:     Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127151656.GA2419733@paju>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <6cd58652-f24e-3919-589f-d71eb0e8070f@baylibre.com>
Date:   Thu, 27 Jan 2022 16:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127151656.GA2419733@paju>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 16:16, Dongjin Kim wrote:
> GPIOE_2 is in AO domain and "<&gpio GPIOE_2 ...>" changes the state of
> TF_PWR_EN of 'FC8731' on BPI-M5
> 
> Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> index 212c6aa5a3b8..5751c48620ed 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
> @@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <3300000>;
>  
> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		regulator-always-on;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks !

Neil
