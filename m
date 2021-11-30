Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4294B463130
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhK3Klr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhK3Klq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:41:46 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18820C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:38:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso14399602wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0WDfd094hQCN0b1mr/jtcBWQltUMMlx+eNjznbKeQ4=;
        b=7SIqr26sShwrURTElJbKQo2AiIjg4/wznyjqLPhBMKebkmMz04shyLIxiit9A/662M
         Dmpr+iFssBUkkJPw5Or/lExLW1GwIaKBSlxY4aayeuuXXu0sVAtb8LvJ+IlxIrf98oQ4
         DcSSpx6EKJA4macVtc1iR+GpJ1ZqtRkYtkKM29sv6zLiSsi0k8QicLE9iMn9EqaMEJV2
         EMuMq6xuQYozpGr3yc7e7hMhd51Cc37IABldQLbeHRU2X5MNkfPexj6nELnd80LtvuP2
         2nvvfRyn+aZX+yKyy5lnq9NGj7jwsGtUKOmBBFhmNajkFMlFtHKtu/7gZSMZo1j3p6yD
         IqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=S0WDfd094hQCN0b1mr/jtcBWQltUMMlx+eNjznbKeQ4=;
        b=dq9R+p7D7b42GKUua20ycjIuL197LCGj6jedbxQ8F1PQWY+MUD2/yX5FXGUg4TaqEK
         fYs4pOhEMAt+cM5vbAzmwMcSUKVTQPCe4QIW/i7Hk525mty4t+4A99fQiHilmsIzIlFg
         KjNBMyR038TUIbsjmmTRwQbhxzFuNlNvpXf5qHSX5zrmB3+6pVrQDM/+WWUsqHNPlPv7
         vVEOx9aU6B+LWGcXf67R/Ds7zHcpdIlAwfIwOz+lk+brx2nwF+LPGrUo6GQrUNGgpz0c
         y0OLYOtXNi74REuGhLIUwzDH1BKP//GCTMuaADk6aaL175+g/6M1av8vDD8YC+eV7kCx
         kTpA==
X-Gm-Message-State: AOAM530LZcVHMHM0o5WCPIFI2RgKmwTx8Z57OMApLiYJMwqynjVXrf8A
        evGnYNU9tsAkHgLSyAGtSmWUVeR1tXeny+im
X-Google-Smtp-Source: ABdhPJzTeWm9B82jXzzbIKkAI0LYt5rTHVxwV2dBT3C4jipfItJRJuoBY5e+ItbeIuLu6Nom/Nhlcw==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr4034600wmq.50.1638268705210;
        Tue, 30 Nov 2021 02:38:25 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a? ([2001:861:44c0:66c0:f80b:b9bd:4d6e:b61a])
        by smtp.gmail.com with ESMTPSA id b15sm14411169wri.62.2021.11.30.02.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 02:38:24 -0800 (PST)
Subject: Re: [PATCH] arm64: meson: fix dts for JetHub D1
To:     Vyacheslav Bocharov <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211125130246.1086627-1-adeep@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7f61ef3a-5ae5-086b-c63c-3b7b1ea28f13@baylibre.com>
Date:   Tue, 30 Nov 2021 11:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211125130246.1086627-1-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2021 14:02, Vyacheslav Bocharov wrote:
> Fix misplace of cpu_cooling_maps for JetHub D1, move it to right place.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  .../amlogic/meson-axg-jethome-jethub-j100.dts | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> index 52ebe371df26..561eec21b4de 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> @@ -134,23 +134,23 @@ cpu_critical: cpu-critical {
>  					type = "critical";
>  				};
>  			};
> -		};
>  
> -		cpu_cooling_maps: cooling-maps {
> -			map0 {
> -				trip = <&cpu_passive>;
> -				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -			};
> +			cpu_cooling_maps: cooling-maps {
> +				map0 {
> +					trip = <&cpu_passive>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
>  
> -			map1 {
> -				trip = <&cpu_hot>;
> -				cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				map1 {
> +					trip = <&cpu_hot>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
>  			};
>  		};
>  	};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
