Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAF5B1F39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiIHNcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiIHNcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:32:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44222F913B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:30:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so27769229lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ssphXCw9dVc4K1o06caOSpIrGhXG1PGN20aX3IK807o=;
        b=ck4sfwitUujJ4vxU9ZOv8HwJvjGvsMZ6KqMM5evDrri5Rht9kYsiegBuwDv4+9EDIf
         sjrTTy8Gxx3SQwy8ByST/AKQejNj1a9cAEZQMJ+OuTI9ffYAJspQo7EsHenHmbfiqJxp
         PEZpXP253o7D9JwQ0QVeyamH+8975QarrG1O9qxnYlX01CoXQMLyJAXjtGKtxP69JJ+h
         kjKArCDi/ob5rxLp/VO4NN8u6S1qY0VkMfXrMBwFqaeJosDzvFQOTvcY4IIoUr47HXLM
         DB55Olq9kSsyaqRMyHVoAq2kr3zBVhcFSj15d6Fm8od7qVplq7ZQnBF7R6EkZ5cBxBJA
         H/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ssphXCw9dVc4K1o06caOSpIrGhXG1PGN20aX3IK807o=;
        b=pxBLOuqsGJK30hACcnz5ksOmCtmhs4A7KhfKCNqSnaYVaukiGzyqZ0JIaNVrCqEuSY
         eOAjUbATd7mhiTy4kocqsGIibq6Xc5Gz0cMERTrbxEuJdwZCPwnJ1cw6ly1XhOedAk+k
         57S5TnQLv4IqyPGJZ0yn4RMD/6AmLd4F84v+OtYiYUw2P57VIQ7IvN8rRPlFJ4Hucr8A
         LAxqEbuJqT22hNRjLFZq1oOy6GhAHAiE7AKue0pDdxSH4eGtCvZJ4IMFWAV8VGtLtEse
         CM52bQv5tFUBS0pBGrTGnP25a3YXnnX1a52GhnjkhBv7y0t+bESHQKFZA3AfAxJ5HcHz
         Wo7w==
X-Gm-Message-State: ACgBeo0WQCRjW2Pz8QzhC4w6YeIFrFNqE1zMXWe8GfPHz+KjIZ28KQug
        vq6RYnq+2YMm5eWdLEofq5tePg==
X-Google-Smtp-Source: AA6agR4Cnrp8WVFsJsdGAqok1HmTtsifWI0ssMvOubIq728013GinG5Ar6anwjFrPPS71YUeXLYwHg==
X-Received: by 2002:a05:6512:3ba9:b0:497:ab81:dca5 with SMTP id g41-20020a0565123ba900b00497ab81dca5mr1972140lfv.129.1662643839504;
        Thu, 08 Sep 2022 06:30:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b00498f0434efdsm221661lfz.19.2022.09.08.06.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:30:39 -0700 (PDT)
Message-ID: <eff1c862-e3f4-d28b-fafa-c6053c48189c@linaro.org>
Date:   Thu, 8 Sep 2022 15:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To:     matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20220908132535.9350-1-matthias.bgg@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908132535.9350-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 15:25, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 
> ---
> 
>  .../bindings/iommu/mediatek,iommu.yaml        | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index fee0241b50988..621aca2adfb7f 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,7 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1

Keep here wide constraints - minItems:1, maxItems:5

> +    description: each bank has one dedicated interrupt


>  
>    clocks:
>      items:
> @@ -183,6 +183,19 @@ allOf:
>        required:
>          - mediatek,infracfg
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 5

and then minItems:5

> +      required:
> +        - interrupts

This seems unrelated and not really needed.

> +
>    - if: # The IOMMUs don't have larbs.
>        not:
>          properties:
> @@ -191,8 +204,12 @@ allOf:
>                const: mediatek,mt8195-iommu-infra
>  
>      then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
>        required:
>          - mediatek,larbs
> +        - interrupts

This seems unrelated and not really needed.

>  
>  additionalProperties: false
>  


Best regards,
Krzysztof
