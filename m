Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6B4E4CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiCWGSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiCWGSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AB5A17B;
        Tue, 22 Mar 2022 23:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EEC3B81DEC;
        Wed, 23 Mar 2022 06:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847AEC340E8;
        Wed, 23 Mar 2022 06:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648016228;
        bh=6qYRKx7Fm1RA0k8Bo9Mk1TZGG2liE+qqs6IEExcenC8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=foPEoL0OltkjH2Y+UusQFnM990XTyl+FfWKHNgYO0CcxIWen+tca4GwNeVt/jKUiv
         ByryQ7fj9u1g2lPrKMM//3ibxsBJF4840PP5KWpYX42WzqxZ4oyll4qfC9mj+Tjdyi
         sytQASqyicy2hFoc8u011wQT4BDkj8/bPYgu6Pv5hPl71M4wj7O4kqW7MptZOH/aCb
         BQsbHqwUrSGW8UYa4RUxmMWbPi5/txY83+Lwleo2Oodk7oMeLxd7AWEyZvYSbJULWQ
         gOn0lnKgcFwAvXiQdPW6vUFCCGFlAAX5U0xzTx9O1KE3a0wilmUSlMj4RwyVRh6ukn
         VmrWtKBMI0YVw==
Message-ID: <7005ad7a-1e5e-8823-239e-18dc0fed472a@kernel.org>
Date:   Wed, 23 Mar 2022 08:17:03 +0200
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

Hi Aswath,

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

We already have ti,j721e-usb.yaml which is covering am64-usb.
We could just add am62 compatible there.

Any am62 specific properties could be handled with conditional
'required' statements.

cheers,
-roger

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
