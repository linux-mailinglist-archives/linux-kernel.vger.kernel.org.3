Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687834C4FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiBYUiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:38:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DFB1768EA;
        Fri, 25 Feb 2022 12:38:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 59CCA1F46676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645821491;
        bh=GRjW8l7YFs9I63NHiDMM0zXU7yqNHLmPi/NdZK9uZMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sgv6tAZCt63KpQGsQ6MjbY8+Eg0hjF3u8RZxljuhM7GeGlwnHTy/xFzLa7uXpOEh1
         zaiqxJiOey9dOPHl56LaP/rLhtkXvZL8j8VaA1IklBT2PKiDhqUar57g2nHfZFZI0U
         lzS+1qHP0IDOm74OMrYBvE7A3ZIteKH5Lgl2xdYASzinXu2WRL5VsmeE+WlQMUOEcT
         dKAd1werFHy26nAbHbvlw7yjo1oFS1g92McSqdKABcAcI0PLuelxlCGHjZQyTi5sUK
         GU3mQo6pYuVVrRz5k9wfKEu06r1y28nAqcyW6aeJdQrxLClFnIaEZS87sUp0UKqJ2i
         vX5GeU9G/Mqtw==
Date:   Fri, 25 Feb 2022 15:38:05 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 14/23] arm64: dts: mt8192: Add mipi_tx node
Message-ID: <20220225203805.xv3sxwi6ucfp6zdq@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-15-allen-kh.cheng@mediatek.com>
 <20220222212658.xuau6t3xcvu7m4uz@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222212658.xuau6t3xcvu7m4uz@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:27:03PM -0500, Nícolas F. R. A. Prado wrote:
> On Fri, Feb 18, 2022 at 05:16:24PM +0800, Allen-KH Cheng wrote:
> > Add mipi_tx node for mt8192 SoC.
> > 
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index cfc2db501108..f5e5af949f19 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -1114,6 +1114,16 @@
> >  			};
> >  		};
> >  
> > +		mipi_tx0: mipi-dphy@11e50000 {
> 
> According to Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml, this
> node's name should be dsi-phy, not mipi-dphy.
> 
> > +			compatible = "mediatek,mt8183-mipi-tx";
> > +			reg = <0 0x11e50000 0 0x1000>;
> > +			clocks = <&apmixedsys CLK_APMIXED_MIPID26M>;
> > +			clock-names = "ref_clk";

Also, this clock-names should be dropped [1].

[1] https://lore.kernel.org/all/CAAOTY_84OF71QK6M5JT1M5YAFKED_xWVpx8B8t859OsVxE0cfQ@mail.gmail.com/

> > +			#clock-cells = <0>;
> > +			#phy-cells = <0>;
> > +			clock-output-names = "mipi_tx0_pll";
> > +		};
> > +
> >  		i2c0: i2c@11f00000 {
> >  			compatible = "mediatek,mt8192-i2c";
> >  			reg = <0 0x11f00000 0 0x1000>,
> > -- 
> > 2.18.0
> > 
> > 
