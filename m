Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537F952B8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiERL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiERL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:29:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10791756A6;
        Wed, 18 May 2022 04:29:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso3038297wma.0;
        Wed, 18 May 2022 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uFIsWxhH+SfWDbQeGJib3EffwTOsdWgNhmP3BKg6cTI=;
        b=GIk1v/SP46GpQB2aa29XniHa4XWAzmRQTBwJvI2ojRUnPlE+MqZBO6G6nMAupnb8W+
         G2EA2unw0FCDCoBzqtVzORAZzUFAFXx+Kdr8mqijkt1cl3qR20Nu7ks1Ou4EEIyvLfG1
         BKNUqHtpdNg9JkHJn34prfdFRVXewGK/0aMoRwE31kjLG9CzM4rhFuUz60WAX4Xx4Qtf
         Iw5hAdG4s9z4F6oM41gnCOxtwot5uL5itCKcTOqR+V3kIeqKyCtmTTLGt5h7TbNeBK4l
         1nRGHnUOJvvntrUCPXJu1pJXgzrO3r0Q2kDfNl8uDHZhwRBCu9LgjhUgB/igxBzXk6Dk
         Y+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uFIsWxhH+SfWDbQeGJib3EffwTOsdWgNhmP3BKg6cTI=;
        b=r7bMVYTEcFIWdWVVfFZRIV76V3Siu6yEXzNA5WQfwP1qDmgGo0yKscAtuKwkJIqZ2O
         mRHaDQt7KD2DwZYe4VKetQsKMoYAGodAucOfxWFJFM63r+zTWhbLJmODa3AtVzbw1/HV
         XspZkk82RLOpA7a90B+cn0UczBia06LYlb+1PA7Jv1KelUGbCMck5bLEU3wnYs/X67wK
         dW9p+RhHBQaMTuNwfXY4yNPTApEILYeWd0uo3jGN3Yv0t6FU1w+O2MnpNxiTFK87lIRc
         rkNIY+8S2Kv1xi5S55pGoEpNkX22WmRvKXHXzFC7DgNViVjfUa2r1MzqWRnbDa5MTJg9
         eMTQ==
X-Gm-Message-State: AOAM530yHaFDBoZ/LSudWjyZA1r8Q6BhuhrcyoAT+GF6OchwCYe2XikF
        WM0P0DvGwhjbhx+N9jI1WJs=
X-Google-Smtp-Source: ABdhPJwmMEJmW+CILoBoRlmxrlpjiQs7Ka6eyFZQusCiGX6OE9WPle9wfc8RX8mJ6nniBuuCC/UxRQ==
X-Received: by 2002:a05:600c:3549:b0:394:89ba:e1be with SMTP id i9-20020a05600c354900b0039489bae1bemr25309861wmq.181.1652873364178;
        Wed, 18 May 2022 04:29:24 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
        by smtp.gmail.com with ESMTPSA id v65-20020a1cac44000000b003947b59dfdesm5121659wme.36.2022.05.18.04.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 04:29:23 -0700 (PDT)
Message-ID: <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
Date:   Wed, 18 May 2022 13:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2022 12:04, AngeloGioacchino Del Regno wrote:
> Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
> mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
> instead of performing a per-soc compatible lookup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..c4af41947593 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -101,6 +101,10 @@ properties:
>       items:
>         - const: bclk
>   
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek infracfg syscon
> +
>     mediatek,larbs:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       minItems: 1
> @@ -112,6 +116,10 @@ properties:
>         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>   
> +  mediatek,pericfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek pericfg syscon
> +

I didn't explain myself. What I was suguesting was to squash the patch that add 
requiered mediatek,infracfg with the patch that adds mediatk,infracfg to the 
binding description. And then squash the both patches adding pericfg as well.

Regards,
Matthias


>     '#iommu-cells':
>       const: 1
>       description: |
