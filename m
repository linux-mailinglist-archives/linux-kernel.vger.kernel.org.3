Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2675564C35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiGDDw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:52:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94E26D9;
        Sun,  3 Jul 2022 20:52:50 -0700 (PDT)
X-UUID: dee92e9303ed433c8dfffdd29b6e8ad2-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:78e3c066-32ee-4c05-b792-54b58b0d3671,OB:20,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.7,REQID:78e3c066-32ee-4c05-b792-54b58b0d3671,OB:20,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:87442a2,CLOUDID:968f82d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:37d60373517a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dee92e9303ed433c8dfffdd29b6e8ad2-20220704
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1049489092; Mon, 04 Jul 2022 11:52:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 4 Jul 2022 11:52:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jul 2022 11:52:40 +0800
Message-ID: <d76f77e50adbf44afbb1c32d8b30c7ee543beafb.camel@mediatek.com>
Subject: Re: [PATCH v20 3/4] arm64: dts: mt8183: add Mediatek MDP3 nodes
From:   CK Hu <ck.hu@mediatek.com>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Date:   Mon, 4 Jul 2022 11:52:40 +0800
In-Reply-To: <20220630091408.6438-4-moudy.ho@mediatek.com>
References: <20220630091408.6438-1-moudy.ho@mediatek.com>
         <20220630091408.6438-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Moudy:

On Thu, 2022-06-30 at 17:14 +0800, Moudy Ho wrote:
> Add device nodes for Media Data Path 3 (MDP3) modules.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 79
> +++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 9485c1efc87c..938f0c4b7525 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1691,6 +1691,50 @@
>  			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0 0x1000>;
>  		};
>  
> +		mdp3-rdma0@14001000 {
> +			compatible = "mediatek,mt8183-mdp3-rdma";
> +			reg = <0 0x14001000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0x1000 0x1000>;
> +			power-domains = <&spm
> MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
> +				 <&mmsys CLK_MM_MDP_RSZ1>;
> +			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
> +			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
> +				 <&gce 21 CMDQ_THR_PRIO_LOWEST 0>;
> +		};
> +
> +		mdp3-rsz0@14003000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0x3000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
> +		};
> +
> +		mdp3-rsz1@14004000 {
> +			compatible = "mediatek,mt8183-mdp3-rsz";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0x4000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
> +		};
> +
> +		mdp3-wrot0@14005000 {
> +			compatible = "mediatek,mt8183-mdp3-wrot";
> +			reg = <0 0x14005000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0x5000 0x1000>;
> +			power-domains = <&spm
> MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_WROT0>;
> +			iommus = <&iommu M4U_PORT_MDP_WROT0>;
> +		};
> +
> +		mdp3-wdma@14006000 {
> +			compatible = "mediatek,mt8183-mdp3-wdma";
> +			reg = <0 0x14006000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> 0x6000 0x1000>;
> +			power-domains = <&spm
> MT8183_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_MDP_WDMA0>;
> +			iommus = <&iommu M4U_PORT_MDP_WDMA0>;
> +		};
> +
>  		ovl0: ovl@14008000 {
>  			compatible = "mediatek,mt8183-disp-ovl";
>  			reg = <0 0x14008000 0 0x1000>;
> @@ -1809,7 +1853,33 @@
>  			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
>  			power-domains = <&spm
> MT8183_POWER_DOMAIN_DISP>;
>  			mediatek,gce-events =
> <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
> -					      <CMDQ_EVENT_MUTEX_STREAM_
> DONE1>;
> +					      <CMDQ_EVENT_MUTEX_STREAM_
> DONE1>,
> +					      <CMDQ_EVENT_MDP_RDMA0_SOF
> >,
> +					      <CMDQ_EVENT_MDP_RDMA0_EOF
> >,

This event is sent from MDP_RDMA0 to GCE, so move this event to
MDP_RDMA0 node.

> +					      <CMDQ_EVENT_MDP_RSZ0_SOF>
> ,
> +					      <CMDQ_EVENT_MDP_RSZ1_SOF>
> ,
> +					      <CMDQ_EVENT_MDP_TDSHP_SOF
> >,
> +					      <CMDQ_EVENT_MDP_WROT0_SOF
> >,
> +					      <CMDQ_EVENT_MDP_WROT0_EOF
> >,
> +					      <CMDQ_EVENT_MDP_WDMA0_SOF
> >,
> +					      <CMDQ_EVENT_MDP_WDMA0_EOF
> >,

This event is sent from MDP_WDMA0 to GCE, so move this event to
MDP_WDMA0 node.

> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_0>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_1>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_2>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_3>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_4>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_5>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_6>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_7>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_8>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_9>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_10>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_11>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_12>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_13>,
> +					      <CMDQ_EVENT_ISP_FRAME_DON
> E_P2_14>,
> +					      <CMDQ_EVENT_WPE_A_DONE>,

This event is sent from WPE_A to GCE, so move this event to WPE_A node.

Regards,
CK

> +					      <CMDQ_EVENT_SPE_B_DONE>;
>  			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX
> 0x6000 0x1000>;
>  		};
>  
> @@ -1834,6 +1904,13 @@
>  			power-domains = <&spm
> MT8183_POWER_DOMAIN_DISP>;
>  		};
>  
> +		mdp3-ccorr@1401c000 {
> +			compatible = "mediatek,mt8183-mdp3-ccorr";
> +			reg = <0 0x1401c000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX
> 0xc000 0x1000>;
> +			clocks = <&mmsys CLK_MM_MDP_CCORR>;
> +		};
> +
>  		imgsys: syscon@15020000 {
>  			compatible = "mediatek,mt8183-imgsys",
> "syscon";
>  			reg = <0 0x15020000 0 0x1000>;

