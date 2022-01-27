Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C749E2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiA0M7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiA0M7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:59:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C255C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:59:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so4380786wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=goAS13FfsIswMixhhU7FnHrHF/d//rIXdJjcvNJfBh8=;
        b=xOHBT25R2/N8GX16UDxtFW2KxwjzMw43A/uPabB9GcqRPOIO9x13pPiJbFlsMxZGIc
         Bb/UpNvnFFiKaA82i0Po+oyXd/1n+eEvRHVr2AjhtZPJHPNpjSsedPbGtni5RhOfQZb3
         TdYQXoyDAnaMYLPThpYbpUc1vxbFDvsSFWPC689N7FX1ETFMXC8qEQ1xivV/4UhyZ6KR
         GZ5ttztUPKE12n2R2229ccJmNGjsfGSsY259FWCYj5oFE8/Be939bKWJ28WijXA4/HPv
         5HyvHctTud7INUJJB6rNJbc4/yIMq9XoGNO26SNSr79WBBR7HedIbw9P4+BTlkgeoArR
         VC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=goAS13FfsIswMixhhU7FnHrHF/d//rIXdJjcvNJfBh8=;
        b=Ye3A9BbepfB3eCCLEzODPhoeToaPNDRhzeOQ07/53IRz1dZ1PiOKq8ErBWpM03n2Wk
         e7HBSLDW7wkvS/0QaDf4YCAloA/wFkXPcryVStZtyqb7sXOZPttRbnSZ05phojUMm8co
         jMIQKbzQRi7PmxMbyCkG+HJG0Vb08oAPosfdjoyEHFs6S1ATQIDDF30wnSxJALVf3ROd
         xyZZi2N2Vbm3hy+0jzVZlN8i140wljheh8BIevVD0Jr5v6mY+wHzz53uxK/C6b7ywhHy
         8XHi9MWqKzjs9zMxBsqqs2rU0l15Ce8ziGbbuAgwwsfANRTn6ts7SqQk54/iddc5NyWx
         bqdg==
X-Gm-Message-State: AOAM530b1jFJmPHGd03J2+Cd4nL9Qgu94UZUZJF5OSv2PP64Xz5QAfwo
        nZb+vGpx2zVYhhcAFkJY4YUeBVIDMEu7FQ==
X-Google-Smtp-Source: ABdhPJwF0/lm3OD969oVAnjhwbzTL7tcqIA9l1PfpN/YK36p3CPP8/bYLvFn9nuKtkh2mcycBjDegw==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr2774150wrs.489.1643288361219;
        Thu, 27 Jan 2022 04:59:21 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id z13sm2389547wrm.90.2022.01.27.04.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:59:20 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
To:     Dongjin Kim <tobetter@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfKQJejh0bfGYvof@anyang>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <51093ba3-b562-d2de-07ef-e4af8dfdffac@baylibre.com>
Date:   Thu, 27 Jan 2022 13:59:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfKQJejh0bfGYvof@anyang>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 13:29, Dongjin Kim wrote:
> Typo in audio amplifier node, dioo2133 -> dio2133
>

Fixes: ef599f5f3e10 ("arm64: dts: meson: convert ODROID-N2 to dtsi")
Fixes: 67d141c1f8e6 ("arm64: dts: meson: odroid-n2: add jack audio output support")

> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index aa5898a58b89..120f2551a28b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -22,7 +22,7 @@ aliases {
>  		spi0 = &spicc0;
>  	};
>  
> -	dioo2133: audio-amplifier-0 {
> +	dio2133: audio-amplifier-0 {
>  		compatible = "simple-audio-amplifier";
>  		enable-gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
>  		VCC-supply = <&vcc_5v>;
> @@ -222,7 +222,7 @@ sound {
>  		audio-widgets = "Line", "Lineout";
>  		audio-aux-devs = <&tdmout_b>, <&tdmout_c>, <&tdmin_a>,
>  				 <&tdmin_b>, <&tdmin_c>, <&tdmin_lb>,
> -				 <&dioo2133>;
> +				 <&dio2133>;
>  		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>  				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>  				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
