Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF294BB995
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiBRM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiBRM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE492B4D9D;
        Fri, 18 Feb 2022 04:55:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9BA331F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188938;
        bh=KGliYYvs3+aIadrV22Be8f4ODgtZewrfuctj/IReXTM=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=ZSofEMtH9ldFOoNbAsGvcilLM8DLw1RNzoDsV7AwB7XbnFQyRDLPz7X2uVvV/pVOC
         yxeKYKQ1BUf/hsRTwtWq//OHLNGPhYB531bFWqw1grWLPBs/VuHWVQN3q3dGzVq02J
         l6L1gxDOj3Zg3AR2DfYok/pozTy/tGsBhgU42Dt1BgY2cxtFvFLMW7R6ntUTLqc1Vs
         YhuYc0d9gQpkdGmp31N7N58zuWsEyWVAOpzzTrdVCAvVuy4uLOl51fLZ626sdBD9FT
         AiudwB/IDw5pIGbrYGUqjE+NN2FJD7aptu95DmxBlKOvP/udL+sbc2EWJvyvm1a3ZA
         HrDgDXPX2158w==
Message-ID: <822cac91-9272-2780-70e2-d4c683da6018@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 07/23] arm64: dts: mt8192: Add xhci node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-8-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-8-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index ce18d692175f..08c7c1c772f5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
>   
>   / {
> @@ -718,6 +719,30 @@
>   			status = "disabled";
>   		};
>   
> +		xhci: xhci@11200000 {
> +			compatible = "mediatek,mt8192-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x1000>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts-extended = <&gic GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "host";
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u3port0 PHY_TYPE_USB3>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_SEL>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&infracfg CLK_INFRA_SSUSB>,
> +				 <&infracfg CLK_INFRA_SSUSB_XHCI>,
> +				 <&apmixedsys CLK_APMIXED_USBPLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			wakeup-source;
> +			mediatek,syscon-wakeup = <&pericfg 0x420 102>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +		};
> +
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;


