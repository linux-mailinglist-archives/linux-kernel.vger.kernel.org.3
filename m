Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529564B2966
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349340AbiBKPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiBKPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:49:33 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDE1A8;
        Fri, 11 Feb 2022 07:49:32 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id y23so9924940oia.13;
        Fri, 11 Feb 2022 07:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gWKYE2d0LpVfiDQEqlRd5JWJe4nWkpS2f1rG0JFNYfg=;
        b=plgJSdeKxJwrQaJij7numzxgN1rI4YWHRZ8T7PdVWRJqPSAkNMEoYq8jraY8jwQtLR
         QKj7W3ldPDaSE12///vBxkDQBYIAIcqmkLY0I/nPzlBfcUj/ux/px3Dzm1vghvbEScnp
         BMP7cYZuMVZHC6i8XGZmff2cGN1baJ77kc5IzJ0nd/TwRhpD7X9q7mxGWwhipOHeRgr4
         biNx9f8HbwE8HgsiGNzpf30l9fPP7LV7uf5Q7Z5aBcKYsNkHB+3jjfqf6VQsRqgZ4Fcu
         xUViP2PP/jsPSMSHTuJa5lCTKj3CsR3fR/Lbe9UiDe3/y6Golnrrz4NciU9JXyEQFQqh
         GJnw==
X-Gm-Message-State: AOAM531aQqgLKwUY2VgJjvre1yRvpHyOLH9rV4LiIasm4UiuhedD7BTR
        73U8Z23vWCLgz2Kwq6kgTw==
X-Google-Smtp-Source: ABdhPJxoP4zIIRj7it+mF16gB50xGdR/J7wpMEl6fEvCZKZC+lc5Es0k1OoC2wRfJCacn5nRg4UQ1w==
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr460883oiv.50.1644594571778;
        Fri, 11 Feb 2022 07:49:31 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id bh7sm6124885oib.6.2022.02.11.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 07:49:30 -0800 (PST)
Received: (nullmailer pid 409607 invoked by uid 1000);
        Fri, 11 Feb 2022 15:46:27 -0000
Date:   Fri, 11 Feb 2022 09:46:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display: imx: Add EPDC
Message-ID: <YgaE06Ktabpf2dJC@robh.at.kernel.org>
References: <20220206080016.796556-1-andreas@kemnade.info>
 <20220206080016.796556-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206080016.796556-2-andreas@kemnade.info>
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

On Sun, Feb 06, 2022 at 09:00:11AM +0100, Andreas Kemnade wrote:
> Add a binding for the Electrophoretic Display Controller found at least
> in the i.MX6.

The first version was in i.MX50 (I helped design the register 
interface). Is that version compatible?

> The timing subnode is directly here to avoid having display parameters
> spread all over the plate.
> 
> Supplies are organized the same way as in the fbdev driver in the
> NXP/Freescale kernel forks. The regulators used for that purpose,
> like the TPS65185, the SY7636A and MAX17135 have typically a single bit to
> start a bunch of regulators of higher or negative voltage with a
> well-defined timing. VCOM can be handled separately, but can also be
> incorporated into that single bit.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/display/imx/fsl,mxc-epdc.yaml    | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> new file mode 100644
> index 000000000000..7e0795cc3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/fsl,mxc-epdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX6 EPDC
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description: |
> +  The EPDC is a controller for handling electronic paper displays found in
> +  i.MX6 SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx6sl-epdc
> +      - fsl,imx6sll-epdc

Not compatible with each other?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus clock
> +      - description: Pixel clock
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: pix
> +
> +  interrupts:
> +    maxItems: 1
> +

> +  vscan-holdoff:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  sdoed-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  sdoed-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  sdoez-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  sdoez-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  gdclk-hp-offs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  gdsp-offs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  gdoe-offs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  gdclk-offs:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
> +  num-ce:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1

All these need a vendor prefix and descriptions.

> +
> +  timing:
> +    $ref: /display/panel/panel-timing.yaml#
> +
> +  DISPLAY-supply:
> +    description:
> +      A couple of +/- voltages automatically powered on in a defintive order
> +
> +  VCOM-supply:
> +    description: compensation voltage
> +
> +  V3P3-supply:
> +    description: V3P3 supply
> +
> +  epd-thermal-zone:
> +    description:
> +      Zone to get temperature of the EPD from, practically ambient temperature.
> +
> +
> +

1 blank line.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - vscan-holdoff
> +  - sdoed-width
> +  - sdoed-delay
> +  - sdoez-width
> +  - sdoez-delay
> +  - gdclk-hp-offs
> +  - gdsp-offs
> +  - gdoe-offs
> +  - gdclk-offs
> +  - num-ce
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sl-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    epdc: epdc@20f4000 {
> +        compatible = "fsl,imx6sl-epdc";
> +        reg = <0x020f4000 0x4000>;
> +        interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clks IMX6SL_CLK_EPDC_AXI>, <&clks IMX6SL_CLK_EPDC_PIX>;
> +        clock-names = "axi", "pix";
> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_epdc0>;
> +        V3P3-supply = <&V3P3_reg>;
> +        VCOM-supply = <&VCOM_reg>;
> +        DISPLAY-supply = <&DISPLAY_reg>;
> +        epd-thermal-zone = "epd-thermal";
> +
> +        vscan-holdoff = <4>;
> +        sdoed-width = <10>;
> +        sdoed-delay = <20>;
> +        sdoez-width = <10>;
> +        sdoez-delay = <20>;
> +        gdclk-hp-offs = <562>;
> +        gdsp-offs = <662>;
> +        gdoe-offs = <0>;
> +        gdclk-offs = <225>;
> +        num-ce = <3>;
> +        status = "okay";

Don't need status in examples.

> +
> +        timing {
> +                clock-frequency = <80000000>;
> +                hactive = <1448>;
> +                hback-porch = <16>;
> +                hfront-porch = <102>;
> +                hsync-len = <28>;
> +                vactive = <1072>;
> +                vback-porch = <4>;
> +                vfront-porch = <4>;
> +                vsync-len = <2>;
> +        };
> +    };
> +...
> -- 
> 2.30.2
> 
> 
