Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E474BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhLNTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:14:24 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36570 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhLNTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:14:23 -0500
Received: by mail-oi1-f172.google.com with SMTP id t23so28525379oiw.3;
        Tue, 14 Dec 2021 11:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWpO3ZY2ZJjXyj/9yda9D07WJ/IdCYOQyo9m/Lpd6cc=;
        b=66AlI+Yq1lWJOLVtgsjFThmgBCtn0L42vZmoKZ5Zn4V+rJV+gl1IuiQaKQVVL9oj8j
         nOaN6m1qYg1ktTiEhx377HV0hqVa/SfXMkLBncN3TDmVKzJKH4C9lrIvqEunCaeUVDrz
         3i+PqjDU5PgcaA3DU4K8T3je+DOSULCFe+xbJ+05wEa51ydjT4rrfQQCd8dXX4Q9RmJZ
         oAibLfdTxPbx/IY6wWLQwi+RBqHN2mUw4hypEINLbGpigSnFzuCc1AUsqfcmYX8OH9eX
         zSkgseBbK9G9xbY6BI17s8Vvr6DUVtEHvaozE44YgJoO3KuU9VP2rsuXHTbYhMxRzVfO
         q+zA==
X-Gm-Message-State: AOAM532olpXLiLJ7XHksEWa2NW6AiiRECi+o0ZDOxvS1K5+XsF2HTuS+
        X2huELoS9Rx/XCNmz25llg==
X-Google-Smtp-Source: ABdhPJwgbIMh5siyTq0QCRyiUVnHcaDFGV5KSe35YUMIerqEIA57SUd69fvNXtBs2azIvORZLRQTQw==
X-Received: by 2002:aca:eb02:: with SMTP id j2mr2784153oih.3.1639509262396;
        Tue, 14 Dec 2021 11:14:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v20sm126884otj.27.2021.12.14.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:14:21 -0800 (PST)
Received: (nullmailer pid 3748250 invoked by uid 1000);
        Tue, 14 Dec 2021 19:14:20 -0000
Date:   Tue, 14 Dec 2021 13:14:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 14/15] dt-bindings: bus: Convert GISB arbiter to YAML
Message-ID: <YbjtDEPnDyOv/AvU@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-15-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-15-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:37:25PM -0800, Florian Fainelli wrote:
> Convert the Broadcom STB GISB bus arbiter to YAML to help with
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/bus/brcm,gisb-arb.txt | 34 ----------
>  .../bindings/bus/brcm,gisb-arb.yaml           | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
> deleted file mode 100644
> index 10f6d0a8159d..000000000000
> --- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Broadcom GISB bus Arbiter controller
> -
> -Required properties:
> -
> -- compatible:
> -    "brcm,bcm7278-gisb-arb" for V7 28nm chips
> -    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
> -    "brcm,bcm7435-gisb-arb" for newer 40nm chips
> -    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
> -    "brcm,bcm7038-gisb-arb" for 130nm chips
> -- reg: specifies the base physical address and size of the registers
> -- interrupts: specifies the two interrupts (timeout and TEA) to be used from
> -  the parent interrupt controller. A third optional interrupt may be specified
> -  for breakpoints.
> -
> -Optional properties:
> -
> -- brcm,gisb-arb-master-mask: 32-bits wide bitmask used to specify which GISB
> -  masters are valid at the system level
> -- brcm,gisb-arb-master-names: string list of the litteral name of the GISB
> -  masters. Should match the number of bits set in brcm,gisb-master-mask and
> -  the order in which they appear
> -
> -Example:
> -
> -gisb-arb@f0400000 {
> -	compatible = "brcm,gisb-arb";
> -	reg = <0xf0400000 0x800>;
> -	interrupts = <0>, <2>;
> -	interrupt-parent = <&sun_l2_intc>;
> -
> -	brcm,gisb-arb-master-mask = <0x7>;
> -	brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
> -};
> diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
> new file mode 100644
> index 000000000000..483b019275cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/brcm,gisb-arb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom GISB bus Arbiter controller
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm7445-gisb-arb
> +          - const: brcm,gisb-arb

> +      - items:
> +          - const: brcm,bcm7278-gisb-arb
> +      - items:
> +          - const: brcm,bcm7435-gisb-arb
> +      - items:
> +          - const: brcm,bcm7400-gisb-arb
> +      - items:
> +          - const: brcm,bcm7038-gisb-arb
> +      - items:
> +          - const: brcm,gisb-arb

All these can be 1 enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 3

We lost what is each interrupt. Do something like this:

minItems: 2
items:
  - description: ...
  - description: ...
  - description: ...

> +
> +  brcm,gisb-arb-master-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: >
> +      32-bits wide bitmask used to specify which GISB masters are valid at the
> +      system level
> +
> +  brcm,gisb-arb-master-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: >
> +      String list of the litteral name of the GISB masters. Should match the
> +      number of bits set in brcm,gisb-master-mask and the order in which they

LSB to MSB or ???

> +      appear

period         ^

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gisb-arb@f0400000 {
> +      compatible = "brcm,gisb-arb";
> +      reg = <0xf0400000 0x800>;
> +      interrupts = <0>, <2>;
> +      interrupt-parent = <&sun_l2_intc>;
> +      brcm,gisb-arb-master-mask = <0x7>;
> +      brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
> +    };
> -- 
> 2.25.1
> 
> 
