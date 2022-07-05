Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4256760E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGER4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiGER4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:56:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182D2BCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:56:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so4292793lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=shYinKXG4MQdFX7ZW9KlW+0lvbviw1UaiNViTCYpf9g=;
        b=lu9+iYAES8x+XD//Jw2ejvInxe149YmabvcbqQQYccKT2ogYWV1q/8A/jBENzR68W2
         PiWgfT9r65LMRPFo+EfVjwi0H9bsIsViE33osoC5KekrSl1EeChAer8Q1AAGy3ozZ+Qw
         FA0CS10uZrfvG46CvCgrNxSzGSxGO34BQSK4/oKsVCOt/4hf/8EjNpT32bVzOA5sN+V9
         KUTHThTY8qn0pyI7T+cMtkMW6FD+kxWbs0Zk6VKp5P1AoS0tPoEeHNmn0jLLs9h8sHOZ
         6TdsQEf2dANyqiQsHQK9UGNivihNibZgCt+lmPn2qb6S8WuhaaGCScHNJqzcwLjgeaUr
         +pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=shYinKXG4MQdFX7ZW9KlW+0lvbviw1UaiNViTCYpf9g=;
        b=wvZ8Xbw27w5VCXGqA7VPshhI0TQMWAi6LTqKoGv0tQ7E2ajmZm5NiJii8PrwKkk/lr
         yafV83+iEBaNikmr9WUeuntF7aSRyj3VKiYF+ks79ZOJaMtN5DNwR50a0HvwXlqY17Zg
         BAJieHTOlyOy/+zXUG4drKi3ALK2sPgq+NoipKJDoVSUDjKmxNGCdFBZ+yb/pF/+yBSf
         G31R1rle3fxqWVxUgm2gaiD6S/QDc3yPlpY4Z6U0aQ5A6pQqN7z6Pf7Zhf6pxd6ewimJ
         h/h8oqwJ026MmN19LaAx6u+u+bDYam9sAZ8BF1oGNs4KJe9C1EsUhqAyI5Tr2PZygp6N
         JIEg==
X-Gm-Message-State: AJIora8MWWSRh0GeM5GUVUAodi0I6cE3XX84fGeISpwkL5BUDdGJ57TT
        WpSQVbr6SoVd0vahumGClyFfDg==
X-Google-Smtp-Source: AGRyM1uhGiiqD3O6wNSZmHwZAko+jzy78knQzJWQpkSCqA52mH/D7cFAy2+U6XnCp2K/VHXfucRtaw==
X-Received: by 2002:a05:6512:2508:b0:480:f1cb:64ad with SMTP id be8-20020a056512250800b00480f1cb64admr25069896lfb.359.1657043790156;
        Tue, 05 Jul 2022 10:56:30 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id z8-20020a05651c022800b0025d37955bc7sm404247ljn.74.2022.07.05.10.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 10:56:29 -0700 (PDT)
Message-ID: <8d71000b-e9d7-3586-5421-36a1fb367b5e@linaro.org>
Date:   Tue, 5 Jul 2022 19:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-binding: sound: Convert atmel pdmic to json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, Claudiu.Beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.berna@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
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

On 05/07/2022 18:21, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert Atmel PDMIC devicetree binding to json-schema.
> Change file naming to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-pdmic.yaml   | 104 ++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-pdmic.txt |  55 ---------

You need to send the patches to proper folks with proper subject prefix.
Use get_maintainers.pl for the first and `git log --oneline --` for the
second.

>  2 files changed, 104 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
> new file mode 100644
> index 000000000000..cb34c0fc4fc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/atmel,sama5d2-pdmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel PDMIC driver under ALSA SoC architecture

"driver" and ALSA are Linux specific, so this could be corrected during
conversion to name the hardware.

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
> +    items:

One item, so no need for items.

> +      - const: atmel,sama5d2-pdmic
> +
> +  reg:
> +    description: Should contain PDMIC registers location and length.

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Must contain an entry for each required entry in clock-names.
> +      Please refer to clock-bindings.txt.

Skip description.

> +
> +    items:
> +      - description: peripheral clock.
> +      - description: generated clock.

Skip trailing dots, since you do not start with capital letter.

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
> +              compatible = "atmel,sama5d2-pdmic";

Use four space for DTS indentation.

> +              reg = <0xf8018000 0x124>;
> +              interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
> +              dmas = <&dma0

Best regards,
Krzysztof
