Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD9543846
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbiFHQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbiFHQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:00:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E96E3C72F;
        Wed,  8 Jun 2022 09:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AFD79CE2906;
        Wed,  8 Jun 2022 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C87C34116;
        Wed,  8 Jun 2022 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654704019;
        bh=qTzUtqLroEpt/T5hEjlRkc3F/hAa9Znk25sWPs74h9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqwrVbdxoCIAF3Bc2P9kylW01YMnq/9XdPmw4parPSJZ5FWsoy/EXu7OqysI4dPZB
         o9OmDaCcEIkMMcm0rNnhRAhJsYE2ZQcsRDakCrV10W9R1soPda41QgujfTIireoMJP
         9z42XEuzs2tIUWgXt5y/L78yRrphadEYF8LwCxyml70FabbJKNvxFcsapstI68rJGB
         3w1rjo+uBub/zwtjahMQHJNIONZ17tmKiTvZhNKejKDOfm7z6O01qlTbf7e6QKjdDj
         n/rMyvtWsVsTUtRFSkNpAvjqfOzEGlhzHfz+YNe9iTNNkuI3aKUHpsoIAc3y1x8htp
         i21q78KhFy+jQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nyy6P-0004b2-CQ; Wed, 08 Jun 2022 18:00:13 +0200
Date:   Wed, 8 Jun 2022 18:00:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Message-ID: <YqDHjTkD/QZFS2Ub@hovoldconsulting.com>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607214113.4057684-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:41:11PM -0700, Bjorn Andersson wrote:
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

> +	aggre1_noc: interconncet-aggre1-noc {

typo: interconnect

> +		compatible = "qcom,sc8280xp-aggre1-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};

> +		usb_2_qmpphy1: phy-wrapper@88f1000 {
> +			compatible = "qcom,sc8280xp-qmp-usb3-uni-phy";
> +			reg = <0 0x088f1000 0 0x1c8>;
> +			status = "disabled";

I'd also much prefer if you move the status property last throughout, as
Krzysztof already mentioned.

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_MP1_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_UNIPHY_MP1_BCR>,
> +				 <&gcc GCC_USB3UNIPHY_PHY_MP1_BCR>;
> +			reset-names = "phy", "common";
> +
> +			power-domains = <&gcc USB30_MP_GDSC>;
> +
> +			usb_2_ssphy1: phy@88efe00 {

Wrong unit address, should be phy@88f1e00

> +				reg = <0 0x088f1e00 0 0x160>,
> +				      <0 0x088f2000 0 0x1ec>,
> +				      <0 0x088f1200 0 0x1f0>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_MP_PHY_PIPE_1_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb2_phy1_pipe_clk";
> +			};
> +		};

> +		usb_0_qmpphy: phy-wrapper@88ec000 {
> +			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
> +			reg = <0 0x088ec000 0 0x1e4>,
> +			      <0 0x088eb000 0 0x40>,
> +			      <0 0x088ed000 0 0x1c8>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB4_EUD_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
> +
> +			usb_0_ssphy: usb3-phy@88e9200 {

unit address, should be usb3-phy@88eb400

> +				reg = <0 0x088eb400 0 0x100>,
> +				      <0 0x088eb600 0 0x3ec>,
> +				      <0 0x088ec400 0 0x1f0>,
> +				      <0 0x088eba00 0 0x100>,
> +				      <0 0x088ebc00 0 0x3ec>,
> +				      <0 0x088ec700 0 0x64>;

I've switched to specifying ranges in the PCIe PHY wrappers to avoid
using absolute addresses here. I think we should do that throughout.

> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb0_phy_pipe_clk_src";
> +			};
> +
> +			usb_0_dpphy: dp-phy@88ed200 {
> +				reg = <0 0x088ed200 0 0x200>,
> +				      <0 0x088ed400 0 0x200>,
> +				      <0 0x088eda00 0 0x200>,
> +				      <0 0x088ea600 0 0x200>,
> +				      <0 0x088ea800 0 0x200>;
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +			};
> +		};

> +		usb_1_qmpphy: phy-wrapper@8904000 {
> +			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
> +			reg = <0 0x08904000 0 0x1e4>,
> +			      <0 0x08903000 0 0x40>,
> +			      <0 0x08905000 0 0x1c8>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB4_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> +			clock-names = "aux", "ref_clk_src", "ref", "com_aux";
> +
> +			resets = <&gcc GCC_USB3_PHY_SEC_BCR>,
> +				 <&gcc GCC_USB4_1_DP_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			power-domains = <&gcc USB30_SEC_GDSC>;
> +
> +			usb_1_ssphy: usb3-phy@88e9200 {

Unit address, should be usb3-phy@08903400

> +				reg = <0 0x08903400 0 0x100>,
> +				      <0 0x08903c00 0 0x3ec>,
> +				      <0 0x08904400 0 0x1f0>,
> +				      <0 0x08903a00 0 0x100>,
> +				      <0 0x08903c00 0 0x3ec>,
> +				      <0 0x08904200 0 0x18>;
> +				#phy-cells = <0>;
> +				#clock-cells = <0>;
> +				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb1_phy_pipe_clk_src";
> +			};
> +
> +			usb_1_dpphy: dp-phy@88ed200 {
> +				reg = <0 0x08904200 0 0x200>,
> +				      <0 0x08904400 0 0x200>,
> +				      <0 0x08904a00 0 0x200>,
> +				      <0 0x08904600 0 0x200>,
> +				      <0 0x08904800 0 0x200>;
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +			};
> +		};
> +
> +		usb_2: usb@a4f8800 {
> +			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";

This compatible isn't described in any binding yet.

> +			reg = <0 0x0a4f8800 0 0x400>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB30_MP_MASTER_CLK>,
> +				 <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> +			clock-names = "core", "iface", "bus_aggr", "utmi", "sleep",
> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";

And as I mentioned off-list, neither are any of these interconnect
clocks.

Ideally, they'd be handled by an interconnect driver, but they'd at
least need to be described in the binding, I guess.

Same for the other controllers.

> +
> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 128 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq", "ss_phy_irq";

These interrupts are all wrong (at least for ADP). The vendor dtsi does
not specify "hs_phy_irq" at all and 127 is really "dp_hs_phy_irq", 126 is
"dm_hs_phy_irq", while 129 and 128 are interrupts for the second HS phy.

Since the driver does not yet support multiple ports and the binding
hasn't been updated either, perhaps you should just leave out the
multi-port usb_2 controller for now.

> +
> +			power-domains = <&gcc USB30_MP_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_MP_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
> +			usb_2_dwc3: usb@a800000 {

usb@a400000

> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a400000 0 0xd93c>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x800 0x0>;
> +				phys = <&usb_2_hsphy0>, <&usb_2_ssphy0>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				/*
> +				 * TODO: Link controller to all 6 phys.
> +				 * phys = <&usb_2_hsphy0>, <&usb_2_ssphy0>,
> +				 *        <&usb_2_hsphy1>, <&usb_2_ssphy1>,
> +				 *        <&usb_2_hsphy2>,
> +				 *        <&usb_2_hsphy3>;
> +				 * phy-names = "usb2-phy", "usb3-phy";
> +				 */

Same argument with respect to the phy-names here, the binding should
probably be updated first.

> +			};
> +		};

> +		usb_1: usb@a8f8800 {
> +			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
> +			reg = <0 0x0a8f8800 0 0x400>;
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB30_SEC_MASTER_CLK>,
> +				 <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> +			clock-names = "core", "iface", "bus_aggr", "utmi", "sleep",
> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
> +
> +			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>;

The vendor dtsi has 136 instead of 16 here as ss_phy_irq (16 is a
usb_2 PHY IRQ).

> +			interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq", "ss_phy_irq";
> +
> +			power-domains = <&gcc USB30_SEC_GDSC>;
> +
> +			resets = <&gcc GCC_USB30_SEC_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
> +			usb_1_dwc3: usb@a800000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a800000 0 0xcd00>;
> +				interrupts = <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x860 0x0>;
> +				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +			};
> +		};
> +
> +		system-cache-controller@9200000 {
> +			compatible = "qcom,sc8280xp-llcc";
> +			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
> +			reg-names = "llcc_base", "llcc_broadcast_base";
> +			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> +		};

The system-cache-controller node is placed out of order.

Johan
