Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99D4AC430
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384633AbiBGPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379639AbiBGPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:34:30 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8DC0401CE;
        Mon,  7 Feb 2022 07:34:29 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 0227C1F43B76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644248068;
        bh=ol3XokBITXIfyab5chsBQWUULIoTBvY1DDSR5rejgvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obxfamCW4cnL3wy0ug3PFGL3p+Tuo+giscjZZG7Gp8W3+dak1a5dMCLmxytjSi3Zu
         +7qQH7krl7nFsswMvu2OmAanWP5sU1e3Qqi2/o+i+IrTiDsoE4OG5n6BMqW+1Oo5ER
         dM8v4gJfJDhlam8krFoExNK0TRnvFIzcCGDMaA1+y6+BYDOHlXxFrkiCf9ptWVe3Gw
         4o32biV2EuqM64q522rtN/Dq039d2I/CvSUOw4UwwMr9unwDv2QrtI5X92Wc9xUWPY
         i1kUSi5T9U+91w0sW2LK+/dNk2NkACnPJaGoT0Y8035wIr+rUwx2uCtNFboIJB3wMj
         4c5WiceFbJ4KQ==
Date:   Mon, 7 Feb 2022 10:34:23 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [v5] arm64: dts: mediatek: Add mt8192 power domains controller
Message-ID: <20220207153423.smz3636wk3hjk3b5@notapiano>
References: <20210825010426.30303-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825010426.30303-1-chun-jie.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie,

thanks for the patch. Please see my comments below.

On Wed, Aug 25, 2021 at 09:04:26AM +0800, Chun-Jie Chen wrote:
> Add power domains controller node for SoC mt8192
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
> This patch is base on v5.14-rc1,
> series "Mediatek MT8192 clock support"[1] and [2].
> No changes compare v4
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521127
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20210727023205.20319-2-chun-jie.chen@mediatek.com/

Those two patches are already merged in mainline, so this patch applies
cleanly on mainline without any other dependencies. Might be worth sending a new
version removing this text to make that clearer to the maintainers.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 201 +++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index c7c7d4e017ae..a0084a7a5bcd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/power/mt8192-power.h>
>  
>  / {
>  	compatible = "mediatek,mt8192";
> @@ -301,6 +302,206 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;
> +
> +			/* System Power Manager */
> +			spm: power-controller {
> +				compatible = "mediatek,mt8192-power-controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domain of the SoC */
> +				power-domain@MT8192_POWER_DOMAIN_AUDIO {
> +					reg = <MT8192_POWER_DOMAIN_AUDIO>;
> +					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
> +						 <&infracfg CLK_INFRA_AUDIO_26M_B>,
> +						 <&infracfg CLK_INFRA_AUDIO>;
> +					clock-names = "audio", "audio1", "audio2";
> +					mediatek,infracfg = <&infracfg>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8192_POWER_DOMAIN_CONN {
> +					reg = <MT8192_POWER_DOMAIN_CONN>;
> +					clocks = <&infracfg CLK_INFRA_PMIC_CONN>;
> +					clock-names = "conn";
> +					mediatek,infracfg = <&infracfg>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8192_POWER_DOMAIN_MFG0 {
> +					reg = <MT8192_POWER_DOMAIN_MFG0>;
> +					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
> +					clock-names = "mfg";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8192_POWER_DOMAIN_MFG1 {
> +						reg = <MT8192_POWER_DOMAIN_MFG1>;
> +						mediatek,infracfg = <&infracfg>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8192_POWER_DOMAIN_MFG2 {
> +							reg = <MT8192_POWER_DOMAIN_MFG2>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_MFG3 {
> +							reg = <MT8192_POWER_DOMAIN_MFG3>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_MFG4 {
> +							reg = <MT8192_POWER_DOMAIN_MFG4>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_MFG5 {
> +							reg = <MT8192_POWER_DOMAIN_MFG5>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_MFG6 {
> +							reg = <MT8192_POWER_DOMAIN_MFG6>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8192_POWER_DOMAIN_DISP {
> +					reg = <MT8192_POWER_DOMAIN_DISP>;
> +					clocks = <&topckgen CLK_TOP_DISP_SEL>,
> +						 <&mmsys CLK_MM_SMI_INFRA>,
> +						 <&mmsys CLK_MM_SMI_COMMON>,
> +						 <&mmsys CLK_MM_SMI_GALS>,
> +						 <&mmsys CLK_MM_SMI_IOMMU>;
> +					clock-names = "disp", "disp-0", "disp-1", "disp-2",
> +						      "disp-3";
> +					mediatek,infracfg = <&infracfg>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8192_POWER_DOMAIN_IPE {
> +						reg = <MT8192_POWER_DOMAIN_IPE>;
> +						clocks = <&topckgen CLK_TOP_IPE_SEL>,
> +							 <&ipesys CLK_IPE_LARB19>,
> +							 <&ipesys CLK_IPE_LARB20>,
> +							 <&ipesys CLK_IPE_SMI_SUBCOM>,
> +							 <&ipesys CLK_IPE_GALS>;
> +						clock-names = "ipe", "ipe-0", "ipe-1", "ipe-2",
> +							      "ipe-3";
> +						mediatek,infracfg = <&infracfg>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_ISP {
> +						reg = <MT8192_POWER_DOMAIN_ISP>;
> +						clocks = <&topckgen CLK_TOP_IMG1_SEL>,
> +							 <&imgsys CLK_IMG_LARB9>,
> +							 <&imgsys CLK_IMG_GALS>;
> +						clock-names = "isp", "isp-0", "isp-1";
> +						mediatek,infracfg = <&infracfg>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_ISP2 {
> +						reg = <MT8192_POWER_DOMAIN_ISP2>;
> +						clocks = <&topckgen CLK_TOP_IMG2_SEL>,
> +							 <&imgsys2 CLK_IMG2_LARB11>,
> +							 <&imgsys2 CLK_IMG2_GALS>;
> +						clock-names = "isp2", "isp2-0", "isp2-1";
> +						mediatek,infracfg = <&infracfg>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_MDP {
> +						reg = <MT8192_POWER_DOMAIN_MDP>;
> +						clocks = <&topckgen CLK_TOP_MDP_SEL>,
> +							 <&mdpsys CLK_MDP_SMI0>;
> +						clock-names = "mdp", "mdp-0";
> +						mediatek,infracfg = <&infracfg>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_VENC {
> +						reg = <MT8192_POWER_DOMAIN_VENC>;
> +						clocks = <&topckgen CLK_TOP_VENC_SEL>,
> +							 <&vencsys CLK_VENC_SET1_VENC>;
> +						clock-names = "venc", "venc-0";
> +						mediatek,infracfg = <&infracfg>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_VDEC {
> +						reg = <MT8192_POWER_DOMAIN_VDEC>;
> +						clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> +							 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +							 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +							 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
> +						clock-names = "vdec", "vdec-0", "vdec-1", "vdec-2";
> +						mediatek,infracfg = <&infracfg>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8192_POWER_DOMAIN_VDEC2 {
> +							reg = <MT8192_POWER_DOMAIN_VDEC2>;
> +							clocks = <&vdecsys CLK_VDEC_VDEC>,
> +								 <&vdecsys CLK_VDEC_LAT>,
> +								 <&vdecsys CLK_VDEC_LARB1>;
> +							clock-names = "vdec2-0", "vdec2-1",
> +								      "vdec2-2";
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +
> +					power-domain@MT8192_POWER_DOMAIN_CAM {
> +						reg = <MT8192_POWER_DOMAIN_CAM>;
> +						clocks = <&topckgen CLK_TOP_CAM_SEL>,
> +							 <&camsys CLK_CAM_LARB13>,
> +							 <&camsys CLK_CAM_LARB14>,
> +							 <&camsys CLK_CAM_CCU_GALS>,
> +							 <&camsys CLK_CAM_CAM2MM_GALS>;
> +						clock-names = "cam", "cam-0", "cam-1", "cam-2",
> +							      "cam-3";
> +						mediatek,infracfg = <&infracfg>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8192_POWER_DOMAIN_CAM_RAWA {
> +							reg = <MT8192_POWER_DOMAIN_CAM_RAWA>;
> +							clocks = <&camsys_rawa CLK_CAM_RAWA_LARBX>;
> +							clock-names = "cam_rawa-0";
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_CAM_RAWB {
> +							reg = <MT8192_POWER_DOMAIN_CAM_RAWB>;
> +							clocks = <&camsys_rawb CLK_CAM_RAWB_LARBX>;
> +							clock-names = "cam_rawb-0";
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8192_POWER_DOMAIN_CAM_RAWC {
> +							reg = <MT8192_POWER_DOMAIN_CAM_RAWC>;
> +							clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>;
> +							clock-names = "cam_rawc-0";
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
>  		apmixedsys: syscon@1000c000 {
>  			compatible = "mediatek,mt8192-apmixedsys", "syscon";
>  			reg = <0 0x1000c000 0 0x1000>;
> -- 
> 2.18.0
> 
> 
