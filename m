Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379E84BB9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiBRM5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:57:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiBRM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:57:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E9C27FCC;
        Fri, 18 Feb 2022 04:56:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EF41A1F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188996;
        bh=zFUQjy3wezXzoLPL7LBwuGlQGw/lZcvr6zcFJ77F9Y0=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=hH/5CMbuPz1k5AETD3XwiFw9SHm8qfwGOZWGg4/nk0OmbrmxTpDyZC7YC4NxWxR68
         FDoKPS/3WZel7kDE7sPXTQSuCh4GdBiL9v/AoFzffvmhR7RiVVV1Tu8t9s47uP0VnQ
         uCK5PODLJOVyj+Gekic5v4Ula1sik3HKcM7UMFxY55XvNVsrQ4WCxzGXdWUOyj+vhu
         9nYkiVhSeXh95SFkkNzIzp8hEEvOCZ+T+Zm/JynWLdzrLQi+hYWiCi9EXxZjRKSGZ+
         ieGUFb2sPsv7DVXsDZ2T+00dwfSWDvsgobmCZfGl7508oVjQb3gb9a0s+TzcCPkLXJ
         EfDkUiNZxYUYA==
Message-ID: <b28ca906-efa8-9f6e-8364-b053c1fead2e@collabora.com>
Date:   Fri, 18 Feb 2022 13:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 23/23] arm64: dts: mt8192: Add pwm node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-24-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-24-allen-kh.cheng@mediatek.com>
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
> Add pwm node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index df884c48669e..c0fc723fdf0a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -642,6 +642,16 @@
>   			status = "disabled";
>   		};
>   
> +		pwm0: pwm@1100e000 {
> +			compatible = "mediatek,mt8183-disp-pwm";
> +			reg = <0 0x1100e000 0 0x1000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#pwm-cells = <2>;
> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
> +				 <&infracfg CLK_INFRA_DISP_PWM>;
> +			clock-names = "main", "mm";

Depending on the machine, some displays may not be using this PWM node, so:

			status = "disabled";

> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8192-spi",
>   				     "mediatek,mt6765-spi";
> 

