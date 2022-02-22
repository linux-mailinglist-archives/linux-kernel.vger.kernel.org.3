Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650A4C0520
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiBVXRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiBVXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:17:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140387C142;
        Tue, 22 Feb 2022 15:16:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EC1691F42A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645571801;
        bh=r6PeHk2jtY6t4pgQWhoW5J6l8CZI1VG43nrak3LpCXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUQ5gjZpK0k1MfDhWh4gwKuGJY8QtXR+gfjkIi1dSVHB/QfrzDXWAfgzpsJ4B4I+a
         9qkZrZ+zW1YN51SUsZmIXglwH7ETI3pVBloGriz/FwcZADdJRjltvIx3PjSGRyu+ll
         1lXbrg5UNPJqIiwF3nGcsizdzZmTn6sGgu9P9j3pSLFCvrypFg9f/7YPjSflujBcy0
         jVVc+PmCxBYM9uJcYMt5tyrT2kcYyqEvK2FPHSIUBv4MruH2i7DCwo1kWIbXdmCtaR
         RLeiz9o/K6/O7C4CjqgPeVNjZiHyoKD4+fXCjvpl11T7rsyC0Qr9dyMXQXn80l1f9b
         MFA/IKqRamyWw==
Date:   Tue, 22 Feb 2022 18:16:35 -0500
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
Subject: Re: [PATCH v2 21/23] arm64: dts: mt8192: Add dsi node
Message-ID: <20220222231635.33cupieckldkzgzn@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-22-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218091633.9368-22-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:16:31PM +0800, Allen-KH Cheng wrote:
> Add dsi ndoe for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 026f2d8141b0..1f1555fd18f5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1350,6 +1350,19 @@
>  			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
>  		};
>  
> +		dsi0: dsi@14010000 {
> +			compatible = "mediatek,mt8183-dsi";
> +			reg = <0 0x14010000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,syscon-dsi = <&mmsys 0x140>;
> +			clocks = <&mmsys CLK_MM_DSI0>,
> +				<&mmsys CLK_MM_DSI_DSI0>,
> +				<&mipi_tx0>;

Please fix the indentation.

> +			clock-names = "engine", "digital", "hs";
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";
> +		};
> +
>  		ovl_2l2: ovl@14014000 {
>  			compatible = "mediatek,mt8192-disp-ovl-2l";
>  			reg = <0 0x14014000 0 0x1000>;
> -- 
> 2.18.0
> 
> 
