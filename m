Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C50589E99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiHDPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiHDPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:23:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28643248CF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:23:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t1so31267587lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nW461BRLiacu0fQQcbQ/ms/ezKwyN5n8RtJZv2E3pzI=;
        b=TE/B8wyMpbf1LI41Lhn15lvfybUpLZEHXS/BLWnYha6wZrM+cxcV1SuDzGfJRc2PgY
         EyrThtV7g6W1JZWxs4kHp8LXLUatpvhCrJ7lfxrC7EmVyuJVwJR4Dx05bIzVyMEFxdbX
         SiJewCnfCknNi+KrQ2jgelkym/SP4B88ZpkG4kCSTiZFoS9ONf1QdulTOssBhXsaTpkm
         24GlW7C6oaTgJcgyzaSQ1OUqi5nKKwoNrPIMOb2r+1TdE6GgwdDK2URutVX2MoRpWB2J
         uV+8tjwPpqmhfOKPp1q3lfHVmy/rYFfRjxwlzJHRnfRJ3kb9q2BskfN3uvw5zsLu70/T
         4HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nW461BRLiacu0fQQcbQ/ms/ezKwyN5n8RtJZv2E3pzI=;
        b=Hhglh4LmEL7ZQ42SdSsTbNfD/9DocutSGQU8CT6ApwdAiNzT82FT2RSuxVeeU6bWHj
         e0bQeWIehf6l3ODLChKth3cuPRQARKWAlUlz5XBmEr5goafLwq8tppHoQRLpZHE9SGxV
         0c8Dc+x3duW2J03YKyXOK42x7/ZehpuVSkyrp8FJ3IjbCr8wDtNC4zvEb+Jf0TNNsRkt
         gB3U7zQgg+ZLKxqbYlJo5NJghHF2JqXIPyKJ8FVOsT2/unh+Qf5CSYVH7fJFqteQGhSL
         0gnRH1XVK7iPpb0iOp9jC3I+d/UEYg+Krj1WAro5xQnqck1HGKZWayPXTtvtJ9K7WqJz
         XQOw==
X-Gm-Message-State: ACgBeo3WavIVNGuSpnutE20lrMZbKIZNHkLIyhXvq8bhOvPPelpyKWz9
        /H7erIJcregP/gBvVxhKA0jGiA==
X-Google-Smtp-Source: AA6agR6XRVfgI5FIRRD5dHZyN1ms60HDbZr53GF7XOvw/X/QlbaYbzoFd/8eYvuatAQOsPhrSuivHg==
X-Received: by 2002:a19:8c04:0:b0:48a:7683:3845 with SMTP id o4-20020a198c04000000b0048a76833845mr975449lfd.297.1659626612516;
        Thu, 04 Aug 2022 08:23:32 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8249000000b0025e66a771efsm148498ljh.136.2022.08.04.08.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:23:31 -0700 (PDT)
Message-ID: <93f32d3a-ffca-8bf1-77c2-d0f4a22f4f12@linaro.org>
Date:   Thu, 4 Aug 2022 17:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8.1, 3/7] arm64: dts: mt8192: Add thermal zone
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-4-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804130912.676043-4-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 15:09, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> This adds the thermal zone for the mt8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 113 ++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index cbae5a5ee4a0..3320b5c14ee3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
> - * Copyright (C) 2020 MediaTek Inc.
> + * Copyright (C) 2022 MediaTek Inc.

This is unexpected, so it needs careful explanation.

>   * Author: Seiya Wang <seiya.wang@mediatek.com>
>   */
>  
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/mt8192-resets.h>
>  
>  / {
>  	compatible = "mediatek,mt8192";
> @@ -599,6 +600,28 @@ spi0: spi@1100a000 {
>  			status = "disabled";
>  		};
>  
> +		lvts_ap: thermal-sensor@1100b000 {
> +			compatible = "mediatek,mt8192-lvts-ap";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
> +			nvmem-cells = <&lvts_e_data1>;
> +			nvmem-cell-names = "lvts_calib_data1";
> +		};
> +
> +		lvts_mcu: thermal-sensor@11278000 {
> +			compatible = "mediatek,mt8192-lvts-mcu";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x11278000 0 0x1000>;
> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_THERM>;
> +			resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +			nvmem-cells = <&lvts_e_data1>;
> +			nvmem-cell-names = "lvts_calib_data1";
> +		};
> +
>  		spi1: spi@11010000 {
>  			compatible = "mediatek,mt8192-spi",
>  				     "mediatek,mt6765-spi";
> @@ -1457,4 +1480,92 @@ larb2: larb@1f002000 {
>  			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-big1-thermal {

Names look not matching DT schema.


Best regards,
Krzysztof
