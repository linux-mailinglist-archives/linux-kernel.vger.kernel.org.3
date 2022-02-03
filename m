Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6E4A877A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351787AbiBCPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBCPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:16:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7CC06173B;
        Thu,  3 Feb 2022 07:16:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 023A81F45DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643901398;
        bh=emTF1W1AOfACykguchNAeQXAxGRzZACcQ0bCDOOa4T0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=liO/NV1+KbO9j5QZG24vwp0MQXhofctxUvUtTiRlw0pp5Nt5K1+YvT6wQOwF9I7+W
         nL9M5YUR0xWUGT2MSjOwr6umSJmIFBPot8WGRUMfYvWGMWHEJq/xyW2jpJT1sKfkFS
         JiZrBJtM7kjMiRmopH0Nthh9+c0jeGAYuvNq5FEIFHVPLuCmSWcziiiVRO2FRNyhrB
         o22Fs6DkiHYVRsn/tg9X6Rnt99PJUN1Gwflpr+gVc/NlH2ErGOVQR0ICd76woFz8PH
         dz5rfm4fuJt9zG/dST6v0SK8q0Fb2ZeMkJldB9pnzQ9/v74UR+oafOavuJqOsTIK4n
         ED4GQ5kUEWnZA==
Message-ID: <e08c8a92-a4c6-61a0-4fe7-6d8e2d83163b@collabora.com>
Date:   Thu, 3 Feb 2022 16:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [V11,PATCH 16/19] arm64: dts: mt8183: add dvfsrc related nodes
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
 <20210812085846.2628-17-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-17-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/08/21 10:58, Dawei Chien ha scritto:
> From: Henry Chen <henryc.chen@mediatek.com>
> 
> Add DDR EMI provider dictating dram interconnect bus performance found on
> MT8192-based platforms
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>

This patch definitely has to be squashed with patch 07/19.

Same for patch 17 and 19.

Also, sign-off.

> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 7ad4cf646579..86f85c34c88a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -7,6 +7,7 @@
>   
>   #include <dt-bindings/clock/mt8183-clk.h>
>   #include <dt-bindings/gce/mt8183-gce.h>
> +#include <dt-bindings/interconnect/mtk,mt8183-emi.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/memory/mt8183-larb-port.h>
> @@ -586,6 +587,7 @@
>   		ddr_emi: dvfsrc@10012000 {
>   			compatible = "mediatek,mt8183-dvfsrc";
>   			reg = <0 0x10012000 0 0x1000>;
> +			#interconnect-cells = <1>;
>   		};
>   
>   		pwrap: pwrap@1000d000 {
