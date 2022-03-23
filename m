Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB14E4DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiCWH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiCWH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:56:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47462EE;
        Wed, 23 Mar 2022 00:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B16B81DC9;
        Wed, 23 Mar 2022 07:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBFFC340E8;
        Wed, 23 Mar 2022 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648022080;
        bh=LmgVh+5eJwUoQW46tKMYwvjxY6qfh1LqV7fJ9IlmAiw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y0uZpP6r9ZH/6LlIXE9NjUTAZIb/ggKhZpquU+CSX9OgPJb4/MCze6L1hb6/mSTJo
         2/WQ3PvSHLuziLApAHYqOdu1t56Zcu/T44lJeZRYT5n0w8CXrCWUaVQLcdoSuC0wTe
         bal7j8J/NHz3hXJii4QieXqUxMUhsqD90vHYHHZm1crFhZHS6DO17fXREvpJJBJKeS
         MiUWdaZQWS4nl0iLveJSSxHa7qMx1H3JxgzfasxSDLKjwtnWSrqnF68DlJE3unp4bd
         rbHmGPqQdXxaygVxR+MsREiW0SHlc1YvtmbF3gLwzc28zzV21wKVzSl85Ej1dL3P60
         WmL9od9lgdjtQ==
Message-ID: <cb74e44b-5f4e-e644-a952-3872296fefc6@kernel.org>
Date:   Wed, 23 Mar 2022 09:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220323053524.7009-1-a-govindraju@ti.com>
 <20220323053524.7009-2-a-govindraju@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20220323053524.7009-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2022 07:35, Aswath Govindraju wrote:
> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> controller.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> new file mode 100644
> index 000000000000..4bb139d1926d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
> +
> +maintainers:
> +  - Aswath Govindraju <a-govindraju@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am62-usb
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  power-domains:
> +    description:
> +      PM domain provider node and an args specifier containing
> +      the USB ISO device id value. See,
> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> +    maxItems: 1
> +
> +  clocks:
> +    description: Clock phandles to usb2_refclk

s/phandles/phandle

> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  id-gpio:
> +    description:
> +      GPIO to be used as ID pin
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt line to be used for detecting changes in VBUS

	maxItems: 1 ?

> +
> +  ti,vbus-divider:
> +    description:
> +      Should be present if USB VBUS line is connected to the
> +      VBUS pin of the SoC via a 1/3 voltage divider.
> +    type: boolean
> +
> +  ti,syscon-phy-pll-refclk:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle to the SYSCON entry
> +          - description: USB phy control register offset within SYSCON
> +    description: Specifier for configuring frequency of ref clock input.
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - ti,syscon-phy-pll-refclk
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      dwc3-usb@f910000 {
> +        compatible = "ti,am62-usb";
> +        reg = <0x00 0x0f910000 0x00 0x800>;
> +        interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>; /* MISC IRQ */
> +        clocks = <&k3_clks 162 3>;
> +        clock-names = "ref";
> +        ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> +        power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> +        id-gpio = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +      };
> +    };

Reviewed-by: Roger Quadros <rogerq@kernel.org>

cheers,
-roger
