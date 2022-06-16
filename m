Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0854E13C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376718AbiFPM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376367AbiFPM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:58:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521E13DF4;
        Thu, 16 Jun 2022 05:57:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so828142wms.3;
        Thu, 16 Jun 2022 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gy0oFAby9fgPJK22xRJJtXNYPWrTCXwW8x6uK6X5dvU=;
        b=Z7w8dNVB6+HrIK1AfeHcndhIn6ZaWZVjaZIxWOsOukdpjyAuA9v5MRUoVszMrQBn3J
         OmEcavKPfNs572/UH5gmdKM7J3jRilp9xyNozanCQxRuPPAHSx18eI8pYMArV407v1zj
         ooLDM0oB0I+fjkcaMrNQZMsuuEmVZHOA89GLn8XQCQZPc5kCtcYe8LI/cYv7QVn7PPK0
         bBwexju2unXFq1uFUGN5CPtTg29DK4hfbDtw2leG52kDHQiU4m8uyyrpWyt7BxLV32vi
         kox7/OnNMP54x3gfxbTCLsOXe8nE6ebCUd2U82Z2pSCrj5cs18rIZzPc3yFkjojHXfaq
         nm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gy0oFAby9fgPJK22xRJJtXNYPWrTCXwW8x6uK6X5dvU=;
        b=B3CRkaCJFNW7g65tKm6P3tBIPDsEstjr6Fx3RaPgugVvhtgblhO/Oxaxk0BxSCW/YM
         UIgCDs2QVw0o3O5kn4Z193cEujqmbCVoi1AeqSx0fjJeQ4tPLSSqeme5o9T6XJANufWL
         y+um7KfvG4e3u2i7UerVdL5riqIT+UH0Hoa6ohE6iIu7LzfZBKV1x083fleqCp/902Cx
         A6aXg2V8zm/Bjxsjux7JALHUS4HrM0gOJOoofyFhtLyc6v0LneCEcGjmLkrXx6pUtUcf
         wQCIUnyVGwcSzA6X121TSxUay2Sb3fKkTBMTsXxmb//qAPBy8PlPY503jkwhLSW0NsO+
         LQEQ==
X-Gm-Message-State: AJIora+VHCr8Jg8wkKUJafSIhTM/HKY0gDjdt/r4oixY/LNNTGKYUoA7
        MHDDoyjMBcOHl+lgmOSzKiI=
X-Google-Smtp-Source: AGRyM1vD+Ab3nz7tP2nVuzPb0dsUZnxwwUULdQcZmibPpfHs7wyej1w4JmMQtgxPcmsGhtrQP3nYMw==
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id o16-20020a05600c379000b0039c62b9b164mr4925109wmr.0.1655384277780;
        Thu, 16 Jun 2022 05:57:57 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4107000000b0020fffbc122asm2161091wrp.99.2022.06.16.05.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 05:57:56 -0700 (PDT)
Message-ID: <d99deddb-c4a9-d5a1-d0a6-0e7f94fbdd9a@gmail.com>
Date:   Thu, 16 Jun 2022 14:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] dt-bindings: iommu: mediatek: Add
 mediatek,infracfg phandle
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <20220616110830.26037-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616110830.26037-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/2022 13:08, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT2712 and MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/iommu/mediatek,iommu.yaml          | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..fee0241b5098 100644
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
> @@ -167,6 +171,18 @@ allOf:
>         required:
>           - power-domains
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2712-m4u
> +              - mediatek,mt8173-m4u
> +
> +    then:
> +      required:
> +        - mediatek,infracfg
> +
>     - if: # The IOMMUs don't have larbs.
>         not:
>           properties:
> @@ -191,6 +207,7 @@ examples:
>               interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
>               clocks = <&infracfg CLK_INFRA_M4U>;
>               clock-names = "bclk";
> +            mediatek,infracfg = <&infracfg>;
>               mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
>                                <&larb3>, <&larb4>, <&larb5>;
>               #iommu-cells = <1>;
