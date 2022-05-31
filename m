Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5353901A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbiEaLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbiEaLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:53:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07F35245
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:53:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f9so26186523ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aZv3mvyH3YwBv75DPbWyCn0ZYruAzdYgAgL6PD0leyM=;
        b=sEekkrr6ZDYJGypMUv4kxJnQIqV1gbcVTncftHFHezDhnkayrx1pwsyyCBA2tRbn0G
         luiuIlu72eZpdya+jg76kOE6AKlZG6/Lp21I5f0mB37j8D8kCv0KxXK5e6dIO8CcVmW8
         5DWYe0a/H5TsRqYT0IkCMYboOQm45AxJWEEzg2JI4t5WpuBu1EQA4G0nFkSfWY3QgIxn
         ttzMqDrP+OnyWebrjqooAUNkydJi1CMpvuI/cqKrnLMx4DwR/3A6O3waKyv8OXCUVSA9
         AWExUukGBEWn3pbRssql9oNEc8iA876VKtN7zmtQ2W2SWb2aOckkwKo5DZX0/kT3p2n2
         AMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aZv3mvyH3YwBv75DPbWyCn0ZYruAzdYgAgL6PD0leyM=;
        b=2esoU7mn05GM5tmauqj0wAxIy/z6zHbGPPMmmtpMk1NrsoMAEWkzr1zFkQMimdiA3K
         BdPsafHglnlb7FBKB98y6axUQW+1KS7qnGqK0xRVESOjSI/RhuJyuXe6RSednF8qq2LK
         OnaLfyRRBsAMUU6EksTAWSD0e50VYc41zYeE+QFKPiNLr4dYTskxLx2byRHHyy84KI+Y
         NNQr91UFOL1H5jWqvtq1wzMp9frAN/QTzAZ4+LZozbfFcW6YgwQxeH4wGcbe0iD03igF
         yB5RwalOjYvK9gei2RVXLpEthSb1FfQHuDJIcuasgFrMI7EipyohWFPDYqx0Evhh4BWs
         uygg==
X-Gm-Message-State: AOAM532j4prT9uxjhtNImQjBF79YhVguDO3XBMKCUWA/vHWRNeAn03Lv
        IRFnv0VE6AU7UqcpaWAGvEflBg==
X-Google-Smtp-Source: ABdhPJymW8FmeTjxdKGYmtGd9rjreWcOisc6PcJr915f/Hv4wEXVceV9u1qf7rs6m1f5pLD06Pogkw==
X-Received: by 2002:a17:907:2cc4:b0:6fe:2100:de21 with SMTP id hg4-20020a1709072cc400b006fe2100de21mr52520891ejc.462.1653998022758;
        Tue, 31 May 2022 04:53:42 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l27-20020a50d6db000000b0042dc25fdf5bsm5320894edj.29.2022.05.31.04.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 04:53:42 -0700 (PDT)
Message-ID: <ce04b6b1-1082-0da6-1852-9819459ccfb7@linaro.org>
Date:   Tue, 31 May 2022 13:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/7] dt-bindings: display: mediatek: dpi: add binding for
 MT8365
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, matthias.bgg@gmail.com,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220530201436.902505-1-fparent@baylibre.com>
 <20220530201436.902505-2-fparent@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530201436.902505-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 22:14, Fabien Parent wrote:
> DPI for MT8365 is compatible with MT8192 but requires an additional
> clock. Modify the documentation to requires this clock only on MT8365 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../display/mediatek/mediatek,dpi.yaml        | 44 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index caf4c88708f4..c9c9f4d5ebe7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -17,13 +17,18 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt2701-dpi
> -      - mediatek,mt7623-dpi
> -      - mediatek,mt8173-dpi
> -      - mediatek,mt8183-dpi
> -      - mediatek,mt8186-dpi
> -      - mediatek,mt8192-dpi
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-dpi
> +          - mediatek,mt7623-dpi
> +          - mediatek,mt8173-dpi
> +          - mediatek,mt8183-dpi
> +          - mediatek,mt8186-dpi
> +          - mediatek,mt8192-dpi
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-dpi
> +          - const: mediatek,mt8192-dpi
>  
>    reg:
>      maxItems: 1
> @@ -32,16 +37,20 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: Pixel Clock
>        - description: Engine Clock
>        - description: DPI PLL
> +      - description: DPI Clock
>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: pixel
>        - const: engine
>        - const: pll
> +      - const: dpi
>  
>    pinctrl-0: true
>    pinctrl-1: true
> @@ -71,6 +80,27 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-dpi
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4

These should be minItems instead.

> +
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          maxItems: 3
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>


Best regards,
Krzysztof
