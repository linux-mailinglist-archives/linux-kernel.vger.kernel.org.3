Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C764EAB86
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiC2Koe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiC2Ko1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:44:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AAECDAD;
        Tue, 29 Mar 2022 03:42:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p189so10012491wmp.3;
        Tue, 29 Mar 2022 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f3iBbK5fy2drNJnHSVd6h7L8RLpAs5pbHayacM7gQx0=;
        b=Nt78WXBKY+MY3+gr7xrFbMs04A5JgW4P5Hmd599UBhQBR7XU0sztciOhTjgTLJoBZx
         5/YqXihN7sBYpKymfVax90fPW3K+7HOUrmshJEaPR5X48tPrU6usCZLMe2yYujwCvtsw
         p6YScdT6Eq5nn0msocyNsxo2JWuqJFXPmx54pAaJWbo/ATPgSvuOnFaohfvW5FktMgXd
         5GUdSZx7vH2paIueNF6BeyOLtb98kzSiiKiGC0qu//dXk9j4KoZqsAjmb1d5T2QOeCyP
         BXKGIamIzxi0ScmxTfurAE4jsL7PZtE0ICPQGtYfA4Ov8cnT/BRcHPcrFJU4OM+b9/wG
         0pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f3iBbK5fy2drNJnHSVd6h7L8RLpAs5pbHayacM7gQx0=;
        b=CibbA0nNPhtL5cBHYG30HRoNsP7oPWBM07cZ3xWbrk5fZGvYozWLKf1d8Gu5bUvsjg
         34qO2MhP+T0inBmc2u+xFBNPQOM/toMjRu19bl6/h1uUdwgNf9GX+4t4M/QMyBFJmmXA
         Z+MyHY3EzzsMld7GZvdZCAPPsjzxJztazYQoaxKZBHl/8EUZbmqbZ/t3V0uSyKNBdydJ
         REQEmRQB6IglwpnN/q/BVD3oOe6VU+nyI3L/IfA+WbZl+PVx0Dod7vYE/txCvs1LPfr/
         5UoNSmsHi63Pe7//XDtPnckurAiTX8A+JEB4zjBqQr92pc/FUid+91ib4V9fNy/BgRLo
         +viQ==
X-Gm-Message-State: AOAM531x8eTXWiNwjGWqQBOwR/u/hCcEbMKSU1TLJMnSo74sFaYVv+Mw
        hZxIt8U1FLhjHRiRoogvRHE=
X-Google-Smtp-Source: ABdhPJwB/NXK19sx39DAWQg5uHNzUaed7dLgj4bbX1z3ETXRa6KA+QTBRYPZmGbtTluMMiRRs7y9PA==
X-Received: by 2002:a05:600c:3d86:b0:38d:581:89ad with SMTP id bi6-20020a05600c3d8600b0038d058189admr5993185wmb.42.1648550562084;
        Tue, 29 Mar 2022 03:42:42 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm2099039wmq.17.2022.03.29.03.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 03:42:41 -0700 (PDT)
Message-ID: <dc80d7f7-7a7b-62fb-fbd6-346dba9fdac5@gmail.com>
Date:   Tue, 29 Mar 2022 12:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 01/22] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, airlied@linux.ie,
        angelogioacchino.delregno@collabora.com, chunfeng.yun@mediatek.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        deller@gmx.de, jitao.shi@mediatek.com, kishon@ti.com,
        krzk+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>
References: <20220327223927.20848-1-granquet@baylibre.com>
 <20220327223927.20848-2-granquet@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220327223927.20848-2-granquet@baylibre.com>
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



On 28/03/2022 00:39, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DP_INTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DP_INTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index dd2896a40ff0..2dba80ad3b18 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -4,16 +4,16 @@
>   $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: mediatek DPI Controller Device Tree Bindings
> +title: mediatek DPI/DP_INTF Controller
>   
>   maintainers:
>     - CK Hu <ck.hu@mediatek.com>
>     - Jitao shi <jitao.shi@mediatek.com>
>   
>   description: |
> -  The Mediatek DPI function block is a sink of the display subsystem and
> -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
> -  output bus.
> +  The Mediatek DPI and DP_INTF function blocks are a sink of the display
> +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
> +  parallel output bus.
>   
>   properties:
>     compatible:
> @@ -23,6 +23,7 @@ properties:
>         - mediatek,mt8173-dpi
>         - mediatek,mt8183-dpi
>         - mediatek,mt8192-dpi
> +      - mediatek,mt8195-dpintf
>   
>     reg:
>       maxItems: 1
> @@ -54,7 +55,7 @@ properties:
>       $ref: /schemas/graph.yaml#/properties/port
>       description:
>         Output port node. This port should be connected to the input port of an
> -      attached HDMI or LVDS encoder chip.
> +      attached HDMI, LVDS or DisplayPort encoder chip.
>   
>   required:
>     - compatible
