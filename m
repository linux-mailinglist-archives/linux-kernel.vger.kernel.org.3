Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C15784D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiGROIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiGROIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:08:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE4B25EBB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:08:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d12so19494452lfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1JhvfwSerHJevbTjrgxZbFc36NslbyY4GFSoZTR74vE=;
        b=KE4D7qn9+mLkdL+4PkRQfxtQE9O4A17G+yqAJMBftSCdle6r2WivRGDH0OP4jDKB6L
         pQJV/tF8SiQ8QXpTy2X2gMpKkPOLwQonvFwaIGenPNyRcGwK+3XxYayUq/FYpxpG+59c
         D4pUDJMNV8sct8Slunl3k2nn3qiIpniVArOjeOApmXFo4Z32TbZDpg+qdb6+zIftoW0t
         nCYWhUTsSCvo8+AiHmcIh1ctAKjLAyweaETE015yUGO8TYEnjV+MyS2j//vxdpJHR9nU
         G58cYD/ATYHKnEm2R+sKAMn7ttduhjJnNDkBLULFUSP6W1Vzyn7TBjWi1Ht1Kxstu1/P
         +z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1JhvfwSerHJevbTjrgxZbFc36NslbyY4GFSoZTR74vE=;
        b=aWEJIU3c4HXrP7nH2M7Ni/l96szhN0khI7yhJuqjhvwann2L+rI0hGW/2Guge1QQKd
         T8VgMWMsi4+dyRiRXRBYmAW2V+tGf+VlyK7kAwWA2j2XLx/U1Yc7cEbC2TAARDjZ2NJd
         HQybka56QtbB3F/SO6QL+RWbF/ZS2yjXfQ1k2v8YkfItrLDyvBuTOzvzMjAHabzAT02e
         Zpn2wtoJ4FRM6jCHy8Gks3L4NB+88X9Uh+8JG0ztHslLWbBZ+ZsGY6avugSzsINqANNm
         677Uxknj4IF8Q5zwV7ap1FzKnqNefNAhquTZ7UlIYre8GW9Y5ikQQm27o8S5iojj49Y6
         n3YA==
X-Gm-Message-State: AJIora8rNvX2qIKjdkH/UlznQbdRXqOttlUh2Wgo9fuRt8n2fBTfza0+
        4xsLqLp/T8AvTp+Qdhh1uUchrQ==
X-Google-Smtp-Source: AGRyM1uA4X1ZcNACiUgMDBusnkLTOMJZhCjYj6GvRd0e8+DzhcDNpPkzzbvd/GVjQgAW+wjhDtT2yg==
X-Received: by 2002:a05:6512:4022:b0:48a:2c31:f26a with SMTP id br34-20020a056512402200b0048a2c31f26amr6529963lfb.94.1658153282930;
        Mon, 18 Jul 2022 07:08:02 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id n3-20020a05651203e300b00485e55192a3sm2404605lfq.72.2022.07.18.07.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:08:02 -0700 (PDT)
Message-ID: <b28dcbe5-d15f-1c4f-9b3d-650d5c39de6b@linaro.org>
Date:   Mon, 18 Jul 2022 16:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: add pinctrl definition for
 mt8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, johnson.wang@mediatek.com,
        zhiyong.tao@mediatek.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220718113813.23787-1-hui.liu@mediatek.com>
 <20220718113813.23787-2-hui.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220718113813.23787-2-hui.liu@mediatek.com>
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

On 18/07/2022 13:38, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> This commit adds mt8188 compatible node in binding document.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8188.yaml      | 306 ++++++++++++++++++
>  1 file changed, 306 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml
> new file mode 100644
> index 000000000000..43cc2424107f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml

vendor,soc-ip
so:
mediatek,mt8188-pinctrl.yaml

> @@ -0,0 +1,306 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8188.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 Pin Controller
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description: |
> +  The MediaTek's Pin controller is used to control SoC pins.

Too generic description. Just drop it or make it useful.

> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-pinctrl
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description: |
> +      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
> +      the amount of cells must be specified as 2. See the below
> +      mentioned gpio binding representation for description of particular cells.

Comment does not make sense.

> +    const: 2
> +
> +  gpio-ranges:
> +    description: gpio valid number range.

Redundant description, skip it.

> +    maxItems: 1
> +
> +  reg:
> +    description: |
> +      Physical address base for gpio base registers. There are 8 GPIO
> +      physical address base in mt8188.

Redundant description, skip it. You should list the instead and describe
each of it.

> +    maxItems: 8
> +
> +  reg-names:
> +    description: |
> +      Gpio base register names.

Redundant description, skip it.

> +    maxItems: 8

You need to list the items instead.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    description: The interrupt outputs to sysirq.
> +    maxItems: 1
> +
> +  mediatek,rsel_resistance_in_si_unit:

No underscores in property names.

> +    type: boolean
> +    description: |
> +      Identifying i2c pins pull up/down type which is RSEL. It can support
> +      RSEL define or si unit value(ohm) to set different resistance.

I cannot understand this description.

> +
> +# PIN CONFIGURATION NODES
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    additionalProperties: false

Blank line. Missing ref to proper generic pinctrl schema.

> +    patternProperties:
> +      '^pins':
> +        type: object
> +        additionalProperties: false

Blank line. Missing ref to proper generic pinctrl schema.


> +        description: |
> +          A pinctrl node should contain at least one subnodes representing the
> +          pinctrl groups available on the machine. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to muxer
> +          configuration, pullups, drive strength, input enable/disable and
> +          input schmitt.
> +          An example of using macro:
> +          pincontroller {
> +            /* GPIO0 set as multifunction GPIO0 */
> +            gpio-pins {
> +              pins {
> +                pinmux = <PINMUX_GPIO0__FUNC_B_GPIO0>;
> +              }
> +            };
> +            /* GPIO56 set as multifunction SDA0 */
> +            i2c0-pins {
> +              pins {
> +                pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
> +              }
> +            };

Drop the code from here. Put it in example.

> +          };
> +        $ref: "pinmux-node.yaml"

Oh, why it's here. This should be just after type.

> +
> +        properties:
> +          pinmux:
> +            description: |
> +              Integer array, represents gpio pin number and mux setting.
> +              Supported pin number and mux varies for different SoCs, and are
> +              defined as macros in dt-bindings/pinctrl/<soc>-pinfunc.h
> +              directly.
> +
> +          drive-strength:
> +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +
> +          mediatek,drive-strength-adv:
> +            description: |
> +              Describe the specific driving setup property.
> +              For I2C pins, the existing generic driving setup can only support
> +              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
> +              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
> +              driving setup, the existing generic setup will be disabled.
> +              The specific driving setup is controlled by E1E0EN.
> +              When E1=0/E0=0, the strength is 0.125mA.
> +              When E1=0/E0=1, the strength is 0.25mA.
> +              When E1=1/E0=0, the strength is 0.5mA.
> +              When E1=1/E0=1, the strength is 1mA.
> +              EN is used to enable or disable the specific driving setup.
> +              Valid arguments are described as below:
> +              0: (E1, E0, EN) = (0, 0, 0)
> +              1: (E1, E0, EN) = (0, 0, 1)
> +              2: (E1, E0, EN) = (0, 1, 0)
> +              3: (E1, E0, EN) = (0, 1, 1)
> +              4: (E1, E0, EN) = (1, 0, 0)
> +              5: (E1, E0, EN) = (1, 0, 1)
> +              6: (E1, E0, EN) = (1, 1, 0)
> +              7: (E1, E0, EN) = (1, 1, 1)
> +              So the valid arguments are from 0 to 7.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3, 4, 5, 6, 7]

No. Use logical units instead, so this should be either mA, no register
hard-coding in the bindings.

> +
> +          bias-pull-down:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]
> +                description: mt8188 pull down PUPD/R0/R1 type define value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +                description: mt8188 pull down RSEL type define value.
> +              - enum: [75000, 5000]
> +                description: mt8188 pull down RSEL type si unit value(ohm).
> +            description: |
> +              For pull down type is normal, it don't need add RSEL & R1R0 define
> +              and resistance value.
> +              For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
> +              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8188.
> +              For pull down type is RSEL, it can add RSEL define & resistance
> +              value(ohm) to set different resistance by identifying property
> +              "mediatek,rsel_resistance_in_si_unit".
> +              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8188. It can also support resistance value(ohm)
> +              "75000" & "5000" in mt8188.
> +
> +              An example of using RSEL define:
> +              pincontroller {
> +                i2c0_pin {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
> +                    bias-pull-updown = <MTK_PULL_SET_RSEL_001>;
> +                  }
> +                };
> +              };
> +              An example of using si unit resistance value(ohm):
> +              &pio {
> +                mediatek,rsel_resistance_in_si_unit;
> +              }
> +              pincontroller {
> +                i2c0_pin {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
> +                    bias-pull-down = <75000>;
> +                  }
> +                };
> +              };

To the example.

> +
> +          bias-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - enum: [100, 101, 102, 103]
> +                description: mt8188 pull up PUPD/R0/R1 type define value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +                description: mt8188 pull up RSEL type define value.
> +              - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
> +                description: mt8188 pull up RSEL type si unit value(ohm).
> +            description: |
> +              For pull up type is normal, it don't need add RSEL & R1R0 define
> +              and resistance value.
> +              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
> +              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8188.
> +              For pull up type is RSEL, it can add RSEL define & resistance
> +              value(ohm) to set different resistance by identifying property
> +              "mediatek,rsel_resistance_in_si_unit".
> +              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8188. It can also support resistance value(ohm)
> +              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
> +              "75000" in mt8188.
> +              An example of using RSEL define:
> +              pincontroller {
> +                i2c0-pins {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
> +                    bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +                  }
> +                };
> +              };
> +              An example of using si unit resistance value(ohm):
> +              &pio {
> +                mediatek,rsel_resistance_in_si_unit;
> +              }
> +              pincontroller {
> +                i2c0-pins {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>;
> +                    bias-pull-up = <1000>;
> +                  }
> +                };
> +              };

The same.

> +
> +          bias-disable: true
> +
> +          output-high: true
> +
> +          output-low: true
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +        required:
> +          - pinmux
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

No need for quotes, especially that you use different here " than in
other places '.



Best regards,
Krzysztof
