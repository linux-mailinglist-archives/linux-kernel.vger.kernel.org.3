Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159F54BBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352353AbiFNUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358274AbiFNUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:23:40 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC542871D;
        Tue, 14 Jun 2022 13:23:39 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id e80so10620141iof.3;
        Tue, 14 Jun 2022 13:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yn1X9tsTyWKYB/yNHVHmt00Zq59Qs2y2qulf6vb+2UM=;
        b=noUaLdzPhPu2HBZB2d/4XGySkKILHQYG/gYFi4ekHvslGfFhF8Ga+JsOhnw5Ms5suJ
         ADsNhn44bKsqE4NVWwDjWu+SztdZALmDXoSFqfKjvG8+lOySE3ojfseJ2Nu64l+qAMmw
         P5q93s/93fWZnruNakq4P4jqMuNnv6wH5XhD3SYyEr0le0/2zIrw/l3m3TH+oEgFjn4V
         qQwN9wryGKfO2vF4uk14DEreQfZpAxwn4CSYIEfX3UiLsxYexUBZm296eVOHh7ev8OVC
         IoYohTHtLVh+IDIsI70OwOy7YDDGE+F8V3jTeP7F4DZ/rkg/sAdL1ajDVWmH41PXNi9t
         lyBw==
X-Gm-Message-State: AOAM530dGMvThCzwXQsVDCMPBBcj0cluj/3bgfRFkdbIerQvy8JWxUIQ
        zrT6/MMpxl3D0sA5DczUbQ==
X-Google-Smtp-Source: ABdhPJx9rerqWe1Bf7zW/nGD3+1oZxHbZiDkER+sQCEKjG2+KNxYREIe+A+7VgkMnLoB33NTi+7crg==
X-Received: by 2002:a05:6638:2711:b0:332:1030:d6c2 with SMTP id m17-20020a056638271100b003321030d6c2mr3817608jav.263.1655238218973;
        Tue, 14 Jun 2022 13:23:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r4-20020a92c504000000b002d54d827007sm5835499ilg.17.2022.06.14.13.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 13:23:38 -0700 (PDT)
Received: (nullmailer pid 2415510 invoked by uid 1000);
        Tue, 14 Jun 2022 20:23:36 -0000
Date:   Tue, 14 Jun 2022 14:23:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v11 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220614202336.GA2400714-robh@kernel.org>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
 <20220610105522.13449-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610105522.13449-2-rex-bc.chen@mediatek.com>
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

On Fri, Jun 10, 2022 at 06:55:13PM +0800, Bo-Chen Chen wrote:
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
> [Bo-Chen: Fix reviewers' comment]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> new file mode 100644
> index 000000000000..10f50a0dcf49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Display Port Controller
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  Device tree bindings for the MediaTek display port and
> +  embedded display port controller present on some MediaTek SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-dp-tx
> +      - mediatek,mt8195-edp-tx
> +
> +  reg:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description: efuse data for display port calibration
> +
> +  nvmem-cell-names:
> +    const: dp_calibration_data
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input endpoint of the controller, usually dp_intf
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output endpoint of the controller
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  max-lanes:
> +    maxItems: 1
> +    description: maximum number of lanes supported by the hardware.

We already have a 'data-lanes' property defined in 
'video-interfaces.yaml' that can serve this purpose.

> +
> +  max-linkrate:
> +    maxItems: 1
> +    description: maximum link rate supported by the hardware and unit is MHz.

Then use '-mhz' suffix on the property name. Then you don't need a type 
(or maxItems).
