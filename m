Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E05894E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbiHCXht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiHCXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:37:47 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C25C953;
        Wed,  3 Aug 2022 16:37:46 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id x64so14081916iof.1;
        Wed, 03 Aug 2022 16:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fLmqeRMf4JDZKs/iHkdB/euWLnNPX6ANGv/0J6rLGMw=;
        b=eEO10LWPNnCW2Agy9hgvLGqmA7WUBCMlVPnEP3pcfySppWgsrVTWk8m9iLEcllbNnN
         C3SZNHOfdMaFZcXV+6rUe5Aw6I+/3d83WpC24TZEEt/pS1sJX2l7Rzm6LoH0xFZywZzC
         KRLiNDy9YNYipsYMORVZIXO8W5IAS1nJ3Gr5T7s4Fcuy0wht94f5LY7+CY0FXsBsT37z
         TQGLfiVA8/+ICkX45uAz4toddwv5rCMK+wWzi2G2fzePfQoI/j5GWCKdcXqrlgzuzkWX
         uDGkgjkKLgUE0mELgw+gYkvprEGEx7WHF/WUwVJc1gcYvVCdZ+WUQp4Yr8BSxLOy8C2v
         bXCA==
X-Gm-Message-State: ACgBeo2eZ0mMapl0i+hO4RdOkuKXUJqD2oAQh6v694hUGOyDSH5qGNht
        hAycrIMqNCfPFReljo1y8A==
X-Google-Smtp-Source: AA6agR53WI0LJZ+DX8d8/XcrWJ10kzKH3mPTOxxzw9arA4anUD75QNQmKl+niGSJgwxKS/uZXonCFA==
X-Received: by 2002:a05:6638:130d:b0:342:9b04:729b with SMTP id r13-20020a056638130d00b003429b04729bmr1074641jad.59.1659569865873;
        Wed, 03 Aug 2022 16:37:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a4-20020a021604000000b00339ceeec5edsm8396727jaa.12.2022.08.03.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:37:45 -0700 (PDT)
Received: (nullmailer pid 2823499 invoked by uid 1000);
        Wed, 03 Aug 2022 23:37:43 -0000
Date:   Wed, 3 Aug 2022 17:37:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
 link MSI bus binding
Message-ID: <20220803233743.GA2813240-robh@kernel.org>
References: <20220803012421.3410226-1-victor.liu@nxp.com>
 <20220803012421.3410226-4-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803012421.3410226-4-victor.liu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:24:21AM +0800, Liu Ying wrote:
> Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
> It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> MIPI DSI controller and Control and Status Registers (CSR) module.
> 
> Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> link MSI bus specific bindings.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> Address Krzysztof's comments:
> * Add a select to explicitly select the MSI bus dt-binding.
> * List 'simple-pm-bus' explicitly as one item of compatible strings.
> * Require compatible and reg properties.
> * Put reg property just after compatible property in example.
> 
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> new file mode 100644
> index 000000000000..358c032041e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect (MSI) Bus
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  i.MX8qxp pixel link MSI bus is used to control settings of PHYs, I/Os
> +  sitting together with the PHYs.  It is not the same as the MSI bus coming
> +  from i.MX8 System Controller Unit (SCU) which is used to control power,
> +  clock and reset through the i.MX8 Distributed Slave System Controller (DSC).
> +
> +  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two input clocks,
> +  that is, MSI clock and AHB clock, need to be enabled so that peripherals
> +  connected to the bus can be accessed. Also, the bus is part of a power
> +  domain. The power domain needs to be enabled before the peripherals can
> +  be accessed.
> +
> +  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX subsystems,
> +  like I2C controller, PWM controller, MIPI DSI controller and Control and
> +  Status Registers (CSR) module, are accessed through the bus.
> +
> +  The i.MX System Controller Firmware (SCFW) owns and uses the i.MX8qm/qxp
> +  pixel link MSI bus controller and does not allow SCFW user to control it.
> +  So, the controller's registers cannot be accessed by SCFW user. Hence,
> +  the interrupts generated by the controller don't make any sense from SCFW
> +  user's point of view.
> +
> +allOf:
> +  - $ref: simple-pm-bus.yaml#
> +
> +# We need a select here so we don't match all nodes with 'simple-pm-bus'.
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,imx8qxp-display-pixel-link-msi-bus
> +          - fsl,imx8qm-display-pixel-link-msi-bus
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8qxp-display-pixel-link-msi-bus
> +          - fsl,imx8qm-display-pixel-link-msi-bus
> +      - const: simple-pm-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: master gated clock from system
> +      - description: AHB clock
> +
> +  clock-names:
> +    items:
> +      - const: msi
> +      - const: ahb
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +unevaluatedProperties: false

No child nodes allowed?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    bus@56200000 {
> +        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
> +        reg = <0x56200000 0x20000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        interrupt-parent = <&dc0_irqsteer>;
> +        interrupts = <320>;
> +        ranges;
> +        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
> +                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
> +        clock-names = "msi", "ahb";
> +        power-domains = <&pd IMX_SC_R_DC_0>;
> +    };
> -- 
> 2.25.1
> 
> 
