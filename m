Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A550BA25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448688AbiDVOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448569AbiDVOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:34:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB757B36;
        Fri, 22 Apr 2022 07:31:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e2so5054055wrh.7;
        Fri, 22 Apr 2022 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wsa45TwHgv/5LBoiLGS2P/m3UDPekxcm9zNGP4Y4EaI=;
        b=kNkr0OOXTip5cDtSJfm9ApUmYZx5mMbrWfqKDXwk1yoqkCE3Yg1IytnneHnmGIMzjR
         OB7WJPhiVA+wg8K9lKq2nOgOaWFXL1+WWAjoqQS17p7DY+iQQ/Z2/Lzcg5dPAzCrKo5p
         C4uwUEgUFKu2ur0PUX/jaCOCnslNclyyco+Ceo/kumK+AbhH+lyrry2X4k8INdaTjsP1
         IhTsdZbx+FFVolul+1ByKTy5e2ckq3AF+c075zYMa4puOtrCziMpdP6MrCA+LgNPJ8HY
         IOmb3hcIeA/cVvdB1zwiQdkgtrgoABVIfVcbBA+8zEePXE3OdAi4vNfQ6Wa2FQIUwzm6
         bUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wsa45TwHgv/5LBoiLGS2P/m3UDPekxcm9zNGP4Y4EaI=;
        b=n+OVfZVPVFS78OYQtMRHoTW5Bl8BDZivmFntrwG2BY7/dlQyXBv2AO+ifO+8wAFED6
         mWoH8/msEBBd7QD34RzEk/orkhWBmNibsCkT4cNQzkEDwzv8DvxD18Q4S88k5vYvAO05
         PxfVH0t7pKlA3XGTkmg1wpfRG+lpGlNX/wqIhRhGbvGFIpAHsvv7cPDVerIcfDbtokQY
         De0UK5R64ebUZmfaiQCdzL6Wc7tL7K5B4OF54v4PYHpSg+1goFfHGS+bUm0+YQsbNzOW
         eMewEdQGmKKrbWaabeYiTpNUk+SECKuJKc8jXVAjsNz5LB4tQrratD2qy42nG3LNHJiJ
         1fRw==
X-Gm-Message-State: AOAM532xCd3SYXuRafLbeUKAHSxIcg2gu6Zwz4jY4uXS7tvGp+gfUkl8
        dfRYmTp33smwBA9ISwQZjbVtKNrm4wJObg==
X-Google-Smtp-Source: ABdhPJzILje0JAbbos2mBoruwCJrBpfJM6vLzXSPrVTORAKPI9iH2ZUfEp4ADwU9BRMO7rT0Bf3gMQ==
X-Received: by 2002:a5d:6702:0:b0:20a:ce25:6590 with SMTP id o2-20020a5d6702000000b0020ace256590mr971887wru.63.1650637865427;
        Fri, 22 Apr 2022 07:31:05 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm6119741wmq.40.2022.04.22.07.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:31:04 -0700 (PDT)
Message-ID: <a5c3512c-771b-9d2f-0701-cadd4da6e85f@gmail.com>
Date:   Fri, 22 Apr 2022 16:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] arm64: dts: mt8192: Add mmc device nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220407113703.26423-1-allen-kh.cheng@mediatek.com>
 <20220407113703.26423-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220407113703.26423-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2022 13:37, Allen-KH Cheng wrote:
> In mt8192 SoC, mmc driver dose not use the MSDC module to control
> clock. It will read/write register to enable/disable clock. Also
> there is no other device of mt8192 using MSDC controller.
> 
> We add mmc nodes for mt8192 SoC and remove the clock-controller in
> dts for avoid a duplicate unit-address(11f60000) warning.
> 

Applied, thanks!

Matthias

> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 +++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index a6da7b04b9d4..18a58239d6f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -985,10 +985,36 @@
>   			#clock-cells = <1>;
>   		};
>   
> -		msdc: clock-controller@11f60000 {
> -			compatible = "mediatek,mt8192-msdc";
> -			reg = <0 0x11f60000 0 0x1000>;
> -			#clock-cells = <1>;
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
>   		};
>   
>   		mfgcfg: clock-controller@13fbf000 {
