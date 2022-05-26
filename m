Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7B534EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345574AbiEZMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244794AbiEZMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:16:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CFCEB93
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:16:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q15so1563901edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WgG+T/OxBY4aQd1LFq7PNdagdKTYGqPQcawpOpu83Hw=;
        b=kqHhtxa8DsR+qtROdGeZStDkz718COk59qOAyNv2L4tklqkyJYvDyJplFJceGVV1h3
         h2AUQq1A1S9uuXFKXQK9P1anRn0S+wHoFlMWJugW/8eN2OxlzcThif0qRCfDVItsK/jR
         gutO21xsCOCuWLM/y9lIP0gQ6z2Gmqp9lsjDF4OtAIgT57sj8TDr04NDH7gP3QikIEUk
         SSaWsM5TQVncss8yxe6XIzKNzSCzGYtLpuTlXHruhVqQMcO6dubbfjBtJjXgPs4hkBtR
         d4P31EP6gg5jGAtyhAOXBtmcn4Qqz2soRQ6PWm6wX13IIfdyy56sU/KxMiGzdRy0IYR3
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WgG+T/OxBY4aQd1LFq7PNdagdKTYGqPQcawpOpu83Hw=;
        b=6P2BlMOfTk3zkWXlRyXyuAuwZu27x6nws/HniP0S0VfSvojMSa/qLbQNC/96FBajim
         0pBRS+BViumsnBq5OkNQ1w2+eMJD+l6BOSfpNJ6sP8a2pjtYb2IPMWo85w6enN5tuRFu
         zpv2oYZ1ay8VHlyW6IawcY1pKRBIfZoXol+ktt5k8ax58KLvCdbePYMJ80iUEzQ1JD5u
         1zHPyXYh/CnUApJ4LoJSfl1MaoyrGs9KE5cy07ZXAB1oE3kZSW88VoWp+JJEsIC91fUg
         yH7dNogEVEKH0xR5VHjNNIDYD3xtr5wl97Z8BA2CgjKktVH37XjcIkVXQbX54+FSWyGX
         NBWw==
X-Gm-Message-State: AOAM532G9ow1QLiTWHxxvEqMsUBsiVFVv/fnmwEqqsrYB9NqWWs5Ri18
        DJUZis9F2Q9L4OieTJD/zK9nzw==
X-Google-Smtp-Source: ABdhPJyIy7ujx1LoHNkv8ke973NyvFGD42vlG2UtAnGb6f89DBj7HneTUz6qJAoHSFYSInNsiHPp0w==
X-Received: by 2002:a05:6402:1393:b0:42a:c36d:67a6 with SMTP id b19-20020a056402139300b0042ac36d67a6mr39935014edv.158.1653567416423;
        Thu, 26 May 2022 05:16:56 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bl16-20020a170906c25000b006fea43db5c1sm480965ejb.21.2022.05.26.05.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 05:16:56 -0700 (PDT)
Message-ID: <1316dd5f-c774-e1c0-892b-7d371936a9eb@linaro.org>
Date:   Thu, 26 May 2022 14:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] dt-bindings: dma: fsl-edma: Convert to DT schema
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220526102438.184803-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526102438.184803-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 12:24, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the eDMA controller binding to DT schema.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Typo fix
>  Correct interrupts/interrupt-names/AllOf
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 140 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-edma.txt      | 111 --------------
>  2 files changed, 140 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,edma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> new file mode 100644
> index 000000000000..0a63b0b70f98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale enhanced Direct Memory Access(eDMA) Controller
> +
> +description: |
> +  The eDMA channels have multiplex capability by programmable
> +  memory-mapped registers. channels are split into two groups, called
> +  DMAMUX0 and DMAMUX1, specific DMA request source can only be multiplexed
> +  by any channel of certain group, DMAMUX0 or DMAMUX1, but not both.
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,vf610-edma
> +          - fsl,imx7ulp-edma
> +      - items:
> +          - const: fsl,ls1028a-edma
> +          - const: fsl,vf610-edma
> +

The reg and interrupts should still be there (matching the widest of
constraints).

> +  "#dma-cells":
> +    const: 2
> +
> +  dma-channels:
> +    const: 32
> +
> +  clocks:
> +    maxItems: 2

Also clock-names with maxItems:2

> +
> +  big-endian:
> +    description: |
> +      If present registers and hardware scatter/gather descriptors of the
> +      eDMA are implemented in big endian mode, otherwise in little mode.
> +    type: boolean
> +

Best regards,
Krzysztof
