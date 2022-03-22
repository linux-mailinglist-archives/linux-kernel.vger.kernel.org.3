Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A824E490D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiCVWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCVWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:19:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685A49680;
        Tue, 22 Mar 2022 15:18:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 2CA7C1F442A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647987499;
        bh=eWWNvfS4c7Pbd117rSjqnHFnvgl9cIGdel1xA62As0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kseM87wJJgeZx4HEvMRKmYMgWYyE482y/DcFndDYyS6DVTfxdQaPbA5VtKghu2BaU
         +BcMo1FseK8EEKCf4J3oQKlOUI2H9n5wglS8+7IpxsDmmpTdFSx2Qucb5sodOi02oz
         97YUND3jesIra3mnN5rEzQ5NyBO2J+htFc2Wzdq/DOUso1GmwUVDO6nQ5Ex4oOGIOO
         w1vrlNkI3VQk7JgotQcacWekzHV++gfxYfsDtNGtPt0BTAfe3Opbz7cXO5AKE9kTuL
         CtXnf5jEo9NwOyD+4Pr7DerSqFVtQNv/xNM+6RSuXF24j+BXAuz373ppq3qmRw5gYg
         DMdgayzVRZPDw==
Date:   Tue, 22 Mar 2022 18:18:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 09/22] arm64: dts: mt8192: Add PCIe node
Message-ID: <20220322221814.pwrqtvzlvrmwvloo@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-10-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-10-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:21PM +0800, Allen-KH Cheng wrote:
> Add PCIe node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 38 ++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 82de1af3f6aa..3a7f93d8eeaa 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -884,6 +884,44 @@
>  			};
>  		};
>  
> +		pcie: pcie@11230000 {
> +			compatible = "mediatek,mt8192-pcie";
> +			device_type = "pci";
> +			reg = <0 0x11230000 0 0x2000>;
> +			reg-names = "pcie-mac";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			clocks = <&infracfg CLK_INFRA_PCIE_TL_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_96M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_32K>,
> +				 <&infracfg CLK_INFRA_PCIE_PERI_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TOP_H_133M>,
> +				 <&infracfg CLK_INFRA_PCIE_PL_P_250M>;
> +			clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> +				      "obff_ck0", "axi_ck0", "pipe_ck0";
> +			assigned-clocks = <&topckgen CLK_TOP_TL_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D6_D4>;
> +			resets = <&infracfg_rst 2>,
> +				 <&infracfg_rst 3>;
> +			reset-names = "phy", "mac";
> +			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
> +			bus-range = <0x00 0xff>;
> +			ranges = <0x82000000 0 0x12000000 0x0 0x12000000 0 0x0800000>,
> +				 <0x81000000 0 0x12800000 0x0 0x12800000 0 0x0800000>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +					<0 0 0 2 &pcie_intc0 1>,
> +					<0 0 0 3 &pcie_intc0 2>,
> +					<0 0 0 4 &pcie_intc0 3>;
> +
> +			pcie_intc0: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
>  		nor_flash: spi@11234000 {
>  			compatible = "mediatek,mt8192-nor";
>  			reg = <0 0x11234000 0 0xe0>;
> -- 
> 2.18.0
> 
> 
