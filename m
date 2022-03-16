Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB54DB166
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbiCPN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356390AbiCPN15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:27:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078345FF2E;
        Wed, 16 Mar 2022 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647437203; x=1678973203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vnRswGehRJLFAaBCzvBCJdjOnc3qj7r4WnbNFLMazzs=;
  b=bLsjJb77BDQAz8l4zvmsDoGWXO2wyOzRjtM+EjqJDhMcW/wZ80J5iO1G
   rpO6ca7jQfR4ztX+PJHiBOwmuTq2KzuSMpNsz4cF/qZNiGHjl84H7K3z/
   XuxvpUrshvf43G7Kt1ZBmNfPiLKB51pUYs84rb5587bJv28QXnqwFIxg2
   nWvhElsTCk+O/fDJJGcX3vkDsuhIeHubgcWdOHUeVfXvlX3tdlRxRtNvD
   4boyTXbJ5Mdn/aSYIo3IOu1Weu9YXpmC9IIbVe4Gp+aPFPiexo1dy7UX2
   P5NaGN69CidL7a3bl+Ea7LrGWBcq0r1YIe4Jg552XhapjAyQf3DyAa/Ty
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256311559"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256311559"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:26:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="634975950"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:26:36 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id A50C620090;
        Wed, 16 Mar 2022 15:26:34 +0200 (EET)
Date:   Wed, 16 Mar 2022 15:26:34 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 7/9] dt-bindings: media: Add Allwinner A83T MIPI CSI-2
 bindings documentation
Message-ID: <YjHlisNfdobeAta7@paasikivi.fi.intel.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
 <20220302220739.144303-8-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302220739.144303-8-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thanks for the patch.

On Wed, Mar 02, 2022 at 11:07:37PM +0100, Paul Kocialkowski wrote:
> This introduces YAML bindings documentation for the Allwinner A83T
> MIPI CSI-2 controller.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../media/allwinner,sun8i-a83t-mipi-csi2.yaml | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
> new file mode 100644
> index 000000000000..75121b402435
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/allwinner,sun8i-a83t-mipi-csi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A83T MIPI CSI-2 Device Tree Bindings
> +
> +maintainers:
> +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun8i-a83t-mipi-csi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock
> +      - description: MIPI-specific Clock
> +      - description: Misc CSI Clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: mod
> +      - const: mipi
> +      - const: misc
> +
> +  resets:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Input port, connect to a MIPI CSI-2 sensor
> +
> +        properties:
> +          reg:
> +            const: 0
> +
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1

Does the hardware support lane reordering? If not, the property should be
omitted here.

I can also remove the three lines here while applying the patches.

> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +            required:
> +              - data-lanes
> +
> +        additionalProperties: false
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Output port, connect to a CSI controller
> +
> +        properties:
> +          reg:
> +            const: 1
> +
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +        additionalProperties: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/sun8i-a83t-ccu.h>
> +    #include <dt-bindings/reset/sun8i-a83t-ccu.h>
> +
> +    mipi_csi2: csi@1cb1000 {
> +        compatible = "allwinner,sun8i-a83t-mipi-csi2";
> +        reg = <0x01cb1000 0x1000>;
> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&ccu CLK_BUS_CSI>,
> +                 <&ccu CLK_CSI_SCLK>,
> +                 <&ccu CLK_MIPI_CSI>,
> +                 <&ccu CLK_CSI_MISC>;
> +        clock-names = "bus", "mod", "mipi", "misc";
> +        resets = <&ccu RST_BUS_CSI>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            mipi_csi2_in: port@0 {
> +                reg = <0>;
> +
> +                mipi_csi2_in_ov8865: endpoint {
> +                    data-lanes = <1 2 3 4>;
> +
> +                    remote-endpoint = <&ov8865_out_mipi_csi2>;
> +                };
> +            };
> +
> +            mipi_csi2_out: port@1 {
> +                reg = <1>;
> +
> +                mipi_csi2_out_csi: endpoint {
> +                    remote-endpoint = <&csi_in_mipi_csi2>;
> +                };
> +            };
> +        };
> +    };
> +
> +...

-- 
Kind regards,

Sakari Ailus
