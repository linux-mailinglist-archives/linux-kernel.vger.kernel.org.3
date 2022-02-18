Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4024BB99D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiBRM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiBRM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CA2B8AEC;
        Fri, 18 Feb 2022 04:56:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A1FB71F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188971;
        bh=Mb736QL1fjTwcEAkdjQx5DGuJ2KdhFkGPZlMm4ES0yA=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=SGMpegoqcbFxYkLIcbIDP0EGh4RS5VW7NALMp7RRNnhKdeF4M1DVmqO6YfdhVsylt
         892VCMrAikWy9DhKY3SqzQOiOrha44E2/FsEyHAti5XfVJrETmIbM6p7nZaEsjQMFg
         wCCoV/+fucwN7Z0AgfVgXNewhcz4YIcmoJ2bf5XcpfhH2E5oE55V5qi4nk8gI59r8r
         /isKlLz2zOSCbjBYlLkWeWVYngHGhBh/ovbRuRKm6nuHBaeRS/zKQJ3AekYtwKUHFk
         umtFehN/9BtY578NLWPkfmnBSgUnjKsR8eRPTd8x4T4NU6V1lkCwEpraohyaOFKNpR
         1PLnD1kf+WAMA==
Message-ID: <985167a1-cd44-4735-c86a-59cd60d31d1a@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 17/23] arm64: dts: mt8192: Add vcodec lat and core
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
 <20220218091633.9368-18-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-18-allen-kh.cheng@mediatek.com>
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
> Add vcodec lat and core nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 ++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 936aa788664f..543a80252ce5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1291,6 +1291,64 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
>   		};
>   
> +		vcodec_dec: vcodec_dec@16000000 {
> +			compatible = "mediatek,mt8192-vcodec-dec";
> +			reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +		};
> +
> +		vcodec_lat: vcodec_lat@0x16010000 {
> +			compatible = "mediatek,mtk-vcodec-lat";
> +			reg = <0 0x16010000 0 0x800>;		/* VDEC_MISC */
> +			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,

Please fix indentation!

			iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,

				 <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,

				 <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,

... etc.

> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
> +				<&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
> +			clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
> +				 <&topckgen CLK_TOP_MAINPLL_D4>;
> +			clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat", "vdec-vdec",
> +				      "vdec-top";
> +			assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
> +		};
> +
> +		vcodec_core: vcodec_core@0x16025000 {
> +			compatible = "mediatek,mtk-vcodec-core";
> +			reg = <0 0x16025000 0 0x1000>;		/* VDEC_CORE_MISC */
> +			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,

ditto.

> +				<&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
> +				<&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
> +			clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +				 <&vdecsys CLK_VDEC_VDEC>,
> +				 <&vdecsys CLK_VDEC_LAT>,
> +				 <&vdecsys CLK_VDEC_LARB1>,
> +				 <&topckgen CLK_TOP_MAINPLL_D4>;
> +			clock-names = "vdec-sel", "vdec-soc-vdec", "vdec-soc-lat", "vdec-vdec",
> +				      "vdec-top";
> +			assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
> +		};
> +
>   		larb5: larb@1600d000 {
>   			compatible = "mediatek,mt8192-smi-larb";
>   			reg = <0 0x1600d000 0 0x1000>;

