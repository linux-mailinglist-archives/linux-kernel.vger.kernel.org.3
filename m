Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858355A7B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiHaKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:23:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F61CFE5;
        Wed, 31 Aug 2022 03:23:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e20so17594997wri.13;
        Wed, 31 Aug 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=QQOr949BNq6Tsz1/GWbY8mmvpE6EQflLuQEMgsG3Mmo=;
        b=N6qelCPephiPlFW95dJC6m2EGeguD6GlubhFgn3yrrYceSIOUjnmv2FjS7kLO784wp
         qrvliJMZE5Mo7cWGZCCBPEs9u7tIHTvUDcFyadVgRHjD8JMaVGl6e/WQ3w8FXN0Wzgl9
         WSgndB2UFYpyZGiRsigro0C/cTmIT/GoYcDMpZjyfkfh7z8PY17W3yfjNYbhcW/x5HnL
         BusJb87qgrJRvZ7VnFcHSX+IHmpOa5WN3l4XTUClj50rO4oltoGifwwy1DW4K4jJ3tUR
         Q1euY5dxLPmNybYtZJZcKB/HlplhwpnEy8geNmxX8NrnzypUWDE+0/xRFdmaSs15Yeqy
         U7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QQOr949BNq6Tsz1/GWbY8mmvpE6EQflLuQEMgsG3Mmo=;
        b=QF2jJNvQgR6cjUgbzcqyUDl+/II7tJsYRC7byn0f+eZL2VJsFTcWVaEhsZ4m2qghZW
         AQdCLElg4VwAOBZ2vufg4HlV81MBVfN1Y/hGaNWb6lAMkmF+7ynpl7273RRIgsQYPrkR
         yU3j2D9KQOlrBRz6+3Lr8SWFJj0GTIUrSbSeKhKggW43jv8yEd1fy7IiKeubWGr7OYSa
         7KuT+p/I6Tp28NMABHiEA+0gfAdlCt/sivCGcSTgnPRutnFgzrlUIhCq+xjINV8WCxWo
         Jb+c1eD2yxzEbJyE3UebQqMPmr0XpvsuLxC9zdkQs1k2dISEgvnIogw/0fPrWaGv9W/s
         NxUw==
X-Gm-Message-State: ACgBeo1ATTue8PHldfyHi6VEtk61qkU81ZZftZHUchlX+wJykBRVOeMF
        W2VaqM5sxOWbnxpPVEiGCn0=
X-Google-Smtp-Source: AA6agR45AiRbadhtI8VHMxdZMgSj4iWs74MjjZ+50gkYRpG4I1dQpNdnXALXXj7dSaAbUnVb7glEHA==
X-Received: by 2002:a5d:47a1:0:b0:226:ebfc:f759 with SMTP id 1-20020a5d47a1000000b00226ebfcf759mr1265470wrb.636.1661941399465;
        Wed, 31 Aug 2022 03:23:19 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003a63a3b55c3sm1955370wmi.14.2022.08.31.03.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 03:23:18 -0700 (PDT)
Message-ID: <995875c3-5b04-5981-b0e1-f66f73cdfafc@gmail.com>
Date:   Wed, 31 Aug 2022 12:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831065100.27722-1-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1] arm64: dts: mediatek: Fix build warnings of mt8173
 vcodec nodes
In-Reply-To: <20220831065100.27722-1-tinghan.shen@mediatek.com>
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

Applied, thanks!

On 31/08/2022 08:51, Tinghan Shen wrote:
> Correct the phandle of power domain node referenced by vcodec nodes.
> 
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1450.35-1471.5: Warning (power_domains_property): /soc/vcodec@18002000: Missing property '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[0])
> arch/arm64/boot/dts/mediatek/mt8173.dtsi:1502.35-1522.5: Warning (power_domains_property): /soc/vcodec@19002000: Missing property '#power-domain-cells' in node /soc/syscon@10006000 or bad phandle (referred from power-domains[0])
> 
> Fixes: d3dfd4688574 ("arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-bindings")
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b4d48f8b7eeb..7640b5158ff9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1467,7 +1467,7 @@
>   			clock-names = "venc_sel";
>   			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
>   			assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> -			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
> +			power-domains = <&spm MT8173_POWER_DOMAIN_VENC>;
>   		};
>   
>   		jpegdec: jpegdec@18004000 {
> @@ -1518,7 +1518,7 @@
>   			assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
>   			assigned-clock-parents =
>   				 <&topckgen CLK_TOP_VCODECPLL_370P5>;
> -			power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
> +			power-domains = <&spm MT8173_POWER_DOMAIN_VENC_LT>;
>   		};
>   	};
>   };
