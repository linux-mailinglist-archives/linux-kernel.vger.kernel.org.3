Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC1563828
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiGAQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiGAQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:40:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8926044753;
        Fri,  1 Jul 2022 09:40:49 -0700 (PDT)
Received: from notapiano (unknown [193.27.14.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A2C666015DA;
        Fri,  1 Jul 2022 17:40:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656693647;
        bh=0LN1nCFHY1IULTVl6FBa/H7bg/S9tIWVbV69kp8VbnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAA9Si32fplazkxh8kicyhndXMgFsW4Iwzx/0yfMwj67OTUL7wGYE4ZQyAZnKtqEO
         iT6m6YdR/rwyrKrIVNJcb57lJfZpOyjXfncsoT+IT9UxEBvedDLpkq9nwO5uAgNMei
         frFMUE0Bv7Re8x2+qC0kdXny9jG3ke/Az7B41EdbKURPBmFxbOGUxYFJeVOB0UJitA
         9iHPk+xxmpLp1txmzqZnuny6BoeNZZZP/hkMeo8lcfWvugQrYTeDsBht/2Dg1yPSCv
         Z9EeIdYXw6QCIoY/+/9UIbFEic6Ii3YwQ8Ddet0J7HWLVzn/pSaglY9OEyFrQ4muXF
         XEBBetMaCs1Yw==
Date:   Fri, 1 Jul 2022 12:40:41 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 4/6] arm64: dts: mt8192: Add display nodes
Message-ID: <20220701164041.rbt3idraawafubcf@notapiano>
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
 <20220701090547.21429-5-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220701090547.21429-5-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:05:45PM +0800, Allen-KH Cheng wrote:
> Add display nodes and gce info for mt8192 SoC.
> 
> GCE (Global Command Engine) properties to the display nodes in order to
> enable the usage of the CMDQ (Command Queue), which is required for
> operating the display.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 137 +++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a789b7c9b2af..c4dc8777f26c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
[..]
> +		rdma4: rdma@14015000 {
> +			compatible = "mediatek,mt8192-disp-rdma";

You added the fallback compatible on rdma0 but missing it on this node.

Thanks,
Nícolas

> +			reg = <0 0x14015000 0 0x1000>;
> +			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA4>;
> +			iommus = <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
> +			mediatek,rdma-fifo-size = <2048>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
> +		};
> +
>  		dpi0: dpi@14016000 {
>  			compatible = "mediatek,mt8192-dpi";
>  			reg = <0 0x14016000 0 0x1000>;
> -- 
> 2.18.0
> 
> 
