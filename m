Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984F574747
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiGNIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiGNIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:38:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79313402C6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:38:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n18so1671294lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7fxd01WSVmh4sZ+rShAEvNwWTJPHinWndJQGVhp8bBI=;
        b=AV6Hhli373vNQFbi9Ak8xtnfk65n1qJoOFR1iopuhLqNO+9rR7YVnsPRxPwQyDSQIV
         +QSw/uYsUn0j3lTno1eRLpYu6NCmKMJ9NHXnu4MS/85dt2BIFA1oM9XA7hsrJQYOFIdC
         hQbQbbF8+DErln2+k/IyanoaqZumXBcql8mwC+7C8GE42BE1um9abQ98AyATK4QRbSW2
         ljWFFeMgHHg4xta7hDjX252AJNu8ISxRyUblN+e3kCPgKPRQ1EbvbtncAOYC8xFT3/bH
         xVMAPvZIlkTEWGZd93pTeNDQCQpHIH9ToFdVKCDS72OiK4S9a+FfVKuuh/PHcI4oOCZI
         5d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7fxd01WSVmh4sZ+rShAEvNwWTJPHinWndJQGVhp8bBI=;
        b=Kv0tCXIulDNmtd8F+UP1lyP9TyEQzqZ2p2eof6QcehqzmB8UJc6r8NRr/cHoYUwLEN
         GdnuV0Q2zN3VLtCfcAVZLGDBEprCCdkyIMSEoJhyRFNbzbGVO+pfMWlANvbUJdUJhOSv
         djZoFEpszSY2n8mTLXZH93VdcpticFjaqQIFfTee5XMsCVM/YGJkkIk9RLRTsm2oVDpn
         cMK3xDf9cI0bTTDhlA3a29+iOnEPqVvisYM6XDrQsmIdbS740dgYBA98HWLm33Y88XSl
         XbMkV9qlNnrknVIlXhLuVjK/ve2D75gl5NVZJcBQwbn8n3bxtsB/XTewBQ0cv0D5mMxL
         DucQ==
X-Gm-Message-State: AJIora8qq+RhfWvfIsKEBm+EgnlJsOT16lHMNWMh0D9I/GOiABADBmoo
        sElA341KlGBrn4WQf2BTzz0ATw==
X-Google-Smtp-Source: AGRyM1uNnmvHoyTRHbkEvCEx1QbExHpVGO/O3M8jCnCpVPFay7j9MN3UnazfseCVeu8DlEirOYwVeg==
X-Received: by 2002:a05:6512:2308:b0:48a:f9d:7389 with SMTP id o8-20020a056512230800b0048a0f9d7389mr3677290lfu.235.1657787888760;
        Thu, 14 Jul 2022 01:38:08 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id k6-20020ac257c6000000b00489cd8ee61asm237159lfo.275.2022.07.14.01.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:38:07 -0700 (PDT)
Message-ID: <3178fad9-b761-dd28-971a-007159d10695@linaro.org>
Date:   Thu, 14 Jul 2022 10:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
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

On 13/07/2022 18:25, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 

Thank you for your patch. There is something to discuss/improve.

> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-i2s.yaml     | 83 +++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-i2s.txt   | 46 ----------
>  2 files changed, 83 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
> new file mode 100644
> index 000000000000..1cadc476565c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/atmel,sama5d2-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel I2S controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel I2S (Inter-IC Sound Controller) bus is the standard
> +  interface for connecting audio devices, such as audio codecs.
> +
> +properties:
> +  compatible:
> +    const: atmel,sama5d2-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Only the peripheral clock (pclk) is required. The generated clock (gclk)
> +      and the I2S mux clock (muxclk) are optional and should only be set together,
> +      when Master Mode is required.

Skip property description, but list and describe the items.

> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +      - const: muxclk
> +    minItems: 1
> +
> +  dmas:
> +    description:
> +      Should be one per channel name listed in the dma-names property.
> +    maxItems: 2

Instead items+description. The description you pasted is obvious and not
helping.

> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
Best regards,
Krzysztof
