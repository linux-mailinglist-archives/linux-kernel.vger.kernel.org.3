Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641665877F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHBHha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiHBHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:37:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1156454
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:37:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h12so14724701ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=URseQjXjOTyP7Y7Ids7IGoAxfF0B+LCgv9LDJOxn0e4=;
        b=hgEifgEEc8RJp8ISWE1R7rNbqZOTjbYFLSR+ZCQ3pCzNKf6M/zLuIFQub34HwSf2Cx
         pXKoJH0Xcib5nDBj2xTw283BeMqtxYDBvYDoIHZ5I6c/rQhNNETCJMkJnDSqRfkdnINH
         WQsz52anuBiuLZsea5kdDORb9OCwYhdOeFETD/smvx1IIcxqGsEipeovwptZxh8xxgMi
         HR1N11jZ7fKXqkJR1DpgnvlUxqvhw4LvcpeLid1CWKfDQbCw8sbPiQkog8VM8YuvXQo5
         HQcRsz5ksXv2HRAld+feKYP4AKMwKPCz4CSwRRY0EOVd0zhAskdDwfJyNkWFza/SJ1WV
         dNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=URseQjXjOTyP7Y7Ids7IGoAxfF0B+LCgv9LDJOxn0e4=;
        b=Xe9mXWKBVdZeJFgivsvC+oSGqbnwWpcX+gfxXybSFAR/0yCKu0a3+2I15BKYe91lOt
         duvTS8QeXrrRn4BAZfeDjRfWcy/AlIzamvha3ZOO3Qz5qaz4zt0FlLvz0PxA3/TcV5yD
         uTSP4mCxfaf5ZX6hcrTbpzZAiH0znW6Z9Y3CavShVNcwDFcCRUdVX1L3kSJ/I5dMF6C8
         o88s7qSOnwUFH91p/C6lSfLM8Of1kXXHbcqXWvVQ6EC3FRxNCANv6bckMUjC8ULiHybH
         +DIjNlhTFKEXxNHwj1oR0iIMYqI89utXdzTdMAv2PVaKT83wtR2LR/i85/F6YnAJ+8Kc
         yVrw==
X-Gm-Message-State: AJIora8VafEU4Alco+Vkmw20a4stKolBIdA1lsif/17fReDTV0x0eOYK
        j24zI2wUtzd4LHvaRA/L8W13+Q==
X-Google-Smtp-Source: AGRyM1uhBNEbBQJbIFzahQRwuRR5CYFcJwVMYLFPLaZ+RgbUYWmzvMn9AyXfnetpcWEXjIbws1+nSA==
X-Received: by 2002:a2e:bc06:0:b0:25e:19b8:637b with SMTP id b6-20020a2ebc06000000b0025e19b8637bmr6779517ljf.356.1659425842847;
        Tue, 02 Aug 2022 00:37:22 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id be20-20020a05651c171400b0025d4cbc20d8sm1845842ljb.22.2022.08.02.00.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:37:22 -0700 (PDT)
Message-ID: <4ff10b73-d04b-cda8-6603-f6f342f5ce9a@linaro.org>
Date:   Tue, 2 Aug 2022 09:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] media: dt-bindings: media: Document RZ/G2L CRU
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
 <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801214718.16943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
> Document the CRU block found on Renesas RZ/G2L SoC's.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1
> * Dropped endpoint stuff from port1 as suggested by Rob
> * Updated description for endpoint
> 
> RFC v1 -> RFC v2
> * Dropped CSI
> ---
>  .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> new file mode 100644
> index 000000000000..d7389693dae9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/renesas,rzg2l-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L (and alike SoC's) Camera Data Receiving Unit (CRU) Image processing
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +description:
> +  The CRU image processing module is a data conversion module equipped with pixel
> +  color space conversion, LUT, pixel format conversion, etc. An MIPI CSI-2 input and
> +  parallel (including ITU-R BT.656) input are provided as the image sensor interface.
> +
> +properties:
> +  compatible:
> +    oneOf:

No need for oneOf, unless you already have a patch adding second case to
oneOf.

> +      - items:
> +          - enum:
> +              - renesas,r9a07g044-cru     # RZ/G2{L,LC}
> +              - renesas,r9a07g054-cru     # RZ/V2L
> +          - const: renesas,rzg2l-cru
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: image_conv
> +      - const: image_conv_err
> +      - const: axi_mst_err
> +
> +  clocks:
> +    items:
> +      - description: CRU Main clock
> +      - description: CPU Register access clock
> +      - description: CRU image transfer clock
> +
> +  clock-names:
> +    items:
> +      - const: vclk
> +      - const: pclk
> +      - const: aclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: CRU_PRESETN reset terminal
> +      - description: CRU_ARESETN reset terminal
> +
> +  reset-names:
> +    items:
> +      - const: presetn
> +      - const: aresetn
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing a parallel input source.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              hsync-active: true
> +              vsync-active: true
> +              bus-width: true
> +              data-shift: true
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port node, describing the Image Processing module connected to the
> +          CSI-2 receiver.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  # Device node example with CSI-2
> +  - |
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cru: video@10830000 {
> +            compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";

Also 4-space for DTS example, please.



Best regards,
Krzysztof
