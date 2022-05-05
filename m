Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279AF51C0FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380005AbiEENoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiEENnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:43:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52956C2C;
        Thu,  5 May 2022 06:40:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so6179836wrg.3;
        Thu, 05 May 2022 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z1RR59cI7xuB4wHEsyPKJMalbJOLkbwR60Nf/1GYehA=;
        b=ndpgFCn1qTpGhnYt6AJHLLEWJlQPdUMvg62egEiojKObjEKE6FEJzqy6ysaSTXnW+c
         39A4IXst24GMi+5AuVkfQN15o6O1nTSncpaAri2VwU//cHQS/1y1bpHqkwxymohUQsMy
         S7wxs09NfXgyGf1uoENAa54UlPTrAtVVdsaV2CffmVoIcn+umOfBQRugbByiyd3Hjen9
         0rC61Vzo7wsAW4hDQHGMPdb+cscQM5+HptSwTHt4KPxmOiNjKnA4tWJtqnmNEHdrlti3
         fq39KCHk4Z4/01z2TpJrV0KDpn7/FCGgSJ3ktpOfCsY2b+g0urMPWeLPnVmWZg6p5Mrj
         D5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z1RR59cI7xuB4wHEsyPKJMalbJOLkbwR60Nf/1GYehA=;
        b=To9W9AKz33r++Y2P5jV651DKHcgWjgya0VQIuhxTDBBTjBfktOsKr/etYHjSk9VcSh
         YGbOsmeTeI3ipoptbj+1s/JenSuvcx8mzRwh9YE7UMJbyRF8wdj0L3PHYoqrwtbecvZL
         y6OrQJ5Ga3qDMRpMo+HHq8TGpbbND77Ws+FT6lHlCjGe5n6e44m+5oTCR168zI8s3S6c
         219x56BhmaDgkMOb6lVdjiF+OzMTaEkBK+yD9aZLMM2Em8qu8KGy2dHgJbv8ZXalZmvk
         33zSJ36LMguW4Z50rpJ06YBHzycTsjeLUya0gLC6kMs/w1BcnS0IV0qOeqgRAZCw7TMb
         a5ew==
X-Gm-Message-State: AOAM53019vFQzIE+AzhciMIXOk6XsHXm28UvYV179UmgOVU5D5Qlthhg
        hjCq0QpjN4BoX1AzldhRtOg=
X-Google-Smtp-Source: ABdhPJyHaFZllmZOyM64fdf7fRq3DCLuUeYU8LlG4ML06VUn++MVFboIpiIVZAXJFIk1tqRN2CMwlQ==
X-Received: by 2002:adf:e40f:0:b0:20a:d221:b00c with SMTP id g15-20020adfe40f000000b0020ad221b00cmr20911209wrm.11.1651758005257;
        Thu, 05 May 2022 06:40:05 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c2f9000b003942a244f50sm6912572wmn.41.2022.05.05.06.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:40:04 -0700 (PDT)
Message-ID: <1b42b5aa-2020-b545-72ab-96ec14ef454a@gmail.com>
Date:   Thu, 5 May 2022 15:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] arm64: dts: mt8192: Follow binding order for SCP
 registers
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220504214516.2957504-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220504214516.2957504-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2022 23:45, Nícolas F. R. A. Prado wrote:
> The dt-binding for SCP documents the reg-names order as sram, cfg,
> l1tcm. Update the SCP node on the mt8192 devicetree to follow that
> order, which gets rid of a dtbs_check warning. This doesn't change any
> behavior since the SCP driver accesses the memory regions through the
> names anyway.
> 
> Fixes: c63556ec6bfe ("arm64: dts: mt8192: Add SCP node")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Applied thanks!

> ---
> 
> Changes in v2:
> - Added missing Fixes tag
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 26dbe9ecc528..733aec2e7f77 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -699,9 +699,9 @@ spi7: spi@1101e000 {
>   		scp: scp@10500000 {
>   			compatible = "mediatek,mt8192-scp";
>   			reg = <0 0x10500000 0 0x100000>,
> -			      <0 0x10700000 0 0x8000>,
> -			      <0 0x10720000 0 0xe0000>;
> -			reg-names = "sram", "l1tcm", "cfg";
> +			      <0 0x10720000 0 0xe0000>,
> +			      <0 0x10700000 0 0x8000>;
> +			reg-names = "sram", "cfg", "l1tcm";
>   			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
>   			clocks = <&infracfg CLK_INFRA_SCPSYS>;
>   			clock-names = "main";
