Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE06589E96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239782AbiHDPXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiHDPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:23:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC5528E2D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:22:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t22so31310216lfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kh4nLytH1UrA2iQs/fVrhb1nEoIoVCV9Y8jH68nXWy8=;
        b=lZJc4JgTk8uKIZ5ux9BZ4zn7/W3yKuDdLZMrPOS4jaxt5r0rEWIgbWzk6+TkTIOEHb
         0gHtYfRs5k+LQjl2A5GGWLja2Z6rSTHQc0XflZt6fkhkRm94K3DYE9QAxyqiNtPJ/ngR
         4pH3gYfp9XQh6FDzdkvoH1dLJjh+00NpMK1Pkf0DuxWM0Yu6CtkcU4JqYlXghucHY8si
         mrf3gsNnfysk9R6bkJeHYLD9HGX7zG/WFXh+CQvOv72hQL7wQk3N+tfSzw3zxbjzJxjk
         MwdvkxGeniCowmbiYerg34tXwvQ3RqTJ7KKQPTVyrzJ6sMyBCOhKeCmVkBp74U9GEEu2
         DQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kh4nLytH1UrA2iQs/fVrhb1nEoIoVCV9Y8jH68nXWy8=;
        b=0LdoN5Y8o6+Mdkaf+ZcNvpWz35ABHTsffSiNCGXLOr9w/hFg4DW6kpzditUxReInbB
         39ehYXEgz6CXZnDrJH3lttOT2GdBDm2153KVOAhpeOlO103O6eci2Xf9g+BrPdZnr8aP
         H03bOtrB9ZC1Kp9+NjYz/l0bj0DF+UnlUJ/xf3x7ZwJh0QOWvL58Ibazfiq3JPCyJeVI
         Ej+lyywd+83Teaq/zSas3Y5jSK7ocIiWet+bCazjbD9fetwtb7pDhZdW9noSx6jdVAno
         Ini5RD8M3lyolsipEiMeZEJkIdXY6jwY8TSixxW30NA201kGNdjPcf3u7DN5iaXI4dZS
         NGqg==
X-Gm-Message-State: ACgBeo2e6K+J8BKN9L/AmXljEuF69MJ1N84ZhZVldFI7wKSRmRInHwpl
        vEbyBR/EdPCstIi6E8Cm1eGiPCrZEQ5T1QRlD1o=
X-Google-Smtp-Source: AA6agR4W2EpgFvOAtyhi3xOePp7AUFNalAIiGmLE6pOC8eXNjKNNM4/4aokgAwUh5QIcbpXFlff6Kw==
X-Received: by 2002:a19:6508:0:b0:48a:71c:b6cb with SMTP id z8-20020a196508000000b0048a071cb6cbmr891768lfb.133.1659626575245;
        Thu, 04 Aug 2022 08:22:55 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id o16-20020a056512053000b0048af6d4e5fbsm150043lfc.275.2022.08.04.08.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:22:54 -0700 (PDT)
Message-ID: <f54deddd-251d-aa8c-6946-f447077d7782@linaro.org>
Date:   Thu, 4 Aug 2022 17:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8.1, 6/7] arm64: dts: mt8195: Add thermal zone
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
 <20220804130912.676043-7-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804130912.676043-7-bchihi@baylibre.com>
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
> From: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> This adds the thermal zone for the mt8195.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 111 +++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index cbd0401968a2..5890e688eebe 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/reset/mt8195-resets.h>
>  
>  / {
>  	compatible = "mediatek,mt8195";
> @@ -452,6 +453,28 @@ spi0: spi@1100a000 {
>  			status = "disabled";
>  		};
>  
> +		lvts_ap: thermal-sensor@1100b000 {
> +			compatible = "mediatek,mt8195-lvts-ap";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
> +			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> +			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
> +		};
> +
> +		lvts_mcu: thermal-sensor@11278000 {
> +			compatible = "mediatek,mt8195-lvts-mcu";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x11278000 0 0x1000>;
> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> +			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
> +		};
> +
>  		spi1: spi@11010000 {
>  			compatible = "mediatek,mt8195-spi",
>  				     "mediatek,mt6765-spi";
> @@ -1106,4 +1129,92 @@ vencsys_core1: clock-controller@1b000000 {
>  			#clock-cells = <1>;
>  		};
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-big1-thermal {

Does this pass dtbs_check?

Best regards,
Krzysztof
