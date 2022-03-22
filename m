Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4F4E48BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiCVV7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiCVV7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:59:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F15D99;
        Tue, 22 Mar 2022 14:58:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 3A0281F43FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647986279;
        bh=I0arKn0E7vN63I4XgUWTYnGY2tJfYbzJ7u22hHlqdDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VsElHnMT+C8u3vo7bEekufFYeVPA3WFbn8uJ7uEwX5zTyvAfnKvP8pET4CbmF9xqP
         D1PxKgrCJG68lzmgEMGyc3swAkukTZmnjPvAXxEOoFep6ecSKq2VjKsUVUgCQF0/mm
         g2FXPiUePLi8uVnGqWFE7nzNlWVzClFXrbhRA9MwXyA8GwUfrJW81L18mPqM2wUqpj
         /h8G4wcFiDkRp9zyF5GIOtqEjW7/J1jPEterRCWpsN6W9Bw4dTUl5021ji1EEjuMX2
         cWFdboVCpxGkZHXt6zRcdBn2tT/LqoXQhPAPRZNrdakXsr/WQ/TQ3XQ5xY/SsWBf08
         3YLGry8aa0FJg==
Date:   Tue, 22 Mar 2022 17:57:54 -0400
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
Subject: Re: [PATCH v4 08/22] arm64: dts: mt8192: Add infracfg_rst node
Message-ID: <20220322215754.j2hzutm775hvr25n@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-9-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-9-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

please see my comment below.

On Fri, Mar 18, 2022 at 10:45:20PM +0800, Allen-KH Cheng wrote:
> Add infracfg_rst node for mt8192 SoC.
>  - Add simple-mfd to allow probing the ti,syscon-reset node.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 40cf6dacca3e..82de1af3f6aa 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/ti-syscon.h>
>  
>  / {
>  	compatible = "mediatek,mt8192";
> @@ -267,10 +268,23 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		infracfg: syscon@10001000 {
> -			compatible = "mediatek,mt8192-infracfg", "syscon";
> +		infracfg: infracfg@10001000 {
> +			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
>  			reg = <0 0x10001000 0 0x1000>;
>  			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "ti,syscon-reset";
> +				#reset-cells = <1>;
> +
> +				ti,reset-bits = <
> +					0x120 0 0x124 0 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: lvts_ap */
> +					0x730 12 0x734 12 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 1: lvts_mcu */
> +					0x140 15 0x144 15 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 2: pcie phy */
> +					0x730 1 0x734 1 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 3: pcie top */
> +					0x150 5 0x154 5 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 4: svs */
> +				>;

If you see [1], Rob has previously said that there shouldn't be new users of the
ti,reset-bits property. I suggest doing like proposed on [2]: moving these bit
definitions to the reset-ti-syscon driver, and have them selected through the
compatible. You'd need to add a mt8192 specific compatible here too for that.

[1] https://lore.kernel.org/all/CAL_JsqJq6gqoXtvG1U7UDsOQpz7oMLMunZHq2njN6nvPr8PZMA@mail.gmail.com/
[2] https://lore.kernel.org/all/CAATdQgA5pKhjOf5gxo+h7cs7kCts3DeKGU5axeX2t+OaJFHyBg@mail.gmail.com/

Thanks,
Nícolas

> +			};
>  		};
>  
>  		pericfg: syscon@10003000 {
> -- 
> 2.18.0
> 
> 
