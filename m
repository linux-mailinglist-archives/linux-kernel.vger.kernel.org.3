Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D54BB9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiBRM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiBRM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB6427F7;
        Fri, 18 Feb 2022 04:56:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C42B01F46724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188988;
        bh=yHQsIU1phFPYNJlSoSOIZ82oubmyvJ4yo5+X5drcQoM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=HuLQl9FzsvAm60s9llILXZUoFH56uLqXJou7BKeuBGbctshOhPFQ/0ekAwowbRbdA
         aYC8f1ezSK1KCEbtcPSyHuEga3Jll9/Bf+MBak2ek+uAejY9e5Y3TBByRqUI43xFq0
         o0vAXkoiainmwcUyt3eUJBCkcyFbH1O/rcbYQMJqz/BWiMw7ixR0TD67068tXvrgkl
         FGLnv0KmOd1qKweGuhaNn/w89QQ+WMI+dI14/SoO5pHo+zDw3KiuRIsqinsxzEM7mx
         2gQ3bPOTlboYV0ccKsiMEmbKKIq9fL8liM8RAZUONzz64KjoPOkrN0Zmn9rMaq3Y5I
         hkpSMgLAofJRg==
Message-ID: <5ad1baeb-6744-1c60-08a8-063db0a2ad03@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 22/23] arm64: dts: mt8192: Add gce info for display
 nodes
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-23-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-23-allen-kh.cheng@mediatek.com>
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

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add gce info for display nodes.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Please mention that this is required to get drivers' CMDQ support in this
commit message, as this is critical information.

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 1f1555fd18f5..df884c48669e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1226,6 +1226,9 @@
>   		mmsys: syscon@14000000 {
>   			compatible = "mediatek,mt8192-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> @@ -1234,6 +1237,8 @@
>   			reg = <0 0x14001000 0 0x1000>;
>   			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
>   			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
>   		};
>   
>   		smi_common: smi@14002000 {
> @@ -1275,6 +1280,7 @@
>   			iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
>   				 <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
>   		};
>   
>   		ovl_2l0: ovl@14006000 {
> @@ -1285,6 +1291,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
>   			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
>   				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
>   		};
>   
>   		rdma0: rdma@14007000 {
> @@ -1296,6 +1303,7 @@
>   			mediatek,larb = <&larb0>;
>   			mediatek,rdma-fifo-size = <5120>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
>   		};
>   
>   		color0: color@14009000 {
> @@ -1305,6 +1313,7 @@
>   			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
>   		};
>   
>   		ccorr0: ccorr@1400a000 {
> @@ -1313,6 +1322,7 @@
>   			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
>   		};
>   
>   		aal0: aal@1400b000 {
> @@ -1321,6 +1331,7 @@
>   			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_AAL0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
>   		};
>   
>   		gamma0: gamma@1400c000 {
> @@ -1330,6 +1341,7 @@
>   			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_GAMMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>   		};
>   
>   		postmask0: postmask@1400d000 {
> @@ -1339,6 +1351,7 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_POSTMASK0>;
>   			iommus = <&iommu0 M4U_PORT_L0_DISP_POSTMASK0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>   		};
>   
>   		dither0: dither@1400e000 {
> @@ -1348,6 +1361,7 @@
>   			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>;
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>   		};
>   
>   		dsi0: dsi@14010000 {
> @@ -1371,6 +1385,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_OVL2_2L>;
>   			iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
>   				 <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>   		};
>   
>   		rdma4: rdma@14015000 {
> @@ -1381,6 +1396,7 @@
>   			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
>   			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
>   			mediatek,rdma-fifo-size = <2048>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>   		};
>   
>   		dpi0: dpi@14016000 {


