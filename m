Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF131504F96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiDRLwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiDRLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:52:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD31929E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:49:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c64so17153372edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Su46te7HNW++2zKgguxu+adMxrQIv2yQPrMKfptRGag=;
        b=Wow3Xq7cPhtHQfiCZO1z4xGsOQSgEraNXhtcAJR+p9ahYFh+UIfpwJjb9ewnX9N810
         rceUBq35zYdLxYRlbvVGzDAVGaBNZqCA7bMp1VlUs9QZ6WUuiqIgGTvoR8eEb5tutur7
         vpdfCjxVi4d6+oN10r4XW/BXHm619ZVAhb2OKaqFhHpDItUc7jJ/87xRjWkMwd3JCg3K
         +peY2iRIUzoCyGLAc4DXiMeFiV44Xqo1KgQLqu2oa60LUldbHs2aROrHQpSdhm+ChGa4
         ags2SP48yGsoglA5lbFxWFP+fqvxKXSxTlkAeJlp0Ipoc7eL32wrkSjftiXeUXauetrB
         NuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Su46te7HNW++2zKgguxu+adMxrQIv2yQPrMKfptRGag=;
        b=TCfUYSorCYbddDmMvmuCTF+Ynf0YTNISIpbtExiQ36RZeL3iwXca0frzwTQRMTWm63
         PippbdUg4h2F1X58jOGB/1/zxXbhb9ym6ouRz1c6rXEzlX4h9lxDNOCAF2BCEbgYR9Ur
         Gt+d8xdaqfauNtMP661ANkjYPySp6h9wseO6qG/MyL9cfn19k/Kgpl5zqf8mU7iDXD+t
         EEz6qp/BbS3RZqiL1/hpVz1OXkh2jZ7ugUbkiq3Z0JFkPImGFCBM2BtA+I1Cjy6mzTM2
         Ib9lNCmIOR9/sd/X/C89mikdWcTWus8GATXfCoFhaU/JczZ0Yl0uYadQ44b5xv0z2m6D
         3/wA==
X-Gm-Message-State: AOAM533eKYheeMJNtrMeNculOTF7pdoR1h3gbS0rwwJZG1ZHDrQOwxeb
        C9FVHDP5a2ivxZ3I4LA3D/ZcZd4td9CuYw==
X-Google-Smtp-Source: ABdhPJyjLcgXf19Bziy6YywbbTjReCFm8EmqOP+nJT4RSe4RjCjRYH99uE2rINOfOjdDhXQpbYrSpA==
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id w9-20020a056402268900b0042215c4e17emr11945878edd.33.1650282567594;
        Mon, 18 Apr 2022 04:49:27 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709067c0400b006ef810aab6fsm2338044ejo.213.2022.04.18.04.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 04:49:27 -0700 (PDT)
Message-ID: <fb275639-096e-78c2-3cbb-1bb10f4bbb08@linaro.org>
Date:   Mon, 18 Apr 2022 13:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: ufs: mediatek,ufs: add compatible for
 MT8195 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220415165939.1861470-1-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220415165939.1861470-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 18:59, Fabien Parent wrote:
> Add bindings for the MT8195 UFS support.
> 
> The MT8195 SoC requires more clocks to be enabled compared to MT8183 and
> MT8192. Document the clocks required for MT8195.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml | 27 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> index 32fd535a514a..5ed36e95e933 100644
> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> @@ -14,16 +14,31 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt8183-ufshci
> -      - mediatek,mt8192-ufshci
> +    oneOf:
> +      - enum:
> +          - mediatek,mt8183-ufshci
> +          - mediatek,mt8192-ufshci
> +      - items:
> +          - const: mediatek,mt8195-ufshci
> +          - const: mediatek,mt8183-ufshci

Are you sure that these devices are compatible? Amount of clock
differences suggests that not (or original bindings were not complete).

>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 8
>  
>    clock-names:
> -    items:
> -      - const: ufs
> +    oneOf:
> +      - items:
> +          - const: ufs
> +      - items:
> +          - const: ufs
> +          - const: ufs_aes
> +          - const: ufs_tick
> +          - const: unipro_sysclk
> +          - const: unipro_tick
> +          - const: unipro_mp_bclk
> +          - const: ufs_tx_symbol
> +          - const: ufs_mem_sub

Add allOf:if:then: which specifies these clocks per different compatible.

Best regards,
Krzysztof
