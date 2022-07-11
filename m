Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2256D88C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGKInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGKImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:42:49 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB50616E;
        Mon, 11 Jul 2022 01:42:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6A9311F4E8;
        Mon, 11 Jul 2022 10:42:45 +0200 (CEST)
Message-ID: <11787e1b-826d-50d8-49ae-6322e11b6d21@somainline.org>
Date:   Mon, 11 Jul 2022 10:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: align SDHCI reg-names with DT
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
 <20220711082940.39539-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220711082940.39539-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index a6cb0dafcc17..2b9374f61d5b 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -379,7 +379,7 @@ spmi_bus: spmi@200f000 {
>  		sdhc_1: mmc@7824900 {
>  			compatible = "qcom,sdhci-msm-v4";
>  			reg = <0x7824900 0x500>, <0x7824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 48bc2e09128d..0bdf4d39f778 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1469,7 +1469,7 @@ lpass_codec: audio-codec@771c000 {
>  		sdhc_1: mmc@7824000 {
>  			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1487,7 +1487,7 @@ sdhc_1: mmc@7824000 {
>  		sdhc_2: mmc@7864000 {
>  			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 1bc0ef476cdb..97dde1a429d9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -799,7 +799,7 @@ sdhc_1: mmc@7824900 {
>  			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
>  
>  			reg = <0x7824900 0x500>, <0x7824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> @@ -859,7 +859,7 @@ sdhc_2: mmc@7864900 {
>  			compatible = "qcom,msm8953-sdhci", "qcom,sdhci-msm-v4";
>  
>  			reg = <0x7864900 0x500>, <0x7864000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 8bc6c070e306..35c1ca080684 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -464,7 +464,7 @@ usb@f9200000 {
>  		sdhc1: mmc@f9824900 {
>  			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> @@ -487,7 +487,7 @@ sdhc1: mmc@f9824900 {
>  		sdhc2: mmc@f98a4900 {
>  			compatible = "qcom,msm8994-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 25d6b26fab60..9745df5dc007 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -2896,7 +2896,7 @@ hsusb_phy2: phy@7412000 {
>  		sdhc1: mmc@7464900 {
>  			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2920,7 +2920,7 @@ sdhc1: mmc@7464900 {
>  		sdhc2: mmc@74a4900 {
>  			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index e263a59d84b0..c98f36f95f3c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -2078,7 +2078,7 @@ qusb2phy: phy@c012000 {
>  		sdhc2: mmc@c0a4900 {
>  			compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
> -			reg-names = "hc_mem", "core_mem";
> +			reg-names = "hc", "core";
>  
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
