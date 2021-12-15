Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C79475C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhLOPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:48:16 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:33749 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244136AbhLOPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:48:15 -0500
Received: by mail-oo1-f48.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so6055350ooe.0;
        Wed, 15 Dec 2021 07:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWe46+RAeAhv8NF0hCOXC2BzwnA8Qf4Za9W9pdCQ3i4=;
        b=dfXOrGp0DhVFyAkstQIYvxwH2uK0DXAR75Y+MX12KVnN4Fok9/WEPYnu3iY1Lg64Jq
         qhD65M6h1395krNMLgoijh8SVK8azNlgdLvMoozTOw5FO7kjfemoCv++vmdR47d/tZ9x
         dtX6tPVjVOVbiaT9VTyNJrnIy3hFc2zTCSme7/O99cgiL4PoGPVWAN2uS/MhreneiT8/
         pMNTe5UpIAoQPu0RijoGNTGalBvDX8GMPdCQ2fjB+NiecmafiTVpTwvVHkMzZjuUDvSW
         /J8EwJ9GQd5zZQV2Vyyoe3R0l3rFlY9x9aIwZcoyPogej/KTKkHhBO2XuB4LjCyYx5vS
         wOUQ==
X-Gm-Message-State: AOAM5308qF8u3wK8LIX9NXVTyLbqDIOPgCON2yblDzwG8fbMo4Cwv8id
        aSkU/29H6Gd7qr/24SZjKg==
X-Google-Smtp-Source: ABdhPJzdctEjOEJ409DYQ3J/LdTeJQRWm7fGan8BXsK3rIpkYQPsb9T0JqpOHXUWRS4QqK/Wk46VBw==
X-Received: by 2002:a4a:d8c7:: with SMTP id c7mr7789817oov.58.1639583295075;
        Wed, 15 Dec 2021 07:48:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm426468oiw.22.2021.12.15.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:48:14 -0800 (PST)
Received: (nullmailer pid 1371708 invoked by uid 1000);
        Wed, 15 Dec 2021 15:48:13 -0000
Date:   Wed, 15 Dec 2021 09:48:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     stefan.wahren@i2se.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to
 json-schema
Message-ID: <YboOPd/xYWkL2JrJ@robh.at.kernel.org>
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

Am I supposed to review this? Some version of it is already in 
linux-next...

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
