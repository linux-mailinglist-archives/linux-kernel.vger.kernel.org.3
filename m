Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968C7534FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiEZM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEZM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:58:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099545C767;
        Thu, 26 May 2022 05:58:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 996081F45608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653569889;
        bh=Pxy52o+lM2XaDOLsjbwjyhew5a/i/1lMjk2kvPzvEYs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h4XZLqWW1UodqgwGvGfUppm/Pacgx73ML19oAAIJIIBs1+VwHCmw4/hlB6DFCN45i
         TVenv+dx+YuUHCmLnyQtNwkB/1S0LauCYcJ34pDOAmhYjNJ8oYF1JYBqwJmK7bXApG
         3w6lsSDO3H1lZiYZvA/YT4nhqlvVVs2XnuJikgv1GJyJFAs3QDlwgrnrqBER0Bmcj9
         nrG9wJ4xeNqNfuScapX1mEyDSlYk+FN4DC6wt0mju3U5tkeVv20EE+X/rnjG4F+JQe
         eJCgkq3l+v6/aUEC8sfn6Fckfcoo2lWCb9r9/amXCwm/6cgKS0HofyHilyEtBpj6Mr
         OdQ6rKgRctCpA==
Message-ID: <76367ac4-15ad-553e-9c88-6464622f393f@collabora.com>
Date:   Thu, 26 May 2022 14:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20220524152552.246193-1-abailon@baylibre.com>
 <20220524152552.246193-3-abailon@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220524152552.246193-3-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/05/22 17:25, Alexandre Bailon ha scritto:
> This patch adds binding document for mt8192 and mt8195 thermal
> controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>   .../thermal/mediatek,mt8192-lvts.yaml         | 81 +++++++++++++++++++
>   1 file changed, 81 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> new file mode 100644
> index 000000000000..914c877d1f2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/mediatek,mt8192-lvts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoC LVTS thermal controller
> +
> +maintainers:
> +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> +  - Ben Tseng <ben.tseng@mediatek.com>
> +
> +allOf:
> +  - $ref: thermal-sensor.yaml#
> +  - $ref: /nvmem/nvmem-consumer.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8192-lvts
> +      - mediatek,mt8195-lvts
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 4
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description: Calibration data for thermal sensors
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: e_data1
> +      - const: e_data2

 From what I understand, each nvmem cell has calibration data for each thermal
sensor, so let's use some more descriptive names...
some ideas: "lvts1-calib" "lvts1-cal" "calib1".

Also, I think that the best option is to register one driver instance for each
hardware instance, meaning that you should have only one reg, only one nvmem-cell,
only one reset, only one interrupt. This makes it possible to have as many
LVTS instances as possible without any code adjustments in the future.

An example for MT8195:

thermal-sensor@1100b000 {
	compatible = "mediatek,mt8195-lvts";
	reg = <0 0x1100b000 0 0x1000>;
	interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
	#thermal-sensor-cells = <1>;
	clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
	nvmem-cells = <&lvts_e_data1>;
	nvmem-cell-names = "calibration";

	/* is this a reset for lvts1? */
	resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
};

thermal-sensor@11278000 {
	compatible = "mediatek,mt8195-lvts";
	reg = <0 0x11278000 0 0x1000>;
	interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
	#thermal-sensor-cells = <1>;
	clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
	nvmem-cells = <&lvts_e_data2>;
	nvmem-cell-names = "calibration";

	/* is this a reset for lvts2? */
	resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
};

In the future, a new MediaTek SoC may simply define more nodes..... :-)

> +
> +  resets:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +
> +required:
> +  - '#thermal-sensor-cells'
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - nvmem-cells
> +  - nvmem-cell-names
> +  - resets
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
> +    lvts: lvts@1100b000 {

Please use generic names: this should be thermal-sensor@1100b000

> +        compatible = "mediatek,mt8195-lvts";
> +        #thermal-sensor-cells = <1>;
> +        reg = <0 0x1100b000 0 0x1000>,
> +              <0 0x11278000 0 0x1000>;
> +        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +        resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>,
> +                 <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +        nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
> +        nvmem-cell-names = "e_data1","e_data2";
> +    };
> +...

