Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAB46A1C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhLFQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:51:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbhLFQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:51:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 94E241F44A9A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638809289; bh=0znrmtZMATzeX3bJhBrLbdzjRWYzL2nWzFbmGEZ2jtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHdKCDuptPO2LMCs+HGvSeo4sLWl0QHF9laW5NDccVgF/ihRStFRdBx4qiV0Ah7Ix
         +cXf4iHe1xT7EEx9wXjtRb/C+x2JlJSEdyLuTQuLS5x/a+J0FeNHeX/HjiaTP13/4B
         f7u06psjW+bgOySr+9YLazQZ0BKOrSXP7fSaT5aRp2D3dVieOQikgz0CaPjbSvDfqC
         IzeoZooYrZIWJDcy2uxAiYT1MzeCY6PsPcLPwkqP4ZN/DAal09+btfg4WUot8UvBGQ
         PP+HAZpmTL2ZbE1qG+/JEp2iWp/V4wTA+fr23YFeUu8Bm/VcXlUFcgReeE8ImgD13n
         IwDSctGieUaFQ==
Date:   Mon, 6 Dec 2021 11:48:02 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 4/5] arm64: dts: mediatek: Correct Nor Flash clock of MT8192
Message-ID: <20211206164802.33ygybxt2bi2wom6@notapiano>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
 <20210825011120.30481-5-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825011120.30481-5-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 09:11:19AM +0800, Chun-Jie Chen wrote:
> update nor flash clock to the real one.

Same comment from patch 1.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index d1c85d3e152b..db6f4c6dc404 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -464,9 +464,9 @@
>  			compatible = "mediatek,mt8192-nor";
>  			reg = <0 0x11234000 0 0xe0>;
>  			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_SFLASH_SEL>,
> +				 <&infracfg CLK_INFRA_FLASHIF_SFLASH>,
> +				 <&infracfg CLK_INFRA_FLASHIF_TOP_H_133M>;
>  			clock-names = "spi", "sf", "axi";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.18.0
> 
> 
