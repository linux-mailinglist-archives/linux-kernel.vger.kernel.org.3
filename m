Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D84BB991
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiBRM5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiBRM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2682B4D9A;
        Fri, 18 Feb 2022 04:56:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 60A091F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188985;
        bh=+LLgEjAtE3bzxpNowg/nqrZgCIcdt+TTuXmtzhwUlSs=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=n9o0r9YXVPf9kpOwl2cybvpxePIQIac+077kozUQFNOC0OqANzSJ3NXeXvcoc3WZR
         7WwPMxtITwY3m10RwKk/Z4W/BQhN9MY+TVYl+E8EvGeSCnpuZcNueNzNfTzzmy7j4W
         jkf7mGzrFH/qozmXWGpbNjIJyDJqDaDY+1SjoZ+x3LNaMN7nEC/l8TjwKe3UY1EHbY
         LfMF1Mzf1ecqc5PAOt9qT20SjLr1JNNOLHOhDw0yVTWElZevKA4bKqZtUnYpsQo9qR
         qxdPqSMinLy1ekDiPz6FOfeinuqd4L7Jeo9mi6apAEpLyp6FXIQ7YNTAe0T7g4E01m
         SJdYHJOIhJ4Kg==
Message-ID: <e04d592f-297e-8c22-356c-7246c3c8ab1d@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 21/23] arm64: dts: mt8192: Add dsi node
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
 <20220218091633.9368-22-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-22-allen-kh.cheng@mediatek.com>
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
> Add dsi ndoe for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 026f2d8141b0..1f1555fd18f5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1350,6 +1350,19 @@
>   			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
>   		};
>   
> +		dsi0: dsi@14010000 {
> +			compatible = "mediatek,mt8183-dsi";
> +			reg = <0 0x14010000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,syscon-dsi = <&mmsys 0x140>;
> +			clocks = <&mmsys CLK_MM_DSI0>,
> +				<&mmsys CLK_MM_DSI_DSI0>,
> +				<&mipi_tx0>;
> +			clock-names = "engine", "digital", "hs";
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";

...please:
			status = "disabled";

> +		};
> +
>   		ovl_2l2: ovl@14014000 {
>   			compatible = "mediatek,mt8192-disp-ovl-2l";
>   			reg = <0 0x14014000 0 0x1000>;
