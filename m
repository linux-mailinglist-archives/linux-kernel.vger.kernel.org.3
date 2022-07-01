Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE495637D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiGAQZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGAQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:25:24 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317B3E5FA;
        Fri,  1 Jul 2022 09:25:23 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p128so2776654iof.1;
        Fri, 01 Jul 2022 09:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GYZt2HTOj5uqVs3VeuCu1VY8xKZXjOoUKU1SlR+YU08=;
        b=prK7JeVgstZxdBgts5CGNF2xaIqEn69ur7Hp5SS66+lQDHXk82WyeGQ6Aq/CBGWUjW
         8MatxWr5EMnvRm84r7tT1Zrz2NY5VOG99ztpqvClwxzLZ18vRQJTlT+jmeqsmovwk/wd
         hk7qGN/sIV4sdVBRmKBRD7liEbfk2SlJVAaPCn8cXJRl7etp5FGzWyngvLf1b3lCVrLv
         DDR1SXdtAEHUqah3SGRa1dGXIohN1suh6fIibkWsLGxJMXvaz0/i1AIr2PufAdSynwMO
         Y9BLpf4SYXPUix/WOweSXBZFcuhOD4HrJ9l1iQU11Ey/itHDkyZX7l7SEmcQAD5ST0VV
         JaSg==
X-Gm-Message-State: AJIora8L482yaS9flFLqwuiL5E/MfGOWR7H6GVR+GuWOlQtHxcW5kc1b
        NwhUZ2JPHQTU8u+TserhEw==
X-Google-Smtp-Source: AGRyM1u2WJf0koBttU3ePsmz386ilkTlLQzKph0Fw5IvRuwDlIu2D9ePyYf/MIdg5/sQyUM6eqm4PQ==
X-Received: by 2002:a02:85e3:0:b0:339:cf24:68f6 with SMTP id d90-20020a0285e3000000b00339cf2468f6mr9378878jai.161.1656692723052;
        Fri, 01 Jul 2022 09:25:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f1-20020a02b781000000b0033cc22c261fsm4209024jam.111.2022.07.01.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:25:22 -0700 (PDT)
Received: (nullmailer pid 1076614 invoked by uid 1000);
        Fri, 01 Jul 2022 16:25:21 -0000
Date:   Fri, 1 Jul 2022 10:25:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, vkoul@kernel.org, kishon@ti.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v1 1/9] dt-bindings: phy: lantiq: xway-rcu-usb2-phy:
 Convert to YAML
Message-ID: <20220701162521.GA1067947-robh@kernel.org>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628124441.2385023-2-martin.blumenstingl@googlemail.com>
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

On Tue, Jun 28, 2022 at 02:44:33PM +0200, Martin Blumenstingl wrote:
> Convert the Lantiq XWAY RCU USB2 PHY bindings to YAML.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../phy/lantiq,xway-rcu-usb2-phy.yaml         | 68 +++++++++++++++++++
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt      | 40 -----------
>  2 files changed, 68 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
> new file mode 100644
> index 000000000000..702a8e8c64b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/lantiq,xway-rcu-usb2-phy.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/lantiq,xway-rcu-usb2-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +properties:
> +  "#phy-cells":
> +    const: 0
> +
> +  compatible:
> +    enum:
> +      - lantiq,ase-usb2-phy
> +      - lantiq,danube-usb2-phy
> +      - lantiq,xrx100-usb2-phy
> +      - lantiq,xrx200-usb2-phy
> +      - lantiq,xrx300-usb2-phy
> +
> +  reg:
> +    minItems: 2

Need to define what each entry is which you lost.

> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: phy
> +
> +  resets:
> +    minItems: 1

But reset-names requires 2 entries.

> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy

'phy' was optional before. You may want to add another case with oneOf:

items:
  - const: ctrl

I'm not sure on all the possibilities though. Is 'ctrl' optional?

> +      - const: ctrl
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_phy0: usb2-phy@18 {
> +        compatible = "lantiq,xrx200-usb2-phy";
> +        reg = <0x18 4>, <0x38 4>;
> +
> +        clocks = <&pmu_USB0_PHY>;
> +        clock-names = "phy";
> +
> +        resets = <&reset1 4 4>, <&reset0 4 4>;
> +        reset-names = "phy", "ctrl";
> +
> +        #phy-cells = <0>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> deleted file mode 100644
> index 643948b6b576..000000000000
> --- a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> -===========================================
> -
> -This binding describes the USB PHY hardware provided by the RCU module on the
> -Lantiq XWAY SoCs.
> -
> -This node has to be a sub node of the Lantiq RCU block.
> -
> --------------------------------------------------------------------------------
> -Required properties (controller (parent) node):
> -- compatible	: Should be one of
> -			"lantiq,ase-usb2-phy"
> -			"lantiq,danube-usb2-phy"
> -			"lantiq,xrx100-usb2-phy"
> -			"lantiq,xrx200-usb2-phy"
> -			"lantiq,xrx300-usb2-phy"
> -- reg		: Defines the following sets of registers in the parent
> -		  syscon device
> -			- Offset of the USB PHY configuration register
> -			- Offset of the USB Analog configuration
> -			  register (only for xrx200 and xrx200)
> -- clocks	: References to the (PMU) "phy" clk gate.
> -- clock-names	: Must be "phy"
> -- resets	: References to the RCU USB configuration reset bits.
> -- reset-names	: Must be one of the following:
> -			"phy" (optional)
> -			"ctrl" (shared)
> -
> --------------------------------------------------------------------------------
> -Example for the USB PHYs on an xRX200 SoC:
> -	usb_phy0: usb2-phy@18 {
> -		compatible = "lantiq,xrx200-usb2-phy";
> -		reg = <0x18 4>, <0x38 4>;
> -
> -		clocks = <&pmu PMU_GATE_USB0_PHY>;
> -		clock-names = "phy";
> -		resets = <&reset1 4 4>, <&reset0 4 4>;
> -		reset-names = "phy", "ctrl";
> -		#phy-cells = <0>;
> -	};
> -- 
> 2.36.1
> 
> 
