Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4574F5ACCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiIEHWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiIEHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:21:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E57402CB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:16:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h1so4754809wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=OpQqWL8WvGzI83++gnFzgrRYABYCTMP3dKLDI17AllA=;
        b=t+KraOsZb8QLSYN2xE+n+kuux3MLwiZEohl+B7PwFQlv1ii2NdiuQ5N0xAZvAphpr2
         QF77nBOs2cGaMzIzDxSyxEncO0639tatQRfu8LbvYqkb0FB0n5Gxg5BOQGQhAn6B2LkX
         GuyrFfaP86UXBUcXRk96wlJuRtIvlb75gW/g9Hrij6pH+BUZ/zyNxCc7JJ5qooHgIJZR
         xgEaVR1deyYKk+75eJCxuM2TMvOBkp3NYkFana/WdiBK0Xw/NghHyFPK2r9gvs0zowMn
         rF7RVXW1cOSbaH2iGkl6KwNesKtK9iQ55wS8/4vDz6Q3ZhXFtLXpsPTjYIWFN/CPd8Oz
         j6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OpQqWL8WvGzI83++gnFzgrRYABYCTMP3dKLDI17AllA=;
        b=nBv22C6o+W74HVDIdO9kDkdc0+plTjTMcY1syXXtli0rHyFaQG8dHw1UC2XKstszdG
         03Cq9mFwndKDsvKzoRAu66CSwY6pFoO0j4teCER4pE5baDNeRmDmJoWPzAU3BygatY0D
         3KXTpMfNo9OSqkiSWlkN5jEk/aMADunCFjH3COmkXI8NrJeLKqoy9JKTdF5UyFPCz1cZ
         jrT0mUZODs2SDTcwyjuCfgguDSFk0E960iMz2NcdKWeclEFNViFCtU4OHGX9lOTQhhbt
         rLBvjomMVIxYiCwQIXY2do4WO2SVsFylSn62+TnDeaqezC/6a9Dpp3c7RP+piWo0kbZb
         wn+A==
X-Gm-Message-State: ACgBeo2CKow5X5REs8s8Ykguz0tGomNVTbReldxQeimNGMlymf51vOEG
        3yktewZVvzhsVc8YmWZhW3hw/w==
X-Google-Smtp-Source: AA6agR5YENFPKSSDPhkvVU7fdBOJYL4EKvRTv/FKMghakW/GuaHJEZ8YMPpu5YrIDMGTcjZObagZdg==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id j25-20020a05600c1c1900b003a5a3c73800mr10152570wms.69.1662362191945;
        Mon, 05 Sep 2022 00:16:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f365:27e9:453c:4c15? ([2a01:e0a:982:cbb0:f365:27e9:453c:4c15])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003a502c23f2asm17310702wmq.16.2022.09.05.00.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:16:31 -0700 (PDT)
Message-ID: <35c2cf9f-ef18-f735-9869-0b70dc1e860b@baylibre.com>
Date:   Mon, 5 Sep 2022 09:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/4] arm64: dts: meson: Add DDR PMU node
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220901024526.2833232-1-jiucheng.xu@amlogic.com>
 <20220901024526.2833232-4-jiucheng.xu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220901024526.2833232-4-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 04:45, Jiucheng Xu wrote:
> Add DDR PMU device node for G12 series SoC
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v6 -> v5:
>    - No change
> 
> Changes v5 -> v4:
>    - Split reg into two items
>    - Alphabet order location
> 
> Changes v3 -> v4:
>    - No change
> 
> Changes v2 -> v3:
>    - No change
> 
> Changes v1 -> v2:
>    - Remove model, dmc_nr, chann_nr properties
>    - Add g12a-ddr-pmu, g12b-ddr-pmu, sm1-ddr-pmu compatibles as
>      identifier
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 4 ++++
>   arch/arm64/boot/dts/amlogic/meson-g12b.dtsi       | 4 ++++
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 4 ++++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..9dbd50820b1c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1705,6 +1705,12 @@ internal_ephy: ethernet_phy@8 {
>   			};
>   		};
>   
> +		pmu: pmu@ff638000 {
> +			reg = <0x0 0xff638000 0x0 0x100>,
> +			      <0x0 0xff638c00 0x0 0x100>;
> +			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
> +		};
> +
>   		aobus: bus@ff800000 {
>   			compatible = "simple-bus";
>   			reg = <0x0 0xff800000 0x0 0x100000>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index fb0ab27d1f64..0e8b57283f31 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -133,3 +133,7 @@ map1 {
>   		};
>   	};
>   };
> +
> +&pmu {
> +	compatible = "amlogic,g12a-ddr-pmu";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> index ee8fcae9f9f0..18791ef51f58 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
> @@ -139,3 +139,7 @@ map1 {
>   &mali {
>   	dma-coherent;
>   };
> +
> +&pmu {
> +	compatible = "amlogic,g12b-ddr-pmu";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 80737731af3f..c307b34ccd72 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -520,6 +520,10 @@ &pcie {
>   	power-domains = <&pwrc PWRC_SM1_PCIE_ID>;
>   };
>   
> +&pmu {
> +	compatible = "amlogic,sm1-ddr-pmu";
> +};
> +
>   &pwrc {
>   	compatible = "amlogic,meson-sm1-pwrc";
>   };

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
