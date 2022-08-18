Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4384A5984AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiHRNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbiHRNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:48:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6FFD01
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:48:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h5so1931146lfk.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Is+DOcT8Igc7YLkCSkZJEYbaJMo6lo7wsCMqnBIM3m8=;
        b=d2t/eQslOw6CIAXZUHpxg7gzDtChs9KCal7MZkOmjM3YWVQOOUX4L/bYH1rFo2Am7z
         G6Sc+58dt++Tv41j4TWkAwFK+J09xa3eE0btttj/DIdWPc7ldTOAWu7AjiQrdb4xshnU
         E3BX4PDUM4BBgXW3A7tyCAy0jaev8rHJ7E49J0Q6ik5kBH54Kx45rXrYv6PAbjqAnlKZ
         OP6IRaql2kfMWfUXfhGLP9fSsDm6inhcgmdOVNXQMdhB/gaGjzkZx2l8oZDmNJo/+Jvo
         GCeggSbUGGo0uaaLzDAklxt5wS1b2XApY59lC9x8Vf93DxzvfaVprQi7WW5g5ZvAqDTn
         faXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Is+DOcT8Igc7YLkCSkZJEYbaJMo6lo7wsCMqnBIM3m8=;
        b=SQhG03UWmW9Av7wcvJQApUGLVvnxQ+iAoACHXzYcQHvMIetuzHxfatbmEdQssCPpWn
         7MJVaGSAqJEFwphepe9DYIDNyRwe1L3QlT3bByru64R9xkYKNyiX9se9gCMX06hzlj7P
         HQlXps0dNZAMdpaqEwvS+jMEi0NjGLoSt4xyy0HvNvse2oQLO4pT+bP8YclNQUYJ5hYA
         zi02bwIIK+zL9jKRTEnTT/QghbFEg5uyxuOA5R02UoPUomV3kFekc8NV8zKN1t2/9iMr
         q6iSJ/b+MZ+l7Mz+WD0+Qc47M370DohKuaRrjZ481tzXmTZN6rZqwhB5hBVCTFQ7uu4+
         QHFw==
X-Gm-Message-State: ACgBeo0aBGqDEC/vhiuuv8GGgSuGvTQF37HYJG55+X2wfvgMJ5klqnoz
        nmuqwMWjSBSuLlMfoY8TNuagxQ==
X-Google-Smtp-Source: AA6agR67w3E4BUkZ6aZMi04k3ORgTI6m48dz0+cFIJ6xCaK3+Qo+Ycn28R4IGCll2/oM8gDv5/Pf1w==
X-Received: by 2002:a05:6512:282c:b0:492:b415:6def with SMTP id cf44-20020a056512282c00b00492b4156defmr1013226lfb.615.1660830517596;
        Thu, 18 Aug 2022 06:48:37 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id be32-20020a056512252000b0048a83ab2d32sm235123lfb.0.2022.08.18.06.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:48:36 -0700 (PDT)
Message-ID: <18164de9-ad28-939c-a802-69647fc65a37@linaro.org>
Date:   Thu, 18 Aug 2022 16:48:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
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
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-3-bchihi@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817080757.352021-3-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:07, bchihi@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.

Rebase your patchset on decent kernel tree. You seem to use something a
bit old.

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> new file mode 100644
> index 000000000000..31d9e220513a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -0,0 +1,152 @@
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
> +description: |
> +  LVTS (Low Voltage Thermal Sensor).
> +  The architecture will be first used on mt8192 and mt8195.
> +
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
> +    maxItems: 1
> +    description: LVTS instance registers.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: LVTS instance interrupts.
> +
> +  clocks:
> +    maxItems: 1
> +    description: LVTS instance clock.

Skip all these three descriptions. They are obvious.

> +
> +  resets:
> +    maxItems: 1
> +    description: |
> +      LVTS instance SW reset for HW AP/MCU domain to clean temporary data
> +      on HW initialization/resume.
> +
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description: Calibration efuse data for LVTS
> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    maxItems: 2
> +    description: Calibration efuse cell names for LVTS
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-lvts-ap
> +              - mediatek,mt8192-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:
> +          items:
> +            - description: Calibration efuse data for LVTS
> +
> +        nvmem-cell-names:
> +          items:
> +            - const: lvts_calib_data1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-lvts-ap
> +              - mediatek,mt8195-lvts-mcu
> +    then:
> +      properties:
> +        nvmem-cells:
> +          items:
> +            - description: Calibration efuse data 1 for LVTS
> +            - description: Calibration efuse data 2 for LVTS
> +
> +        nvmem-cell-names:
> +          items:
> +            - const: lvts_calib_data1
> +            - const: lvts_calib_data2
> +
> +required:
> +  - compatible
> +  - '#thermal-sensor-cells'

Use consistent quotes: either ' or "

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
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +    #include <dt-bindings/reset/mt8192-resets.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      lvts_ap: thermal-sensor@1100b000 {
> +        compatible = "mediatek,mt8192-lvts-ap";
> +        #thermal-sensor-cells = <1>;
> +        reg = <0 0x1100b000 0 0x1000>;

Convention is: compatible, then reg, then the rest of properties

> +        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
> +        nvmem-cells = <&lvts_e_data1>;
> +        nvmem-cell-names = "lvts_calib_data1";
> +      };
> +
> +      lvts_mcu: thermal-sensor@11278000 {
> +        compatible = "mediatek,mt8192-lvts-mcu";
> +        #thermal-sensor-cells = <1>;
> +        reg = <0 0x11278000 0 0x1000>;
> +        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&infracfg CLK_INFRA_THERM>;
> +        resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +        nvmem-cells = <&lvts_e_data1>;
> +        nvmem-cell-names = "lvts_calib_data1";
> +      };
> +    };

This part is the same as previous, so just skip it or replace with an
example which is different somehow.

Best regards,
Krzysztof
