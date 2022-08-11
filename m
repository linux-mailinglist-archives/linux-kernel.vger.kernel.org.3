Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC275905E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiHKRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHKRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:30:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35A45071;
        Thu, 11 Aug 2022 10:30:07 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2F956601C04;
        Thu, 11 Aug 2022 18:30:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660239006;
        bh=lvFb3qNxbflRt6kaIIDY/QEgJF+f1L7YQ9FOa4oivHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc4NnNdE6paaHjMAGFeShTe+BYkDfMv1a3Ujpqdy7c2Vgapkj+1+jvMPU8n7zcTVY
         p92B/v5t7v0x+f6NgYQ8/nmUfcaEugp2uLd7mZfWaFuevFkfwc/QmIcomBgu25dJyR
         OAKebNwFcGk/ihZslkA6k5O1/MlnznGLAjpY5qwTiOQELealARpz2pLWkj0sEDiWTN
         XdTzsaCKExiWK7FmcL8G9/ksrvypsv7nWVHRpEI6jQEiWElFLBlp6BChqiFIicz8Cy
         jfbNju5+9SuAz0St33VwrGwWE8HvDzk9pspdkUPM0MiTkEKuzxmaiKU433qPI+BVdT
         eGnm2lpZeZsUw==
Date:   Thu, 11 Aug 2022 13:30:00 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>, hsinyi@chromium.org
Subject: Re: [PATCH v14 1/1] arm64: dts: Add MediaTek MT8186 dts and
 evaluation board and Makefile
Message-ID: <20220811173000.kiplkbqzawlbreqf@notapiano>
References: <20220811125805.28577-1-allen-kh.cheng@mediatek.com>
 <20220811125805.28577-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811125805.28577-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 08:58:05PM +0800, Allen-KH Cheng wrote:
> Add basic chip support for MediaTek MT8186.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 228 ++++++
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 858 ++++++++++++++++++++
>  3 files changed, 1087 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi
[..]
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-evb.dts
[..]
> +		xhci0: usb@11200000 {
> +			compatible = "mediatek,mt8186-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x1000>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port0 PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_USB_TOP>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_REF>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_HCLK>,
> +				 <&infracfg_ao CLK_INFRA_AO_ICUSB>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_TOP_XHCI>;
> +			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
> +			mediatek,syscon-wakeup = <&pericfg 0x420 2>;
> +			wakeup-source;
> +			status = "disabled";
> +		};

You mention in the cover letter that the DSI node was removed from the patch
since it requires a power domain, and so will be added later when the MTK power
controller binding is sorted out. But the XHCI controller nodes also depend on
power domains:

	MT8186_POWER_DOMAIN_SSUSB
	MT8186_POWER_DOMAIN_SSUSB_P1

You're omitting the power domain for the xhci nodes here to avoid the dependency
on the power controller, which means you're relying on the bootloader to leave
them on for them to work.

I don't see any problem with adding the nodes without the reference to the
power domain for now, and just adding those later when the binding is sorted
out. The DT will be incomplete for a while, but that's usually the case anyway.

This is to say I think you should keep the DSI node in the patch without the
power-domain for now, like in the previous version. But let's see what others
think, in case omitting the power domain isn't acceptable, then you should
remove the XHCI nodes as well.

Matthias, any thoughts on this?

Thanks,
Nícolas
