Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F024C84BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiCAHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCAHPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:15:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170160D8C;
        Mon, 28 Feb 2022 23:14:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so776731wms.4;
        Mon, 28 Feb 2022 23:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dMkVK0banCGS1SiaiD3Pe8NqYzc2z8K/wyEPw+N+YvU=;
        b=ib347cIt3ntK1P/QPyVbu2vUwQsRjZbNdUDSmPJeHxjB7RNf56VOiV6hjCN1rkVyrK
         p7ixJLG8+O4nB1pc5s322BKZjlpyAL4EBxERgZdxRLIqOhhPjRdbsGhn0dEx0HP85PJJ
         /1NFNhkVR3alsfWEMIZCE/wce81GRXXUpUuNb/pE442lUCTMQbLWPYW5vrXkfhhYHgy9
         1opLYjWvXCNiAuHObmpW0m7XBx/tHm5fmgPLzPYz1q8v9N6k+OxKTt3K4w2ErvakWro0
         uOHjAXwpLOeTWTxvrLcffHd3g1cXDrsH2Ztnixohp1uBM1dl8TMY07dQPMAO7MEV7/54
         Li6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dMkVK0banCGS1SiaiD3Pe8NqYzc2z8K/wyEPw+N+YvU=;
        b=gDD5BLbW1nYcaaEN9S31ALodYw+KG2aiXCHEQCz2L054F6y9USql130dy5zY0nH2ga
         zL+yQAIl73+m1QmO1iUbnG/y3+Sv/2ULU/5bhvwjR9mdrjF66IBk9pCs2snKBXskN9S6
         BoFqnepQuLbb/00B0tBeRtsmYSIxj224SQt6htKxWGY3ZKB/y4ptCcH7GXP8sgiEz6qD
         9v8c+fsMbVt5aJfewOFTOvCWqPBoVmz9n7wjcEgl5PxGOm0E6AMN0/nTkZ0seN45zEEb
         LIJkDUU4pJj5lKY75mnxiLqiFyULuLP8vYAqzvgwsSk2RuUFat+a4VL0jhEGO2hm7QTh
         PFlA==
X-Gm-Message-State: AOAM530/rfDNFAnvH2rVz2W9O29n4tEQtLvy0GaFbVnWz+LA08+CtvnB
        JVgfwucN2Ds57Uah438jWSkybcpc/NM7Vw==
X-Google-Smtp-Source: ABdhPJw86wvyFdv4N7Lgo+V4+RrPrPEo8SsZKzNeoYzKkuCc4Zz/khabOPClOAl/SG1YZ3AWJZW9+Q==
X-Received: by 2002:a1c:4b17:0:b0:380:e44f:426e with SMTP id y23-20020a1c4b17000000b00380e44f426emr15843929wma.150.1646118881620;
        Mon, 28 Feb 2022 23:14:41 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i12-20020adfe48c000000b001ef6eab4c81sm12113858wrm.96.2022.02.28.23.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:14:41 -0800 (PST)
Message-ID: <c5d61fe7-5238-58ae-c782-5e28531d9b2b@gmail.com>
Date:   Tue, 1 Mar 2022 08:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: Add compatibles for undocumented trivial
 syscons
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220228221537.1700071-1-robh@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220228221537.1700071-1-robh@kernel.org>
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

Hi Rob,

On 28/02/2022 23:15, Rob Herring wrote:
> 'intel,lgm-syscon', 'marvell,armada-3700-usb2-host-misc',
> 'mediatek,mt8135-pctl-a-syscfg', and 'mediatek,mt8135-pctl-b-syscfg' are
> all used in DT binding examples and/or dts files, but are not
> documented. Add them to syscon.yaml as they are all trivial cases.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index eeac1cbc5a17..29d4a97f7108 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -44,6 +44,10 @@ properties:
>                 - hisilicon,hi6220-sramctrl
>                 - hisilicon,pcie-sas-subctrl
>                 - hisilicon,peri-subctrl
> +              - intel,lgm-syscon
> +              - marvell,armada-3700-usb2-host-misc
> +              - mediatek,mt8135-pctl-a-syscfg
> +              - mediatek,mt8135-pctl-b-syscfg

Thanks for filling the gap. Would you mind to add as well:
"mediatek,mt2701-pctl-a-syscfg"
"mediatek,mt2712-pctl-a-syscfg"
"mediatek,mt7623-pctl-a-syscfg"
"mediatek,mt8173-pctl-a-syscfg

With that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>                 - microchip,sparx5-cpu-syscon
>                 - mstar,msc313-pmsleep
>                 - rockchip,px30-qos
