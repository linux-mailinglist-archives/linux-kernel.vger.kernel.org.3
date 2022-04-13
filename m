Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CB4FF4AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiDMKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDMKaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:30:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7F473AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:28:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 21so1839433edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R3EQcXNwiHoGLibRNZM84Xx3HLPLT7OeOsdWHMolBU0=;
        b=XjBwrxbZnOFSYpEjeTAJSHsPIraWNt7Z8dFNiQaWOB+yk0a6RkQURtgBGEGR3R4k2N
         dZW8o/op1DQf9VHN5WCBB5DNfQR/q45etGnwKF7DsnCKkCmOT3SRlFYPKZZ/4ydV+pZ9
         tItVyhmspl+n2Qdczec9WNxbfLjX2Tu6vlGTxN12p14vATW9xRC9GcCEsMgx5wAx/pdn
         dBOAbWxaR5Bc32H+i/Z7NqnhC/A5iZczQeAo9proLHjWrmNHupzQDUK9uodxJlArAJdf
         kAc+Wk2SrZ3S+NwUhy9AkMvlSPueCmXHk6FQZis9Vlaq1T7QtWRLD0tTANWAOZPRiG0+
         4VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R3EQcXNwiHoGLibRNZM84Xx3HLPLT7OeOsdWHMolBU0=;
        b=rwPhQd9pi6xTcq1cbrbwsQPYqELs2R9yUPjK9c8gDQnkrI/5hAcd4bepMFvUlzFSEO
         RDo9vtMWkYtMJMfRKGL8jYCN1wfG0dmVebp6acd2iy3gQG/a5rVn9war/C4SBl3SWgCS
         yl6GNuzcQIDFTQVlhf6NSKp9+fTLddv2K4niq021jyy6H2421rcl722Md5NJfOAq9e9k
         8IqlyV77laGWqjDQxlV8BFmV+qW5eXNA5ecKFiS23pPii9vJ7voN0lX7KTyA+2m12hWo
         qUZHElwP+g6pFACAl+HoIfIHWGC7PHiGvx1YaBHlnILT99SeNEEdPp4dkwYbt/sPt/A9
         v1wA==
X-Gm-Message-State: AOAM531f2OylaxUyghivp++EXwoKcNMmdTDMz1LVmoD/WT69e1pg7q5a
        4GoCYE5VzK86gnWAO9Docz4mTA==
X-Google-Smtp-Source: ABdhPJxPBKrnJ5zL7mJn2c/3VCB1NQBYCwUBGLxjcK4aAJIpKXzcg2mnhESD2bvp5MpHvuaGCtmKUw==
X-Received: by 2002:a05:6402:42cb:b0:41e:ce5:f02c with SMTP id i11-20020a05640242cb00b0041e0ce5f02cmr3717675edc.74.1649845681551;
        Wed, 13 Apr 2022 03:28:01 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709067c0c00b006e86db76851sm5099383ejo.193.2022.04.13.03.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:28:01 -0700 (PDT)
Message-ID: <c6fe3895-29b2-a371-ccae-c5a12c45d4f1@linaro.org>
Date:   Wed, 13 Apr 2022 12:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: add pwm1/backlight support
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220413102052.20207-1-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413102052.20207-1-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 12:20, Tommaso Merciai wrote:
> Add pwm1/backlight support nodes for imx8mm_evk board. Align with u-boot
> dts
> 
> References:
>  - https://patchwork.ozlabs.org/project/uboot/patch/20220326111911.13720-9-tommaso.merciai@amarulasolutions.com/
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index 6d67df7692f1..55566708f667 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -59,6 +59,15 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  	};
>  
> +	backlight: backlight {
> +		status = "disabled";

Why disabled?

> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 5000000>;
> +		brightness-levels = <0 255>;
> +		num-interpolated-steps = <255>;
> +		default-brightness-level = <250>;
> +	};
> +
>  	ir-receiver {
>  		compatible = "gpio-ir-receiver";
>  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> @@ -395,6 +404,12 @@ &wdog1 {
>  	status = "okay";
>  };
>  
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_backlight>;
> +	status = "disabled";

Same here.


Best regards,
Krzysztof
