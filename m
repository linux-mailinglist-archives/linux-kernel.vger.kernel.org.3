Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C834D5548
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbiCJX0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344626AbiCJX0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:26:20 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968E4199D4F;
        Thu, 10 Mar 2022 15:25:18 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so8657547oos.9;
        Thu, 10 Mar 2022 15:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6w+O5WHCDjl5wbn5DykYEU1YA3lse6HoQ4X4n2SBQ0E=;
        b=J+i4uYHKChdyvoeOwlEpvTxygenISaQqBC4Z7mFUgRaBY+cVVXUQwb4Vqg4zvBNBO3
         4eBdDYmGnwOumfnOCgyZeN/5naHbkBybxt/dEEH/ZbkxNUyU0vO3jD5GPShMc/lw7J6I
         AzGRAVt6b6UkIF9HqhfuELZs6+ZTbZanjhOoYb6w7f57aCqNViaoAVdyG8H+aGgbB+m8
         1YBtLZ53wjhDbCNaEqpyX2oIuARTJuH6D3Mnkba0vm+i3RCSm8deoBUe+DbopVvRZ9JV
         SOrjYfZyCGAWkP4lTKGf/HfO/+J+wjiqAqhkzjOst5JIr/yBXCeCilH46/QSxw7muItx
         /yVA==
X-Gm-Message-State: AOAM531P8MT1e89ysVRgTCxdsXfz0cXoLPW29rHuaLKFHL9Y2jJXsFox
        Wfa57Cc5XBeigGlH85E+IQ==
X-Google-Smtp-Source: ABdhPJw93wspnZY5lHnUvT+I+4Eho5yHyZHour2RJDedXvX/kod1RlNzg/cMBeVPl0llJZbBUOlpeQ==
X-Received: by 2002:a05:6870:f70a:b0:da:bbb7:ab59 with SMTP id ej10-20020a056870f70a00b000dabbb7ab59mr2269545oab.93.1646954717912;
        Thu, 10 Mar 2022 15:25:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x7-20020a4a8687000000b003191a2edc67sm3245292ooh.7.2022.03.10.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:25:17 -0800 (PST)
Received: (nullmailer pid 2291916 invoked by uid 1000);
        Thu, 10 Mar 2022 23:25:16 -0000
Date:   Thu, 10 Mar 2022 17:25:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        robert.marko@sartura.hr, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/4] dt-bindings: pinctrl: mvebu: Document bindings
 for AC5
Message-ID: <YiqI3Gjcf8AFVQYL@robh.at.kernel.org>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310030039.2833808-2-chris.packham@alliedtelesis.co.nz>
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

On Thu, Mar 10, 2022 at 04:00:36PM +1300, Chris Packham wrote:
> Add JSON schema for marvell,ac5-pinctrl present on the Marvell 98DX2530
> SoC.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/pinctrl/marvell,ac5-pinctrl.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
> new file mode 100644
> index 000000000000..c7ab3d0e8420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/marvell,ac5-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell AC5 pin controller
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +description:
> +  Bindings for Marvell's AC5 memory-mapped pin controller.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: marvell,ac5-pinctrl
> +      - const: syscon
> +      - const: simple-mfd

How is this a 'syscon' or 'simple-mfd' For syscon, what other 
functions/registers does it have? For simple-mfd, what other functions? 
You haven't defined them in the schema.

blank line needed here.

> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    $ref: pinmux-node.yaml#
> +
> +    properties:
> +      marvell,function:
> +        $ref: "/schemas/types.yaml#/definitions/string"
> +        description:
> +          Indicates the function to select.
> +        enum: [ gpio, i2c0, i2c1, nand, sdio, spi0, spi1, uart0, uart1, uart2, uart3 ]
> +
> +      marvell,pins:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description:
> +          Array of MPP pins to be used for the given function.
> +        minItems: 1
> +        items:
> +          enum: [ mpp0, mpp1, mpp2, mpp3, mpp4, mpp5, mpp6, mpp7, mpp8, mpp9,
> +                  mpp10, mpp11, mpp12, mpp13, mpp14, mpp15, mpp16, mpp17, mpp18, mpp19,
> +                  mpp20, mpp21, mpp22, mpp23, mpp24, mpp25, mpp26, mpp27, mpp28, mpp29,
> +                  mpp30, mpp31, mpp32, mpp33, mpp34, mpp35, mpp36, mpp37, mpp38, mpp39,
> +                  mpp40, mpp41, mpp42, mpp43, mpp44, mpp45 ]
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@80020100 {
> +      compatible = "marvell,ac5-pinctrl",
> +      "syscon", "simple-mfd";
> +      reg = <0x80020100 0x20>;
> +
> +      i2c0_pins: i2c0-pins {
> +        marvell,pins = "mpp26", "mpp27";
> +        marvell,function = "i2c0";
> +      };
> +
> +      i2c0_gpio: i2c0-gpio-pins {
> +        marvell,pins = "mpp26", "mpp27";
> +        marvell,function = "gpio";
> +      };
> +    };
> -- 
> 2.35.1
> 
> 
