Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC344FFA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiDMPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDMPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:31:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E56338E;
        Wed, 13 Apr 2022 08:29:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 623F81F45A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649863748;
        bh=QkuxM+5pnkSA1ICUnAKMrVwzy8WneSmBDiuAOn1jeUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2P2ES0QUqCA8NlI18oTrBam5MoFphrsbmf+R5RvhI4PZA6bUx1dA6fGxfrwf+jOv
         7381/YQjBg9oODeEmpBqpo9q515hMr/XGKo2aveT750cxgtfyPMEBXSE1nr2GV/uEf
         biVW+X12b/5t8N9cKppfWxYGJnZpY17RQG/3uH3pGgbnCa2a3vsP/ksctA4/cfq8G8
         FK4ewWzrI3bBmVFtZ1feT7weYHHjXrIiGjAc2oBUN+ZNCvB3mIpNunPylDCmUZ2Hw+
         DTEGJnzrwU9Fb83K950oZ+Ry4cx4N9g5si4BKW1FG9PKa5kB3Wy8znVjkp5PXuVHgM
         EiNWtT0Xd7AVg==
Date:   Wed, 13 Apr 2022 11:29:03 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH 1/1] arm64: dts: mt8192: Add vcodec lat and core nodes
Message-ID: <20220413152903.3pk3ed5a5lgtiyf4@notapiano>
References: <20220408104124.31395-1-allen-kh.cheng@mediatek.com>
 <20220408104124.31395-2-allen-kh.cheng@mediatek.com>
 <20220412230819.vnbdv6wpsg73eqzi@notapiano>
 <649d747ceddc7fbd3f226f4448874665231ae744.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649d747ceddc7fbd3f226f4448874665231ae744.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:21:29PM +0800, allen-kh.cheng wrote:
> Hi Nícolas,
> 
> On Tue, 2022-04-12 at 19:08 -0400, Nícolas F. R. A. Prado wrote:
> > Hi Allen,
> > 
> > On Fri, Apr 08, 2022 at 06:41:24PM +0800, Allen-KH Cheng wrote:
> > > Add vcodec lat and core nodes for mt8192 SoC.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60
> > > ++++++++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 18a58239d6f1..c7f4b2fbb315 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -1120,6 +1120,66 @@
> > >  			power-domains = <&spm
> > > MT8192_POWER_DOMAIN_ISP2>;
> > >  		};
> > >  
> > > +		vcodec_dec: vcodec-dec@16000000 {
> > > +			compatible = "mediatek,mt8192-vcodec-dec";
> > > +			reg = <0 0x16000000 0 0x1000>;
> > > +			mediatek,scp = <&scp>;
> > > +			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> > > +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0
> > > 0xfff00000>;
> > > +			#address-cells = <2>;
> > > +			#size-cells = <2>;
> > 
> > The dt-binding says address-cells and size-cells should be 1. Then
> > most of the
> > extra 0s can be dropped from ranges and the children's regs.
> > 
> > Other than that,
> > 
> > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > Thanks,
> > Nícolas
> > 
> 
> I have checked the description in mediatek,vcodec-subdev-decoder.yaml
> 
> address-cells and size-cells are two after the below commit is merged.
> 
> media: mediatek,vcodec: Fix addressing cell sizes
> linux/kernel/git/next/linux-next.git
> commit/id=a50e431bbc6fc5768ed26be5fab5b149b7b8b1fe

Hi Allen,

yes, you're right. I missed that commit, sorry. This patch is perfectly fine
as it is then.

Thanks,
Nícolas

> 
> Correct me if I got this wrong.
> 
> Thanks,
> Allen
> 
> > > +			ranges = <0 0 0 0x16000000 0 0x26000>;
> > > +
> > > +			vcodec_lat: vcodec-lat@10000 {
> > > +				compatible = "mediatek,mtk-vcodec-lat";
> > > +				reg = <0x0 0x10000 0 0x800>;
> > > +				interrupts = <GIC_SPI 426
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +				iommus = <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
> > > +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> > > +					 <&vdecsys_soc
> > > CLK_VDEC_SOC_VDEC>,
> > > +					 <&vdecsys_soc
> > > CLK_VDEC_SOC_LAT>,
> > > +					 <&vdecsys_soc
> > > CLK_VDEC_SOC_LARB1>,
> > > +					 <&topckgen
> > > CLK_TOP_MAINPLL_D4>;
> > > +				clock-names = "sel", "soc-vdec", "soc-
> > > lat", "vdec", "top";
> > > +				assigned-clocks = <&topckgen
> > > CLK_TOP_VDEC_SEL>;
> > > +				assigned-clock-parents = <&topckgen
> > > CLK_TOP_MAINPLL_D4>;
> > > +				power-domains = <&spm
> > > MT8192_POWER_DOMAIN_VDEC>;
> > > +			};
> > > +
> > > +			vcodec_core: vcodec-core@25000 {
> > > +				compatible = "mediatek,mtk-vcodec-
> > > core";
> > > +				reg = <0 0x25000 0 0x1000>;
> > > +				interrupts = <GIC_SPI 425
> > > IRQ_TYPE_LEVEL_HIGH 0>;
> > > +				iommus = <&iommu0
> > > M4U_PORT_L4_VDEC_MC_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_UFO_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_PP_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_PRED_RD_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_PRED_WR_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_PPWRAP_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_TILE_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_VLD_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_VLD2_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_AVC_MV_EXT>,
> > > +					 <&iommu0
> > > M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
> > > +				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
> > > +					 <&vdecsys CLK_VDEC_VDEC>,
> > > +					 <&vdecsys CLK_VDEC_LAT>,
> > > +					 <&vdecsys CLK_VDEC_LARB1>,
> > > +					 <&topckgen
> > > CLK_TOP_MAINPLL_D4>;
> > > +				clock-names = "sel", "soc-vdec", "soc-
> > > lat", "vdec", "top";
> > > +				assigned-clocks = <&topckgen
> > > CLK_TOP_VDEC_SEL>;
> > > +				assigned-clock-parents = <&topckgen
> > > CLK_TOP_MAINPLL_D4>;
> > > +				power-domains = <&spm
> > > MT8192_POWER_DOMAIN_VDEC2>;
> > > +			};
> > > +		};
> > > +
> > >  		larb5: larb@1600d000 {
> > >  			compatible = "mediatek,mt8192-smi-larb";
> > >  			reg = <0 0x1600d000 0 0x1000>;
> > > -- 
> > > 2.18.0
> > > 
> > > 
> 
