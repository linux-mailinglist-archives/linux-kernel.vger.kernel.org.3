Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4C44B4000
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbiBNDEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:04:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiBNDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:04:47 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116B50E33;
        Sun, 13 Feb 2022 19:04:39 -0800 (PST)
X-UUID: 1dccdf04fa5543f4a273866eb06de347-20220214
X-UUID: 1dccdf04fa5543f4a273866eb06de347-20220214
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 696984098; Mon, 14 Feb 2022 11:04:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Feb 2022 11:04:25 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 11:04:24 +0800
Message-ID: <3a13098517b4fc3bbba3960ec9d24060460b9c34.camel@mediatek.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file
 and binding document
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 14 Feb 2022 11:04:24 +0800
In-Reply-To: <YgZWg6NgiuqN4H7U@robh.at.kernel.org>
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
         <20220210062122.23974-2-guodong.liu@mediatek.com>
         <YgZWg6NgiuqN4H7U@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Rob Herring <robh@kernel.org>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <
matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Sean Wang <
sean.wang@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl
file and binding document
Date: Fri, 11 Feb 2022 06:28:51 -0600

On Thu, Feb 10, 2022 at 02:21:20PM +0800, Guodong Liu wrote:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      |  313 +++++
>  include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174
> +++++++++++++++++
>  2 files changed, 1487 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8186.yaml
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
> +      Number of cells in GPIO specifier. Since the generic GPIO
> binding is used,
> +      the amount of cells must be specified as 2. See the below
> +      mentioned gpio binding representation for description of
> particular cells.
> +    const: 2
> +
> +  gpio-ranges:
> +    description: gpio valid number range.

Don't need generic descriptions for common properties

Hi Rob

we will update it for next version.

Thanks
Guodong

> +    maxItems: 1
> +
> +  reg:
> +    description: |
> +      Physical address base for gpio base registers. There are 8
> different GPIO
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
Hi Rob

We will update it for next version.

Thanks
Guodong
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
Hi Rob

We will update it for next version.

Thanks
Guodong
> +    maxItems: 1
> +
> +  mediatek,rsel-resistance-in-si-unit:
> +    type: boolean
> +    description: |
> +      Identifying i2c pins pull up/down type which is RSEL. It can
> support
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
> +          A pinctrl node should contain at least one subnodes
> representing the
> +          pinctrl groups available on the machine. Each subnode will
> list the
> +          pins it needs, and how they should be configured, with
> regard to muxer
> +          configuration, pullups, drive strength, input
> enable/disable and
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
> +              Integer array, represents gpio pin number and mux
> setting.
> +              Supported pin number and mux varies for different
> SoCs, and are
> +              defined as macros in dt-bindings/pinctrl/<soc>-
> pinfunc.h
> +              directly.
> +
> +          drive-strength:
> +            enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +
> +          mediatek,drive-strength-adv:
> +            description: |
> +              Describe the specific driving setup property.
> +              For I2C pins, the existing generic driving setup can
> only support
> +              2/4/6/8/10/12/14/16mA driving. But in specific driving
> setup, they
> +              can support 0.125/0.25/0.5/1mA adjustment. If we
> enable specific
> +              driving setup, the existing generic setup will be
> disabled.
> +              The specific driving setup is controlled by E1E0EN.
> +              When E1=0/E0=0, the strength is 0.125mA.
> +              When E1=0/E0=1, the strength is 0.25mA.
> +              When E1=1/E0=0, the strength is 0.5mA.
> +              When E1=1/E0=1, the strength is 1mA.
> +              EN is used to enable or disable the specific driving
> setup.
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
> +              - description: mt8186 pull down PUPD/R0/R1 type define
> value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +              - description: mt8186 pull down RSEL type define
> value.
> +              - enum: [75000, 5000]
> +              - description: mt8186 pull down RSEL type si unit
> value(ohm).

This should fail validation. All the description entries are True, so 
oneOf will be False. Drop the '-' on description so the enum and 
description are 1 entry.
Hi Rob

We will update it for next version.

Thanks
Guodong
> +
> +            description: |
> +              For pull down type is normal, it don't need add RSEL &
> R1R0 define
> +              and resistance value.
> +              For pull down type is PUPD/R0/R1 type, it can add R1R0
> define to
> +              set different resistance. It can support
> "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8186.
> +              For pull down type is RSEL, it can add RSEL define &
> resistance
> +              value(ohm) to set different resistance by identifying
> property
> +              "mediatek,rsel-resistance-in-si-unit".
> +              It can support "MTK_PULL_SET_RSEL_000" &
> "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8186. It can also support resistance
> value(ohm)
> +              "75000" & "5000" in mt8186.
> +              An example of using RSEL define:

Perhaps move this to the example.
Hi Rob

Typically, I2C will config this type of pins as : "bias-pull-up =
<MTK_PULL_SET_RSEL_001>;", so we just move partial "bias-pull-up"
 description info to the example, and we will update it for next
version.

Thanks
Guodong
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
> +              - description: mt8186 pull up PUPD/R0/R1 type define
> value.
> +              - enum: [200, 201, 202, 203, 204, 205, 206, 207]
> +              - description: mt8186 pull up RSEL type define value.
> +              - enum: [1000, 1500, 2000, 3000, 4000, 5000, 10000,
> 75000]
> +              - description: mt8186 pull up RSEL type si unit
> value(ohm).
> +
> +            description: |
> +              For pull up type is normal, it don't need add RSEL &
> R1R0 define
> +              and resistance value.
> +              For pull up type is PUPD/R0/R1 type, it can add R1R0
> define to
> +              set different resistance. It can support
> "MTK_PUPD_SET_R1R0_00" &
> +              "MTK_PUPD_SET_R1R0_01" & "MTK_PUPD_SET_R1R0_10" &
> +              "MTK_PUPD_SET_R1R0_11" define in mt8186.
> +              For pull up type is RSEL, it can add RSEL define &
> resistance
> +              value(ohm) to set different resistance by identifying
> property
> +              "mediatek,rsel-resistance-in-si-unit".
> +              It can support "MTK_PULL_SET_RSEL_000" &
> "MTK_PULL_SET_RSEL_001"
> +              & "MTK_PULL_SET_RSEL_010" & "MTK_PULL_SET_RSEL_011"
> +              & "MTK_PULL_SET_RSEL_100" & "MTK_PULL_SET_RSEL_101"
> +              & "MTK_PULL_SET_RSEL_110" & "MTK_PULL_SET_RSEL_111"
> +              define in mt8186. It can also support resistance
> value(ohm)
> +              "1000" & "1500" & "2000" & "3000" & "4000" & "5000" &
> "10000" &
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

