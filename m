Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69B560D46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiF2Xbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2Xbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:31:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B8625C;
        Wed, 29 Jun 2022 16:31:41 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64A426601907;
        Thu, 30 Jun 2022 00:31:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656545499;
        bh=X82AnTeS9ql4xEMo8Ss/zWO0HusDJV9VvepmEeYZ+J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZFVdXWUBZB399V8KEwYh6tIku1a4jBEO9WHmqe/hDQheX/9GYKCYeSIuvT9hMLve
         Ie6JZ9z84WYFMRr+zJAmMA1jnBObYh9u3cy/0woI52gx455Bj1VYt+Al5R1ipAmSiV
         bTiP//qTup/B2Z2p+WVuWHfrjYzAgJ8I8NyX8QxPXlyV64wXu5EzmrbvGGCpTInrOV
         jHqgtW1FFWKCIGwkrcM3FQeO078a4e7/rbW89inh6DFIePPZUIl7EKvus9cSxKxiZ2
         XWzHj3azdm/cea5pvTYt8fayc0UHP/STwO1vk1BFo7sJl7Fep5f9d5n1a/E5OJAR+f
         H/YjOE0oqJOTw==
Date:   Wed, 29 Jun 2022 19:31:34 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 4/5] arm64: dts: mt8192: Add dsi node
Message-ID: <20220629233134.zt5ua4v5itycjmlt@notapiano>
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
 <20220629121358.19458-5-allen-kh.cheng@mediatek.com>
 <730f334e-c10d-8f8b-94e6-b66a56e03320@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <730f334e-c10d-8f8b-94e6-b66a56e03320@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 03:42:42PM +0200, AngeloGioacchino Del Regno wrote:
> Il 29/06/22 14:13, Allen-KH Cheng ha scritto:
> > Add dsi ndoe for mt8192 SoC.

Typo: s/ndoe/node.

> > 
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index 26d01544b4ea..72af328126de 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -1334,6 +1334,24 @@
> >   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
> >   		};
> > +		dsi0: dsi@14010000 {
> > +			compatible = "mediatek,mt8183-dsi";
> > +			reg = <0 0x14010000 0 0x1000>;
> > +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			mediatek,syscon-dsi = <&mmsys 0x140>;

Also drop this syscon-dsi property.

> > +			clocks = <&mmsys CLK_MM_DSI0>,
> > +				 <&mmsys CLK_MM_DSI_DSI0>,
> > +				 <&mipi_tx0>;
> > +			clock-names = "engine", "digital", "hs";
> > +			phys = <&mipi_tx0>;
> > +			phy-names = "dphy";

It's also missing power-domains.

> 
> resets = <&mmsys MT8192_MMSYS_SW0_RST_B_DISP_DSI0>;
> 
> ^^^ This is missing, please add it and resend :-)

Also, when this is added you'll need

#include <dt-bindings/reset/mt8192-resets.h>

With those addressed,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
> > +			status = "disabled";
> > +
> > +			port {
> > +				dsi_out: endpoint { };
> > +			};
> > +		};
> > +
> >   		ovl_2l2: ovl@14014000 {
> >   			compatible = "mediatek,mt8192-disp-ovl-2l";
> >   			reg = <0 0x14014000 0 0x1000>;
> 
> 
> 
