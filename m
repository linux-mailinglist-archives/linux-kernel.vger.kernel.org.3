Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6329D4B25BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiBKM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:29:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350110AbiBKM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:29:08 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C963AFCA;
        Fri, 11 Feb 2022 04:28:56 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id k25so8870876qtp.4;
        Fri, 11 Feb 2022 04:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQ7t2s41KR46XW+SKpqA/NdZOvbeY/VcC/0Qbk2166s=;
        b=4HWZOjcvB+oxZocSN79quCSxkHyE1GtSmuphCv/aDL9ClVTxejKAo9OlrMp/+3pctv
         qIpbulpL7dV13WLh5TKOCPgHQw0iGw9HE6/hOALjZPybQHEbIxJOp5KN/5OXpC3wAOE1
         NcDpME/1uP+8AwJVErBWAMexkUkmFG6jjAZdOdTVLoKylaeNahPPlI8L8I9NVExiQPky
         LVxOnLU77HNwVKqRShSh/d3R9Ld9lsnog4lEAyGkFy+UD4GZoDdGIYH5DoGRKnhCB7kC
         3n+1aZua+YatuT/ztrDTAHIYlPU8gO7UIBHfYHCjN0C5PiI7ZAXdirWnPSUlYNywfF+1
         Y1Fw==
X-Gm-Message-State: AOAM533uQBMF1ch7UCUKLCY5mmOXnlF/qiGeM1NviuM1aXiQybOriC19
        3KHhbuZX53YNxGxQPeE8cg==
X-Google-Smtp-Source: ABdhPJxF+Fg+zK3nkizcVQFSiaGm7FGXCh5j8GQuEKbpxnzTTpnMNnFnBzziWvacEaI31gspbiIf8g==
X-Received: by 2002:a05:622a:289:: with SMTP id z9mr839932qtw.520.1644582535606;
        Fri, 11 Feb 2022 04:28:55 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d4:10b7:69a2:33cd:1782:fb47])
        by smtp.gmail.com with ESMTPSA id h20sm5155793qtk.21.2022.02.11.04.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:28:54 -0800 (PST)
Received: (nullmailer pid 164793 invoked by uid 1000);
        Fri, 11 Feb 2022 12:28:51 -0000
Date:   Fri, 11 Feb 2022 06:28:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file
 and binding document
Message-ID: <YgZWg6NgiuqN4H7U@robh.at.kernel.org>
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
 <20220210062122.23974-2-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210062122.23974-2-guodong.liu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:21:20PM +0800, Guodong Liu wrote:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      |  313 +++++
>  include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174 +++++++++++++++++
>  2 files changed, 1487 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> new file mode 100644
> index 000000000000..54c9508af922
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> @@ -0,0 +1,313 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8186.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8186 Pin Controller
> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description: |
> +  The Mediatek's Pin controller is used to control SoC pins.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8186-pinctrl
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description: |
> +      Number of cells in GPIO specifier. Since the generic GPIO binding is used,
> +      the amount of cells must be specified as 2. See the below
> +      mentioned gpio binding representation for description of particular cells.
> +    const: 2
> +
> +  gpio-ranges:
> +    description: gpio valid number range.

Don't need generic descriptions for common properties

> +    maxItems: 1
> +
> +  reg:
> +    description: |
> +      Physical address base for gpio base registers. There are 8 different GPIO
> +      physical address base in mt8186.
> +    maxItems: 8
> +
> +  reg-names:
> +    description: |
> +      Gpio base register names.
> +    items:
> +      - const: "iocfg0"
> +      - const: "iocfg_bm"
> +      - const: "iocfg_bl"
> +      - const: "iocfg_br"
> +      - const: "iocfg_lm"
> +      - const: "iocfg_rb"
> +      - const: "iocfg_tl"
> +      - const: "eint"

Don't need quotes

> +    maxItems: 8
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    description: The interrupt outputs to sysirq.

Drop.

> +    maxItems: 1
> +
> +  mediatek,rsel-resistance-in-si-unit:
> +    type: boolean
> +    description: |
> +      Identifying i2c pins pull up/down type which is RSEL. It can support
> +      RSEL define or si unit value(ohm) to set different resistance.
> +
> +# PIN CONFIGURATION NODES
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      '^pins':
> +        type: object
> +        additionalProperties: false
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
> +                pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
> +              }
> +            };
> +            /* GPIO128 set as multifunction SDA0 */
> +            i2c0-pins {
> +              pins {
> +                pinmux = <PINMUX_GPIO128__FUNC_SDA0>;
> +              }
> +            };
> +          };
> +        $ref: "pinmux-node.yaml"
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
> +
> +          bias-pull-down:
> +            oneOf:
> +              - enum: [100, 101, 102, 103]
> +              - description: mt8186 pull down PUPD/R0/R1 type define value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +              - description: mt8186 pull down RSEL type define value.
> +              - enum: [75000, 5000]
> +              - description: mt8186 pull down RSEL type si unit value(ohm).

This should fail validation. All the description entries are True, so 
oneOf will be False. Drop the '-' on description so the enum and 
description are 1 entry.

> +
> +            description: |
> +              For pull down type is normal, it don't need add RSEL & R1R0 define
> +              and resistance value.
> +              For pull down type is PUPD/R0/R1 type, it can add R1R0 define to
> +              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8186.
> +              For pull down type is RSEL, it can add RSEL define & resistance
> +              value(ohm) to set different resistance by identifying property
> +              "mediatek,rsel-resistance-in-si-unit".
> +              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8186. It can also support resistance value(ohm)
> +              "75000" & "5000" in mt8186.
> +              An example of using RSEL define:

Perhaps move this to the example.

> +              pincontroller {
> +                i2c0_pin {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO128__FUNC_SDA0>;
> +                    bias-pull-down = <MTK_PULL_SET_RSEL_001>;
> +                  }
> +                };
> +              };
> +              An example of using si unit resistance value(ohm):
> +              &pio {
> +                mediatek,rsel-resistance-in-si-unit;
> +              }
> +              pincontroller {
> +                i2c0_pin {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO128__FUNC_SDA0>;
> +                    bias-pull-down = <75000>;
> +                  }
> +                };
> +              };
> +
> +          bias-pull-up:
> +            oneOf:
> +              - enum: [100, 101, 102, 103]
> +              - description: mt8186 pull up PUPD/R0/R1 type define value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +              - description: mt8186 pull up RSEL type define value.
> +              - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000, 75000]
> +              - description: mt8186 pull up RSEL type si unit value(ohm).
> +
> +            description: |
> +              For pull up type is normal, it don't need add RSEL & R1R0 define
> +              and resistance value.
> +              For pull up type is PUPD/R0/R1 type, it can add R1R0 define to
> +              set different resistance. It can support "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8186.
> +              For pull up type is RSEL, it can add RSEL define & resistance
> +              value(ohm) to set different resistance by identifying property
> +              "mediatek,rsel-resistance-in-si-unit".
> +              It can support "MTK_PULL_SET_RSEL_000" & "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8186. It can also support resistance value(ohm)
> +              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" & "10000" &
> +              "75000" in mt8186.
> +              An example of using RSEL define:
> +              pincontroller {
> +                i2c0-pins {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO128__FUNC_SDA0>;
> +                    bias-pull-up = <MTK_PULL_SET_RSEL_001>;
> +                  }
> +                };
> +              };
> +              An example of using si unit resistance value(ohm):
> +              &pio {
> +                mediatek,rsel-resistance-in-si-unit;
> +              }
> +              pincontroller {
> +                i2c0-pins {
> +                  pins {
> +                    pinmux = <PINMUX_GPIO128__FUNC_SDA0>;
> +                    bias-pull-up = <1000>;
> +                  }
> +                };
> +              };
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
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pio: pinctrl@10005000 {
> +      compatible = "mediatek,mt8186-pinctrl";
> +      reg = <0x10005000 0x1000>,
> +            <0x10002000 0x0200>,
> +            <0x10002200 0x0200>,
> +            <0x10002400 0x0200>,
> +            <0x10002600 0x0200>,
> +            <0x10002A00 0x0200>,
> +            <0x10002c00 0x0200>,
> +            <0x1000b000 0x1000>;
> +      reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
> +                  "iocfg_br", "iocfg_lm", "iocfg_rb",
> +                  "iocfg_tl", "eint";
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      gpio-ranges = <&pio 0 0 185>;
> +      interrupt-controller;
> +      interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH 0>;
> +      #interrupt-cells = <2>;
> +
> +      pio-pins {
> +        pins {
> +          pinmux = <PINMUX_GPIO0__FUNC_GPIO0>;
> +          output-low;
> +        };
> +      };
> +
> +      spi0-pins {
> +        pins-spi {
> +          pinmux = <PINMUX_GPIO0__FUNC_SPI0_CLK_B>,
> +                   <PINMUX_GPIO1__FUNC_SPI0_CSB_B>,
> +                   <PINMUX_GPIO2__FUNC_SPI0_MO_B>;
> +          bias-disable;
> +        };
> +        pins-spi-mi {
> +          pinmux = <PINMUX_GPIO3__FUNC_SPI0_MI_B>;
> +          bias-pull-down;
> +        };
> +      };
> +
> +      i2c0-pins {
> +        pins {
> +          pinmux = <PINMUX_GPIO127__FUNC_SCL0>,
> +                   <PINMUX_GPIO128__FUNC_SDA0>;
> +          bias-disable;
> +          mediatek,drive-strength-adv = <7>;
> +        };
> +      };
> +    };
