Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B781646BDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhLGOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhLGOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:39:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C905C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:36:04 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so18299356otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ca/ZfVcUU8maYjpZU9kIokWeUgbOFULJH3lKSEdkVJ4=;
        b=Smp16oE41OT4RZ7NYx1mmQJkQUSTLC8DhW/PDPMu1ZRkCZ3sdae5MCFcRPxyPvzdXq
         EVkzkGSg59ygUTFwR7ES+fyPpZKMwR1FTZ7lKeP8bwSAm6uF7vGyBT+3OT5hGAYpHx4I
         u/L/C7IAmbnQNJuEGTwQ5OAYzvS7G+neUF4i3Zf4wsPCHwCRX++dwi+DSPoqpNflkdGz
         wfBUKA7eG+uaBRKzz1UUbshqpvWxYP2dIBPOUYizQ6P3m6jwx2PoMyGLNkOyR1RbT1Bi
         6EUdL/SIim4EeOThLfHxi9FAEtKzPmtTz4EvjiIOIIFT8y8j7Gy85WMNN2E2N5k6FQDE
         Ydgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ca/ZfVcUU8maYjpZU9kIokWeUgbOFULJH3lKSEdkVJ4=;
        b=yVPCh7JLkiSXXVUrHvHXGCjAFA8MDSLBZ+3JjbehDsISsvcpyrbUYyRTeRmPhu8LMW
         rYGLKz8Tgnw6NH8RCy/2i3U5HePZgJIV6FBKVmLDT/vZKK1DbGKcRwQqk1PLIf6pdvOu
         /znJ9lOWVfx+r5KXGXfp/gOOgBUfMwc1hYhHyxAcbAX6+L91dAujsyW3OZPN+hrGJD9M
         hTuJFGQldTYRG3E8YFkRUpJZBL+OEtnJTSZ5myWrtn5QRhg1Gog0oRcawZKv2HXzBTN4
         RVcZ5W/Zw0IQ0h/2Bj5qUPrlhvxvFNdmD2rZdo608UidRC2vVKKIxxPiXk53Hm5LbAkb
         mMuA==
X-Gm-Message-State: AOAM531XtNQut/XxO7pkn1uB5BMGtoUgDnkHRYQfR8WYVBeUZt/KyWxC
        ER9mjoFiy6fGYaMJVjVFG0BuoA==
X-Google-Smtp-Source: ABdhPJzHJhrjhZAdmpGWiPf/jWB2MNrH/VVlJFPVle9dCIUU6hLaq07NInEaQmlN6pLDndblmOTKeg==
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr35505970otj.16.1638887764000;
        Tue, 07 Dec 2021 06:36:04 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v10sm2790947oor.33.2021.12.07.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:36:03 -0800 (PST)
Date:   Tue, 7 Dec 2021 06:37:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] arm64: dts: qcom: sm8450: Add tlmm nodes
Message-ID: <Ya9xqfuN/4dCrLxr@ripper>
References: <20211201072915.3969178-1-vkoul@kernel.org>
 <20211201072915.3969178-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072915.3969178-4-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Nov 23:29 PST 2021, Vinod Koul wrote:

> Add tlmm node found in SM8450 SoC and uart pin configuration
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index d838283bde4b..f0b9e80238a2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -343,6 +343,8 @@ uart7: serial@99c000 {
>  				reg = <0 0x0099c000 0 0x4000>;
>  				clock-names = "se";
>  				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&qup_uart7_default_state>;
>  				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -366,6 +368,33 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		tlmm: pinctrl@f100000 {
> +			compatible = "qcom,sm8450-tlmm";
> +			reg = <0 0x0f100000 0 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 211>;
> +			wakeup-parent = <&pdc>;
> +
> +			qup_uart7_default_state: qup-uart3-default-state {

There's a '3' in the node name.

Loos good otherwise.

Thanks,
Bjorn

> +				rx {
> +					pins = "gpio26";
> +					function = "qup7";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +				tx {
> +					pins = "gpio27";
> +					function = "qup7";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +		};
> +
>  		intc: interrupt-controller@17100000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;
> -- 
> 2.31.1
> 
