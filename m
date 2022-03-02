Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A34CA198
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiCBKAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiCBKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:00:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222015A0A6;
        Wed,  2 Mar 2022 01:59:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so871940wmp.5;
        Wed, 02 Mar 2022 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bqn15CLszH8tgeYVXPDyS9PDZ9V24xOYhyZEU0cziCU=;
        b=KLHxpiGmD+04NGOjMBe6yOlM94zblYrTamClh0LbnsP5jkc9u1g7CSCSgFsvmQsdh9
         rYhEy0QAYYPsKcAZ7JiaQQdkByAkQB0VnHFbVu7duCCpZx+xQTGbbb41PCB+Qbe+L96Q
         mJOm7oIUiqlzWKo5888GlAF8x6ukCruimuRmcXP+nwrnW0wGR66rhDGF+IP5ahEZb7ld
         sOFRaaG1AuvKKxQAqfNao0dLczLwP7CD8liF5JkQ1ebJv5bbTaAOR96bjX/5olk9wg0a
         k/n1p68zpRtldT4j/gUStEy9kRxdlsy9SuUJ/827EHh5kgWAJuEroI9VsulyYBLvuJMP
         Bb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bqn15CLszH8tgeYVXPDyS9PDZ9V24xOYhyZEU0cziCU=;
        b=ziI4GubaXbBGZCI3VMqECuOPNhbOgN6uCECvPrtMGcITvL7SmbqxeO7LKnZj3BX5RT
         OPE8/XNb9ORJw3pCcQpbZPxfQVLG5FZR7Oh1Ui9ff3jPzcyAiNTUsHZzlO2LramCxMOr
         BFrERA0THURzktzVE7onc/gdEV/xvdZ30OGMYozM3/Xl/TwJoSzDnESi1EIE2U8A44o/
         +tCOPyguAzrCWl1pNVU7tnQcFirohheHK4JbSH/ItvBteCBQihW7ITbneBDKwJ0B9A0C
         WTuAsbmVoZNbc3ZhpB95PZNIL8vDwAkliYbWSxE0+n6kQViEP6GN/gItY3Kc7QcjUKBH
         P57A==
X-Gm-Message-State: AOAM531yMdaclF63mvHMHx32ZXUdCYZjm9ejUG+2SX8BBNK3msxP0MEw
        uACNG3ucZF3ArRgTDYSOqiE=
X-Google-Smtp-Source: ABdhPJw99nTjEa0dXu0eyoXNDI7VMBV+HKjmZwzeXg3DgKKLpyej0dWV7jQr5um9TpsLlKMVGOWV1g==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr20490626wmp.41.1646215170531;
        Wed, 02 Mar 2022 01:59:30 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm6844599wmp.44.2022.03.02.01.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:59:30 -0800 (PST)
Message-ID: <00c646de-053c-d84f-cb70-e33060264d40@gmail.com>
Date:   Wed, 2 Mar 2022 10:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] arm: dts: mediatek: Format mediatek,larbs as an
 array of phandles
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220301203147.1143782-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220301203147.1143782-1-nfraprado@collabora.com>
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



On 01/03/2022 21:31, Nícolas F. R. A. Prado wrote:
> Commit 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> updated the mediatek,larbs property in the mediatek,iommu.yaml
> dt-binding to make it clearer that the phandles passed to the property
> are independent, rather than subsequent arguments to the first phandle.
> 
> Update the mediatek,larbs property in the arm Devicetrees to use the
> same formatting. This change doesn't impact any behavior: the compiled
> dtb is exactly the same. It does however fix the warnings generated by
> dtbs_check.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Applied, thanks!

Matthias

> ---
> v1: https://lore.kernel.org/linux-mediatek/20220225225315.80220-1-nfraprado@collabora.com/
> 
> Changes in v2:
> - Split arm and arm64 changes into separate commits
> 
>   arch/arm/boot/dts/mt2701.dtsi  | 2 +-
>   arch/arm/boot/dts/mt7623n.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
