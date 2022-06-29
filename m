Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A70560D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiF2XYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2XYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:24:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC02409D;
        Wed, 29 Jun 2022 16:24:35 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B52F6601907;
        Thu, 30 Jun 2022 00:24:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656545074;
        bh=3fot2bcVVnwspQui/MoRpRupiqAdVcAQgZ6BaPV5nj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K5SO9aFBOzLkBsWZ/3hTM4xodKEeoVVNmPelvZDX8vvA/hDdPLQwOvYB9XmwHse/F
         j3xcWL3FJMCoLKEjcHcR6ByVAGez/UVPdaJDKl8UaX/bPp1wL3zlcwR21Aqzo/+Fk1
         r8qR2146p8s0P3wamUwR+aKoEAOKHdvMKq2Tw0bFSu+zK6ZH7GfcV9Bjm7JlXd73iw
         MP9JYm3s7K1gyOo4s3Kx8ORbDc1acMQc3M0QuIjYnCwPKt3jZfRmDIKZaZEFnFjZc3
         xZmMcTwPRB8ofTaGrBrvYVorw+0qFqL2DRCcNEtrI+1Pp6V0EMt9wGfPAOPt0z+jlK
         DXI2yvgX9yUiw==
Date:   Wed, 29 Jun 2022 19:24:29 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 3/5] arm64: dts: mt8192: Add display nodes
Message-ID: <20220629232429.c5oysjgy6gflqhct@notapiano>
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
 <20220629121358.19458-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629121358.19458-4-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:13:56PM +0800, Allen-KH Cheng wrote:
> Add display nodes and gce info for mt8192 SoC.
> 
> GCE (Global Command Engine) properties to the display nodes in order to
> enable the usage of the CMDQ (Command Queue), which is required for
> operating the display.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 136 +++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a07edc82d403..26d01544b4ea 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
[..]
>  
> +		mutex: mutex@14001000 {
> +			compatible = "mediatek,mt8192-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;

This node is missing power-domains.

> +		};
> +
[..]
> +		rdma0: rdma@14007000 {
> +			compatible = "mediatek,mt8192-disp-rdma";

dtbs_check is complaining that there isn't a "mediatek,mt8183-disp-rdma"
fallback compatible here. But given that the rdma driver matches directly to the
mt8192 compatible, I think the node here is fine, and the binding is the one
that should be updated.

> +			reg = <0 0x14007000 0 0x1000>;
> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			iommus = <&iommu0 M4U_PORT_L0_DISP_RDMA0>;
> +			mediatek,larb = <&larb0>;

mediatek,larb is no longer used, so drop it.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
