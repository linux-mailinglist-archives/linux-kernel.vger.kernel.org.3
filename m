Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B454B459
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356407AbiFNPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFNPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:16:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE03E5EB;
        Tue, 14 Jun 2022 08:16:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so11699470wrm.13;
        Tue, 14 Jun 2022 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vhkIKfkGo8kjikdx6e7XD32K64ham8C6J5zyVmKGo9E=;
        b=mn9mH9dlcktjsbOMweXezuaZH6SedKsBiAp/sPrP+O/C4uzVoiTXk0Hp2qzmmYN8mH
         txJIAOk0oCR3M4iXvuNWj36oJ5TXwOXGhsvH3FLUorO0KJCZXKZZnwWPJYbZ4ESJmdf+
         S9WtMjEksOcMwWCn4jHjLhFrSaYEUPcJJYtLmzE22G2yT6MVn3QND8NEpCxaaCqm3Ba+
         gvFcCl7VOOzuOSf69Is+3ei0t5tbkfcY56+nNn/6GSoQ1xMsJVcD9FYC47Z8mjUp5kUg
         uQaJfFGtgXl9F1UOXFC7ht0yd3Euz9EUuj6jKHpk+ZOw4NXqoY1LWCjP56Rtws3Oujb5
         ClmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vhkIKfkGo8kjikdx6e7XD32K64ham8C6J5zyVmKGo9E=;
        b=u0fNKoXfFczEuA3RhkI+OkcXivVe7SUCnpvBvlOsKYtRSgQUwINm1h3AOwJl5OFz90
         nW61ZLYWbfAGgj8H3Mje2vanC/frH3YacW8qydd+QO1ijRg0bUEpX/ayivJCqp/05lmI
         6Uk+AGGELum9NvawluC1TNU+fKs7d5qSEkftqbMUTNId8FnJbT9RM7UEGTtFQLIPqh25
         ph+j3CQBHfluMKnpdMStwRY8Ds7cWgv8go7noDDxkDqJ/IOMhI+4uHsNyBpv8OX3GAZJ
         gUlxr7RoVoQcR2nJ5ByxwqL4s/Dng4c2C7xWOCs80T9Ficym2o555A+QK3XDTJfDNQ/4
         PdRg==
X-Gm-Message-State: AJIora/ZevrAbsGE7H1iSWu1Y/8UoJZm5xCjRJAcNnXWb0dPkDcAZuFo
        f9ifPjIwgs6L9c6ABQREqfnYpzS2h1XfZQ==
X-Google-Smtp-Source: AGRyM1sTU/BX79X8IM4FR68caCqL83NVFcemJZ7ybhRIwDuMBFF47IEvxKSKZvZKgUvjv9UhRysOaA==
X-Received: by 2002:adf:f584:0:b0:218:5a97:8f05 with SMTP id f4-20020adff584000000b002185a978f05mr5365598wro.333.1655219802133;
        Tue, 14 Jun 2022 08:16:42 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c024400b0039c811077d3sm13490956wmj.22.2022.06.14.08.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:16:41 -0700 (PDT)
Message-ID: <9a5afd0c-0c92-52c3-72d9-2c2f6c469e05@gmail.com>
Date:   Tue, 14 Jun 2022 17:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 5/6] dt-bindings: iommu: mediatek: Add mediatek,pericfg
 phandle
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220609100802.54513-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,pericfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT8195's infra IOMMU.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewd-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml  | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 4142a568b293..d5e3272a54e8 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -116,6 +116,10 @@ properties:
>         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>   
> +  mediatek,pericfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek pericfg syscon
> +
>     '#iommu-cells':
>       const: 1
>       description: |
> @@ -183,6 +187,16 @@ allOf:
>         required:
>           - mediatek,infracfg
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
> +
> +    then:
> +      required:
> +        - mediatek,pericfg
> +
>     - if: # The IOMMUs don't have larbs.
>         not:
>           properties:
