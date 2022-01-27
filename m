Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD85C49DA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiA0F5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiA0F5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:57:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69853C061714;
        Wed, 26 Jan 2022 21:57:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id n10so2146316edv.2;
        Wed, 26 Jan 2022 21:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rtoTYqjQ8PbChSKR1PmaXjaY2py2OwAJLT1zQ2IW+3M=;
        b=HHhMl6Gjxz0Qn0fJ49nRZAqDu+g/ehm7+7f2P62+EftZ3LIkhgkuyNxI+pXVcXRrBZ
         mJlc34CNAjWW8HYZCP1vG1m1RpKZb1lhlMbH/fCJ/LR4C9CekW0SttplCbbnENZJ5RLo
         vnVoIYiqdNWAi/OguKSvD/vgyoXRvrjbCgYYHdJbq80J0UxEcQXa8qT/FE2IBbM7In8V
         ckXYtwn/Z0QYeGRtfVQli5CHrvuZRkm8JpZeD5J/V7hUM/GSf2DkW5ETTyOy62DMF2jI
         1K29DTvc/VzryA95w51Ma1MaaumXxF7W2+8hkmkhcL2HhS04DQSWBEOGqDmZkdDdjCbB
         UCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rtoTYqjQ8PbChSKR1PmaXjaY2py2OwAJLT1zQ2IW+3M=;
        b=oRyQ1IQl89kIB5EJyb9rVmG8EqW2d7L8NrEYyZ5zPPrE1e62mPoaZ4/rcRyKOFZJmI
         4IBd1X90zlyIZHi12n7Ixn9rDuBgBYxcKchMq/KX9fUorNxBdLDOLgMs/kxXq87V+8PJ
         7rCbmaJp7DaTkDMftD/Jcxvy2S10ESkjGUNU+DqNKtp9ECjVu3en30YfhThtNS/jRISd
         kvQs+uWgsHYGJLhQuPAu1A2XIepcbWf3ju1f/+gHD6+EejjBBJvRqBnvrva0gGJHu6XU
         SX0x14RDCCEJ8zvRqkRzCsMHHWtiF66sUZclPtXXtAYhTxhAiAArlGwajZqcgHZnNRoe
         iBGQ==
X-Gm-Message-State: AOAM533PzOG4iE/BihM7i/RSOWE8fV/ggV7qLjvvX0YfHh3WjcDrDntR
        Xf/pupicj18IqeAyu2eIOdQ=
X-Google-Smtp-Source: ABdhPJz5Ch0dyPmyMf9mI+Ne9qs7BcjCptofSyeC6Yd4Bewk40Z0j2uXNyCboGiILHVradbKAh8+vQ==
X-Received: by 2002:a05:6402:387:: with SMTP id o7mr2119776edv.253.1643263021855;
        Wed, 26 Jan 2022 21:57:01 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g27sm8211426ejf.108.2022.01.26.21.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 21:57:01 -0800 (PST)
Message-ID: <e2479729-154a-122f-f2e0-89b62ffe2c8d@gmail.com>
Date:   Thu, 27 Jan 2022 06:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add Quartz64-A pmu_io_domains
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127010023.3169415-1-pgwipeout@gmail.com>
 <20220127010023.3169415-3-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220127010023.3169415-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 1/27/22 02:00, Peter Geis wrote:
> Several io power domains on the Quartz64-A operate at 1.8v.
> Add the pmu_io_domains definition to enable support for this.
> This permits the enablement of the following features:
> sdio - wifi support
> sdhci - mmc-hs200-1_8v
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index d9eb92d59099..33c2c18caaa9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -482,6 +482,19 @@ vcc_sd_h: vcc-sd-h {
>  	};
>  };
>  

https://files.pine64.org/doc/quartz64/Quartz64_model-A_schematic_v2.0_20210427.pdf

Could you check with the IO Power Domain Map?

> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
VCC3V3_PMU

> +	pmuio2-supply = <&vcc3v3_pmu>;
VCC3V3_PMU

> +	vccio1-supply = <&vccio_acodec>;
VCCIO_ACODEC

> +	vccio2-supply = <&vcc_1v8>;
VCC_1V8

> +	vccio3-supply = <&vccio_sd>;
VCCIO_SD

> +	vccio4-supply = <&vcc_1v8>;
==> VCC1V8_PMU

> +	vccio5-supply = <&vcc_3v3>;
==> VCC_1V8

> +	vccio6-supply = <&vcc1v8_dvp>;
VCC1V8_DVP

> +	vccio7-supply = <&vcc_3v3>;
VCC_3V3

> +	status = "okay";
> +};
> +
>  &sdhci {
>  	bus-width = <8>;
>  	mmc-hs200-1_8v;
