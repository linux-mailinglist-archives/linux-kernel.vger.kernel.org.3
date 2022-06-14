Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083D54BBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiFNUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243841AbiFNUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:25:00 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09929363;
        Tue, 14 Jun 2022 13:24:59 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id z11so7413602ilq.6;
        Tue, 14 Jun 2022 13:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Prhy9A37ks1LcK4a+DeU6wJg8EaLF2YElpfIpuhjq5k=;
        b=Q35vSe8QqyGhZ+XWZigsyHj0LHDWdQoKfBmt5DUKvShr1dv+1Vepa4EZm3jfAyL96B
         reAnPXOPiyyObHfZH+ZmySE6VH/dEbPqUEEGpJ3Nd6uUfV006HLaOYqMFtmDBUM5lv+8
         rWKFJkz7AhXJfkmwO2YQgKFjrzgaW2DPIRJ+X+jgrXyXXIXNypi2Fl8CWQvOU+qLoCvZ
         U5fwX3uEYy/bexu2L16JpMwC4wQZ4HbtW2rb+alKTXPQEknbLptxg8NXVVaCeVb0rxcH
         EVRzLGX58jqGjAAy06oJQwBpoEwgAC+gKw7gEgM6pqA/Snh+DPH5QO/TIbaLdvC0+fYo
         lMPQ==
X-Gm-Message-State: AJIora+/8HPwKDLccRx+Ik4ou8kot/8x2t2XQbGzvpo9/0uWNR79xHuQ
        REnCUJ3/ByDYRgDoWv7Hvg==
X-Google-Smtp-Source: AGRyM1vF7TJBKpD4DYZTQWlZ5S4iATGPfvcxpkyfqWopgl8NXoI8/XPuak8qVqPSqHwTLaejygTYLA==
X-Received: by 2002:a05:6e02:1b04:b0:2d1:af55:eb92 with SMTP id i4-20020a056e021b0400b002d1af55eb92mr3936723ilv.227.1655238298241;
        Tue, 14 Jun 2022 13:24:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w20-20020a029694000000b00331d98c9a7fsm5258030jai.40.2022.06.14.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:24:57 -0700 (PDT)
Received: (nullmailer pid 2419397 invoked by uid 1000);
        Tue, 14 Jun 2022 20:24:55 -0000
Date:   Tue, 14 Jun 2022 14:24:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v11 01/12] dt-bindings: mediatek,dpi: Add DP_INTF
 compatible
Message-ID: <20220614202455.GA2415891-robh@kernel.org>
References: <20220613064841.10481-1-rex-bc.chen@mediatek.com>
 <20220613064841.10481-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613064841.10481-2-rex-bc.chen@mediatek.com>
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

On Mon, Jun 13, 2022 at 02:48:30PM +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DP_INTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DP_INTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> In this patch, we also do these string replacement:
> - s/mediatek/MediaTek/ in title.
> - s/Mediatek/MediaTek/ in description.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index 77ee1b923991..ca1b48e78581 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -4,16 +4,16 @@
>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: mediatek DPI Controller Device Tree Bindings
> +title: MediaTek DPI and DP_INTF Controller
>  
>  maintainers:
>    - CK Hu <ck.hu@mediatek.com>
>    - Jitao shi <jitao.shi@mediatek.com>
>  
>  description: |
> -  The Mediatek DPI function block is a sink of the display subsystem and
> -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
> -  output bus.
> +  The MediaTek DPI and DP_INTF function blocks are a sink of the display
> +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
> +  parallel output bus.
>  
>  properties:
>    compatible:
> @@ -24,6 +24,7 @@ properties:
>        - mediatek,mt8183-dpi
>        - mediatek,mt8186-dpi
>        - mediatek,mt8192-dpi
> +      - mediatek,mt8195-dp_intf
>  
>    reg:
>      maxItems: 1
> @@ -36,12 +37,14 @@ properties:
>        - description: Pixel Clock
>        - description: Engine Clock
>        - description: DPI PLL
> +      - description: Clock gate for PLL
>  
>    clock-names:
>      items:
>        - const: pixel
>        - const: engine
>        - const: pll
> +      - const: pll_gate

You just added a new required clock for everyone.

>  
>    pinctrl-0: true
>    pinctrl-1: true
> @@ -55,7 +58,7 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/port
>      description:
>        Output port node. This port should be connected to the input port of an
> -      attached HDMI or LVDS encoder chip.
> +      attached HDMI, LVDS or DisplayPort encoder chip.
>  
>  required:
>    - compatible
> -- 
> 2.18.0
> 
> 
