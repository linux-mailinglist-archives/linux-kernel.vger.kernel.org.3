Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CB582102
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiG0HXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiG0HXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:23:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1440BC4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:23:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y11so25703605lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ft3XCwNiOjU+32vJUTrHCohDlzXHlrGObjp/2D3lLcw=;
        b=D2vcTf6EHxluMdEITJVhlFAhkbW4JXwi4l16W6a5A5FW0GepRJX9Hz0VOFqH4OJ3wj
         y0rysj0Ybv4kH6MNX324hPKweTIx+9oV9gisPrVjJ6i35zZ/pRYd1H/dD9gTertXKydw
         QM98CFre3HZrSY0dBfvD4/4qAo2bD5sBxN3qoysT+IjmD5ers8ddWUnRvHqjNJEVH/v3
         LNm/UZRG9iGKtJNCYgo7kr+eKfozku480KhGGtqiFFigOrP9OjE/Uos5MkYy/PNpuY55
         hrPdf6wrmD4tAW6gYoHF0KcPidX//mUg5U5xdPL8ylBCsbjjXSKgHw88aOrMWLuOhZXo
         fBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ft3XCwNiOjU+32vJUTrHCohDlzXHlrGObjp/2D3lLcw=;
        b=ffIJ5ygDv5Iey7ETp+3pMpiF4EOEPZHRM9/feN+2art2eBdl6+BZmUNHenTgKyG2ll
         1imu1AEhQqMgRAv2olSXLKXabdpWkoxoqhOnRXoRXQb9VT3IlnDs0/CvSUMtAw52PSPj
         GRnOXD25EdJ2fhhf0/UnPIOd5HDZ7blCg74fMij2fPwyXMS5G7fpWXfd61iAgTpZ665h
         Vm0HWdxXrYla0vhAXa6n3AF5JzVAZIoSPxwtEoAp9oblzxi6E9Urd2QooPR3AK9Otnb/
         b4eYRm4hxCEDETET7sAcP8FYyTU8y1efclabk54GGHFvz+2QMP/dFEr45cO+BUEF89+x
         iAZA==
X-Gm-Message-State: AJIora8l8lcqZFvfhrxvvG5JRDdWm0SidHjsV7Ur3spM5x4pJBYI8ZDj
        CDwW1nW8MKRx8KoWEHI719puXg==
X-Google-Smtp-Source: AGRyM1uHJ5ymf8whLvfZFW+rSC4qpuSxZKs4pbYbEi1RVIOv6PYyOgAgAz2r6JpgBX6lGa3re4pjbA==
X-Received: by 2002:a19:dc4d:0:b0:489:63cb:20c7 with SMTP id f13-20020a19dc4d000000b0048963cb20c7mr7155587lfj.101.1658906616374;
        Wed, 27 Jul 2022 00:23:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id o14-20020ac24e8e000000b0048a8899db0fsm1733291lfr.7.2022.07.27.00.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 00:23:35 -0700 (PDT)
Message-ID: <aaa6b5d0-20e8-146f-ba37-8784dbfd6072@linaro.org>
Date:   Wed, 27 Jul 2022 09:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v15 01/11] dt-bindings: mediatek,dp: Add Display Port
 binding
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        ck.hu@mediatek.com, liangxu.xu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
 <20220727045035.32225-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727045035.32225-2-rex-bc.chen@mediatek.com>
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

On 27/07/2022 06:50, Bo-Chen Chen wrote:
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
>  .../display/mediatek/mediatek,dp.yaml         | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> new file mode 100644
> index 000000000000..fd68c6c08df3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> @@ -0,0 +1,117 @@
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

Drop entire sentence and just describe the hardware.

> +  We just need to enable the power domain of DP. The clock of DP is
> +  generated by itself and we are not using other PLL to generate clocks.
> +  MediaTek DP and eDP are different hardwares and there are some features
> +  which are not supported for eDP. For example, audio is not supported for
> +  eDP. Therefore, we need to use two different compatibles to describe them.
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

No underscores in node names, so just "dp".

Best regards,
Krzysztof
