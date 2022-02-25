Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780054C4A09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiBYQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiBYQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:05:05 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA11A3617;
        Fri, 25 Feb 2022 08:04:33 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so6735322oot.11;
        Fri, 25 Feb 2022 08:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=62snw7bOF/0Xdj/1zQ7dCw19azD4vyQfzWzESw+fN1c=;
        b=2Nv7sc9UosMZYZwLN/xUO3Z4j8H29qV1gigNW8JqIcCaLhyDjZhzxwOdWCpmoXXunG
         Jg2Qv34CeTi2mPqlTH2bKBjmhYBCb1fR2P03b64d0ThauvmMS7so+GsOmv/skFAw6o9R
         bYdRF3D8hoLBR6u81IXo7VkdHsrrDsNL3RrAr6LWhNlYAHo/rIQA9lTaaLUMjelu/oNR
         9ODp7L5q5Q18kjkzrOB2njKd/5vcvt/oBefxq99eqjfRAfaWnN53LDdb6QEpA0Noy0TG
         RVU3MVzlKhUZtOWR4sdO2qW6djVita0VA5v+g69o1EOQnOqN7kEhTfTI8DBvf+LqRjLN
         PXPg==
X-Gm-Message-State: AOAM53163sbRVJsplYE+oX9FDL+6VtJCRso4TBdnZ6n7Eemdx2q9/bvb
        Qme7VEYv6YQac0abAT17KQ==
X-Google-Smtp-Source: ABdhPJyCTntZfMAJhy9C7v8gnaenj+HNsX34XTMCJK82mHMST9OItKpfymK8bM0r0lWLPdgkfspdiQ==
X-Received: by 2002:a4a:4589:0:b0:319:edf:10c7 with SMTP id y131-20020a4a4589000000b003190edf10c7mr2935651ooa.44.1645805072946;
        Fri, 25 Feb 2022 08:04:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c26-20020a056830349a00b005af30960c75sm1268657otu.38.2022.02.25.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:04:32 -0800 (PST)
Received: (nullmailer pid 1008598 invoked by uid 1000);
        Fri, 25 Feb 2022 16:04:30 -0000
Date:   Fri, 25 Feb 2022 10:04:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        linux-imx@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: imx93: Add pinctrl binding
Message-ID: <Yhj+DrSDF6VQWe6X@robh.at.kernel.org>
References: <20220215082006.790843-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215082006.790843-1-peng.fan@oss.nxp.com>
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

On Tue, Feb 15, 2022 at 04:20:05PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add pinctrl binding doc for i.MX93
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,imx93-pinctrl.yaml   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
> new file mode 100644
> index 000000000000..95c87ea4c5c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license. checkpatch will tell you this and which ones.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/fsl,imx93-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale IMX93 IOMUX Controller
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description:
> +  Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
> +  for common binding part and usage.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx93-iomuxc
> +
> +  reg:
> +    maxItems: 1
> +
> +# Client device subnode's properties
> +patternProperties:
> +  'grp$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      fsl,pins:
> +        description:
> +          each entry consists of 6 integers and represents the mux and config
> +          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
> +          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
> +          be found in <arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h>. The last
> +          integer CONFIG is the pad setting value like pull-up on this pin. Please
> +          refer to i.MX8M Plus Reference Manual for detailed CONFIG settings.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        items:
> +          items:
> +            - description: |
> +                "mux_reg" indicates the offset of mux register.
> +            - description: |
> +                "conf_reg" indicates the offset of pad configuration register.
> +            - description: |
> +                "input_reg" indicates the offset of select input register.
> +            - description: |
> +                "mux_val" indicates the mux value to be applied.
> +            - description: |
> +                "input_val" indicates the select input value to be applied.
> +            - description: |
> +                "pad_setting" indicates the pad configuration value to be applied.
> +
> +
> +    required:
> +      - fsl,pins
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

Move this above 'properties'

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  # Pinmux controller node
> +  - |
> +    iomuxc: pinctrl@443c0000 {
> +        compatible = "fsl,imx93-iomuxc";
> +        reg = <0x30330000 0x10000>;
> +
> +        pinctrl_uart3: uart3grp {
> +            fsl,pins =
> +                <0x48 0x1f8 0x41c 0x1 0x0	0x49>,
> +                <0x4c 0x1fc 0x418 0x1 0x0	0x49>;
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
> 
