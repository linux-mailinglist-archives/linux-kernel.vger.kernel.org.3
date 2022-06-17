Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929754F551
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiFQKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQKYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:24:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2639814;
        Fri, 17 Jun 2022 03:24:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n185so2078588wmn.4;
        Fri, 17 Jun 2022 03:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=87NBtn3fIzpcWWtrcUYIvzoMaW95mCV5xGCLKQRGxCc=;
        b=Z1ubmAeXMXtINOBjiTE+TBu9JWUvjg5v9bBjTN1duRP5FrsHW7h4RltWMIuzRRcRLQ
         +sGFYgauppjoDbO0i1ub+MlOSPj5LXtafc+voS16rHLXpw7ApGdTOMyxDBslh7dXhnvg
         rBYY4e0KH1GBnw9OMJHmAr9XTEmLoqnKA6zadnaHh/EH27mejQqfHhW8iCyfaUpl3a4E
         xgHgZR/uYCCvgSjxMzYfFZxsIxw5m2dgV7Hpioq+ndyygjAGnwkK0Pla3faKJ9ZpLBvi
         gVtUJIAYD8FbF9UV3fq5+KWw1WBzA2qmjRC33JyjWeI7PuK+yoheH08GfoNj+sLYCdB6
         2W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=87NBtn3fIzpcWWtrcUYIvzoMaW95mCV5xGCLKQRGxCc=;
        b=shz/smCmz0/99WHsWiyogTTDnJ9s2Tw9cd+C7WZR6g8Kd5zr9OoXqp7Lz+uC6N0dKo
         x2lQCtI1CagO3WYmampG1PvmoEq/ly5IZKkeyIDe4kWhxk+FNCXNpQlOFwgbSlZwUr4h
         26T9P9FJzbmxexZUdJoF2o996K86TXx/ndbFHlP9un8lNUHygElz1xxmWtU5awSdHOAx
         joS6RU8+SBZaQsrwwis/s2r4ksHTGp3I/cgRBbqLa39hr3q6mTJpn5NkmVKD3sCKVjkw
         R8QDR7nksxgxWThqkzTyYX/A38x5dFaalJSPDeajRantaEqWnn4uwkrp1W5Bg3y5TsCN
         6/Yw==
X-Gm-Message-State: AJIora+P7vX4UCEhq5CAnCDVKMwwgddy3LWA4TEHPSst9XQaHzUZTbax
        annXiQeYYSgNZJSyiVwqEOk=
X-Google-Smtp-Source: AGRyM1tYRcM5+4zfrt0cnFtee2FUHZMlGXpNtJjRvwNJspxR68rEySJKJQgcK+qlSQnxTlMMu5r2uA==
X-Received: by 2002:a05:600c:1e09:b0:39c:5351:789a with SMTP id ay9-20020a05600c1e0900b0039c5351789amr9510011wmb.177.1655461447699;
        Fri, 17 Jun 2022 03:24:07 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b0039c5645c60fsm14751427wms.3.2022.06.17.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:24:06 -0700 (PDT)
Message-ID: <cca1882c-2ea7-34a3-ebed-9ea89d46f09d@gmail.com>
Date:   Fri, 17 Jun 2022 12:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/7] dt-bindings: display: mediatek: add bindings for
 MT8365 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220530201436.902505-1-fparent@baylibre.com>
 <20220530201436.902505-3-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220530201436.902505-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2022 22:14, Fabien Parent wrote:
> Add MT8365 binding documentation for all the display components that are
> compatible with the compatible string from other SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/display/mediatek/mediatek,aal.yaml |  1 +
>   .../display/mediatek/mediatek,ccorr.yaml        |  1 +
>   .../display/mediatek/mediatek,color.yaml        |  1 +
>   .../display/mediatek/mediatek,dither.yaml       |  1 +
>   .../bindings/display/mediatek/mediatek,dsi.yaml | 17 +++++++++++------
>   .../display/mediatek/mediatek,gamma.yaml        |  1 +
>   .../display/mediatek/mediatek,mutex.yaml        |  1 +
>   .../bindings/display/mediatek/mediatek,ovl.yaml |  1 +
>   .../display/mediatek/mediatek,rdma.yaml         |  1 +
>   9 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index d4d585485e7b..d47bc72f09c0 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -33,6 +33,7 @@ properties:
>                 - mediatek,mt8186-disp-aal
>                 - mediatek,mt8192-disp-aal
>                 - mediatek,mt8195-disp-aal
> +              - mediatek,mt8365-disp-aal
>             - const: mediatek,mt8183-disp-aal
>   
>     reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index 63fb02014a56..fc999e614718 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -32,6 +32,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-ccorr
> +              - mediatek,mt8365-disp-ccorr
>             - const: mediatek,mt8183-disp-ccorr
>   
>     reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index d2f89ee7996f..9d081da433e8 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -39,6 +39,7 @@ properties:
>                 - mediatek,mt8186-disp-color
>                 - mediatek,mt8192-disp-color
>                 - mediatek,mt8195-disp-color
> +              - mediatek,mt8365-disp-color
>             - const: mediatek,mt8173-disp-color
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> index 8ad8187c02d1..a7706cd65675 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> @@ -29,6 +29,7 @@ properties:
>                 - mediatek,mt8186-disp-dither
>                 - mediatek,mt8192-disp-dither
>                 - mediatek,mt8195-disp-dither
> +              - mediatek,mt8365-disp-dither
>             - const: mediatek,mt8183-disp-dither
>   
>     reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> index fa5bdf28668a..d17ea215960c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
> @@ -22,12 +22,17 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - mediatek,mt2701-dsi
> -      - mediatek,mt7623-dsi
> -      - mediatek,mt8167-dsi
> -      - mediatek,mt8173-dsi
> -      - mediatek,mt8183-dsi
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-dsi
> +          - mediatek,mt7623-dsi
> +          - mediatek,mt8167-dsi
> +          - mediatek,mt8173-dsi
> +          - mediatek,mt8183-dsi
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-dsi
> +          - const: mediatek,mt8183-dsi
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index a89ea0ea7542..f54859cfc97b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -30,6 +30,7 @@ properties:
>                 - mediatek,mt8186-disp-gamma
>                 - mediatek,mt8192-disp-gamma
>                 - mediatek,mt8195-disp-gamma
> +              - mediatek,mt8365-disp-gamma
>             - const: mediatek,mt8183-disp-gamma
>   
>     reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> index 3fdad71210b4..f4a12dfae77b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> @@ -32,6 +32,7 @@ properties:
>         - mediatek,mt8186-disp-mutex
>         - mediatek,mt8192-disp-mutex
>         - mediatek,mt8195-disp-mutex
> +      - mediatek,mt8365-disp-mutex
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> index a2a27d0ca038..20e4ca4fc915 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> @@ -41,6 +41,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8186-disp-ovl
> +              - mediatek,mt8365-disp-ovl
>             - const: mediatek,mt8192-disp-ovl
>   
>     reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> index 0882ae86e6c4..3bc914785976 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> @@ -40,6 +40,7 @@ properties:
>             - enum:
>                 - mediatek,mt8186-disp-rdma
>                 - mediatek,mt8192-disp-rdma
> +              - mediatek,mt8365-disp-rdma
>             - const: mediatek,mt8183-disp-rdma
>   
>     reg:
