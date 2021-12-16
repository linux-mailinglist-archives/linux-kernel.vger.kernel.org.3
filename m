Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB3477ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhLPRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:45:47 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40629 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbhLPRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:45:45 -0500
Received: by mail-oi1-f180.google.com with SMTP id bk14so37505991oib.7;
        Thu, 16 Dec 2021 09:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LeFxsK8QyXU8K28445Wc60vnDZvxzxjUOcvj2+QjvVo=;
        b=uCLua88C/Ty/+NXeJG3l6dD/cIyiFdTt7NFjMdCx5+yj4QJHqofW/KnR52UL3sMzOY
         sv3g+u3GbZcR0dhZy06xUyjq6G4x7lotYdg9leTM4iFmL6eFQ3ZdoIcoNDDwKlFnoGiW
         aZd4LxQLQZRX7SEYsd/zBkkhptONmQfF6uj+DYYSOYeHztv3RCippJpygqR89JvBqJKF
         LtcA1PjOXWuQnqR9AhCVl21Wjsmz7ukH/19llPat48LjbMCChEGMYIMcumlMJ41diddB
         NH3AKu0NS5TKako0Dwx2cdI2JPXNoptEAtPxnZYapMUKJ64GCJB6+v8ju3rAHoaabxZp
         FPaw==
X-Gm-Message-State: AOAM5315vnHXFFTjqHLm/FpHA6e/dzB/hZ5bAE8giwudp6s5PBhz/tyI
        5JomPGwESr1A63G9zuFLXg==
X-Google-Smtp-Source: ABdhPJzvyF3D//1p2iui0IoSA2Y90lzPJXHaCu9FB5Oyua22AXVCfs+m7pWUPkmfB4yi4EKopZvGHA==
X-Received: by 2002:a05:6808:3c6:: with SMTP id o6mr5043144oie.145.1639676745275;
        Thu, 16 Dec 2021 09:45:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q10sm1123242oiw.17.2021.12.16.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:45:44 -0800 (PST)
Received: (nullmailer pid 457462 invoked by uid 1000);
        Thu, 16 Dec 2021 17:45:43 -0000
Date:   Thu, 16 Dec 2021 11:45:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     stefan.wahren@i2se.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to
 json-schema
Message-ID: <Ybt7RwjH6TAACqqh@robh.at.kernel.org>
References: <20211215094448.280796-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215094448.280796-1-nsaenz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:44:49AM +0100, Nicolas Saenz Julienne wrote:
> From: Stefan Wahren <stefan.wahren@i2se.com>
> 
> This converts the VCHIQ bindings to YAML format.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> 
> ---
> Changes since v2:
>  - Reinstate fallback compatible
> 
>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 17 ------
>  .../bindings/soc/bcm/brcm,bcm2835-vchiq.yaml  | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> deleted file mode 100644
> index f331316183f6..000000000000
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Broadcom VCHIQ firmware services
> -
> -Required properties:
> -
> -- compatible:	Should be "brcm,bcm2835-vchiq" on BCM2835, otherwise
> -		"brcm,bcm2836-vchiq".
> -- reg:		Physical base address and length of the doorbell register pair
> -- interrupts:	The interrupt number
> -		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> -
> -Example:
> -
> -mailbox@7e00b840 {
> -	compatible = "brcm,bcm2835-vchiq";
> -	reg = <0x7e00b840 0xf>;
> -	interrupts = <0 2>;
> -};
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> new file mode 100644
> index 000000000000..e04439b3355b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-vchiq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom VCHIQ firmware services
> +
> +maintainers:
> +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> +
> +description:
> +  The VCHIQ communication channel can be provided by BCM283x and Capri SoCs,
> +  to communicate with the VPU-side OS services.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: BCM2835 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm2835-vchiq
> +
> +      - description: BCM2836/BCM2837 based boards
> +        items:
> +          - enum:
> +              - brcm,bcm2836-vchiq
> +          - const: brcm,bcm2835-vchiq
> +
> +  reg:
> +    description: Physical base address and length of the doorbell register pair
> +    minItems: 1
> +
> +  interrupts:
> +    description: Interrupt number of the doorbell interrupt
> +    minItems: 1
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
> +    mailbox@7e00b840 {

A 'mailbox' node should have '#mbox-cells'. And be located in 
bindings/mailbox. That can all be a separate patch (or part of this one 
if you want).

Reviewed-by: Rob Herring <robh@kernel.org>

> +      compatible = "brcm,bcm2835-vchiq";
> +      reg = <0x7e00b840 0xf>;
> +      interrupts = <0 2>;
> +    };
> +
> +...
> -- 
> 2.33.1
> 
> 
