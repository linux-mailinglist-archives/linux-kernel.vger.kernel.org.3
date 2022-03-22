Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DE4E4749
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiCVUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiCVUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:15:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E0DF83;
        Tue, 22 Mar 2022 13:14:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 5AD151F42EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647980041;
        bh=CHw7sZCuJpAli88yUDsSE7+L4DPTITJnekKWt6hXu+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0xFVdRqaYEq/WG30NJ6ZSA+WJpaI1VAtF463Z9pVkqndqm6IJ7czLjyD8i8NfZWh
         CoMhVRHRlBaWkm20jGRYkIlJOqabo8/PYnzmbEcHqPY4M2HWHY7F0543offvVfKsHp
         FjkuM+dLOg/4Xy/fZQQGyRjRzsAB7fGxiGyZvPqRVzj5P/C1nQyisKy0DRtpBdenA3
         uIVI6C9LlDFJzLEz4jGJHcl751IHsHRVvNoG+YIg9d8lSpa7NsPfOsREeaS+7eJr3Z
         lpMB1UcrLPNEHWdZcC2JY2/PtDI0G5tDhKt2GJjWxS7J+iIrcQH53Zj8iCoWwzti0l
         ooijqNv5T82AA==
Date:   Tue, 22 Mar 2022 16:13:57 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 20/22] arm64: dts: mt8192: Add dsi node
Message-ID: <20220322201357.ykxi4h7l3rkp6z3s@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:32PM +0800, Allen-KH Cheng wrote:
> Add dsi ndoe for mt8192 SoC.

Minor typo: ndoe -> node.

> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 59183fb6c80b..08e0dd2483d1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/mt8192-resets.h>
>  #include <dt-bindings/reset/ti-syscon.h>
>  
>  / {
> @@ -1203,6 +1204,7 @@
>  			compatible = "mediatek,mt8192-mmsys", "syscon";
>  			reg = <0 0x14000000 0 0x1000>;
>  			#clock-cells = <1>;
> +			#reset-cells = <1>;
>  		};
>  
>  		mutex: mutex@14001000 {
> @@ -1327,6 +1329,20 @@
>  			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
>  		};
>  
> +		dsi0: dsi@14010000 {
> +			compatible = "mediatek,mt8183-dsi";
> +			reg = <0 0x14010000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DSI0>,
> +				 <&mmsys CLK_MM_DSI_DSI0>,
> +				 <&mipi_tx0>;
> +			clock-names = "engine", "digital", "hs";
> +			resets = <&mmsys MT8192_MMSYS_SW0_RST_B_DISP_DSI0>;
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";
> +			status = "disabled";
> +		};
> +
>  		ovl_2l2: ovl@14014000 {
>  			compatible = "mediatek,mt8192-disp-ovl-2l";
>  			reg = <0 0x14014000 0 0x1000>;
> -- 
> 2.18.0
> 
> 
