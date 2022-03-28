Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517E4E9C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbiC1QfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiC1QfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:35:00 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BA7648;
        Mon, 28 Mar 2022 09:33:18 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id e189so16151635oia.8;
        Mon, 28 Mar 2022 09:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIvjLAN1WghVKdHbiAwbpiS4KUlO9J5lK2uou4RVILk=;
        b=4BuMH9UC17PguaV7KVJJqo4LZHm4VxTwZQ3azrARHcBzitgGWODEb3IuIXHryl09Q1
         PHaRtwISpRuw28cShPTwqWLLFh7u7Kf6lp2nRJXrKXQ9SrzTt2xkRC+LC8RWE8/3Q78k
         yYSACNPIxAk3HmJwe6x295vWxb02lfeMTeshxV2f1pQWc+zy3AdgzfFKKPb3nB+C54Wl
         1OVH3WCZxz2Wv3rntn6tQvi5d9beZDsDnPQ64uXi1D0e45vNcfYi3Sty1Imrp4cBRshp
         hpde1HBbm95O1T56LfCUAWRpyYjJgvNlOAZm7M0o4E5JfQeXpVLrRIYZ9i1diSYMl0VU
         39nQ==
X-Gm-Message-State: AOAM533GjdNXKY4KDptnJoLLywK33KVjrlY8NuTPLNeK75esrMK0Eeu7
        ejVBq6tWoln0o2EjEQtjDg==
X-Google-Smtp-Source: ABdhPJwNVh5RZ1sp9MXlR5GlreRlGRTmHJKVh03oTfj9pol2juq4vLORJb84KwOjAAWD3ibi6+xCCg==
X-Received: by 2002:a05:6808:1059:b0:2ed:b699:7f2e with SMTP id c25-20020a056808105900b002edb6997f2emr909oih.240.1648485197630;
        Mon, 28 Mar 2022 09:33:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t15-20020a056808158f00b002e331356c87sm7218218oiw.39.2022.03.28.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:33:16 -0700 (PDT)
Received: (nullmailer pid 2515489 invoked by uid 1000);
        Mon, 28 Mar 2022 16:33:15 -0000
Date:   Mon, 28 Mar 2022 11:33:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, tzimmermann@suse.de,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v9 02/22] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <YkHjS9ToXqyliItf@robh.at.kernel.org>
References: <20220327223927.20848-1-granquet@baylibre.com>
 <20220327223927.20848-3-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327223927.20848-3-granquet@baylibre.com>
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

On Mon, Mar 28, 2022 at 12:39:07AM +0200, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> new file mode 100644
> index 000000000000..802cc406c72b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Display Port Controller
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  Device tree bindings for the Mediatek (embedded) Display Port controller
> +  present on some Mediatek SoCs.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-dp-tx
> +      - const: syscon

Add something to the above description to convince me this is a syscon. 

If you need a regmap, the driver can create one. 'syscon' is really only 
needed if there's not a specific driver.

Rob
