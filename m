Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119DC4E32FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiCUWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiCUWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:47:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECB136627B;
        Mon, 21 Mar 2022 15:26:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 77B891F43C7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647901578;
        bh=B8Pb07hkCfW+xPaMdiwdl2p2fFiGYRzPCnnydlob/vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr6qLx7D1I+cpf7Bg25M1DfpHYW3LmJzrS546wmKykxyPgOQv1Df3Rntju+oWv201
         1Ra/PeOakKqLV/N3BEUPbzEaYb0wn1biZgAZA65z7cMHgQsuxjTGm3bpqjzW59xCGk
         5jhd37GA0/JDDEMVWyMozFZN9JK48X3vUMl+o8x/BB1h00W5ATPRwwTdYFbXNLc9ep
         RF5R5bwIIjsOsc+qU22Boj5yX79cEyZo4KS94s1yRpcME8W8RJ4VU7JDonUHzP2zr3
         LGR7UELzrHvuqenyN4atQ0SwuxsVfoD3SIGKIZANQ2uKd+Tscr4Miw5sZXKZ/l+G1Q
         n99LtvS7z+gkw==
Date:   Mon, 21 Mar 2022 18:26:13 -0400
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
Subject: Re: [PATCH v4 06/22] arm64: dts: mt8192: Add xhci node
Message-ID: <20220321222613.aro6m72hoyubsggg@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-7-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-7-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:18PM +0800, Allen-KH Cheng wrote:
> Add xhci node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 28b93b76fe17..6bc36a4076f4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mt8192-power.h>
>  
>  / {
> @@ -718,6 +719,29 @@
>  			status = "disabled";
>  		};
>  
> +		xhci: usb@11200000 {
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
> +			status = "disabled";
> +		};
> +
>  		nor_flash: spi@11234000 {
>  			compatible = "mediatek,mt8192-nor";
>  			reg = <0 0x11234000 0 0xe0>;
> -- 
> 2.18.0
> 
> 
