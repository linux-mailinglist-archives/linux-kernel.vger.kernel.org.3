Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321945877F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiHBHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiHBHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:36:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0648FD12C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:36:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y23so4391401ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+uxw0k1z3yLPPGIvdY7TbWXYjeq8DTWxtJm8yZgfHjM=;
        b=lehLhnOxHSYYvDeRIsj9cGKX6iGFd9EJ2KyLjQ5zdw7EOpe1ax+Ck7FKZfJ548h9H0
         Zt2R10iuct7iBdcxdUCrvsrXObQRCImWlwl0I+TuPuYGTcfZUK6k0RBbN/PU+Z0seItZ
         yTDMWwLcdRS+Mhh/bUX6F2w7fbdpfP41BrO2FvZK+NZGCtnw3OgH7Qq5dBsyKornMVRD
         dx7PIhgzHNvZMEEjmv+Inv8ReKtWN8jIw/FgVHidrnOObka+qI1Z/KPdFjg8hfCqH7FF
         amNvad1KBCWNy3YqRmzqn4vfET8D6hlgdXElhoAia1WeuZW4uqNU2cOil9Fzm7x25xOc
         nYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+uxw0k1z3yLPPGIvdY7TbWXYjeq8DTWxtJm8yZgfHjM=;
        b=CU7KJsDPGAwZPw8Tt2lqz1V5thebODTZIyy8DGzMJjExVt3GcKK4sMdOJfZY7UFkLV
         k++EV1xlRVHcTX0pTIh4wGEVvcaTi3ZRA/FvKeuvW+RCBLx9UB+orc/o2YP+0b84MS7D
         qMoW/DAJimBe0kdgrQCrkFLhKoCCukPSKZQmOAhI2FyAMyHOByK++DgkZe+YjUIVXRSw
         +x3nlepPaqLEZkRezRQ0/Oo4zweUPLA5sUzoiaeZw4vXzqfkGKfwhfIUM0SB/YuE/cTN
         84gpFVw3EP/uh98CJ8s32CUczyQIacoOHikF4w9Smw9MuWjFfIrwOeg8dkPCmbOxWabg
         ZDYg==
X-Gm-Message-State: AJIora9xfWVTwlV4NnOM1cOdEYUVwIMrekuoAbWaitBI9NwzUUtteJSA
        0cPMWdILyet3AiTnfCtPNjnOHg==
X-Google-Smtp-Source: AGRyM1sCfsPc72zuAnJmDLr75MiHUEpZykMoGAAgdiNdr2Jw6rzcump9gBcYkdkMXkdsf9InJgbzyA==
X-Received: by 2002:a2e:934f:0:b0:24f:ea1:6232 with SMTP id m15-20020a2e934f000000b0024f0ea16232mr6321414ljh.135.1659425788309;
        Tue, 02 Aug 2022 00:36:28 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id h40-20020a0565123ca800b0048af895ca6bsm718364lfv.107.2022.08.02.00.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:36:27 -0700 (PDT)
Message-ID: <4b1d5266-40a9-9897-7caf-d3d41c0aa598@linaro.org>
Date:   Tue, 2 Aug 2022 09:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2
 block
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 23:47, Lad Prabhakar wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1

Too many "media" in the subject prefixes.

> * Fixed review comments pointed by Rob and Jacopo.
> 
> RFC v1 -> RFC v2
> * New patch
> ---
>  .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> new file mode 100644
> index 000000000000..f82f88c096df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
> +  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
> +  with the Image Processing module, which provides the video capture capabilities.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
> +              - renesas,r9a07g054-csi2       # RZ/V2L
> +          - const: renesas,rzg2l-csi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: csi2_link
> +
> +  clocks:
> +    items:
> +      - description: Internal clock for connecting CRU and MIPI
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: vclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_CMN_RSTB reset terminal
> +
> +  reset-names:
> +    const: cmn-rstb
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +            required:
> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node, Image Processing block connected to the CSI-2 receiver.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    csi20: csi2@10830400 {

Node name just "csi"

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
> +            reg = <0x10830400 0xfc00>;

Please use 4-space indentation for example DTS.

> +            interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
> +                     <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
> +            clock-names = "sysclk", "vclk", "pclk";
> +            power-domains = <&cpg>;
> +            resets = <&cpg R9A07G044_CRU_CMN_RSTB>;
> +            reset-names = "cmn-rstb";
> +
> +            ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                            reg = <0>;
> +
> +                            csi2_in: endpoint {
> +                                    clock-lanes = <0>;
> +                                    data-lanes = <1 2>;
> +                                    remote-endpoint = <&ov5645_ep>;
> +                            };
> +                    };
> +
> +                    port@1 {
> +                            #address-cells = <1>;
> +                            #size-cells = <0>;
> +
> +                            reg = <1>;
> +
> +                            csi2cru: endpoint@0 {
> +                                    reg = <0>;
> +                                    remote-endpoint = <&crucsi2>;
> +                            };
> +                    };
> +            };
> +    };


Best regards,
Krzysztof
