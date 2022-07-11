Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1416556D895
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGKIoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiGKInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:43:51 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41641E5;
        Mon, 11 Jul 2022 01:43:30 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 107EA1F53F;
        Mon, 11 Jul 2022 10:43:28 +0200 (CEST)
Message-ID: <0004504d-d009-1eb7-d544-5f8a28aa565a@somainline.org>
Date:   Mon, 11 Jul 2022 10:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] ARM: dts: qcom: align SDHCI clocks with DT schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
 <20220711082940.39539-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220711082940.39539-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.07.2022 10:29, Krzysztof Kozlowski wrote:
> The DT schema expects clocks iface-core order.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8084.dtsi    | 12 ++++++------
>  arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
>  arch/arm/boot/dts/qcom-msm8226.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974pro.dtsi |  6 +++---
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 45f3cbcf6238..c887ac5cdd7d 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -425,10 +425,10 @@ mmc@f9824900 {
>  			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -				 <&gcc GCC_SDCC1_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			status = "disabled";
>  		};
>  
> @@ -438,10 +438,10 @@ mmc@f98a4900 {
>  			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> -				 <&gcc GCC_SDCC2_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index 1b98764bab7a..a8a32a5e7e5d 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -228,9 +228,9 @@ sdhci: mmc@7824900 {
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			bus-width = <8>;
> -			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>, <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&gcc GCC_DCD_XO_CLK>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index f711463d22dc..9d4223bf8fc1 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -141,10 +141,10 @@ sdhc_1: mmc@f9824900 {
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -				 <&gcc GCC_SDCC1_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc1_default_state>;
>  			status = "disabled";
> @@ -157,10 +157,10 @@ sdhc_2: mmc@f98a4900 {
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> -				 <&gcc GCC_SDCC2_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc2_default_state>;
>  			status = "disabled";
> @@ -173,10 +173,10 @@ sdhc_3: mmc@f9864900 {
>  			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC3_APPS_CLK>,
> -				 <&gcc GCC_SDCC3_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
> +				 <&gcc GCC_SDCC3_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdhc3_default_state>;
>  			status = "disabled";
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 971eceaef3d1..1f4baa6ac64d 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -443,10 +443,10 @@ sdhc_1: mmc@f9824900 {
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -				 <&gcc GCC_SDCC1_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			bus-width = <8>;
>  			non-removable;
>  
> @@ -460,10 +460,10 @@ sdhc_3: mmc@f9864900 {
>  			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC3_APPS_CLK>,
> -				 <&gcc GCC_SDCC3_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
> +				 <&gcc GCC_SDCC3_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			bus-width = <4>;
>  
>  			#address-cells = <1>;
> @@ -479,10 +479,10 @@ sdhc_2: mmc@f98a4900 {
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> -			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> -				 <&gcc GCC_SDCC2_AHB_CLK>,
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&xo_board>;
> -			clock-names = "core", "iface", "xo";
> +			clock-names = "iface", "core", "xo";
>  			bus-width = <4>;
>  
>  			#address-cells = <1>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro.dtsi b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
> index 1e882e16a221..58df6e75ab6d 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
> @@ -10,10 +10,10 @@ &gpu {
>  };
>  
>  &sdhc_1 {
> -	clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> -		 <&gcc GCC_SDCC1_AHB_CLK>,
> +	clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +		 <&gcc GCC_SDCC1_APPS_CLK>,
>  		 <&xo_board>,
>  		 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
>  		 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
> -	clock-names = "core", "iface", "xo", "cal", "sleep";
> +	clock-names = "iface", "core", "xo", "cal", "sleep";
>  };
