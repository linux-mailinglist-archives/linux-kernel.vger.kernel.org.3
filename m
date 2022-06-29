Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3B55FDE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiF2Kv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2KvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:51:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97326569
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:51:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z41so3055650ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/WzBp18LKZqSKYqbDKk6Oq8ggaqGJZKxa+Z+FGlULYQ=;
        b=rNekH7esQwdFoUrV+OQ7tNQusXFKep9peSzA4lY44/D3O6rRuwDUUFvP/tIozeFl0A
         Rct+yIWR6669oJT/tYSdcSeV4MjAGDkVIDAlK+mk2jreftsN0R64ckDPHR0KQ2ufRZZZ
         86uDev5U3WwyygTqKCZewri/8F413Gs74ZtTo2l8fbSA0IK/+dTgR5a213eN383oaxlQ
         7RGpBQV+8C7cSuXb+3kxDZdH12RMwY+E5fhYr1K5R10AFx7Jx7ol152FUuoJY2QobpgI
         FN2EXpgUH3f9v5XXSZs3fsKMA8u+wkATJswMSg6UsGTZDXWVw5VJJk+QApzzBW4h+P90
         HXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WzBp18LKZqSKYqbDKk6Oq8ggaqGJZKxa+Z+FGlULYQ=;
        b=r2/+9M3W9BT6ifdoEopmV8Yl5MYtdsDJ1OIVBCjhA4vS/8yP3Fiv6cyyc5p9uHYAoo
         Lwwr+jfTkexAPZiq52tZPsTQzSWrWcwR6CQ0vGiTwrABP0RQEmpPOUQDaZLEG7cPP6qe
         4pBbMdZ9g2BtLLT1qbCf3b89FSA0qvr+4kMPxfESu0mfguPq/qa1AWY5L3TApshvSDSN
         ejSShqOmkZUIirZMgwiVQgVHJngrxHiVVUwsxENQRxB/oBn2BcjQHTyxwDu2ZSCtPxd8
         wCLsYjlwp7ItDpFVHt1/VZeKw57AwIYonrLmG/fNJ6tTSXDXfbaDSSJWr3FgVuwkkXIu
         O9fQ==
X-Gm-Message-State: AJIora+/Fh6kMPunON6k1rX44dP7YYGSkN2heDnuJMEwQnw8NVxTPQKW
        KCcjURh4DlMoVQVSACwbUojO1g==
X-Google-Smtp-Source: AGRyM1sYVRiFJXQJZQmnqBYLOkLubf7ZwCbfZgC1NFu0yS0OD6FiS0Ak2yA9G+L6OwBGH6pZegK/sw==
X-Received: by 2002:aa7:cd17:0:b0:435:bd7e:2efb with SMTP id b23-20020aa7cd17000000b00435bd7e2efbmr3541102edw.180.1656499880428;
        Wed, 29 Jun 2022 03:51:20 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906444d00b00722eeb368cesm7582864ejp.64.2022.06.29.03.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:51:19 -0700 (PDT)
Message-ID: <fdc4fcfa-2d30-310e-d736-fd317b1cd2da@linaro.org>
Date:   Wed, 29 Jun 2022 12:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/7] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220627085632.23797-1-angelogioacchino.delregno@collabora.com>
 <20220627085632.23797-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627085632.23797-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 10:56, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 54 +++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
> new file mode 100644
> index 000000000000..795fb18721c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

No quotes in both places. Especially that once you use " and in other
place here '.

> +
> +title: MediaTek Functional Clock Controller for MT6795
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description: |
> +  The clock architecture in MediaTek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6795-mfgcfg
> +      - mediatek,mt6795-vdecsys
> +      - mediatek,mt6795-vencsys
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mfgcfg: clock-controller@13000000 {
> +            compatible = "mediatek,mt6795-mfgcfg";
> +            reg = <0 0x13000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        vdecsys: clock-controller@16000000 {
> +            compatible = "mediatek,mt6795-vdecsys";
> +            reg = <0 0x16000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +
> +        vencsys: clock-controller@18000000 {
> +            compatible = "mediatek,mt6795-vencsys";
> +            reg = <0 0x18000000 0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> new file mode 100644
> index 000000000000..629e0cc7c916
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/mediatek,mt6795-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

No quotes.


Best regards,
Krzysztof
