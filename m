Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB1E4C868E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiCAIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCAIeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:34:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9029B27FFC;
        Tue,  1 Mar 2022 00:33:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so801129wmb.1;
        Tue, 01 Mar 2022 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LkrTcQQbt/9+kZrb/G+6KYClsmPdfv/aEHScRzi5ZAs=;
        b=mtj+dI+NVw8LeXLhTCnZeZgjE3M77ddOgX9ienReKqhu6eqXMGaGvl7kUgLxrH/imx
         zZL610ITo2FA7KruB9rkrHKT4/Lwpt/A3V3047Sb8rZzaecQu8EuVpKZycFqjIf+Ea4F
         1Ysqyx7vO9OwDlQTRcD+6O6gpHTx7Fw5Hw+exkYLnkC+IckNQZ9/lqdjjYftid5gPmse
         d7D0a0z9p529s7UIwJUtQlgVGEp3iWEeBgftNB1BSDhHTWNlWvSwbDKAGdVMajt29Ily
         0TwJaiR/lZw0rkHIIdH1NSpo+w34uoy7kF+7eM0po8sA+nNKCN9ARHCMjWC/Mjt8tVU9
         1rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LkrTcQQbt/9+kZrb/G+6KYClsmPdfv/aEHScRzi5ZAs=;
        b=7hnRhBnHhc1xCk5Uti9CJqOdl32R4Osfyr1p04QiKqF9DeqRIbGpO00VKbW6lagESZ
         KtQyin/6wDFLJZfkeFcFsyFyOdnik/3/n9HCI9+08Tm+8x49CIkXANXCbjMCukBMyNHr
         EdV6MDG3cVQhH1VWmELT8wfPIghP2kDLUuAoDc2PZm7ckORSH+VEDDv1qUEknfSw8ANY
         7E7xUhmTuncemW6Jg2Fs5Fb2/XmyR5LZPI1uXsKPkGZror+zfLd/3iFNYxvR/zdQLdW/
         II8Gr+Y21coFqmotLAM2Dl8xOo+gxzMhQLLQ7qzz52GbKqxyBcInjcpMaZsV4LX5netE
         V/vA==
X-Gm-Message-State: AOAM532M9xwhExwFwRLPUsYSt+NxeTVni+9vpDoCZsPlvjUdjzy6iShL
        Ac2++EQ9HvlEuRo+XQRubbM=
X-Google-Smtp-Source: ABdhPJwgp8UucD4OAX8skQYsYngCTn4CiMKZRKK9OmCXn08gSTewF+CNCCfhF6TU4XyQpJj6ERIYSQ==
X-Received: by 2002:a05:600c:508:b0:380:fd39:2c42 with SMTP id i8-20020a05600c050800b00380fd392c42mr15993789wmc.178.1646123616070;
        Tue, 01 Mar 2022 00:33:36 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q17-20020adfc511000000b001edc0a8a8b6sm19256706wrf.0.2022.03.01.00.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:33:35 -0800 (PST)
Message-ID: <232259a8-1cce-002b-3f46-916425de1d69@gmail.com>
Date:   Tue, 1 Mar 2022 09:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] arm64: dts: mediatek: add clock support for mt7986a
Content-Language: en-US
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>
References: <20220119123624.10043-1-sam.shih@mediatek.com>
 <20220119123624.10043-2-sam.shih@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220119123624.10043-2-sam.shih@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/2022 13:36, Sam Shih wrote:
> Add clock controller nodes, include 40M clock source, topckgen,
> infracfg, apmixedsys and ethernet subsystem.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 68 +++++++++++++++++++++--
>   1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index b8da76b6ba47..694acf8f5b70 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -6,16 +6,18 @@
>   
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/mt7986-clk.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> -	system_clk: dummy40m {
> +	clk40m: oscillator@0 {
>   		compatible = "fixed-clock";
>   		clock-frequency = <40000000>;
>   		#clock-cells = <0>;
> +		clock-output-names = "clkxtal";
>   	};
>   
>   	cpus {
> @@ -98,6 +100,18 @@ gic: interrupt-controller@c000000 {
>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		infracfg: infracfg@10001000 {
> +			compatible = "mediatek,mt7986-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		topckgen: topckgen@1001b000 {
> +			compatible = "mediatek,mt7986-topckgen", "syscon";
> +			reg = <0 0x1001B000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>   		watchdog: watchdog@1001c000 {
>   			compatible = "mediatek,mt7986-wdt",
>   				     "mediatek,mt6589-wdt";
> @@ -107,6 +121,12 @@ watchdog: watchdog@1001c000 {
>   			status = "disabled";
>   		};
>   
> +		apmixedsys: apmixedsys@1001e000 {
> +			compatible = "mediatek,mt7986-apmixedsys";
> +			reg = <0 0x1001E000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>   		pio: pinctrl@1001f000 {
>   			compatible = "mediatek,mt7986a-pinctrl";
>   			reg = <0 0x1001f000 0 0x1000>,
> @@ -128,11 +148,25 @@ pio: pinctrl@1001f000 {
>   			#interrupt-cells = <2>;
>   		};
>   
> +		sgmiisys0: syscon@10060000 {
> +			compatible = "mediatek,mt7986-sgmiisys_0",
> +				     "syscon";
> +			reg = <0 0x10060000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sgmiisys1: syscon@10070000 {
> +			compatible = "mediatek,mt7986-sgmiisys_1",
> +				     "syscon";
> +			reg = <0 0x10070000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>   		trng: trng@1020f000 {
>   			compatible = "mediatek,mt7986-rng",
>   				     "mediatek,mt7623-rng";
>   			reg = <0 0x1020f000 0 0x100>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_TRNG_CK>;
>   			clock-names = "rng";
>   			status = "disabled";
>   		};
> @@ -142,7 +176,13 @@ uart0: serial@11002000 {
>   				     "mediatek,mt6577-uart";
>   			reg = <0 0x11002000 0 0x400>;
>   			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART0_SEL>,
> +				 <&infracfg CLK_INFRA_UART0_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&topckgen CLK_TOP_UART_SEL>,
> +					  <&infracfg CLK_INFRA_UART0_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_XTAL>,
> +						 <&topckgen CLK_TOP_UART_SEL>;
>   			status = "disabled";
>   		};
>   
> @@ -151,7 +191,11 @@ uart1: serial@11003000 {
>   				     "mediatek,mt6577-uart";
>   			reg = <0 0x11003000 0 0x400>;
>   			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART1_SEL>,
> +				 <&infracfg CLK_INFRA_UART1_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&infracfg CLK_INFRA_UART1_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
>   			status = "disabled";
>   		};
>   
> @@ -160,10 +204,24 @@ uart2: serial@11004000 {
>   				     "mediatek,mt6577-uart";
>   			reg = <0 0x11004000 0 0x400>;
>   			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&system_clk>;
> +			clocks = <&infracfg CLK_INFRA_UART2_SEL>,
> +				 <&infracfg CLK_INFRA_UART2_CK>;
> +			clock-names = "baud", "bus";
> +			assigned-clocks = <&infracfg CLK_INFRA_UART2_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_F26M_SEL>;
>   			status = "disabled";
>   		};
>   
> +		ethsys: syscon@15000000 {
> +			 #address-cells = <1>;
> +			 #size-cells = <1>;
> +			 compatible = "mediatek,mt7986-ethsys",
> +				      "syscon";
> +			 reg = <0 0x15000000 0 0x1000>;
> +			 #clock-cells = <1>;
> +			 #reset-cells = <1>;
> +		};
> +
>   	};
>   
>   };
