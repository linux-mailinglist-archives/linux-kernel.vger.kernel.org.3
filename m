Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD794C662C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiB1JzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiB1JzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:55:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913601A82A;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j17so14541750wrc.0;
        Mon, 28 Feb 2022 01:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A7Z1FVgJGlZ2dvwgZt8YIkYACQclsVMlrLP+8qyAGPs=;
        b=WS1VQxu/dCiW3P6jRxORXGv3sA2OJy2ZKDs7VmpPXBtUvQId6QocQQkgg1rCH4XC5J
         AfqhHU4TfYT4avWDMJHv2M2qFzQ0Rv9zLhGjF3R3wPjv3+EId+ak0+NzcmOdy9fwoPmn
         yvpjU5GFz02D3lCu6l7++p5iwUpjboHDc070bKgN62tRMNpn6ItZteb1RqZg0P2NVqjE
         rbkM8VcybDQsFXu7Je0alFBdHsdD0eXbbmlxQCBSrWjetW62LsSUBepO9Svo/qscnmgL
         zBsXGgrH3djp2cNFpVz20b2013wPgynpRUSx5Pv35AA5fDu3/JXwaDFufcGJ34pWAjRl
         KV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A7Z1FVgJGlZ2dvwgZt8YIkYACQclsVMlrLP+8qyAGPs=;
        b=Q8sOQecmUqAz/g9TK1OBP5L1DoKvNLrKlxih1r9v0YAUR8pO3K9JmM/MU24SbQFYdi
         dRzRRuaLaFyBbNqQVbuFzUyyDDw/vUPsJiJrAyXrjKb7v+LLZh26kdxvICeDMPx1A0Zj
         ePaEVTQVUjypHUO1nhCldkCGlwrj9A14/Dbw5Bf0nSrkGEGrFcpAIvV33IDWilWJ4O4T
         GJLjce3fNwoVjYLJD0l/YsrGTtoPVj0PUfJn5GEkvbahR0tXynEX54FN+vcXLLIcoIgO
         ftMaf2BIcy7s0Pj8B+r9/KzBcXgwv54ahkOkSJwLUg3nJnySs5+i0cIlBr6tSRFeXCTA
         33FQ==
X-Gm-Message-State: AOAM531Vy6BM8emdwskHfNUckqCl7PbkkYL8H/t7g0j3Osqwwm73a+5U
        VoDCQ9c08j707XIsTikQRbO2DYPkJopttw==
X-Google-Smtp-Source: ABdhPJz1GC6uvxJkgM9EYizFqh4nwhKC18ePBdTpL5nFxhMH0QLm7YnCHqS0Q3o3LDVmzk9ytup/zQ==
X-Received: by 2002:a5d:4848:0:b0:1ef:9028:46a9 with SMTP id n8-20020a5d4848000000b001ef902846a9mr6507072wrs.402.1646042063011;
        Mon, 28 Feb 2022 01:54:23 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id 2-20020a1c1902000000b00380d3873d6asm10955463wmz.43.2022.02.28.01.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:54:22 -0800 (PST)
Message-ID: <559c4849-6808-697d-f7f9-72cd87c61317@gmail.com>
Date:   Mon, 28 Feb 2022 10:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] arm/arm64: dts: mediatek: Format mediatek,larbs as an
 array of phandles
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220225225315.80220-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220225225315.80220-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nícolas,

On 25/02/2022 23:53, Nícolas F. R. A. Prado wrote:
> Commit 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> updated the mediatek,larbs property in the mediatek,iommu.yaml
> dt-binding to make it clearer that the phandles passed to the property
> are independent, rather than subsequent arguments to the first phandle.
> 
> Update the mediatek,larbs property in the Devicetrees to use the same
> formatting. This change doesn't impact any behavior: the compiled dtb is
> exactly the same. It does however fix the warnings generated by
> dtbs_check.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   arch/arm/boot/dts/mt2701.dtsi             | 2 +-
>   arch/arm/boot/dts/mt7623n.dtsi            | 2 +-

Thanks for your patch. Would you mind to split it in two parts. One for 64 bit 
and one 32 bits?

Regards,
Matthias

>   arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 6 +++---
>   arch/arm64/boot/dts/mediatek/mt8167.dtsi  | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 4 ++--
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi  | 4 ++--
>   6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 4776f85d6d5b..64722285228c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -222,7 +222,7 @@ iommu: mmsys_iommu@10205000 {
>   		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&infracfg CLK_INFRA_M4U>;
>   		clock-names = "bclk";
> -		mediatek,larbs = <&larb0 &larb1 &larb2>;
> +		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>;
>   		#iommu-cells = <1>;
>   	};
>   
> diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
> index bcb0846e29fd..f9e031621c80 100644
> --- a/arch/arm/boot/dts/mt7623n.dtsi
> +++ b/arch/arm/boot/dts/mt7623n.dtsi
> @@ -107,7 +107,7 @@ iommu: mmsys_iommu@10205000 {
>   		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&infracfg CLK_INFRA_M4U>;
>   		clock-names = "bclk";
> -		mediatek,larbs = <&larb0 &larb1 &larb2>;
> +		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>;
>   		#iommu-cells = <1>;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index de16c0d80c30..973c9beade0c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -329,8 +329,8 @@ iommu0: iommu@10205000 {
>   		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&infracfg CLK_INFRA_M4U>;
>   		clock-names = "bclk";
> -		mediatek,larbs = <&larb0 &larb1 &larb2
> -				  &larb3 &larb6>;
> +		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
> +				 <&larb3>, <&larb6>;
>   		#iommu-cells = <1>;
>   	};
>   
> @@ -346,7 +346,7 @@ iommu1: iommu@1020a000 {
>   		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&infracfg CLK_INFRA_M4U>;
>   		clock-names = "bclk";
> -		mediatek,larbs = <&larb4 &larb5 &larb7>;
> +		mediatek,larbs = <&larb4>, <&larb5>, <&larb7>;
>   		#iommu-cells = <1>;
>   	};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 9029051624a6..54655f2feb04 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -174,7 +174,7 @@ larb2: larb@16010000 {
>   		iommu: m4u@10203000 {
>   			compatible = "mediatek,mt8167-m4u";
>   			reg = <0 0x10203000 0 0x1000>;
> -			mediatek,larbs = <&larb0 &larb1 &larb2>;
> +			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>;
>   			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_LOW>;
>   			#iommu-cells = <1>;
>   		};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 2b7d331a4588..042feaedda4a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -588,8 +588,8 @@ iommu: iommu@10205000 {
>   			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
>   			clocks = <&infracfg CLK_INFRA_M4U>;
>   			clock-names = "bclk";
> -			mediatek,larbs = <&larb0 &larb1 &larb2
> -					  &larb3 &larb4 &larb5>;
> +			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
> +					 <&larb3>, <&larb4>, <&larb5>;
>   			#iommu-cells = <1>;
>   		};
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 00f2ddd245e1..523741150968 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -682,8 +682,8 @@ iommu: iommu@10205000 {
>   			compatible = "mediatek,mt8183-m4u";
>   			reg = <0 0x10205000 0 0x1000>;
>   			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
> -			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3
> -					  &larb4 &larb5 &larb6>;
> +			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>,
> +					 <&larb4>, <&larb5>, <&larb6>;
>   			#iommu-cells = <1>;
>   		};
>   
