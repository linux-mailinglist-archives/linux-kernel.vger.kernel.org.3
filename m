Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883F589E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbiHDPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiHDPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:21:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12CC24BD3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:21:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u1so21024254lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sLHXisZDzhQTu+IhZD1MGX5kdmZBF2E9OyEhDTPZJwU=;
        b=MkFB+W3R4k/NmdzMtGvO5gm8bWIU/D3gqfEfki8sreQu/60nOhWupmHELrsdxsDNxS
         WT7olF55X3+NnUwsGIK+/5xVeDIXpI3AZYGhlk8YbSW/qAp2+u8cYiH/JwAzsMfslxTQ
         174s3nNsRf4FC6xCh/tS76iCgWBdiMvpYcRKkTLgY8ODyVSxWZA9kr64eG92gFiwPui2
         hicquy9dQ4m1PDAd9L+Mp0rK9f5BbUOYYfEaiM4sX5fd8EgxoG1zIPQMhdT2u3pqsdFI
         OTFWtje7TEcvipt37N3gDIsUQIEOPpT/CX8SEjySZASBM1mU4wCSdFM81FvEkI4yISn+
         LVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sLHXisZDzhQTu+IhZD1MGX5kdmZBF2E9OyEhDTPZJwU=;
        b=j0qthURBCoYXrYeTmW22gNBgCLC6XvPeq6p1mDh6iL43//CAgSK6kLJZwjQpAlliVr
         9SkaM8vrsgDf8NAfCK8DdiU3WdKI1AveQuaub9HD0fHQoHlmbEK11OskmIW59mU3/tsz
         mASbv4VtzJOoEjP+nECXiIhj5LzersrhTa1/FFoUuXnvIehLZoNn9mK/lzcuIEvE8OGI
         CecLKlIR4C+S8u8q2BGck7d6Bbfdg9q4W6Gm5w10M95tH3aqr2cUjqJ1tP1zcX6D1YzX
         KsPZ3zGTQyk6Q9Y/QfJyVvCKy++BW2VermARAQUcMPv7KlzYXKmfDCKeJ9m4NV4baJFi
         KoHA==
X-Gm-Message-State: ACgBeo1LeFKRRyeAOKUAT3ryNK9wk3Ue07hfgiN8yi57mjr8uAXawdUd
        ldXCT2LrXXudZGf/rOUW2zXqCQ==
X-Google-Smtp-Source: AA6agR7eeNfFMJaNN8k/ryXzsufMj3U/fkqVDVZELOmyQq1N/mh7D7XfeQg7tK35//Sy3EhyeaaZLw==
X-Received: by 2002:a05:6512:2623:b0:48a:ac70:311 with SMTP id bt35-20020a056512262300b0048aac700311mr912828lfb.278.1659626498050;
        Thu, 04 Aug 2022 08:21:38 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id v25-20020a2e4819000000b0025df04af0f0sm154942lja.51.2022.08.04.08.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 08:21:37 -0700 (PDT)
Message-ID: <191fc051-f10c-3eb1-2810-ebfce2279bbd@linaro.org>
Date:   Thu, 4 Aug 2022 17:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8.1, 2/7] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-3-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220804130912.676043-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 15:09, bchihi@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

Please rebase your patches on recent Linux kernel (or next).

> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..53c44a73f3a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC LVTS thermal controller
> +
> +maintainers:
> +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> +  - Ben Tseng <ben.tseng@mediatek.com>
> +

Any reason why not referencing thermal-sensor.yaml?

> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8192-lvts-ap
> +      - mediatek,mt8192-lvts-mcu
> +      - mediatek,mt8195-lvts-ap
> +      - mediatek,mt8195-lvts-mcu
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 2

You need to describe the items (like nvmem-cells).

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: SW reset HW AP/MCU domain to clean temporary data on HW initialization/resume.
> +
> +  nvmem-cells:
> +    items:
> +      - description: LVTS calibration data 1 for thermal sensors
> +      - description: LVTS calibration data 2 for thermal sensors
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: lvts_calib_data1
> +      - const: lvts_calib_data2
> +
> +required:
> +  - compatible
> +  - '#thermal-sensor-cells'
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/thermal/thermal.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/reset/mt8195-resets.h>
> +
> +      lvtsmcu: thermal-sensor@11278000 {

Mixed-up indentation.

Best regards,
Krzysztof
