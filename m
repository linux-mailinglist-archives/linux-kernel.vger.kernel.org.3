Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03A511103
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358038AbiD0GUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiD0GUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:20:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4804617C;
        Tue, 26 Apr 2022 23:16:52 -0700 (PDT)
X-UUID: d2924d6d266245b99969b02056fca99e-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a758f74d-a4d2-4133-8ff3-b2808168d643,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:9c29a3c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d2924d6d266245b99969b02056fca99e-20220427
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1965537658; Wed, 27 Apr 2022 14:16:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 14:16:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 14:16:46 +0800
Message-ID: <c9bb743907ec5d8eb8465f22db4db4d477ca161f.camel@mediatek.com>
Subject: Re: [PATCH 3/7] arm64: dts: mediatek: mt8195: add ethernet device
 node
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Biao Huang <biao.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 14:16:45 +0800
In-Reply-To: <20220426134106.242353-4-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
         <20220426134106.242353-4-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 15:41 +0200, Fabien Parent wrote:
> From: Biao Huang <biao.huang@mediatek.com>
> 
> This commit adds device node for mt8195 ethernet.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> This patch comes from 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20211207015505.16746-7-biao.huang@mediatek.com/__;!!CTRNKA9wMg0ARbw!zMbdbHaOYVgzrhlWiTJyY40dCmVZaK1jStklyKdY5qoDUoA5uoISlYOx9E801CRuEHQ$
>  
> 
> The differences between that patch and this patch is that:
> * The EVB dts modification has been split into its own commit
> * The patch was rebased to fix merge conflict with the upstream
> mt8195.dtsi file
> * Re-ordered the node to be correctly sorted based on node address
> 
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 70
> ++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index aa05071a80b8..a58641d1cab0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -912,6 +912,76 @@ spis1: spi@1101e000 {
>  			status = "disabled";
>  		};
>  
> +		eth: ethernet@11021000 {
> +			compatible = "mediatek,mt8195-gmac",
> "snps,dwmac-5.10a";
> +			reg = <0 0x11021000 0 0x4000>;
> +			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH
> 0>;
> +			interrupt-names = "macirq";
> +			mac-address = [00 55 7b b5 7d f7];
> +			clock-names = "axi",
> +				      "apb",
> +				      "mac_main",
> +				      "ptp_ref",
> +				      "rmii_internal",
> +				      "mac_cg";
> +			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
> +				 <&pericfg_ao
> CLK_PERI_AO_ETHERNET_BUS>,
> +				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
> +				 <&topckgen
> CLK_TOP_SNPS_ETH_62P4M_PTP>,
> +				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>,
> +				 <&pericfg_ao
> CLK_PERI_AO_ETHERNET_MAC>;
> +			assigned-clocks = <&topckgen
> CLK_TOP_SNPS_ETH_250M>,
> +					  <&topckgen
> CLK_TOP_SNPS_ETH_62P4M_PTP>,
> +					  <&topckgen
> CLK_TOP_SNPS_ETH_50M_RMII>;
> +			assigned-clock-parents = <&topckgen
> CLK_TOP_ETHPLL_D2>,
> +						 <&topckgen
> CLK_TOP_ETHPLL_D8>,
> +						 <&topckgen
> CLK_TOP_ETHPLL_D10>;
> +			power-domains = <&spm
> MT8195_POWER_DOMAIN_ETHER>;
> +			mediatek,pericfg = <&infracfg_ao>;
> +			snps,axi-config = <&stmmac_axi_setup>;
> +			snps,mtl-rx-config = <&mtl_rx_setup>;
> +			snps,mtl-tx-config = <&mtl_tx_setup>;
> +			snps,txpbl = <16>;
> +			snps,rxpbl = <16>;
> +			clk_csr = <0>;
> +			status = "disabled";
> +
> +			stmmac_axi_setup: stmmac-axi-config {
> +				snps,wr_osr_lmt = <0x7>;
> +				snps,rd_osr_lmt = <0x7>;
> +				snps,blen = <0 0 0 0 16 8 4>;
> +			};
> +
> +			mtl_rx_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <1>;
> +				snps,rx-sched-sp;
> +				queue0 {
> +					snps,dcb-algorithm;
> +					snps,map-to-dma-channel =
> <0x0>;
> +					snps,priority = <0x0>;
> +				};
> +			};
> +			mtl_tx_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <3>;
> +				snps,tx-sched-wrr;
> +				queue0 {
> +					snps,weight = <0x10>;
> +					snps,dcb-algorithm;
> +					snps,priority = <0x0>;
> +				};
> +				queue1 {
> +					snps,weight = <0x11>;
> +					snps,dcb-algorithm;
> +					snps,priority = <0x1>;
> +				};
> +				queue2 {
> +					snps,weight = <0x12>;
> +					snps,dcb-algorithm;
> +					snps,priority = <0x2>;
> +				};
> +			};
> +		};
> +
>  		ssusb: usb@11201000 {
>  			compatible ="mediatek,mt8195-mtu3",
> "mediatek,mtu3";
>  			reg = <0 0x11201000 0 0x2dff>,

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

Regards,
Macpaul Lin

