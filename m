Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969074801BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhL0Qnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:43:41 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:45649 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhL0Qnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:43:40 -0500
Received: by mail-qk1-f170.google.com with SMTP id e25so9156606qkl.12;
        Mon, 27 Dec 2021 08:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jMdv9xd9PoSHjcMmTulIP1O3UGaGGGFNdoHfOX3Pq64=;
        b=NxPSbLCqxoqXk1GNe5oPI57GbJbl12NXr6VEqhF+udFe2GN5J7Tlee3cJLIQEfYPpl
         58OVhd35Y32cZOeRTufFc8pa9cm7IcsOYYA6FzbqzaYnwlPBsRr3z+nXR8r/H+Y+KU8x
         vMvTfViollPXprSlOdNWg2wXd1rIbStuMOKTYfSLZvTe9eUrTp+4ceLO2XwvX4yijVDm
         re0blqpER24wfI3synqy9h5JCILPWbqjs08owoR6+k1SUckv48+uAeyJOWDHSneHIDs7
         TfRJN2ZQkN3W2C//cRLiH22Xt24YgwY/V1pfWoxLMOy6HdBQCsIK8xvMuMGYORTO2XnQ
         3tDw==
X-Gm-Message-State: AOAM531OmHrcrgglCw0ok73P1Imq7/VtwbQZIAJVJ/qY/CyG9/aG7Jpz
        sYLVYrZEg5gL15cRLNJUOw==
X-Google-Smtp-Source: ABdhPJxMQh8LnbwbTtqBVlk0XLUYP7bjASwZRhN7o9JN5O3G0NMtglZO6GHrRdEklfXZke5t26TDqg==
X-Received: by 2002:a05:620a:b47:: with SMTP id x7mr12386678qkg.749.1640623419748;
        Mon, 27 Dec 2021 08:43:39 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d17sm13373495qtx.96.2021.12.27.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 08:43:38 -0800 (PST)
Received: (nullmailer pid 631653 invoked by uid 1000);
        Mon, 27 Dec 2021 16:43:37 -0000
Date:   Mon, 27 Dec 2021 12:43:37 -0400
From:   Rob Herring <robh@kernel.org>
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, tony.huang@sunplus.com,
        wells.lu@sunplus.com
Subject: Re: [PATCH v5 1/2] dt-binding: misc: Add iop yaml file for Sunplus
 SP7021
Message-ID: <YcntOas63oWyZ1sq@robh.at.kernel.org>
References: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
 <edc63b968d7903cc6e96151c7e51cd6446835b70.1640332430.git.tonyhuang.sunplus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc63b968d7903cc6e96151c7e51cd6446835b70.1640332430.git.tonyhuang.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 04:35:55PM +0800, Tony Huang wrote:
> Add iop yaml file for Sunplus SP7021
> 
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v5:
> -Add iop-wakeup pin for 8051 to wake up the Linux kernel in shutdown mode.
> 
>  .../devicetree/bindings/misc/sunplus-iop.yaml      | 72 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/sunplus-iop.yaml b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> new file mode 100644
> index 0000000..fad0f50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/sunplus-iop.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/sunplus-iop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus IOP(8051) controller
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +
> +description: |
> +  Processor for I/O control, RTC wake-up procedure management,
> +  and cooperation with CPU&PMC in power management.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-iop
> +
> +  reg:
> +    items:
> +      - description: IOP registers regions
> +      - description: PMC registers regions
> +      - description: MOON0 registers regions
> +
> +  reg-names:
> +    items:
> +      - const: iop
> +      - const: iop_pmc
> +      - const: moon0
> +
> +  interrupts:
> +    items:
> +      - description: IOP_INT0. IOP to system Interrupt 0.
> +                     Sent by IOP to system RISC.
> +      - description: IOP_INT1. IOP to System Interrupt 1.
> +                     Sent by IOP to system RISC.
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  iop-wakeup:
> +    description: Notify 8051 to wake up the Linux kernel.

What does that mean? What's the type? Does the standard 'wakeup-source' 
property not work here?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    iop: iop@9c000400 {
> +        compatible = "sunplus,sp7021-iop";
> +        reg = <0x9c000400 0x80>, <0x9c003100 0x80>, <0x9c000000 0x80>;
> +        reg-names = "iop", "iop_pmc", "moon0";
> +        interrupt-parent = <&intc>;
> +        interrupts = <41 IRQ_TYPE_LEVEL_HIGH>, <42 IRQ_TYPE_LEVEL_HIGH>;
> +        memory-region = <&iop_reserve>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&iop_pins>;
> +        iop-wakeup = <&pctl 1 GPIO_ACTIVE_HIGH>;

That's not how the GPIO binding works.

> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..071b5e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS IOP DRIVER
> +M:	Tony Huang <tonyhuang.sunplus@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/misc/sunplu-iop.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
