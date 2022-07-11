Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33B56D891
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGKInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGKInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:43:13 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C521818
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:43:02 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 56A0A1F5C9;
        Mon, 11 Jul 2022 10:43:00 +0200 (CEST)
Message-ID: <7efbd77d-bb7a-fe4c-237a-be988c541141@somainline.org>
Date:   Mon, 11 Jul 2022 10:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] ARM: dts: qcom: align SDHCI reg-names with DT
 schema
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
 <20220711082940.39539-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220711082940.39539-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.07.2022 10:29, Krzysztof Kozlowski wrote:
> DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
> just like TXT bindings were expecting before the conversion.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-sdx65.dtsi   | 2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 3e8bded2b5c8..45f3cbcf6238 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -422,7 +422,7 @@ blsp2_uart2: serial@f995e000 {
>  		mmc@f9824900 {
>  			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> @@ -435,7 +435,7 @@ mmc@f9824900 {
>  		mmc@f98a4900 {
>  			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index a2632349cec4..1b98764bab7a 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -224,6 +224,7 @@ vqmmc: regulator@1948000 {
>  		sdhci: mmc@7824900 {
>  			compatible = "qcom,sdhci-msm-v4";
>  			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
>  			bus-width = <8>;
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 0b5effdb269a..f711463d22dc 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -137,7 +137,7 @@ apcs: syscon@f9011000 {
>  		sdhc_1: mmc@f9824900 {
>  			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> @@ -153,7 +153,7 @@ sdhc_1: mmc@f9824900 {
>  		sdhc_2: mmc@f98a4900 {
>  			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> @@ -169,7 +169,7 @@ sdhc_2: mmc@f98a4900 {
>  		sdhc_3: mmc@f9864900 {
>  			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 11b4206036e6..971eceaef3d1 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -439,7 +439,7 @@ acc3: clock-controller@f90b8000 {
>  		sdhc_1: mmc@f9824900 {
>  			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> @@ -456,7 +456,7 @@ sdhc_1: mmc@f9824900 {
>  		sdhc_3: mmc@f9864900 {
>  			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> @@ -475,7 +475,7 @@ sdhc_3: mmc@f9864900 {
>  		sdhc_2: mmc@f98a4900 {
>  			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 7a193678b4f5..4f3389cb6300 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -334,7 +334,7 @@ glink-edge {
>  		sdhc_1: mmc@8804000 {
>  			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x08804000 0x1000>;
> -			reg-names = "hc_mem";
> +			reg-names = "hc";
>  			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "hc_irq", "pwr_irq";
