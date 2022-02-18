Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2164BB996
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiBRM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiBRM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D32B405C;
        Fri, 18 Feb 2022 04:56:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 05B621F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188975;
        bh=vYybVfxwdCEV/CCokEdFCHCzJx1h/SHusE4GhNmMHlo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=QotMRuu+LAfP3106/kPC5ecRGxEaUOMWkk+1ZftxenKUfoeO1TIS/wuEDnFqx1TRZ
         uxa342L6RjZy16Qz0SLE7HEMkhPpxcE8pw0l4x/qDVkjqMo74oGmNLr5Ry8gZokD5R
         127vodAYPwJNOm6+lTsirhMk2ZcRgRk4EhmJwUXOA6uM/ib0ZSHiAyLWRLGfJDaD3O
         3QYClKEo3gBTKm+U5zFJSafREWmxnirtpQGVDsK+fU7S8Bq0di0rLaOPn5CoN+mZaE
         yMeh7pj4plhboKj3QIIvj9ICZ/jU6GN4roGM3MPi629Mv1B5ldTfQjLHd0EWOlaTIW
         dolwkQkhT8Iaw==
Message-ID: <0c28ee90-6dc0-9230-1feb-7c0c2cde24c1@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 18/23] arm64: dts: mt8192: Add dpi node
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
 <20220218091633.9368-19-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-19-allen-kh.cheng@mediatek.com>
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
> Add dpi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 543a80252ce5..55bcbf72a366 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1242,6 +1242,16 @@
>   			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
>   		};
>   
> +		dpi0: dpi@14016000 {
> +			compatible = "mediatek,mt8192-dpi";
> +			reg = <0 0x14016000 0 0x1000>;
> +			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DPI_DPI0>,
> +				<&mmsys CLK_MM_DISP_DPI0>,
> +				<&apmixedsys CLK_APMIXED_TVDPLL>;
> +			clock-names = "pixel", "engine", "pll";

Please, for the same reason explained for mipi_tx0:

			status = "disabled";

> +		};
> +
>   		iommu0: m4u@1401d000 {
>   			compatible = "mediatek,mt8192-m4u";
>   			reg = <0 0x1401d000 0 0x1000>;
