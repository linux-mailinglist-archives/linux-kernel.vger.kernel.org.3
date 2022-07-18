Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59A578BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiGRUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiGRUVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:21:17 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EBE3056D;
        Mon, 18 Jul 2022 13:21:16 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id w9so3123178ilg.1;
        Mon, 18 Jul 2022 13:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ynxFYeVYReMscKRbp1PGFWnDnfPfj0JbfYGgEj9QMa8=;
        b=J+vrUYpQeZ/Cy0gkMY17/5bzKV7eaujoyI9bq2GFe+voqTqdoTeGpJocLQvNFZ7vQ0
         ILgJA/GMVZHQOY92cHK/hcMmCiL+wpXnl1v24Sssfll6zfyATPLWenyP4aqq7hwtCwON
         2pSXqoNTbEmK+vveBJXTZOXN0KFXWwV4sa5KkbDRLVopgUbQ5bD/6fI2cvTj/Dgqe4/x
         C6soF3U6g/rPwJpbcQxVAlrF6Wg7D6PfA5EBNpI4FOSnFSI+y1MdDEBr9r2UrgEndjxp
         CrUdvSNikdymQSZ/uBMvLa7ewD2kGrpVqHR+jI+miFOhilUVI1CD2Hb6sYdBCn/toF5g
         PhRQ==
X-Gm-Message-State: AJIora9d0irJ4GNdAWm43m/ikP0Zq1iOmJ6RIzAZNMAIDupkGQKvadve
        8vQSOddRd5aflZ6qM7pmDw==
X-Google-Smtp-Source: AGRyM1vaDDDUOeHt3lurvR3J3lSRNZ44pNwdJGSHidBa5vaIG068vrI+0SSo+eDbXIHdcLNloTdksA==
X-Received: by 2002:a05:6e02:1688:b0:2dc:822e:7c63 with SMTP id f8-20020a056e02168800b002dc822e7c63mr14459068ila.205.1658175675865;
        Mon, 18 Jul 2022 13:21:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d190-20020a6bb4c7000000b0066961821575sm6327392iof.34.2022.07.18.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 13:21:14 -0700 (PDT)
Received: (nullmailer pid 3481625 invoked by uid 1000);
        Mon, 18 Jul 2022 20:21:09 -0000
Date:   Mon, 18 Jul 2022 14:21:09 -0600
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
Subject: Re: [PATCH v14 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220718202109.GA3465206-robh@kernel.org>
References: <20220712111223.13080-1-rex-bc.chen@mediatek.com>
 <20220712111223.13080-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712111223.13080-2-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:12:14PM +0800, Bo-Chen Chen wrote:
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
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> new file mode 100644
> index 000000000000..e2d6cb314297
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -0,0 +1,115 @@
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
> +  Device tree bindings for the MediaTek display port TX (DP) and
> +  embedded display port TX (eDP) controller present on some MediaTek SoCs.
> +  MediaTek DP and eDP are different hardwares and they have different
> +  base address for registers, so we need two different compatibles to
> +  separate them.

As I said before, 'different base address for registers' is not a reason 
for different compatibles. If it was, then we'd never have a compatible 
string appear more than once in a DT.

Explain WHAT is different within the block. For example[1].

Rob

[1] https://lore.kernel.org/all/20220710084133.30976-10-dmitry.baryshkov@linaro.org/


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
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Output endpoint of the controller
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            properties:
> +              data-lanes:
> +                description: |
> +                  number of lanes supported by the hardware.
> +                  The possible values:
> +                  0       - For 1 lane enabled in IP.
> +                  0 1     - For 2 lanes enabled in IP.
> +                  0 1 2 3 - For 4 lanes enabled in IP.
> +                minItems: 1
> +                maxItems: 4
> +            required:
> +              - data-lanes
> +
> +    required:
> +      - port@0
> +      - port@1
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
> +        max-linkrate-mhz = <8100>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                dptx_in: endpoint {
> +                    remote-endpoint = <&dp_intf0_out>;
> +                };
> +            };
> +            port@1 {
> +                reg = <1>;
> +                dptx_out: endpoint {
> +                    data-lanes = <0 1 2 3>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.18.0
> 
> 
