Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E6571423
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiGLIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiGLIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:14:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E184DC1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:14:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so12637479lfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=piVMAlOpffJwid9tZ0g858Wy2lJidXX23spAtayy7OI=;
        b=StLfu8nwjSGQBtoVu4xYBsPLaD86GA58kvcFstln0NzGJ/tDTYxbzgh3KFuopdgHNF
         fK+aRHHn5QwzVLgwmscm7kPdZVWj+Lyj+G6BTDqzEVOJMulJ+zd4o8+JeCOdURYADhdN
         dJCsIuavIfqIWAzB5j1VjwTnovlSzB+zyXJM5URY8uDY5idEMKcQGkhk7QT6ka1njyOs
         gXDpjtdnsNFSHZQh59Az9HtdqoLcByUS4I9wjlO4d2zx4Q5iGdnSiL+FyuVfIbPlvJOO
         oD26l4vQ80PEHbSKsVUliv8Ke8if2qF42yz+10hJLfWg54eG43XGUooXN25VQE3E2Fkd
         ugfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=piVMAlOpffJwid9tZ0g858Wy2lJidXX23spAtayy7OI=;
        b=dhcoJFiX1pVtPqc9Ek4ckT5edUZPQLLiQ2q1J3ZMv99tQ3VzYjwh8ws5fQDiU9UBhD
         40TlcadQf3lGD7/dCQX5o60bSzHT1c7FF2rkcwkeKcAXlFR48iMsU9oR+sy3hjr4+XjZ
         0CIN4qX3ALcqyVoFrLkZLLMo9s++fYkzCvHZzAtk5a+oCvH1ze1WAMeTK60Qy4ALy4+i
         0ekRYu6fte+LGipupWe/lhAZWl1CrDWv+3m/729ynRe+FFpLBgqLtF8cP0cT3RUOzcL+
         i+qAmc5MLlXsdQ9iW3b3GQYXcec9tj1NPvktFmvhNzRiVK4XkdgwaxjNn3B6kZqMsLpv
         UEYg==
X-Gm-Message-State: AJIora+cBKvP4VwtAIDDTXw8K8U6iJVOmjjIs0sYszV8NTSi5i8vdKg1
        hn1fZ6AF7snfYEhfN0euDbK+9w==
X-Google-Smtp-Source: AGRyM1vqqp5s0BWN1F/7Lz3d6Rxo5GmlvLhM0XjExtACcM8zjS7RAxUFqyw3vof8bqYboTmuemBL4g==
X-Received: by 2002:a05:6512:2345:b0:489:e76e:cc1a with SMTP id p5-20020a056512234500b00489e76ecc1amr3619483lfu.219.1657613656558;
        Tue, 12 Jul 2022 01:14:16 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c02ce00b0025d754ba5f4sm639397ljo.99.2022.07.12.01.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:14:16 -0700 (PDT)
Message-ID: <1d048162-8051-f95b-c359-0ab59e32e507@linaro.org>
Date:   Tue, 12 Jul 2022 10:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] dt-binding: sound: atmel,pdmic: Convert to
 json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
 <20220711183010.39123-3-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711183010.39123-3-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 20:30, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert Atmel PDMIC devicetree binding to json-schema.
> Change file naming to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> v1 -> v2:
> - Fix title.
> - Removed trivial descriptions.
> - Fix formatting.
> 
>  .../bindings/sound/atmel,sama5d2-pdmic.yaml   | 98 +++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-pdmic.txt | 55 -----------
>  2 files changed, 98 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
> new file mode 100644
> index 000000000000..88fa92a30147
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/atmel,sama5d2-pdmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel PDMIC decoder
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel Pulse Density Modulation Interface Controller
> +  (PDMIC) peripheral is a mono PDM decoder module
> +  that decodes an incoming PDM sample stream.
> +
> +properties:
> +  compatible:
> +    const: atmel,sama5d2-pdmic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: peripheral clock
> +      - description: generated clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx
> +
> +  atmel,mic-min-freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The minimal frequency that the microphone supports.
> +
> +  atmel,mic-max-freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The maximal frequency that the microphone supports.
> +
> +  atmel,model:
> +    description: The user-visible name of this sound card.

In previous properties the description was the last one, so keep it
consistent.

> +    $ref: /schemas/types.yaml#/definitions/string
> +    default: PDMIC
> +
> +  atmel,mic-offset:
> +    $ref: /schemas/types.yaml#/definitions/int32
> +    description: The offset that should be added.
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +  - clock-names
> +  - clocks
> +  - atmel,mic-min-freq
> +  - atmel,mic-max-freq
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pdmic: sound@f8018000 {
> +    	compatible = "atmel,sama5d2-pdmic";

Wrong indentation. I already asked for this.


Best regards,
Krzysztof
