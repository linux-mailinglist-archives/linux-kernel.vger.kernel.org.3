Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628CB574BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiGNLOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiGNLOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:14:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45733E08C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:13:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu42so2300120lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PT/4K4arBk0MnJ0M0dc1KtDYYfffmFSSHZchX6nK/Ts=;
        b=pf4++Jveg52p97y240axHMxQDcWVufltds5BIwpqNEEdokgGLbvGXxhdnmQvXFYNhD
         SOPL7g724E5yqW1esWnTaCzkujDBKANOISH0TPctyzq3U7t7+yqYpfJsiRfLzikQwwtr
         AhD0ALAD9huWSDA5ChdwJzCMM0GaBrdBp54Kq4dNPdCg6XjWxPdMbVLK+DYpDWKK08iQ
         f9Xnvp/XsrW5G2JoMXLaExIK8vKDTQdaGQXHjXWvGrX+m7UhcUtGcEgVfezv1difa5MQ
         bFDyN7Eg+W4JdWMTml0yhdQRmoZYBCjCe89C86m43Eq6HW1+oPZS5r+xhDRMYo3s+diH
         4GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PT/4K4arBk0MnJ0M0dc1KtDYYfffmFSSHZchX6nK/Ts=;
        b=ebUy0flgs45SeNMCMnydlBBcscX/TxYMIXYKJKOQx6JMPUdw56RYd+KiMQsNZtx69y
         K8V/AzCpuKQj6P11+H+WYf51U+UAz7eKnOv1S+lotW5eL75/Yn2Tr7BjU+lg9eSDmYlf
         IVcIUZE6U/IzORN3letyouDozQpctj8FO0749wZTOvjk/3sikbshZQ3njEzXgn1WFt6U
         j2Y+wPIze+pfErLlVwPLMPqOumfZk4UkAZT0MCfEkN3PvPcPa3+yH+Q6yZXR/vC5bS0O
         L88Y+8IrCsQ+MIXN7g0xzR5CQn4UrRDdr7ohIRS7REK1UrftE0rSLcaiWonIMJrnBaOC
         xlKQ==
X-Gm-Message-State: AJIora/waAKUZnGmUzKpUliK3aStbf69yM+JiPbJTiI1GofG1iFAOmlq
        yZQ4V3UdOhAGewb8KCNUumGmpg==
X-Google-Smtp-Source: AGRyM1tgyfO4kzaAmSUqA5QzYgflARPcKrYmikUVFSwIhu+b+fdsGMhLvkoOeZsyDKJUvBtulfFuXQ==
X-Received: by 2002:a05:6512:12cc:b0:481:338:d3f with SMTP id p12-20020a05651212cc00b0048103380d3fmr4729553lfg.464.1657797236663;
        Thu, 14 Jul 2022 04:13:56 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0025d39993856sm229553ljc.127.2022.07.14.04.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:13:56 -0700 (PDT)
Message-ID: <879c9348-7841-4569-7dce-5714b4b3f535@linaro.org>
Date:   Thu, 14 Jul 2022 13:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8450: Add SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
 <20220713201047.1449786-3-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713201047.1449786-3-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 22:10, Konrad Dybcio wrote:
> Add and configure the SDHCI host responsible for (mostly) SD Card and
> its corresponding pins' sleep states.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 59 ++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 09e7587de0de..daea2fe7f83d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2355,6 +2355,26 @@ tlmm: pinctrl@f100000 {
>  			gpio-ranges = <&tlmm 0 0 211>;
>  			wakeup-parent = <&pdc>;
>  
> +			sdc2_sleep_state: sdc2-sleep {
> +				clk {
> +					pins = "sdc2_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				cmd {
> +					pins = "sdc2_cmd";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				data {
> +					pins = "sdc2_data";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +			};
> +
>  			pcie0_default_state: pcie0-default-state {
>  				perst {
>  					pins = "gpio94";
> @@ -3101,6 +3121,45 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			iommus = <&apps_smmu 0x4a0 0x0>;
> +			power-domains = <&rpmhpd SM8450_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +			bus-width = <4>;
> +			dma-coherent;
> +
> +			status = "disabled";
> +
> +			sdhc2_opp_table: sdhc2-opp-table {

This does not match the bindings. Just "opp-table".


Best regards,
Krzysztof
