Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6674D9E09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349423AbiCOOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349534AbiCOOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:48:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F755748;
        Tue, 15 Mar 2022 07:47:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E1B6E1F42EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647355624;
        bh=IR+pW29vwKpjjmBqvGZ3LB+SNS5bnCefYbo8aC6sJWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bp3ievLV+eSSIagMLXGDCH2WguJGGv8p1YZZ5fPggMAEwsjBquzlreWjWmAlZKdNZ
         njRq5g5+0I7cSuTF+tDy6VmrjgocrqQWTR8VNLdYgXIX87rVv6AfYdRkXpuYuyJBH6
         Db0eVvAjg/i8fGlRSTsJ77NgF0RMd6OX3kk6+ME/yG54eFdSFf9PhEqrqZl01faLtm
         /cl9mn0vxZwO9sJN30LsPPqS2NrgKy401mULFcuOOWk1+GHRCwgJzsgLMpyh4rd1iw
         RuByvbMU3EE84RjXbeW8BBZBbIK+J4lRoMq8HrhS7HiYej0pf3LuX1xx3w6TaQK738
         CPncbaJEzLcjA==
Message-ID: <dc4ce2b5-bf8e-ea20-f9b1-9034caff421b@collabora.com>
Date:   Tue, 15 Mar 2022 15:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 12/21] arm64: dts: mt8192: Add mmc device nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220304130809.12924-1-allen-kh.cheng@mediatek.com>
 <20220304130809.12924-13-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220304130809.12924-13-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 14:08, Allen-KH Cheng ha scritto:
> Add mmc nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 +++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6220d6962f58..4e4081ea7db5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1150,10 +1150,36 @@
>   			#clock-cells = <1>;
>   		};
>   
> -		msdc: clock-controller@11f60000 {
> -			compatible = "mediatek,mt8192-msdc";
> -			reg = <0 0x11f60000 0 0x1000>;
> -			#clock-cells = <1>;
> +		mmc0: mmc@11f60000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "axi_cg", "ahb_cg", "pclk_cg";

Can you please use the same clock order as specified in the dt-bindings?
This means that "pclk_cg" goes before "axi_cg".

				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>,
				 <&msdc_top CLK_MSDC_TOP_AXI>;
		clock-names = "source", "hclk", "source_cg", "sys_cg",
			      "pclk_cg", "axi_cg", "ahb_cg";

> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11f70000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>;

same here please.

> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "axi_cg", "ahb_cg", "pclk_cg";
> +			status = "disabled";
>   		};
>   
>   		mfgcfg: clock-controller@13fbf000 {

After applying the requested changes,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks,
Angelo
