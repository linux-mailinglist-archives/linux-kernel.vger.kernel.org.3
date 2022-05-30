Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77678538796
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiE3Szj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbiE3SzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:55:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D409B1AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:55:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f21so22391841ejh.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d8jz6yy04RZpYVju6I1nUJOzV31CIoBhvUwccQjlYuQ=;
        b=CPEMxREMxajdKrg4N4452mUrbH0EBE7qqCF1yilC3r94zhdjZkRwBGxMhlSyrgll2F
         ysltOe4JsQvs6qSzdkc/nqaA7vJgdattpQhQNilncrxAW4zGo5uRHslnGk/QZefny8HU
         7Bw4nK+splyhw0dWHSOVHAIZZRiqmi2HpYLPAIzqCjm+9pmC4uON89Aik2WuMkyqODwR
         n6wbxTF2EYc+TqxvRb1Hf9PbQR+6+fXkt0JNcwJF6+JYhaoEJ8EiGpt5n7jFi6kFXLZC
         svp8M5NDmIkcp7HhyeuDSkubinDo7GIPTwa+7hRwZ5+ntZMWUxxC9dNgvb5zfzulpBVA
         kr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d8jz6yy04RZpYVju6I1nUJOzV31CIoBhvUwccQjlYuQ=;
        b=p9MWl8vsTpKmeHf3BV205rCtNmYpQ41KXeFjzR5FJetlwXYZEbY/yTkLUom5iIfWAF
         2YBSqQAIJjwEjcp6N7XoNotAdi3HcGZvh5JJywiZ4jv3ZnKWAeXLe1yUM1uC8GsP+HKU
         8Ul7rrdbkLQCrS15aXqjSkLXnDxDJBTM1NYbgAf6vT7AdHMLiEDxfwHb7ZoSu7ut8pHl
         BrdLizgiSFyJPgWdr5cPeX06Yb6Ugq/g703VQpHlUB3RBHq3+ErywCy7Xnom+uaRX1Nj
         i7RaYepLNtsti6FwOrhtypNtwfDo1ciWXkRbZjJcteIlHs2KN+8L/Omn3DqtOZSv8I2P
         aPZg==
X-Gm-Message-State: AOAM533qEsMyxITi/BnI0NAUd9esiVslbTiucsXRd4N5SMxn/pf/jGtS
        yGUcm5tDPjyjvtXgk18iQ9p2Hw==
X-Google-Smtp-Source: ABdhPJzwk9pDtaC1Pv9ltsngCaUPI5mE/EH3pP2OH7hunJQmLWwPbfqwashPfm4KwDjz/sh26/qFmQ==
X-Received: by 2002:a17:907:7d86:b0:6ff:1598:b049 with SMTP id oz6-20020a1709077d8600b006ff1598b049mr23254206ejc.637.1653936916192;
        Mon, 30 May 2022 11:55:16 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z19-20020a50e693000000b0042ab2127051sm7134669edm.64.2022.05.30.11.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 11:55:15 -0700 (PDT)
Message-ID: <73f01056-e674-d910-1c0d-98c4001f909d@linaro.org>
Date:   Mon, 30 May 2022 20:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dts: socfpga: Change Mercury+ AA1 devicetree to
 header
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org
References: <20220530130839.120710-1-pan@semihalf.com>
 <20220530130839.120710-2-pan@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530130839.120710-2-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 15:08, Paweł Anikiel wrote:
> The Mercury+ AA1 is not a standalone board, rather it's a module
> with an Arria 10 SoC and some peripherals on it. Remove everything that
> is not strictly related to the module.

Subject has several issues:
1. Use prefix matching subsystem (git log --oneline)
2. You are not changing here anything to header. Header files have
different format and end with .h. This is a DTSI file.

> 
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  arch/arm/boot/dts/Makefile                    |  1 -
>  ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 68 ++++---------------
>  2 files changed, 14 insertions(+), 55 deletions(-)
>  rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (58%)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index edfbedaa6168..023c8b4ba45c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1146,7 +1146,6 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
>  	s5pv210-torbreck.dtb
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
>  	socfpga_arria5_socdk.dtb \
> -	socfpga_arria10_mercury_aa1.dtb \
>  	socfpga_arria10_socdk_nand.dtb \
>  	socfpga_arria10_socdk_qspi.dtb \
>  	socfpga_arria10_socdk_sdmmc.dtb \
> diff --git a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
> similarity index 58%
> rename from arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
> rename to arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
> index a75c059b6727..fee1fc39bb2b 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dts
> +++ b/arch/arm/boot/dts/socfpga_arria10_mercury_aa1.dtsi
> @@ -1,57 +1,38 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> +/*
> + * Copyright 2022 Google LLC
> + */

How is this related to the patch?

>  #include "socfpga_arria10.dtsi"
>  
>  / {
> -
> -	model = "Enclustra Mercury AA1";
> -	compatible = "enclustra,mercury-aa1", "altr,socfpga-arria10", "altr,socfpga";
> -
>  	aliases {
>  		ethernet0 = &gmac0;
>  		serial1 = &uart1;
> -		i2c0 = &i2c0;
> -		i2c1 = &i2c1;
> -	};
> -
> -	memory@0 {
> -		name = "memory";
> -		device_type = "memory";
> -		reg = <0x0 0x80000000>; /* 2GB */
>  	};
>  
>  	chosen {
>  		stdout-path = "serial1:115200n8";
>  	};
> -};
>  
> -&eccmgr {
> -	sdmmca-ecc@ff8c2c00 {
> -		compatible = "altr,socfpga-sdmmc-ecc";
> -		reg = <0xff8c2c00 0x400>;
> -		altr,ecc-parent = <&mmc>;
> -		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
> -			     <47 IRQ_TYPE_LEVEL_HIGH>,
> -			     <16 IRQ_TYPE_LEVEL_HIGH>,
> -			     <48 IRQ_TYPE_LEVEL_HIGH>;
> +	memory@0 {
> +		name = "memory";
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>; /* 2GB */
>  	};
>  };
>  
>  &gmac0 {
>  	phy-mode = "rgmii";
> -	phy-addr = <0xffffffff>; /* probe for phy addr */
> +	phy-handle = <&phy3>;
>  
>  	max-frame-size = <3800>;
> -	status = "okay";
> -
> -	phy-handle = <&phy3>;
>  
>  	mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "snps,dwmac-mdio";
>  		phy3: ethernet-phy@3 {
> +			reg = <3>;
>  			txd0-skew-ps = <0>; /* -420ps */
>  			txd1-skew-ps = <0>; /* -420ps */
>  			txd2-skew-ps = <0>; /* -420ps */
> @@ -64,35 +45,23 @@ phy3: ethernet-phy@3 {
>  			txc-skew-ps = <1860>; /* 960ps */
>  			rxdv-skew-ps = <420>; /* 0ps */
>  			rxc-skew-ps = <1680>; /* 780ps */
> -			reg = <3>;

This and few other changes (like memory) are not related to the commit.
Do not mix different cleanups together.

>  		};
>  	};
>  };
>  
> -&gpio0 {
> -	status = "okay";
> -};
> -
> -&gpio1 {
> -	status = "okay";
> -};
> -
> -&gpio2 {
> -	status = "okay";
> -};

Why removing all these? Aren't they available on the SoM? The same
question applies to several other pieces, for example UART and USB -
aren't these part of SoM?

> -
>  &i2c1 {
> -	status = "okay";
> +	atsha204a: atsha204a@64 {

How is this change related at all to what you described in commit? There
was no atsha204a before.

> +		compatible = "atmel,atsha204a";
> +		reg = <0x64>;
> +	};
> +
>  	isl12022: isl12022@6f {
> -		status = "okay";
>  		compatible = "isil,isl12022";
>  		reg = <0x6f>;
>  	};
>  };
>  

Best regards,
Krzysztof
