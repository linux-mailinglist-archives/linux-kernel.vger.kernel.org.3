Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ABD534893
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbiEZCFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344428AbiEZCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:05:33 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F53101C2;
        Wed, 25 May 2022 19:05:32 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w130so738639oig.0;
        Wed, 25 May 2022 19:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChisiLO0bsSW3mWXz6BoXIcubu0hhX1WwidCN2NJ5Xs=;
        b=dVwbnO22o2lJa7TnL95+9Q8djwItS7TXrq7umduc6XDDiPckVHPFJnW8L9jX+zcGAF
         KTAmkTtVbc4Y3KujsDNXp0eAlSpelGlqO8//BGd23PGYpG0mnX402n9EiGI+VaDFlQi2
         oqGqV5929LblJYhKZZHmozP17nO0nGb5YXqpgpe80jVObuLuI023yjSNUrNRPWNNuNOo
         UVPl2rfcZKOIowyLbEBiZgTE4RPdHABFODTU+GtjK4IM3osXsJRQbcaEvzi1PIKfkvj3
         ISZlYtQYbPMHGsojVKWNlemnnHraFU8oHUmUI2OISBOxX5A39HvXW50w5lzoVgmCxXIz
         5Zyw==
X-Gm-Message-State: AOAM5301KoPm765g6jjz3LiBCJ5hQw32xiYbazzNwj4STYXsay/t4b7c
        2fJ04q7sZJYYkcTOVJlWiA==
X-Google-Smtp-Source: ABdhPJw+s4ts1U0RT6Kz+SuPmsS63MroSVk4RpangHXlIlCPwlPCRe4u5Bf1C8W6qkMcBU9s4R3QzQ==
X-Received: by 2002:a05:6808:199b:b0:329:92c:4a1e with SMTP id bj27-20020a056808199b00b00329092c4a1emr33497oib.214.1653530731400;
        Wed, 25 May 2022 19:05:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj39-20020a05680819a700b0032b7b588f3asm195674oib.46.2022.05.25.19.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:05:30 -0700 (PDT)
Received: (nullmailer pid 2907659 invoked by uid 1000);
        Thu, 26 May 2022 02:05:29 -0000
Date:   Wed, 25 May 2022 21:05:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v7 2/6] dt-bindings: thermal: Add binding document for
 LVTS thermal controllers
Message-ID: <20220526020529.GA2901912-robh@kernel.org>
References: <20220524152552.246193-1-abailon@baylibre.com>
 <20220524152552.246193-3-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152552.246193-3-abailon@baylibre.com>
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

On Tue, May 24, 2022 at 05:25:49PM +0200, Alexandre Bailon wrote:
> This patch adds binding document for mt8192 and mt8195 thermal
> controllers.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../thermal/mediatek,mt8192-lvts.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
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

Besides having an error, there is no need to reference this. It is 
applied to all nodes and you still have to list the properties here to 
define how many entries and what they are.

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

Need to define what each entry is.

> +
> +  nvmem-cell-names:
> +    items:
> +      - const: e_data1
> +      - const: e_data2

Wow, those are useful names.

> +
> +  resets:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Already has a type. Need to define how many entries and what each one is 
(if more than 1).

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

Drop unused label.

thermal-sensor@...

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
> -- 
> 2.35.1
> 
> 
