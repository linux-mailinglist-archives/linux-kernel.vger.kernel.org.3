Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1558E136
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiHIUhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiHIUhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:37:12 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B812D15;
        Tue,  9 Aug 2022 13:37:11 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id j20so7186507ila.6;
        Tue, 09 Aug 2022 13:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pY+C9vONR9Qj4GAbUoRFOfpVvcsMJ1yvkqH3xXgdv6A=;
        b=ErGhkf0bhTIlc8NLEx5i18aH4oRuxEexdj4IDRTj1Id3n4MsONtskKi+/XgrKKuy04
         pW7Y20wd6vui0Kf6gP5WwEMw7MSzzhxoEXQAD6TBLK6Db/uN+/tSVpTNYN9dCqFd/5YK
         d3wBp2EjP8syDfnxAA9a5kY5+l1Cxy5c8BPDHKGyDrW5916LaPgfwgpLMarv62kHzd0m
         3C6qbImpvW/JrWhsK9thk3FmqQZJV8deVlKWndqwa7bWxrT8sBP64UInWfLZ/Rv2Mt4p
         sJkUACzYQ+uFnpYNFbBArfMc13/YpiU3hADsCObNTQIPgAZmUBaIkDBWJSx1DOggT2AE
         L8mg==
X-Gm-Message-State: ACgBeo3PRUDW8Vin2Cit5YFRgyHZu/iIAwwOelN7fqWsm+eNf57Zr5Fm
        XmgdbDQjC0ZmbERqiq0VJg==
X-Google-Smtp-Source: AA6agR5Ppmth+Lg164h9uGEX2uXGyayBPre4N1yTywCH7PJjT8/5lY5fff+RGrRVKWVD0q0ltTfUgQ==
X-Received: by 2002:a05:6e02:e14:b0:2de:60af:e408 with SMTP id a20-20020a056e020e1400b002de60afe408mr11328414ilk.170.1660077430201;
        Tue, 09 Aug 2022 13:37:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y9-20020a056602048900b0068463d9e33csm1504251iov.8.2022.08.09.13.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:37:09 -0700 (PDT)
Received: (nullmailer pid 2353917 invoked by uid 1000);
        Tue, 09 Aug 2022 20:37:05 -0000
Date:   Tue, 9 Aug 2022 14:37:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     shubhrajyoti.datta@xilinx.com, michal.simek@xilinx.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, srinivas.neeli@amd.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, git@amd.com
Subject: Re: [PATCH] dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi gpio
 binding to YAML
Message-ID: <20220809203705.GA2340911-robh@kernel.org>
References: <20220809130842.27975-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809130842.27975-1-srinivas.neeli@xilinx.com>
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

On Tue, Aug 09, 2022 at 06:38:42PM +0530, Srinivas Neeli wrote:
> Convert Xilinx axi gpio binding documentation to YAML.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
>  .../devicetree/bindings/gpio/gpio-xilinx.txt  |  48 ------
>  .../bindings/gpio/xlnx,gpio-xilinx.yaml       | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt b/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
> deleted file mode 100644
> index e506f30e1a95..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -Xilinx plb/axi GPIO controller
> -
> -Dual channel GPIO controller with configurable number of pins
> -(from 1 to 32 per channel). Every pin can be configured as
> -input/output/tristate. Both channels share the same global IRQ but
> -local interrupts can be enabled on channel basis.
> -
> -Required properties:
> -- compatible : Should be "xlnx,xps-gpio-1.00.a"
> -- reg : Address and length of the register set for the device
> -- #gpio-cells : Should be two. The first cell is the pin number and the
> -  second cell is used to specify optional parameters (currently unused).
> -- gpio-controller : Marks the device node as a GPIO controller.
> -
> -Optional properties:
> -- clocks : Input clock specifier. Refer to common clock bindings.
> -- interrupts : Interrupt mapping for GPIO IRQ.
> -- xlnx,all-inputs : if n-th bit is setup, GPIO-n is input
> -- xlnx,dout-default : if n-th bit is 1, GPIO-n default value is 1
> -- xlnx,gpio-width : gpio width
> -- xlnx,tri-default : if n-th bit is 1, GPIO-n is in tristate mode
> -- xlnx,is-dual : if 1, controller also uses the second channel
> -- xlnx,all-inputs-2 : as above but for the second channel
> -- xlnx,dout-default-2 : as above but the second channel
> -- xlnx,gpio2-width : as above but for the second channel
> -- xlnx,tri-default-2 : as above but for the second channel
> -
> -
> -Example:
> -gpio: gpio@40000000 {
> -	#gpio-cells = <2>;
> -	compatible = "xlnx,xps-gpio-1.00.a";
> -	clocks = <&clkc25>;
> -	gpio-controller ;
> -	interrupt-parent = <&microblaze_0_intc>;
> -	interrupts = < 6 2 >;
> -	reg = < 0x40000000 0x10000 >;
> -	xlnx,all-inputs = <0x0>;
> -	xlnx,all-inputs-2 = <0x0>;
> -	xlnx,dout-default = <0x0>;
> -	xlnx,dout-default-2 = <0x0>;
> -	xlnx,gpio-width = <0x2>;
> -	xlnx,gpio2-width = <0x2>;
> -	xlnx,interrupt-present = <0x1>;
> -	xlnx,is-dual = <0x1>;
> -	xlnx,tri-default = <0xffffffff>;
> -	xlnx,tri-default-2 = <0xffffffff>;
> -} ;
> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> new file mode 100644
> index 000000000000..089e297aa530
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Axi GPIO controller Device Tree Bindings

AXI

Drop 'Device Tree Bindings'

> +
> +maintainers:
> +  - Neeli Srinivas <srinivas.neeli@amd.com>

Which is the right name? This or your S-o-b/author?

> +
> +description:
> +  The AXI GPIO design provides a general purpose input/output interface
> +  to an AXI4-Lite interface. The AXI GPIO can be configured as either
> +  a single or a dual-channel device. The width of each channel is
> +  independently configurable. The channels can be configured to
> +  generate an interrupt when a transition on any of their inputs occurs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,xps-gpio-1.00.a
> +  reg:
> +    maxItems: 1
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  gpio-line-names:
> +    description: strings describing the names of each gpio line
> +    minItems: 1
> +    maxItems: 64
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupt-names: true
> +
> +  xlnx,all-inputs:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Don't need quotes.

> +    description: This option sets this GPIO channel1 bits in input mode.
> +
> +  xlnx,all-inputs-2:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This option sets this GPIO channel2 bits in input mode.
> +
> +  xlnx,all-outputs:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This option sets this GPIO channel1 bits in output mode.
> +
> +  xlnx,all-outputs-2:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This option sets this GPIO channel2 bits in output mode.
> +
> +  xlnx,dout-default:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Sets the default value of all the enabled bits of
> +                 channel1. By default, this parameter is set to 0x0.

default: 0

> +
> +  xlnx,dout-default-2:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: Sets the default value of all the enabled bits of
> +                 channel2. By default, this parameter is set to 0x0.

default: 0

> +
> +  xlnx,gpio-width:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: The value defines the bit width of the GPIO channel1.
> +                 Its value can be from 1 to 32, and default value is 32.

Express as constraints instead:

minimum: 1
maximum: 32
default: 32

> +
> +  xlnx,gpio2-width:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: The value defines the bit width of the GPIO channel2.
> +                 Its value can be from 1 to 32, and default value is 32.
> +
> +  xlnx,interrupt-present:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This parameter enables interrupt control logic
> +                 and interrupt registers in GPIO module. By default it is 0.

blank line

Constraints? Only 0 or 1?

> +  xlnx,is-dual:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This parameter enables a second GPIO channel (GPIO2).

Constraints?

> +
> +  xlnx,tri-default:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This value configures the input or output mode
> +                 of each bit of GPIO channel1.
> +
> +  xlnx,tri-default-2:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: This value configures the input or output mode
> +                 of each bit of GPIO channel2.
> +
> +required:
> +  - reg
> +  - compatible
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +        gpio@e000a000 {
> +            #gpio-cells = <2>;
> +            #interrupt-cells = <0x2>;
> +            clocks = <&zynqmp_clk 71>;
> +            compatible = "xlnx,xps-gpio-1.00.a";
> +            gpio-controller;
> +            interrupt-controller;
> +            interrupt-names = "ip2intc_irpt";
> +            interrupt-parent = <&gic>;
> +            interrupts = <0 89 4>;
> +            reg = <0xa0020000 0x10000>;

Normal order is 'compatible' first, then 'reg', then everything else.

> +            xlnx,all-inputs = <0x0>;
> +            xlnx,all-inputs-2 = <0x0>;
> +            xlnx,all-outputs = <0x0>;
> +            xlnx,all-outputs-2 = <0x0>;
> +            xlnx,dout-default = <0x0>;
> +            xlnx,dout-default-2 = <0x0>;
> +            xlnx,gpio-width = <0x20>;
> +            xlnx,gpio2-width = <0x20>;
> +            xlnx,interrupt-present = <0x1>;
> +            xlnx,is-dual = <0x1>;
> +            xlnx,tri-default = <0xFFFFFFFF>;
> +            xlnx,tri-default-2 = <0xFFFFFFFF>;
> +        };
> +
> +...
> -- 
> 2.17.1
> 
> 
