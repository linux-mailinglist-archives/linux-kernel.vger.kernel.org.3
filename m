Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB866490A82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiAQOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbiAQOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:32:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39855C061749
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:32:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so23149303wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JkVqqY9kZfQlCXm2Gf4qVdWbnEyCYzJMqa1tKAalEO0=;
        b=GwOd4qQ17iTBKi/M2U09g7wFRrZ7O1AcmcJsEB4JxJHNHmQDDZeuIJcVxi2iKOt3LI
         sjaEewjLWKtdO/Fcual2luU6kyA/r/EhCe/KRLfQCueOCNTkSduqbysao57Bo1lhmYd3
         9nJ2sk3UjPwh1ZMjx58Us5bV0deT7dp2w8u/N/lzJXfHKSKUxLE8fZ2ZTAGJ4djz2uhW
         p47foC9ykdJDRwLlldDV++bMlA9SPs7gMkmOzuG+Dss144I1w2tuj+ByGPpp5opg4XIw
         JE/LAuQe99lypus2YI8qHf4+JPmy+9ACu6dXlxpf5GjHixnpKmryC2HsPo828+KHOKsM
         uHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JkVqqY9kZfQlCXm2Gf4qVdWbnEyCYzJMqa1tKAalEO0=;
        b=6PNu8yN0y0H+cTRU9JwRIMk5kWsrlIJgrtgPhDlqyi1s/KmtgPnd9ROCxO0XKCmHFV
         6NzMWEx55bGcl6HiZdBjreHPK36pEqVrsvzJtyeNscEVxyClO5FQ6oUibH4DO47Ba9nq
         +0faZNXUiJrAVUFjnGZyjZ6asWvrp769kmUD8j7ZWjhCOoM0eQONpAcUk1iT64zsp0mX
         nhpdV5eHD31g45FlwPrxCDwkO8PzsNIS2vbMGBUXWSVOHU9Lv6qgmubSRQJiGu0jn83p
         i3Fp/IN3r4wjIRH7mSN3NRYVyVvstDvsl0D/irM4o1XqNrWQoDT5k102bUG08neCOWFf
         WKhA==
X-Gm-Message-State: AOAM533ye9mfP8Yo4tA2eXmCnwkX7RA6Sd5IG/LdZVTY1usr+uPdpk7Z
        hNPgsp6ytp9dBpnhLf34FwUKcJZCUM4WUQ==
X-Google-Smtp-Source: ABdhPJy96ZZV8+Ibug5tTlQussK4v5Du7LmRau62LTD73sovJWJzj+U7KynntUu/47ZyvxG+FR4F6A==
X-Received: by 2002:a5d:6d89:: with SMTP id l9mr15499890wrs.14.1642429925354;
        Mon, 17 Jan 2022 06:32:05 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:c004:9fe1:fbda:2d0c? ([2001:861:44c0:66c0:c004:9fe1:fbda:2d0c])
        by smtp.gmail.com with ESMTPSA id y9sm6702962wrm.94.2022.01.17.06.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:32:04 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: dts: meson: add Broadcom WiFi to P212 dtsi
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220113041746.16040-1-christianshewitt@gmail.com>
 <20220113041746.16040-2-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <927257db-1338-af1c-3198-3153e122967b@baylibre.com>
Date:   Mon, 17 Jan 2022 15:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113041746.16040-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 05:17, Christian Hewitt wrote:
> The P212 has a combined WiFi/BT module. The BT side is already enabled
> in the dtsi but the WiFi side is not. Let's tweak SDIO speed (in-line
> with other GXL/GXM devices) and enable the WiFi module.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 05cb2f5e5c36..c635e5858929 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -113,7 +113,7 @@
>  
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> -	max-frequency = <50000000>;
> +	max-frequency = <100000000>;
>  
>  	non-removable;
>  	disable-wp;
> @@ -125,6 +125,11 @@
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
>  };
>  
>  /* SD card */
> 

As I commented in patch 3, the 2 changes should be split.

When you resend, you can put my:

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

in both patches.

Neil
