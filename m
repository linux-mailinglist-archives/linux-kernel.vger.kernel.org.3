Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334724D0BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbiCGXOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiCGXOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:14:07 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125A1EC77;
        Mon,  7 Mar 2022 15:13:12 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so4211520otq.13;
        Mon, 07 Mar 2022 15:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/DahnhrrL/jdB0W/TX4PSLrYdtNRildr05b0KSXkCI=;
        b=WF9PODNO7slZyaOxxW8j3epZMkQzX9oVqQlrDj6d6+iPpEZjBS6gYMSXrguQV4xQpI
         kOsSFq6Ccq1FLrVFLzLqFNbiCzgGo/uM6V82zSl7UPgUCKJoEKh10jvhfiAOkuCTpKlb
         18m6ngtig3/VGlwHtDq68WlBAFlwAlcL2wixDCxUvVIRSICOCfHIEiKOxkW8Z9pc4RAP
         2NQXEqTR0m6osY85kSDJHVIzLV1lYk7wEMUxsRVR1RDzueEh0XIQloTf/LIUjTf6GQHX
         3spLwmLdBvGMB1U8XT51ABAb2OJQFFBLv4tGy82U4ncySDPnNdG2ItUlk5ojoYSS5hGN
         02dQ==
X-Gm-Message-State: AOAM532kOPzrPvULaVM/bQyN1/YQSQwWmOXcVcC51bMz6UUxCW9HaKXW
        81O4oCstNWlcmGRUyG23Jw==
X-Google-Smtp-Source: ABdhPJz5YrAJp5ahVdp+farn9/jwvddcBMFpjQ8JynmRqN9lTMELxi2ky9lAb04HsWWkxDZTDgMR3A==
X-Received: by 2002:a05:6830:165a:b0:5af:12dc:65e5 with SMTP id h26-20020a056830165a00b005af12dc65e5mr6983650otr.30.1646694792187;
        Mon, 07 Mar 2022 15:13:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 69-20020a9d0bcb000000b005af83322c6asm6917909oth.12.2022.03.07.15.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:13:11 -0800 (PST)
Received: (nullmailer pid 3439393 invoked by uid 1000);
        Mon, 07 Mar 2022 23:13:10 -0000
Date:   Mon, 7 Mar 2022 17:13:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com
Subject: Re: [PATCH v4 1/7] dt bindings: remoteproc: Add bindings for the
 MT8183 APU
Message-ID: <YiaRhu+tSg7+ZH16@robh.at.kernel.org>
References: <20220304161514.994128-1-abailon@baylibre.com>
 <20220304161514.994128-2-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161514.994128-2-abailon@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:15:08PM +0100, Alexandre Bailon wrote:
> This adds dt bindings for the APU present in the MT8183.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../bindings/remoteproc/mtk,apu.yaml          | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> new file mode 100644
> index 000000000000..b640aa96d678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/mtk,apu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek AI Processor Unit (APU)
> +
> +description:
> +  This document defines the binding for the APU, a co-processor that could
> +  offload the CPU for machine learning and neural network.
> +
> +maintainers:
> +  - Alexandre Bailon <abailon@bayLibre.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8183-apu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: ipu
> +      - const: jtag
> +
> +  iommus:
> +    maxItems: 3
> +
> +  memory-region:
> +    maxItems: 3
> +
> +  memory-region-da:
> +    description:
> +      Array of APU device address. This is used to map the APU device address
> +      to a physical address.
> +    maxItems: 3

'dma-ranges' should work for this.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  pinctrl:
> +    description: pinctrl handles, required to configure pins for JTAG.
> +
> +  pinctrl-names:
> +    items:
> +      - const: jtag
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - iommus
> +  - memory-region
> +  - memory-region-da
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +
> +    reserved-memory {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +
> +      vdev0buffer: vdev0buffer@52900000 {
> +        compatible = "shared-dma-pool";
> +        reg = <0x52900000 0x4000>;
> +        no-map;
> +      };
> +
> +      vdev0vring0: vdev0vring0@52904000 {
> +        compatible = "shared-dma-pool";
> +        reg = <0x52904000 0x2000>;
> +        no-map;
> +      };
> +
> +      vdev0vring1: vdev0vring1@52906000 {
> +        compatible = "shared-dma-pool";
> +        reg = <0x52906000 0x2000>;
> +        no-map;
> +      };
> +    };
> +
> +    apu0: apu@19100000 {
> +      compatible = "mediatek,mt8183-apu";
> +      reg = <0x19180000 0x14000>;
> +      interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
> +
> +      iommus = <&iommu M4U_PORT_IMG_IPUO>,
> +         <&iommu M4U_PORT_IMG_IPU3O>,
> +         <&iommu M4U_PORT_IMG_IPUI>;
> +
> +      clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
> +         <&ipu_core0 CLK_IPU_CORE0_IPU>,
> +         <&ipu_core0 CLK_IPU_CORE0_JTAG>;
> +
> +      clock-names = "axi", "ipu", "jtag";
> +
> +      power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
> +      memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>;
> +      memory-region-da = <0x6fff8000>, <0x6fffc000>, <0x6fffe000>;
> +    };
> +...
> -- 
> 2.34.1
> 
> 
