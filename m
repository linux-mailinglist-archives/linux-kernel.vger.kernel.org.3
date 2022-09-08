Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB575B1BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIHLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIHLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:40:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109B6D568
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:39:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x14so11881804lfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VIMRu3DlnR1bsB5zLuZyfEMWhGcdT9QFRMPDPMKjXCI=;
        b=EUN/eII6fAHStDiHP5M4+H2AZnUfJoda1Sv4cDqD+ji7NebxXFawVFe3nHmjf4Prai
         nXsU+2T+GtYxm+SuzBObS+BG1F+XFuMd/RglD5GU7CN7HKOQxGyogX250NIAOCxS3UdT
         fTQ4EKOyayztjv9V11TNKnXLqu0LZRuH42IEFipXFalZKACfj75glHGXpIc7KMriqp8j
         Iv5IzHBx6X2cEFnUpJM/m6uCFTHCaNOfvb7USbV5NxsNfP6D4phf178lkBhsaeqR8uMt
         nZilSPb5eJVN3GmO/W4VuOBLFUcsQtiY/NRlu9MguM1n7sfHfOJIeIFOUGaOvjfJ3If5
         m0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VIMRu3DlnR1bsB5zLuZyfEMWhGcdT9QFRMPDPMKjXCI=;
        b=B+J6tM35aclgYx50wV8FYprEh/7GGtMJXmf1Zw6TOMLTMWdibjyjc+F2J6jrcnTp1H
         3hfXbsrg0kTDi3pl29Qy8BrjZ04r4tG4Ri10Q9KxD0xR9fXKxxXk7BtADMScCQLECaTJ
         EjF1bHGCrpI6W3EAq9EL8lVPTfaoc9mOvs5XXdT268qL1/DZwJ5ZHkRFhNrqa4z6ILQj
         QiyRELV8I/9wWJw1uL+O8RcX1EI/g9LggfIt+uePceke+qo3c7ckHRkFFD+HLBX0y61f
         KK1V0A8CZPUgUJD3wQ7GDAKds6ZCbax+thn09KVAWzboDZ3Ky/gTpwRMu1gpDLmcPv2z
         4J5g==
X-Gm-Message-State: ACgBeo1OsmWuZ0U+4PZqDPjCqYBtQC+RtJoy0zzEDiOHNEL3TXHPytQn
        zoVrxNZNVPS4kNiWJoVxGe4fXA==
X-Google-Smtp-Source: AA6agR5sTBbNR2Xr0R2PxZyBP7qGDTxaJA/YR/L8EF9WX4+xtyxyVk7fYZFU0G2jo0dBbnMdcDRArg==
X-Received: by 2002:a05:6512:1189:b0:494:b306:c16 with SMTP id g9-20020a056512118900b00494b3060c16mr2700311lfr.452.1662637197344;
        Thu, 08 Sep 2022 04:39:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a18-20020ac25052000000b004979e231fafsm1495281lfm.38.2022.09.08.04.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:39:56 -0700 (PDT)
Message-ID: <961b4821-4111-b48e-1ae0-60da8c427fbb@linaro.org>
Date:   Thu, 8 Sep 2022 13:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2
 block
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 01:04, Lad Prabhakar wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L (and alike) SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> v1 -> v2
> * Dropped media prefix from subject
> * Renamed node name csi20 -> csi
> * Used 4 spaces for indentation in example node
> * Dropped reset-names and interrupt-names properties
> * Dropped oneOf from compatible
> * Included RB tag from Laurent
> 
> RFC v2 -> v1
> * Fixed review comments pointed by Rob and Jacopo.
> 
> RFC v1 -> RFC v2
> * New patch
> ---
>  .../bindings/media/renesas,rzg2l-csi2.yaml    | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> new file mode 100644
> index 000000000000..79beace4dec2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> @@ -0,0 +1,140 @@
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
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
> +          - renesas,r9a07g054-csi2       # RZ/V2L
> +      - const: renesas,rzg2l-csi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
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

One more: drop the "clk" suffixes. Remaining names could be made a bit
more readable.


Best regards,
Krzysztof
