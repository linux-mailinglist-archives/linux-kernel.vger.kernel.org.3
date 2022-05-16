Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532C528351
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiEPLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEPLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:32:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D138D8B;
        Mon, 16 May 2022 04:32:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso793881wmp.0;
        Mon, 16 May 2022 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=caeR1d5UF/OVvqIoQomSco97tJ43m4mKPZrJZyYHxJw=;
        b=J9z9Eo4Uws1wL5DN7Apv1Nidg+AkLal3CFdoeL6/CmNOcfT+UuLdAwwacmvG72zOjp
         AJfH7g3i4BHKEG3vxH0OCHDxdgDOWHtmgZoSfTjRvEhAPgwsfzY0PgDT0uDPZ2QzGsSb
         K8e21Vw3Q/4L5V2DDzqveSFoIMTm4O8Z1Eg0AQxycGm9+FcRUhjuQvLyLzZLYXpZ8c+U
         nxHnJEoTyKSxHH6VU5jLYXW8Wi5vz+8KgiL1r73b+mqpC6r6bX72GL53a/Zhjf8iroFY
         FgUN9zRwN0Jo/Z88OXmjABQ34oU6ncA478+oJ1k1OXf0rZ3NbiEdheSVwWLMaHekGxx9
         PJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=caeR1d5UF/OVvqIoQomSco97tJ43m4mKPZrJZyYHxJw=;
        b=XHcaxlv3YOf59u8YzLiGiCLkNsPGCTkkmBFittSgZbeFnBgcUiTcl+O5BxAwPl3tFp
         r23kfXFYAyF7dIxL68zO5VREG6OH+T5UcPo+/9z1okER/FUvaRgx30SRxHsibKkE9ZvI
         /rUyvNKmqcFk9s1P2lqXWTA97BFN+feMWIN41NMe0edho8jrzkOYuP7cKBFLQFgnTrqE
         pz50LCaVC/B8uHwWbD0CKcNdScWuz1CqAbT2Qz0tJbBfb8rLo67W0sC1yZPQttMTR7zm
         gpJ75RqafQzSaxkhHNfMRTJQPJQBVR2UOhCGzvZBBZoNlJDXLxlSd9Ok5xgr+kkQ/75A
         sq9A==
X-Gm-Message-State: AOAM532yCUiiCLGME1oQZiY5Rsxzjbnzvf4fGPJpk/2p5jTfw0xjmO6A
        UZ1h7qFZatmKdn9oYIVqGIo=
X-Google-Smtp-Source: ABdhPJz3pErEXVh6c5jSOm5lb9urUb/kznpC3Pzf2jcgE4pcvIh1nDHvdVZVd+IKCii501ptpAeCxw==
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id f13-20020a05600c154d00b003948d649166mr16485448wmg.102.1652700768735;
        Mon, 16 May 2022 04:32:48 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n12-20020adf8b0c000000b0020cdf6ecafbsm11529943wra.81.2022.05.16.04.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 04:32:48 -0700 (PDT)
Message-ID: <d602eb96-587d-5b1d-17af-2af83acde709@gmail.com>
Date:   Mon, 16 May 2022 13:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: mtk-smi: Add MT6795 Helio X10
 bindings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
 <20220513150633.387200-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220513150633.387200-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2022 17:06, AngeloGioacchino Del Regno wrote:
> Add SMI bindings for the MediaTek Helio X10 (MT6795) SoC
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/memory-controllers/mediatek,smi-common.yaml         | 1 +
>   .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a98b359bf909..71bc5cefb49c 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -32,6 +32,7 @@ properties:
>             - mediatek,mt2701-smi-common
>             - mediatek,mt2712-smi-common
>             - mediatek,mt6779-smi-common
> +          - mediatek,mt6795-smi-common
>             - mediatek,mt8167-smi-common
>             - mediatek,mt8173-smi-common
>             - mediatek,mt8183-smi-common
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index c886681f62a7..59dcd163668f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -20,6 +20,7 @@ properties:
>             - mediatek,mt2701-smi-larb
>             - mediatek,mt2712-smi-larb
>             - mediatek,mt6779-smi-larb
> +          - mediatek,mt6795-smi-larb
>             - mediatek,mt8167-smi-larb
>             - mediatek,mt8173-smi-larb
>             - mediatek,mt8183-smi-larb
