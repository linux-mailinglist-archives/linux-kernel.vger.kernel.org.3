Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F284C16EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbiBWPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242117AbiBWPgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:36:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844BFBB57B;
        Wed, 23 Feb 2022 07:35:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 76B041F429B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645630549;
        bh=tP0g/xufzKKvhWPi4v/n2vm5kmuNUItMFZ3CsZ84rbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsqqG4jtdYxdTUGEACf3J8GFzjVQsjSqjIr4GVNPFl/fgoeETax4lz1Z7FK4i8cgl
         b35wyK80nEnrFeup3RAGiyqzRaAJsdWWB3cpYiIwhe6TZJOc3R7fVVnpJd3p1RGW/2
         +BzBu0YDgwgbqGfy2sdcerbr9H1c1MNl8Gf4+UZn7rZ8ACPV7qWIt6d3NI9/Nv7KDF
         XvPmmIgRM/7oLDCR3PKnThmABiuBbmDOgae+7ekPPodV3CqCaSE/8kiUAjJHburRA+
         1WNfFRS1SFnGCkuNq7x/4aJYWrUl/f1Xo6xR4dXy9tG41OHFyFIt9IsESFNL+bF8KM
         MSHMfwZut4Dbw==
Date:   Wed, 23 Feb 2022 10:35:44 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 20/23] arm64: dts: mt8192: Add display nodes
Message-ID: <20220223153544.nmaufqixkchp5zkq@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-21-allen-kh.cheng@mediatek.com>
 <CAGXv+5H8WY6=qvcz1CARfjf5UREH7i7v2Uz99frby5S=eqV6gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5H8WY6=qvcz1CARfjf5UREH7i7v2Uz99frby5S=eqV6gQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 06:24:29PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Fri, Feb 18, 2022 at 5:16 PM Allen-KH Cheng
> <allen-kh.cheng@mediatek.com> wrote:
> >
> > Add display nodes for mt8192 SoC.
> >
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 115 +++++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index e3314cdc7c1a..026f2d8141b0 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -32,6 +32,11 @@
> >                 i2c7 = &i2c7;
> >                 i2c8 = &i2c8;
> >                 i2c9 = &i2c9;
> > +               ovl0 = &ovl0;
> > +               ovl-2l0 = &ovl_2l0;
> > +               ovl-2l2 = &ovl_2l2;
> > +               rdma0 = &rdma0;
> > +               rdma4 = &rdma4;
> >         };
> >
> >         clk26m: oscillator0 {
> > @@ -1224,6 +1229,13 @@
> >                         #clock-cells = <1>;
> >                 };
> >
> > +               mutex: mutex@14001000 {
> > +                       compatible = "mediatek,mt8192-disp-mutex";
> > +                       reg = <0 0x14001000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> > +               };
> > +
> >                 smi_common: smi@14002000 {
> >                         compatible = "mediatek,mt8192-smi-common";
> >                         reg = <0 0x14002000 0 0x1000>;
> > @@ -1255,6 +1267,109 @@
> >                         power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> >                 };
> >
> > +               ovl0: ovl@14005000 {
> > +                       compatible = "mediatek,mt8192-disp-ovl";
> > +                       reg = <0 0x14005000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       clocks = <&mmsys CLK_MM_DISP_OVL0>;
> > +                       iommus = <&iommu0 M4U_PORT_L0_OVL_RDMA0>,
> > +                                <&iommu0 M4U_PORT_L0_OVL_RDMA0_HDR>;
> > +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> > +               };
> > +
> > +               ovl_2l0: ovl@14006000 {
> > +                       compatible = "mediatek,mt8192-disp-ovl-2l";
> > +                       reg = <0 0x14006000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> > +                       clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> > +                       iommus = <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0>,
> > +                                <&iommu0 M4U_PORT_L1_OVL_2L_RDMA0_HDR>;
> > +               };
> > +
> > +               rdma0: rdma@14007000 {
> > +                       compatible = "mediatek,mt8192-disp-rdma";
> > +                       reg = <0 0x14007000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> > +                       iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> > +                       mediatek,larb = <&larb0>;
> > +                       mediatek,rdma-fifo-size = <5120>;
> > +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> > +               };
> > +
> > +               color0: color@14009000 {
> > +                       compatible = "mediatek,mt8192-disp-color",
> > +                                    "mediatek,mt8173-disp-color";
> > +                       reg = <0 0x14009000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> > +                       clocks = <&mmsys CLK_MM_DISP_COLOR0>;
> > +               };
> > +
> > +               ccorr0: ccorr@1400a000 {
> > +                       compatible = "mediatek,mt8192-disp-ccorr";
> > +                       reg = <0 0x1400a000 0 0x1000>;
> > +                       interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                       power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> > +                       clocks = <&mmsys CLK_MM_DISP_CCORR0>;
> > +               };
> > +
> > +               aal0: aal@1400b000 {
> > +                       compatible = "mediatek,mt8192-disp-aal";
> 
> git.kernel.org/chunkuang.hu/c/4ed545e7d10049b5492afc184e61a67e478a2cfd
> 
> suggests that there should be a fallback compatible? Otherwise this
> doesn't probe.

Indeed, the "mediatek,mt8173-disp-aal" compatible should be appended here for
the node to probe.

Thanks,
Nícolas
