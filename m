Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7637563AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiGAU3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGAU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:29:18 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D535A81;
        Fri,  1 Jul 2022 13:29:17 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id a16so2096763ilr.6;
        Fri, 01 Jul 2022 13:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uo+ZyI55hAfSIWqq6L8CrLiVvmJn3xH9wA2nHRVPzqs=;
        b=TSONNoI0HLytRZvHm7gAUoF86+bSDHbQ9yEXwUQpi/l/B4q5AEjqWyRQDWBoKixReL
         c3XD1378LrPUkiYXMhnYAU11oGW5Hn44pSi/vfkgVX0k6Oac4aawbmmICIxoqHqTi88i
         sruGWrjCWAqzbwz1kZTKeIvPnvbKK3I8kMjr+sQcQdp7HCsqJETTUtGrXccE6+Q6vi3p
         ao+VM81pG98VdhbiTY3LUhUplgBDexdIzso+KZX1ZpN13Hou6UZWWTXtgIz+MKMbIqAz
         i8sP/vNQIWbeNSGwuizVv8H7/KQ4pVlsvcCVzaNzumLVVv8/fzpRvoOZU2qKq65KpRBe
         2LXQ==
X-Gm-Message-State: AJIora+wH5zCBqM5MK5/0RR0MOCyMf96IIJyDZmNeibYIxrQ2ae7gB2T
        SlpnqZJ6etj8ZldoBt7IMA==
X-Google-Smtp-Source: AGRyM1tZiGuUdsxhrqYhUe40OKpKjKLHpucAiduiag1kEaPCFa4zBB7r9DaKoLV8cPTwKhI5n7GFIA==
X-Received: by 2002:a92:b10e:0:b0:2d8:d8a7:8b29 with SMTP id t14-20020a92b10e000000b002d8d8a78b29mr9510641ilh.233.1656707357164;
        Fri, 01 Jul 2022 13:29:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b00331cfbce17csm10280153jae.100.2022.07.01.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:29:16 -0700 (PDT)
Received: (nullmailer pid 1469333 invoked by uid 1000);
        Fri, 01 Jul 2022 20:29:14 -0000
Date:   Fri, 1 Jul 2022 14:29:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        liangxu.xu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v13 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220701202914.GA1457156-robh@kernel.org>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
 <20220701062808.18596-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701062808.18596-2-rex-bc.chen@mediatek.com>
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

On Fri, Jul 01, 2022 at 02:27:59PM +0800, Bo-Chen Chen wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.

I'm sure you answered this before, but I'll keep asking until the 
information is contained within this patch. Otherwise, I won't remember. 
Is there a h/w difference in the 2 blocks? Different registers? Why 
can't you just look at what the output is connected to?

> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> new file mode 100644
> index 000000000000..26047fc65e7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -0,0 +1,108 @@
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
> +  data-lanes:

This is not where data-lanes belongs. It goes in port@1 endpoint. Look 
at other users.

> +    $ref: /schemas/media/video-interfaces.yaml#/properties/data-lanes

Generally, not how references look in DT bindings.

> +    description: |
> +      number of lanes supported by the hardware.
> +      The possible values:
> +      0       - For 1 lane enabled in IP.
> +      0 1     - For 2 lanes enabled in IP.
> +      0 1 2 3 - For 4 lanes enabled in IP.
> +    minItems: 1
> +    maxItems: 4
> +
> +  max-linkrate-mhz:
> +    enum: [ 1620, 2700, 5400, 8100 ]
> +    description: maximum link rate supported by the hardware.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ports
> +  - data-lanes
> +  - max-linkrate-mhz
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +    dp_tx@1c600000 {
> +        compatible = "mediatek,mt8195-dp-tx";
> +        reg = <0x1c600000 0x8000>;
> +        power-domains = <&spm MT8195_POWER_DOMAIN_DP_TX>;
> +        interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
> +        data-lanes = <0 1 2 3>;
> +        max-linkrate-mhz = <8100>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                edp_in: endpoint {
> +                    remote-endpoint = <&dp_intf0_out>;
> +                };
> +            };
> +            port@1 {
> +                reg = <1>;
> +                edp_out: endpoint {
> +                    remote-endpoint = <&panel_in>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.18.0
> 
> 
