Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3084854EB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378667AbiFPUb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiFPUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA95C850;
        Thu, 16 Jun 2022 13:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1514AB825C6;
        Thu, 16 Jun 2022 20:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7183C34114;
        Thu, 16 Jun 2022 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655411511;
        bh=MbWog7iJkiXGWGNEF0vvlSerlb5BzHWTqRrUhY0/NQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGcCbYbjG7GgmSBPJ15SR9ozis7yJ9LLZPSUB6S+dq4tlCdnEsWj1dGNJ8ARrohoC
         ShTP/M2VFiuoiKn/THwk+VRLvPQwxEyBeKfinWG0UKYjY8YB6r/GqpcI0knkd7OEnL
         OAXwhKV/4S1Nw+dVggBmTwZVzlI3XxABf27EzLutzsjzIbXgYnLOMA2B5LpcK0svhE
         Fu+DdyWLerwQ8yh0PrjPD+ah3bgyGQ4rMGtWdoN+x55iA6YOP1c6hrG6aGgN4+xOLI
         BjpYcUkZsptn/WSTjbLC5qOySVFH2lk2FLsrcqhJVapkAEf1tLZP02g9oYoj4/8Y7c
         p3hMy3BQKQOkg==
Date:   Fri, 17 Jun 2022 02:01:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 rda,8810pl-intc to YAML
Message-ID: <20220616203149.GF2889@thinkpad>
References: <20220611180703.GA24988@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220611180703.GA24988@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 08:07:03PM +0200, Stanislav Jakubek wrote:
> Convert RDA Micro interrupt controller bindings to DT schema format.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> 
> Changes in v2:
>   - drop the interrupt sources header file
> 
>  .../interrupt-controller/rda,8810pl-intc.txt  | 61 -------------------
>  .../interrupt-controller/rda,8810pl-intc.yaml | 43 +++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 44 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> deleted file mode 100644
> index e0062aebf025..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -RDA Micro RDA8810PL Interrupt Controller
> -
> -The interrupt controller in RDA8810PL SoC is a custom interrupt controller
> -which supports up to 32 interrupts.
> -
> -Required properties:
> -
> -- compatible: Should be "rda,8810pl-intc".
> -- reg: Specifies base physical address of the registers set.
> -- interrupt-controller: Identifies the node as an interrupt controller.
> -- #interrupt-cells: Specifies the number of cells needed to encode an
> -  interrupt source. The value shall be 2.
> -
> -The interrupt sources are as follows:
> -
> -ID	Name
> -------------
> -0:	PULSE_DUMMY
> -1:	I2C
> -2:	NAND_NFSC
> -3:	SDMMC1
> -4:	SDMMC2
> -5:	SDMMC3
> -6:	SPI1
> -7:	SPI2
> -8:	SPI3
> -9:	UART1
> -10:	UART2
> -11:	UART3
> -12:	GPIO1
> -13:	GPIO2
> -14:	GPIO3
> -15:	KEYPAD
> -16:	TIMER
> -17:	TIMEROS
> -18:	COMREG0
> -19:	COMREG1
> -20:	USB
> -21:	DMC
> -22:	DMA
> -23:	CAMERA
> -24:	GOUDA
> -25:	GPU
> -26:	VPU_JPG
> -27:	VPU_HOST
> -28:	VOC
> -29:	AUIFC0
> -30:	AUIFC1
> -31:	L2CC
> -
> -Example:
> -		apb@20800000 {
> -			compatible = "simple-bus";
> -			...
> -			intc: interrupt-controller@0 {
> -				compatible = "rda,8810pl-intc";
> -				reg = <0x0 0x1000>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -			};
> -		};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
> new file mode 100644
> index 000000000000..96d6285d0087
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/rda,8810pl-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RDA Micro RDA8810PL interrupt controller
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: rda,8810pl-intc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    intc: interrupt-controller@0 {
> +      compatible = "rda,8810pl-intc";
> +      reg = <0x0 0x1000>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0a90b256b26..58a35519b7c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2590,7 +2590,7 @@ L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/rda.yaml
>  F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
> -F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
> +F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.yaml
>  F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
>  F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
>  F:	arch/arm/boot/dts/rda8810pl-*
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
