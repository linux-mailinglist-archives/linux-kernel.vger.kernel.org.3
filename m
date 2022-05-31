Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B0539836
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiEaUq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiEaUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:46:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6208B0A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:46:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so881326ejq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KcvmS0RVCH7dS0drP08+taDktOji7A6kv3U7tUCF6Ik=;
        b=HTr4rtci7pN7h0V00Ch+MPN8QFo2ca3cbuR97hJFCjr/w9xXjQBq2dVHkwu2xOQxuP
         1BAcI7MDZnyoPC+UpdTeLBJPlg2PhTf6pVAwFMZWgaAMuCIAkFRoqjReMoODOOjmEMJX
         IjUtvCCX1SazMLSX9dPPH4ll/fvXY9zNkCpWYWWm6qiRiNScCJ5X+FtKaejGXadsVW5p
         Lz/guvnDDwLOuKIEGKL0cTmlihLsXks9QmOOfUl3nvKkS4hvGf3sf1rozyplnW3X71yG
         o2gtsW2bOmKqoFZiVYnKs8AIcYfZFHvPWTEsCleu1N6AOYbrFfsieqmW/d1LzaiWM6l2
         +aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KcvmS0RVCH7dS0drP08+taDktOji7A6kv3U7tUCF6Ik=;
        b=B5WpzN7pYb+Zf05IYntHbIbx8Vy5I94ROK/RSQ9i9t9chXU6IVh212GaFpufcCAq5B
         2aqrhUDgu0+kvun+d1u4A0hblBPxOdhQaYRS9R1BsqAfskx2mILx90sSClxhQKkqnx0M
         TksMO9E9Q+jDkYZ1zxQUVn3DNDvcuv4y7kDI/nNeOOKAtrjVdc0v5Uq0hQC18IO/yUY6
         lP/jxTNqAauzdlZ01x4BHn/ikqdOWFIOD8ZSpBeei7g5wKP4cCgZkMyRdBdPUDWPj2PL
         MRotv/LkvWi4VotO5zZe3NIHrQeTpdTpK2wiN9KvVjeoR/xQVQG2TqOSrNJ39Z9D9QxX
         Vq0w==
X-Gm-Message-State: AOAM5322MbErRVXhd97UjsUGTzawgmCuEFIQs+ZaQJDs5ISVCHUQzKFs
        IiQ3MzPrQ4+NP0A+5eOUwIDFXQ==
X-Google-Smtp-Source: ABdhPJxKQIk0np3addOYv0X6i3FNyMcBrbHc8niPiUYWepcaSBJXVhBWS9DiYV743l/82t3zhs6jFw==
X-Received: by 2002:a17:906:685:b0:6fa:8e17:e9b5 with SMTP id u5-20020a170906068500b006fa8e17e9b5mr57334212ejb.522.1654029981975;
        Tue, 31 May 2022 13:46:21 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k2-20020a1709063e0200b006f3ef214e5bsm5182391eji.193.2022.05.31.13.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 13:46:21 -0700 (PDT)
Message-ID: <4ac3dc81-98e5-8c94-8dd4-b30ee587eb42@linaro.org>
Date:   Tue, 31 May 2022 22:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 14/14] dt-bindings: mfd: Add Mediatek MT6370 binding
 documentation
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
 <20220531102809.11976-15-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531102809.11976-15-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 12:28, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 binding documentation.

Subject: same as previous patches.

> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/mfd/mediatek,mt6370.yaml         | 282 ++++++++++++++++++
>  .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |  18 ++
>  include/dt-bindings/mfd/mediatek,mt6370.h     |  83 ++++++
>  3 files changed, 383 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
>  create mode 100644 include/dt-bindings/mfd/mediatek,mt6370.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> new file mode 100644
> index 000000000000..96a12dce0108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> @@ -0,0 +1,282 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6370.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6370 SubPMIC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  MT6370 is a highly-integrated smart power management IC, which includes a
> +  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-C &
> +  Power Delivery (PD) controller, dual flash LED current sources, a RGB LED
> +  driver, a backlight WLED driver, a display bias driver and a general LDO for
> +  portable devices.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370
> +
> +  reg:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  adc:
> +    type: object
> +    description: |
> +      List the compatible configurations of MT6370 ADC.

This sentence does not make any sense. The "description" field is to
describe, explain the meaning behind given property.

> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt6370-adc
> +
> +      "#io-channel-cells":
> +        const: 1
> +
> +    required:
> +      - compatible
> +      - '#io-channel-cells'
> +
> +  backlight:
> +    type: object
> +    $ref: /schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
> +
> +  charger:
> +    type: object
> +    $ref: /schemas/power/supply/mediatek,mt6370-charger.yaml#
> +
> +  tcpc:
> +    type: object
> +    $ref: /schemas/usb/mediatek,mt6370-tcpc.yaml#
> +
> +  indicator:
> +    type: object
> +    $ref: /schemas/leds/mediatek,mt6370-indicator.yaml#
> +
> +  flashlight:
> +    type: object
> +    $ref: /schemas/leds/mediatek,mt6370-flashlight.yaml#
> +
> +  regulators:
> +    type: object
> +    description: |
> +      List all supported regulators

Ditto

> +
> +    patternProperties:
> +      "^(dsvbst|vibldo)$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +      "^(dsvpos|dsvneg)$":
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +        properties:
> +          enable-gpio:
> +            maxItems: 1
> +            description: |
> +              Specify a valid 'enable' gpio for the regulator and it's optional

Same comment as your patch #10.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - regulators
> +  - adc
> +  - backlight
> +  - indicator
> +  - tcpc
> +  - charger
> +  - flashlight
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +    #include <dt-bindings/mfd/mediatek,mt6370.h>
> +    #include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      mt6370@34 {

Generic node name, so "pmic".

> +        compatible = "mediatek,mt6370";
> +        reg = <0x34>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        mt6370_adc: adc {
> +          compatible = "mediatek,mt6370-adc";
> +          #io-channel-cells = <1>;
> +        };
> +
> +        backlight {
> +          compatible = "mediatek,mt6370-backlight";
> +          mediatek,bled-channel-use = /bits/ 8 <15>;
> +        };
> +
> +        charger {
> +          compatible = "mediatek,mt6370-charger";
> +          interrupts = <MT6370_IRQ_ATTACH>, <MT6370_IRQ_OVPCTRL_UVP_D>,
> +                       <MT6370_IRQ_CHG_MIVR>;
> +          interrupt-names = "attach_i", "uvp_d_evt", "mivr";
> +          io-channels = <&mt6370_adc MT6370_CHAN_IBUS>;
> +
> +          mt6370_otg_vbus: usb-otg-vbus {
> +            regulator-compatible = "mt6370,otg-vbus";
> +            regulator-name = "usb-otg-vbus";
> +            regulator-min-microvolt = <4350000>;
> +            regulator-max-microvolt = <5800000>;
> +            regulator-min-microamp = <500000>;
> +            regulator-max-microamp = <3000000>;
> +          };
> +        };
> +
> +        indicator {
> +          compatible = "mediatek,mt6370-indicator";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          multi-led@0 {
> +            reg = <0>;
> +            function = LED_FUNCTION_INDICATOR;
> +            color = <LED_COLOR_ID_RGB>;
> +            led-max-microamp = <24000>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            mediatek,soft-start = <3>;
> +              led@0 {

Messed up indentation.

> +                reg = <0>;
> +                color = <LED_COLOR_ID_RED>;
> +              };
> +              led@1 {
> +                reg = <1>;
> +                color = <LED_COLOR_ID_GREEN>;
> +              };
> +              led@2 {
> +                reg = <2>;
> +                color = <LED_COLOR_ID_BLUE>;
> +              };
> +            };
> +          led@3 {
> +            reg = <3>;
> +            function = LED_FUNCTION_INDICATOR;
> +            color = <LED_COLOR_ID_WHITE>;
> +            led-max-microamp = <6000>;
> +          };
> +        };
> +
> +        flashlight {
> +          compatible = "mediatek,mt6370-flashlight";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          led@0 {
> +            reg = <0>;
> +            led-sources = <0>;
> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            function-enumerator = <1>;
> +            led-max-microamp = <200000>;
> +            flash-max-microamp = <500000>;
> +            flash-max-timeout-us = <1248000>;
> +          };
> +          led@1 {
> +            reg = <1>;
> +            led-sources = <1>;
> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            function-enumerator = <2>;
> +            led-max-microamp = <200000>;
> +            flash-max-microamp = <500000>;
> +            flash-max-timeout-us = <1248000>;
> +          };
> +        };
> +
> +        tcpc {
> +          compatible = "mediatek,mt6370-tcpc";
> +          interrupts-extended = <&gpio26 4 IRQ_TYPE_LEVEL_LOW>;
> +
> +          connector {
> +            compatible = "usb-c-connector";
> +            label = "USB-C";
> +            vbus-supply = <&mt6370_otg_vbus>;
> +            data-role = "dual";
> +            power-role = "dual";
> +            try-power-role = "sink";
> +            source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +            sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +            op-sink-microwatt = <10000000>;
> +
> +            ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                reg = <0>;
> +                endpoint {
> +                  remote-endpoint = <&usb_hs>;
> +                };
> +              };
> +              port@1 {
> +                reg = <1>;
> +                endpoint {
> +                  remote-endpoint = <&usb_ss>;
> +                };
> +              };
> +              port@2 {
> +                reg = <2>;
> +                endpoint {
> +                  remote-endpoint = <&dp_aux>;
> +                };
> +              };
> +            };
> +          };
> +        };
> +
> +        regulators {
> +          dsvbst {
> +            regulator-name = "mt6370-dsv-vbst";
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <6200000>;
> +          };
> +          dsvpos {
> +            regulator-name = "mt6370-dsv-vpos";
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <6000000>;
> +            regulator-boot-on;
> +          };
> +          dsvneg {
> +            regulator-name = "mt6370-dsv-vneg";
> +            regulator-min-microvolt = <4000000>;
> +            regulator-max-microvolt = <6000000>;
> +            regulator-boot-on;
> +          };
> +          vibldo {
> +            regulator-name = "mt6370-vib-ldo";
> +            regulator-min-microvolt = <1600000>;
> +            regulator-max-microvolt = <4000000>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h b/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> new file mode 100644
> index 000000000000..18ce2fef8f9e
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Same license as bindings, please.

> +
> +#ifndef __DT_BINDINGS_MEDIATEK_MT6370_ADC_H__
> +#define __DT_BINDINGS_MEDIATEK_MT6370_ADC_H__
> +
> +/* ADC Channel Index */
> +#define MT6370_CHAN_VBUSDIV5	0
> +#define MT6370_CHAN_VBUSDIV2	1
> +#define MT6370_CHAN_VSYS	2
> +#define MT6370_CHAN_VBAT	3
> +#define MT6370_CHAN_TS_BAT	4
> +#define MT6370_CHAN_IBUS	5
> +#define MT6370_CHAN_IBAT	6
> +#define MT6370_CHAN_CHG_VDDP	7
> +#define MT6370_CHAN_TEMP_JC	8
> +#define MT6370_CHAN_MAX		9
> +
> +#endif
> diff --git a/include/dt-bindings/mfd/mediatek,mt6370.h b/include/dt-bindings/mfd/mediatek,mt6370.h
> new file mode 100644
> index 000000000000..df641e5d651f
> --- /dev/null
> +++ b/include/dt-bindings/mfd/mediatek,mt6370.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Same license as bindings, please.

> +
> +#ifndef __DT_BINDINGS_MEDIATEK_MT6370_H__
> +#define __DT_BINDINGS_MEDIATEK_MT6370_H__
> +
> +/* IRQ definitions */

> +#define MT6370_IRQ_DIRCHGON		0
> +#define MT6370_IRQ_CHG_TREG		4

These should be IDs, so numbers incremented by one. Holes are not
accepted. There is no point in encoding actual hardware numbers which
are directly passed to implementation. Just pass the number, not define.
Therefore remove entire file.

> +#define MT6370_IRQ_CHG_AICR		5
> +#define MT6370_IRQ_CHG_MIVR		6
> +#define MT6370_IRQ_PWR_RDY		7
> +#define MT6370_IRQ_FL_CHG_VINOVP	11
Best regards,
Krzysztof
