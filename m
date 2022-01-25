Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25949B3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383915AbiAYMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355805AbiAYMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:14:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DAC06173D;
        Tue, 25 Jan 2022 04:14:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jx6so30442555ejb.0;
        Tue, 25 Jan 2022 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vvFgFjh/h8Rzded/DiWiu2ZGRJkVIhHilEl7/kR6X8M=;
        b=k+TGVTJJ7eqYdNfHflsvQ0/CtFdbBeyJUdmt0tPSKVTZwZpnQWB0AqQ7OowpIVboW+
         f+BeYrtvnbGdpstNuxicHa9jJOnpnLJ+6q7vTx6tBuKY79FZXNWDhYmhz6pHLnNnI9eE
         C3YTjGB4s37lbKmD8tPz/H1r/g3zy4F5HQxqpS7J7j6tCXWUElEEVWhYHKt28I2kUgTO
         jZzCGwis0NR/jBYNu8veItHwD9Kp0wtBwYWiz2oceRB0YwQiazbvnZb1YT13h3ZnMvgF
         TWeq44HJuMwpzLOFgfwpkBUca7QGUPoAsjWGe689iKFNt99XpE4PFhgSxd5dsR739K+u
         TcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vvFgFjh/h8Rzded/DiWiu2ZGRJkVIhHilEl7/kR6X8M=;
        b=LxF7CN3uIOR0qinX49FfpE3vvtjF3cNngd0ofQUUqdaksbqJW6Cgf7IGQ1ie7JJTvS
         XfKWbugYyR4DA/CvX8wjKS007Gmlkars1DuHABE9EZCXgUT9SPu+9la0GqIBbNR4Nsxh
         qq/Lpt0zuXShtvAiA3E1GikkrphbA8YtNEwwKsJm1fALLWminFB8+/JxFDZuDBboT7BE
         2FuxYMKCfaCQvNkhcdg+GiGBNTRO0OeSeV4oOBJ/6GJzvhx/22nsoTlOeLq89BfaA9DW
         S/c1bnlIZZF4FtZktMMZsonyP/PenroHfdESCogwCqeGGoLKp0kfNBiyxAFn8Up+XbXC
         aWNQ==
X-Gm-Message-State: AOAM531wUB5S4Ztn+fVmZ6Av8f9oifCwq6K7dYIsJN7KVLRc0imWJtFX
        iKyMVrmx9ENBZmlgD7J+EnE=
X-Google-Smtp-Source: ABdhPJzNj7jDwhu3m6E+S4oK27aeFpCkMtpa7L9AlQobvrCSyRqA3TwmwStawhWD+mzUWp69QrW1VA==
X-Received: by 2002:a17:906:d542:: with SMTP id cr2mr16059095ejc.720.1643112862686;
        Tue, 25 Jan 2022 04:14:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o11sm8173097edh.75.2022.01.25.04.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:14:22 -0800 (PST)
Message-ID: <7e935740-66a3-da07-a196-0584dab310b9@gmail.com>
Date:   Tue, 25 Jan 2022 13:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ARM: dts: rockchip: fix MMC compatibles for rk3288
Content-Language: en-US
To:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220125115007.3138311-1-john@metanate.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220125115007.3138311-1-john@metanate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

MMC aliases should go in the dts board files.
Sort on reg address, based on availability and without number gab.
(For rk3288 a lot of boards to change. That's why it wasn't done
yet...Could someone pick that up?)

Johan

On 1/25/22 12:50, John Keeping wrote:
> Prior to commit 4bac670aa5cb ("mmc: dw_mmc: rockchip: use common_caps")
> the mshcN aliases were used in an unusual way by the dw_mmc driver and
> affected behaviour.  Now that this has been fixed, rename the mmc
> aliases to use the standard form.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index aaaa61875701..50fa0a4652b5 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -25,10 +25,10 @@ aliases {
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> -		mshc0 = &emmc;
> -		mshc1 = &sdmmc;
> -		mshc2 = &sdio0;
> -		mshc3 = &sdio1;
> +		mmc0 = &emmc;
> +		mmc1 = &sdmmc;
> +		mmc2 = &sdio0;
> +		mmc3 = &sdio1;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  		serial2 = &uart2;
