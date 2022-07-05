Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F95678C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiGEUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGEUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:50:11 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD720BDC;
        Tue,  5 Jul 2022 13:49:05 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id m13so12342587ioj.0;
        Tue, 05 Jul 2022 13:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzARt3SUylprTdvbWfGQj5lJEtQuB8YwyDUa4X1Y/TQ=;
        b=YwzAylPYHe2q835HmyhBdJA4eZ5VAi3duzajM32bPJ0/iJztJ6uRnFEduxLMhR1ZHq
         nbu+5W6hcuZAG2oZPj3G/Wq6cCzBDgJ9xBsnt9oZi1QCKsfgR2UvhA4z54lC6YucKn7L
         sYVw2TBmEImfnZh6c7UM173HjTDUY6oBokUAWKRfF2rJ+CF71K1aWpnZmTEZuEHgwesz
         ONsZGYBP/aXc06MWbs9BL5U5UGWbnjvD1SyKKes7LvOSqfCDB9eA64XlR7gwqMnKdXu0
         4DqGVglizdnBtzOuM42gS8tYJf/y4zygPlPp2E1Spx7W/NopQuaNhZ4nqrYZSDTco53T
         hxFg==
X-Gm-Message-State: AJIora8b2Yx/JTlS0GCbz7JCpMyJa1zpqcLLHTNl6nf6+Q6DG547mvww
        8kAi2q8dc2Zv9OJ1RCPzVA==
X-Google-Smtp-Source: AGRyM1t3Q/lWtfZuyq003ElF5s7OUqIiDA2Wq5dxaxnoKjRtLzsbmHFJ7CK7VeOkWtDkrsMgCyJuvQ==
X-Received: by 2002:a6b:f718:0:b0:675:54cb:dda with SMTP id k24-20020a6bf718000000b0067554cb0ddamr20639324iog.114.1657054144601;
        Tue, 05 Jul 2022 13:49:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a9-20020a92c709000000b002dc133c9468sm2578869ilp.6.2022.07.05.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:49:04 -0700 (PDT)
Received: (nullmailer pid 2598242 invoked by uid 1000);
        Tue, 05 Jul 2022 20:49:02 -0000
Date:   Tue, 5 Jul 2022 14:49:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 01/16] dt-bindings: iommu: mediatek: Increase max
 interrupt number
Message-ID: <20220705204902.GA2596733-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704100028.19932-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 06:00:13PM +0800, Tinghan Shen wrote:
> mt8195 infra iommu has max 5 interrupts.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..27eb9f6aa3ce 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,8 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    clocks:
>      items:
> @@ -175,9 +176,18 @@ allOf:
>                const: mediatek,mt8195-iommu-infra
>  
>      then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>        required:
>          - mediatek,larbs
>  
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 5

5 is already the max.

minItems: 5

