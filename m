Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D244732E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhLMR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:26:57 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45847 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbhLMR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:26:55 -0500
Received: by mail-oi1-f170.google.com with SMTP id 7so24020524oip.12;
        Mon, 13 Dec 2021 09:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uT5K+dobELzQL3BFp46zypn9eqMneODf83+eLIbB26U=;
        b=nSRX0KqtSJotPL9oGcxzirvjxLATOyE7mOoAILO5J+MVZyeJcW5Vn9i0bhuwvN4gTg
         B9jscEvbXpxglwpTD9XrMgRT9PUgGP8S58m6EWy1106uROpTOmFJNMfdeW2SZqKrTbNP
         yebaHbhgezUC+td0L0EwWZol8itpLE1p19Ir69ujH8B32zVCKfXcmFsShahptRDQC25T
         fr/SXmVT2EQzS2GMULvpK5Bzd5iL6dRvaLEHLtt5/QPB4mtoBFcww25CYP45KMHuU+QO
         haCfNx7hh0lsigqkZrXXSQK0Vk8UeOGo+j9OrL293n8ZVD3i/RsACDDO/ICJesQkgDRZ
         e1lw==
X-Gm-Message-State: AOAM531zwzqHIoXN4NXEuyJgs7XUg1tMH1itRLoFn6BB6QR4BmXm/kEU
        FZstWfrwumCvuwLV+xP9ZQ==
X-Google-Smtp-Source: ABdhPJye2tX92JYEA30JMuBhXmirrqJcC4ZKW22kWxJSNNizFvLZ2tllquyG4ikWLK0huZBQUQ72nw==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr28368884oiw.4.1639416414975;
        Mon, 13 Dec 2021 09:26:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r25sm2302884ote.73.2021.12.13.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 09:26:54 -0800 (PST)
Received: (nullmailer pid 1242841 invoked by uid 1000);
        Mon, 13 Dec 2021 17:26:53 -0000
Date:   Mon, 13 Dec 2021 11:26:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 1/2] dt-bindings:serial:Add bindings doc for Sunplus
 SoC UART Driver
Message-ID: <YbeCXYQuqjO3yoC6@robh.at.kernel.org>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-2-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639379407-28607-2-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:10:06PM +0800, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
> ---
> Changes in v4:
>  - no change.
>  - Reviewed-by : Rob Herring <robh@kernel.org> in v3.

That goes above your Signed-off-by.

> 
> Changes in v5:
>  - remove another two author's name, the whole driver already quite different compared 
>    with patch v1. The other two authors request me to remove it.
> 
>  .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> new file mode 100644
> index 0000000..ab66a0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
> +
> +maintainers:
> +  - Hammer Hsieh <hammer.hsieh@sunplus.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    aliases {
> +            serial0 = &uart0;
> +    };
> +
> +    uart0: serial@9c000900 {
> +        compatible = "sunplus,sp7021-uart";
> +        reg = <0x9c000900 0x80>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 0x28>;
> +        resets = <&rstc 0x18>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..f2ee40c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS UART DRIVER
> +M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
