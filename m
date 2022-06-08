Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F0542A22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiFHI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiFHI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:57:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA543A79F9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:18:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v19so26003082edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lJu7f90/17ENJHeOodBXtuPNJTJFwuBT63hP1IT/OVM=;
        b=URFGorMQpl7AiTcT3K116o61q9Gw1Y7xbs78/Alh1ddhW11RceAO4V1vXAGLgvAOo3
         vTkyPvv6PixhUafKVvDPwTFWLsodkgkdeRV+0+jFbNFA84vmZoYWCV6KEFIjMXbMPSNH
         gSZN0INIfu1cMqJXbOi4rTRsloGUfW66DDjejdAVAislEBy0PAynv4Z83ZJkRdN8K+JM
         0obFFCuI4Fia/umvnbxgdQTe5Y4rbG6y6CX3LFqH7JNIo260JFq2BG1iszyRjKSYfbbT
         Vyv4AiBeCF+955lwvB3K+a6CM9WUW4fwylQbgfOnZ2d2QiB1ehBa9Rgfvw55HwvU4JcZ
         RGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lJu7f90/17ENJHeOodBXtuPNJTJFwuBT63hP1IT/OVM=;
        b=7N4w5G/nyT01jtjZ4kYlyavqtdgRc1uNLi/FpIsCbFnJVrw1jFzJtVfDnQPNDA6TAj
         fR4oZSU0Lxje61DqUMx1X0eZBbIaiEEn/+52TVw9D5W9vam7qkRWPj+JxGuI/o3UXmC2
         9sy8WPfvm5hB2hVkDyivrcor/RFtq0CzOI9u+hKWXWWdyVPehDw0ozi923IYD4SLL9iG
         Ehptfg0PsHwMPJoj/r9bPUqo6przctymiyoS//aROrGQPbARqkoYiqmPRRDdbLTY4qeu
         MTNZ2/RGBfV/WykVv2AjaB7v07TL+3txy7pyXYHEHrbHz0ZKgyoskieXojTQMip5INGk
         nxJg==
X-Gm-Message-State: AOAM533qfPO4VP/3H+mMghJowapkRdERutIYgYvRmWMIrNOoOm2P+V1i
        ADrZGBbqu14sqedqAPjsLgfpUg==
X-Google-Smtp-Source: ABdhPJxnCzCjUnvhxXYiotWtcKQPuPZvHbxx4DCOkLs+hjD7cVT2yw+SkYky4cMjJ5JGiQe7NhFbQw==
X-Received: by 2002:aa7:db02:0:b0:42d:c3ba:9c86 with SMTP id t2-20020aa7db02000000b0042dc3ba9c86mr37852819eds.337.1654676284100;
        Wed, 08 Jun 2022 01:18:04 -0700 (PDT)
Received: from [192.168.0.189] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060e0100b006fec4ee28d0sm7301486eji.189.2022.06.08.01.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:18:03 -0700 (PDT)
Message-ID: <79443fb4-5c09-a33f-594d-71ac93cc0317@linaro.org>
Date:   Wed, 8 Jun 2022 10:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607214113.4057684-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 23:41, Bjorn Andersson wrote:
> Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
> Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
> idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
> interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
> tsens.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2195 ++++++++++++++++++++++++
>  1 file changed, 2195 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> new file mode 100644
> index 000000000000..4143813643ad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -0,0 +1,2195 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interconnect/qcom,sc8280xp.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		xo_board: xo-board {

xo-board-clk

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <38400000>;

The clock is probably on the board, so the frequency should be rather
defined in DTS.

> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32764>;
> +		};
> +	};

(...)

> +
> +		qup1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0 0x00ac0000 0 0x6000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			clock-names = "m-ahb", "s-ahb";
> +			iommus = <&apps_smmu 0x83 0>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_hc: ufshc@1d84000 {

Just "ufs" as node name.

> +			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0 0x01d84000 0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			iommus = <&apps_smmu 0xe0 0x0>;
> +
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			freq-table-hz = <75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>;
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> +			reg = <0 0x01d87000 0 0xe10>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "ref",
> +				      "ref_aux";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			status = "disabled";
> +
> +			ufs_mem_phy_lanes: phy@1d87400 {
> +				reg = <0 0x01d87400 0 0x108>,
> +				      <0 0x01d87600 0 0x1e0>,
> +				      <0 0x01d87c00 0 0x1dc>,
> +				      <0 0x01d87800 0 0x108>,
> +				      <0 0x01d87a00 0 0x1e0>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +			};
> +		};
> +
> +		ufs_card_hc: ufshc@1da4000 {

node name: ufs

> +			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
> +				     "jedec,ufs-2.0";
> +			reg = <0 0x01da4000 0 0x3000>;
> +			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_card_phy_lanes>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_CARD_BCR>;
> +			reset-names = "rst";
> +
> +			power-domains = <&gcc UFS_CARD_GDSC>;
> +
> +			iommus = <&apps_smmu 0x4a0 0x0>;
> +
> +			clocks = <&gcc GCC_UFS_CARD_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_CARD_AXI_CLK>,
> +				 <&gcc GCC_UFS_CARD_AHB_CLK>,
> +				 <&gcc GCC_UFS_CARD_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_CARD_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_CARD_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_CARD_RX_SYMBOL_1_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			freq-table-hz = <75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>;
> +			status = "disabled";
> +		};
> +
> +		ufs_card_phy: phy@1da7000 {
> +			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> +			reg = <0 0x01da7000 0 0xe10>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "ref",
> +				      "ref_aux";
> +			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
> +				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
> +
> +			resets = <&ufs_card_hc 0>;
> +			reset-names = "ufsphy";
> +			status = "disabled";
> +
> +			ufs_card_phy_lanes: phy@1da7400 {
> +				reg = <0 0x01da7400 0 0x108>,
> +				      <0 0x01da7600 0 0x1e0>,
> +				      <0 0x01da7c00 0 0x1dc>,
> +				      <0 0x01da7800 0 0x108>,
> +				      <0 0x01da7a00 0 0x1e0>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +			};
> +		};
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x01f40000 0x0 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		usb_0_hsphy: phy@88e5000 {
> +			compatible = "qcom,sc8280xp-usb-hs-phy",
> +				     "qcom,usb-snps-hs-5nm-phy";
> +			reg = <0 0x088e5000 0 0x400>;
> +			status = "disabled";

status goes to the end

> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB2_HS0_CLKREF_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		};
> +
> +		usb_2_hsphy0: phy@88e7000 {
> +			compatible = "qcom,sc8280xp-usb-hs-phy",
> +				     "qcom,usb-snps-hs-5nm-phy";
> +			reg = <0 0x088e7000 0 0x400>;
> +			status = "disabled";

ditto

> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB2_HS0_CLKREF_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_HS0_MP_BCR>;
> +		};
> +
> +		usb_2_hsphy1: phy@88e8000 {
> +			compatible = "qcom,sc8280xp-usb-hs-phy",
> +				     "qcom,usb-snps-hs-5nm-phy";
> +			reg = <0 0x088e8000 0 0x400>;
> +			status = "disabled";

ditto

> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB2_HS1_CLKREF_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_HS1_MP_BCR>;
> +		};
> +
> +		usb_2_hsphy2: phy@88e9000 {
> +			compatible = "qcom,sc8280xp-usb-hs-phy",
> +				     "qcom,usb-snps-hs-5nm-phy";
> +			reg = <0 0x088e9000 0 0x400>;
> +			status = "disabled";

ditto and so on

Best regards,
Krzysztof
