Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20083478EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhLQO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:59:07 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40607 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhLQO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:59:06 -0500
Received: by mail-ot1-f46.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so3168174otj.7;
        Fri, 17 Dec 2021 06:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtNNLbxBpuHX5RmS7GKEPVN70OvcjZU0mEBkeENGSlM=;
        b=JesvwuojGhgViV3E28QA05+RME7VFXOb8016iHbZ7yWVGoyfDk90p6z96nPYdQ/+mE
         mDhDfepFFkMRwbRHXK5RqAv5dReVKt2p3VaYo1bNREMamAyitotidbh6efaAIhr52D6K
         0N4/C2zeioCtPbzvaknBnOUmgtfCOqV/MEmio9dyth9oZsPDszp3LcwKVGSbaIs0ngT1
         eYBdn3tgCld1mgPmuLBG5LKOZue7e0QaMAXL4TxPbsVB/ELyu1Mu4TTJqWKgsSc5ODkv
         i0xUI1bxdaiV6AC/gBSw0oZ2sDgZbeZsbBBShxP4Zs8qRMaAEFjnoypfJ1Mhj+5NWdY+
         u7Kg==
X-Gm-Message-State: AOAM5315Pa05R1dpKSDYyQczhKfIlwxLQe9dd0h4+jWNjzqZby+ruTOC
        caoPx/b8uqRlfAgnHvmQtIKKcl/22g==
X-Google-Smtp-Source: ABdhPJxFtDSunlbe57jArZYJu0wYYZwKyWjva5ekvHqFWfYjG9zeN+rbLPoMpSUVApxg8x75T89/xg==
X-Received: by 2002:a9d:d02:: with SMTP id 2mr2421512oti.342.1639753146035;
        Fri, 17 Dec 2021 06:59:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl33sm1797061oib.47.2021.12.17.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:59:05 -0800 (PST)
Received: (nullmailer pid 2879918 invoked by uid 1000);
        Fri, 17 Dec 2021 14:59:04 -0000
Date:   Fri, 17 Dec 2021 08:59:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: interrupt-controller: Convert
 BCM7120 L2 to YAML
Message-ID: <YbyluObgbL3+hqYO@robh.at.kernel.org>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
 <20211217042001.479577-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217042001.479577-2-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:19:56PM -0800, Florian Fainelli wrote:
> Convert the Broadcom BCM7120 Level 2 interrupt controller Device Tree
> binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../brcm,bcm7120-l2-intc.txt                  |  88 -------------
>  .../brcm,bcm7120-l2-intc.yaml                 | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
> deleted file mode 100644
> index addd86b6ca2f..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -Broadcom BCM7120-style Level 2 interrupt controller
> -
> -This interrupt controller hardware is a second level interrupt controller that
> -is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
> -platforms. It can be found on BCM7xxx products starting with BCM7120.
> -
> -Such an interrupt controller has the following hardware design:
> -
> -- outputs multiple interrupts signals towards its interrupt controller parent
> -
> -- controls how some of the interrupts will be flowing, whether they will
> -  directly output an interrupt signal towards the interrupt controller parent,
> -  or if they will output an interrupt signal at this 2nd level interrupt
> -  controller, in particular for UARTs
> -
> -- has one 32-bit enable word and one 32-bit status word
> -
> -- no atomic set/clear operations
> -
> -- not all bits within the interrupt controller actually map to an interrupt
> -
> -The typical hardware layout for this controller is represented below:
> -
> -2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
> -
> -0 -----[ MUX ] ------------|==========> GIC interrupt 75
> -          \-----------\
> -                       |
> -1 -----[ MUX ] --------)---|==========> GIC interrupt 76
> -          \------------|
> -                       |
> -2 -----[ MUX ] --------)---|==========> GIC interrupt 77
> -          \------------|
> -                       |
> -3 ---------------------|
> -4 ---------------------|
> -5 ---------------------|
> -7 ---------------------|---|===========> GIC interrupt 66
> -9 ---------------------|
> -10 --------------------|
> -11 --------------------/
> -
> -6 ------------------------\
> -                           |===========> GIC interrupt 64
> -8 ------------------------/
> -
> -12 ........................ X
> -13 ........................ X 		(not connected)
> -..
> -31 ........................ X
> -
> -Required properties:
> -
> -- compatible: should be "brcm,bcm7120-l2-intc"
> -- reg: specifies the base physical address and size of the registers
> -- interrupt-controller: identifies the node as an interrupt controller
> -- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> -  source, should be 1.
> -- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> -  node, valid values depend on the type of parent interrupt controller
> -- brcm,int-map-mask: 32-bits bit mask describing how many and which interrupts
> -  are wired to this 2nd level interrupt controller, and how they match their
> -  respective interrupt parents. Should match exactly the number of interrupts
> -  specified in the 'interrupts' property.
> -
> -Optional properties:
> -
> -- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
> -  wakeup source for system suspend/resume.
> -
> -- brcm,int-fwd-mask: if present, a bit mask to configure the interrupts which
> -  have a mux gate, typically UARTs. Setting these bits will make their
> -  respective interrupt outputs bypass this 2nd level interrupt controller
> -  completely; it is completely transparent for the interrupt controller
> -  parent. This should have one 32-bit word per enable/status pair.
> -
> -Example:
> -
> -irq0_intc: interrupt-controller@f0406800 {
> -	compatible = "brcm,bcm7120-l2-intc";
> -	interrupt-parent = <&intc>;
> -	#interrupt-cells = <1>;
> -	reg = <0xf0406800 0x8>;
> -	interrupt-controller;
> -	interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
> -	brcm,int-map-mask = <0xeb8>, <0x140>;
> -	brcm,int-fwd-mask = <0x7>;
> -};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> new file mode 100644
> index 000000000000..e10c9879f3f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM7120-style Level 2 interrupt controller
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +description: >
> +  This interrupt controller hardware is a second level interrupt controller that
> +  is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
> +  platforms. It can be found on BCM7xxx products starting with BCM7120.
> +
> +  Such an interrupt controller has the following hardware design:
> +
> +  - outputs multiple interrupts signals towards its interrupt controller parent
> +
> +  - controls how some of the interrupts will be flowing, whether they will
> +    directly output an interrupt signal towards the interrupt controller parent,
> +    or if they will output an interrupt signal at this 2nd level interrupt
> +    controller, in particular for UARTs
> +
> +  - has one 32-bit enable word and one 32-bit status word
> +
> +  - no atomic set/clear operations
> +
> +  - not all bits within the interrupt controller actually map to an interrupt
> +
> +  The typical hardware layout for this controller is represented below:
> +
> +  2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
> +
> +  0 -----[ MUX ] ------------|==========> GIC interrupt 75
> +            \-----------\
> +                         |
> +  1 -----[ MUX ] --------)---|==========> GIC interrupt 76
> +            \------------|
> +                         |
> +  2 -----[ MUX ] --------)---|==========> GIC interrupt 77
> +            \------------|
> +                         |
> +  3 ---------------------|
> +  4 ---------------------|
> +  5 ---------------------|
> +  7 ---------------------|---|===========> GIC interrupt 66
> +  9 ---------------------|
> +  10 --------------------|
> +  11 --------------------/
> +
> +  6 ------------------------\
> +                            |===========> GIC interrupt 64
> +  8 ------------------------/
> +
> +  12 ........................ X
> +  13 ........................ X           (not connected)
> +  ..
> +  31 ........................ X
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm7120-l2-intc
> +
> +  reg:
> +    maxItems: 1
> +    description: >
> +      Specifies the base physical address and size of the registers
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupts: true

How many?

> +
> +  brcm,int-map-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: >
> +      32-bits bit mask describing how many and which interrupts are wired to
> +      this 2nd level interrupt controller, and how they match their respective
> +      interrupt parents. Should match exactly the number of interrupts
> +      specified in the 'interrupts' property.
> +
> +  brcm,irq-can-wake:
> +    type: boolean
> +    description: >
> +      If present, this means the L2 controller can be used as a wakeup source
> +      for system suspend/resume.
> +
> +  brcm,int-fwd-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: >
> +      if present, a bit mask to configure the interrupts which have a mux gate,
> +      typically UARTs. Setting these bits will make their respective interrupt
> +      outputs bypass this 2nd level interrupt controller completely; it is
> +      completely transparent for the interrupt controller parent. This should
> +      have one 32-bit word per enable/status pair.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - interrupts
> +
> +examples:
> +  - |
> +    irq0_intc: interrupt-controller@f0406800 {
> +      compatible = "brcm,bcm7120-l2-intc";
> +      interrupt-parent = <&intc>;
> +      #interrupt-cells = <1>;
> +      reg = <0xf0406800 0x8>;
> +      interrupt-controller;
> +      interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
> +      brcm,int-map-mask = <0xeb8>, <0x140>;
> +      brcm,int-fwd-mask = <0x7>;
> +    };
> -- 
> 2.25.1
> 
> 
