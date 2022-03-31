Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3BA4ED931
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiCaME3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbiCaMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:04:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B729208C26;
        Thu, 31 Mar 2022 05:02:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h23so33469491wrb.8;
        Thu, 31 Mar 2022 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A4Zjm/xBLp9YxmFT/DNtR5IxUCWdPvGVNi6dsCwjlvs=;
        b=hs1mRpoxuE6ZpUUnB6ufTgWOqqKRMlwZk7UDkYvnKGNfNaFa5kiy2kivZyhLrqXN+M
         iLOmA6pRfoJPDsUf+L9H95Xeuta15xztQkd5PxNID2AvHYeyyMv1+wwW3Ki/AdU6rWcQ
         orKBN+Jv70ZNVgEoCHvXATcpAbHpggbrtJmj4ZxX8Uk8YqJ76WlPyDodhGFbgTsFMUf+
         ozqSH5sd2hMaFTclgBsW8y9A4uYFYLZ9qSM0do8pJlrCcowHx1LDo1925nd/cFiTuWci
         x+pIBkfqWBSnFCPCAZCoT3ZYwCOhLWBoo3Xe/de4TTJUj/gFHDuXfWK9B9qn+53yL7FZ
         Nt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A4Zjm/xBLp9YxmFT/DNtR5IxUCWdPvGVNi6dsCwjlvs=;
        b=MypxIpZze4LhD57iPE5TKi0FnZBCrwwknhWVhY8jMJ6pZ5Im8zCEPQGYe4V5om9LRo
         +NR9BOT4QkO+uPNUzHKDI8xVKFJ+NBS/HJ84J64dMEPtF9wVS4ZfYYZk09jEiD42GR12
         yt04H3kOmp3t0cRICinoLMVoSqJwheKk4ag0nWoXnT0z1HiVnXS4Xb7b1fajieZ5811P
         k4S3YuaHIA3ovwwj2alBPVsvohU0PRQGUhrYrFebMCBsjH/3Hl4cPfzRyCSK/eCLg3NH
         I+xAbMMgw3RIVau/sMvhW/jmbQvOpFdhhuv5teNE/TQPC0TzBsWEw7+cbN+kJG1dPjTn
         bN2g==
X-Gm-Message-State: AOAM531NVYQT0SCW0GfhrOTH2AhqITIHtAazZMfkWWmp/1pb7PF8PijA
        y40h2FQjLzrOLtdq0tKHpeI=
X-Google-Smtp-Source: ABdhPJy1pwWwEsM0zqdfSBXpyPAD0/x0pcEIXNpZNqEniEbmMNwfmK6IiIHr/hlxLOMYZdRzHxD8rw==
X-Received: by 2002:a05:6000:1:b0:205:e7cd:2a5 with SMTP id h1-20020a056000000100b00205e7cd02a5mr2498122wrx.485.1648728132726;
        Thu, 31 Mar 2022 05:02:12 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0038c8fdc93d6sm6881237wmc.28.2022.03.31.05.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 05:02:12 -0700 (PDT)
Message-ID: <4cd1c5fa-0982-0355-d5b6-7025b82174a4@gmail.com>
Date:   Thu, 31 Mar 2022 14:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/4] arm64: dts: mt8192: Add mmc device nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
 <20220330133816.30806-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220330133816.30806-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 15:38, Allen-KH Cheng wrote:
> Add mmc nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

You forgot to disable the msdc clock node, which I understood we agreed on in in 
v4. I would consider this change as an substantial one, so in this case please 
delete the reviewed-by tags.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 32 ++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 69e8d1934d53..c1057878e2c6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -991,6 +991,38 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		mmc0: mmc@11f60000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11f70000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
> +		};
> +
>   		mfgcfg: clock-controller@13fbf000 {
>   			compatible = "mediatek,mt8192-mfgcfg";
>   			reg = <0 0x13fbf000 0 0x1000>;
