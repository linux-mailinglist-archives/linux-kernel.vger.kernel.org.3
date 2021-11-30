Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9F462A39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhK3CPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:15:15 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38764 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhK3CPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:15:13 -0500
Received: by mail-oi1-f181.google.com with SMTP id r26so38265048oiw.5;
        Mon, 29 Nov 2021 18:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kySY1jLIWmb/d9rGGP7AKU8g2DZOHFlN0dtFDWeAiUQ=;
        b=Rs1Kg6sMcgLj0r/ZO8hT1PhQ6Bq7MLVnSsiXwd8Iya65cgiyzci4Y/FL00xkSjrJrV
         TowqPLZTIY0pzZFehAMr1fvbN5qm5sKbGJKZCd6BBY1MO6zc+fZqoUOno9vLQOfjC0ED
         EFEQE2TiBrFju7uOVTU6g3iEURKQwREQhsa7lFCKubMZgIAW6Tv079viSJYbM7ySP5iK
         r6W+rdigwaZDM9ldanuc9A10u/QAl1Uz+PhKUHcKpHinhimqQO95Si573Ez26+RXqsaM
         pk0I0sP3YVUqIyYYHhu6io8vxF5LOmrE4vXh5mhaRiohMEbLFp0YoqfN5gab3Fu1hyGA
         Mg8g==
X-Gm-Message-State: AOAM5338QS5SHQDa3mRLxkUhV2S1SgD5TFxQBpkpO73ioM5EYPUySHuU
        p3nYOB16Zsar+Dqx70Vomv2THHYTWg==
X-Google-Smtp-Source: ABdhPJydLpwX10OsIdv9y2AqcypFLRjKhiotvNXFIPJ7gTIIzljy6WfKP3TlhTMVJmQVLEWi7xuogQ==
X-Received: by 2002:a05:6808:f8c:: with SMTP id o12mr1671490oiw.50.1638238315109;
        Mon, 29 Nov 2021 18:11:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s6sm3621912ois.3.2021.11.29.18.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:11:54 -0800 (PST)
Received: (nullmailer pid 1036795 invoked by uid 1000);
        Tue, 30 Nov 2021 02:11:53 -0000
Date:   Mon, 29 Nov 2021 20:11:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mka@chromium.org,
        ravisadineni@chromium.org, stern@rowland.harvard.edu,
        alcooperx@gmail.com, michal.simek@xilinx.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com
Subject: Re: [PATCH V2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb2244 Controller
Message-ID: <YaWIafw+XB8tknpJ@robh.at.kernel.org>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
 <20211122062834.1812005-2-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122062834.1812005-2-piyush.mehta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:58:33AM +0530, Piyush Mehta wrote:
> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
> provides an ultra-fast interface between a USB host controller and flash
> media cards.
> 
> Add dt-bindings documentation for Microchip's usb2244 Controller.
> USB224x is a USB 2.0 compliant ultra fast USB 2.0 multi-format,
> SD/MMC, and MS Flash Media Controllers.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> Changes for V2:
> - Update reset polarity, make reset ACTIVE LOW in the dt-binding document.
> - Added usbsd node under the usb controller (usb0) node.
> - Remove Warning: decoded text below may be mangled, UTF-8 assumed.
> 
> Review comments:
> Link: https://lore.kernel.org/lkml/CAL_JsqKu6vr3iCz1G7MtK6gyqAvn4s4mpuLOwPzJDEmyZeROig@mail.gmail.com/
> ---
>  .../devicetree/bindings/usb/microchip,usb2244.yaml | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
> new file mode 100644
> index 0000000..1854313
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/microchip,usb2244.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Bindings for the Microchip USB2244 Ultra Fast USB-SD Controller
> +
> +description:
> +  Microchip USB224x is a USB 2.0 compliant, Hi-Speed bulk only mass
> +  storage class peripheral controller intended for reading and writing
> +  to popular flash media from the xDPicture Card, Memory Stick (MS),
> +  Secure Digital (SD), and MultiMediaCard (MMC) families.
> +
> +  USB224x is a flash media card reader solution fully compliant with the
> +  USB 2.0 specification.
> +
> +maintainers:
> +  - Piyush Mehta <piyush.mehta@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: microchip,usb2244
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      The phandle and specifier for the GPIO that controls the RESET line of
> +      flash media controller.
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    usb0 {
> +        usbsd {
> +            compatible = "microchip,usb2244";
> +            reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> +        };

This is not how the USB device binding works. See usb-device.yaml.

> +    };
> +
> +...
> -- 
> 2.7.4
> 
> 
