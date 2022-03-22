Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07094E4842
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiCVV0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiCVV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:26:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F5396A4;
        Tue, 22 Mar 2022 14:25:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D03E61F42E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647984315;
        bh=FN4g7OUcn1ja9g5IGVEoumm6Jbs/S5KfOE1/HCBlfhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjndmY3/tEwT1vjYFlZRlDw6u0KBWVKjhGOHT4IhFIuw6jPMHZdgJ7iu6yXmzLF6Y
         vL7ytXr1343H/gWInrvFG++p2Yx+bWzQbgY6zSTaPAV+OSNKxf1bcofIkpPiLPbN04
         uJuTGgI1VpAP4Dqh1n76QmRtu7opiiIGmSfN9IJHwJiPwfBmNcRr2+l2wSbUQEZ5dK
         5sH9U9kDalMDd0CxOJc9U2uJdIJWCkWAOTv09gAP9PhtNc5Kwvmms4wFTSXQWEtPac
         Crbv7yNxHqa806N0jrJtBo9Lbr5gblH0lNUHUwOPmnhqpR9SRVOk2Eewkyx8VjtZXj
         Fc+WE8lm5LyIg==
Date:   Tue, 22 Mar 2022 17:25:09 -0400
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
Subject: Re: [PATCH v4 21/22] arm64: dts: mt8192: Add gce info for display
 nodes
Message-ID: <20220322212509.nviacy3dk4mpvz6f@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-22-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-22-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:33PM +0800, Allen-KH Cheng wrote:
> Add gce info for display nodes
> - It's required to get drivers' CMDQ support

It's better to use complete sentences instead of bullet points like this. Also
you could be more descriptive in the commit message. Suggestion:

Add GCE (Global Command Engine) properties to the display nodes in order to
enable the usage of the CMDQ (Command Queue), which is required for operating
the display.

> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 08e0dd2483d1..f0f0f067c023 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1203,6 +1203,9 @@
>  		mmsys: syscon@14000000 {
>  			compatible = "mediatek,mt8192-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  		};
> @@ -1212,6 +1215,8 @@
>  			reg = <0 0x14001000 0 0x1000>;
>  			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
>  			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
>  		};
>  
>  		smi_common: smi@14002000 {
> @@ -1253,6 +1258,7 @@
>  			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
>  				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
>  		};
>  
>  		ovl_2l0: ovl@14006000 {
> @@ -1263,6 +1269,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
>  			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
>  				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
>  		};
>  
>  		rdma0: rdma@14007000 {
> @@ -1274,6 +1281,7 @@
>  			mediatek,larb = <&larb0>;
>  			mediatek,rdma-fifo-size = <5120>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
>  		};
>  
>  		color0: color@14009000 {
> @@ -1283,6 +1291,7 @@
>  			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
>  		};
>  
>  		ccorr0: ccorr@1400a000 {
> @@ -1291,6 +1300,7 @@
>  			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
>  		};
>  
>  		aal0: aal@1400b000 {
> @@ -1300,6 +1310,7 @@
>  			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>  		};
>  
>  		gamma0: gamma@1400c000 {
> @@ -1309,6 +1320,7 @@
>  			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>  		};
>  
>  		postmask0: postmask@1400d000 {
> @@ -1318,6 +1330,7 @@
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
>  			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>  		};
>  
>  		dither0: dither@1400e000 {
> @@ -1327,6 +1340,7 @@
>  			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
>  			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>  			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>  		};
>  
>  		dsi0: dsi@14010000 {
> @@ -1351,6 +1365,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
>  			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
>  				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>  		};
>  
>  		rdma4: rdma@14015000 {
> @@ -1361,6 +1376,7 @@
>  			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
>  			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
>  			mediatek,rdma-fifo-size = <2048>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>  		};
>  
>  		dpi0: dpi@14016000 {
> -- 
> 2.18.0
> 
> 
