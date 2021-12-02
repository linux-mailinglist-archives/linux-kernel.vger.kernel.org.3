Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50C465A82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354261AbhLBAQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:16:41 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43533 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354103AbhLBAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:42 -0500
Received: by mail-ot1-f43.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so16197928otu.10;
        Wed, 01 Dec 2021 16:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Su5uVtfC4tYXWdd9BOXOVaJYt86ikGsngAqLHjPcTh0=;
        b=7w4Mv/hHgg/KwrGab9q10/axdlNB6LldAcU5uX250xQSYI7FjiYx+kLbTz2bkk2bvF
         YTZyhvnlozS1jna80UNbPsAXpyQCiyav7odUtYBXYc3DVF1NC7paiGWv2/eyAjXpgLZu
         nPaNJ2MKwtS0CzZcckkVPK6K4d1KqcANzRJoSD36qusZU634vju4pqqux3Zulou5oBl+
         W6lt6bcwwzs6S0+o7rAJVLG6ucv6MAaWlkGlqj5eouqVIcVbQidCFeNODrLXMelhlqZu
         bq4LVROXo4FEg+NTfDpQhrbZQ5VLaIE9Ehkx0pB12R9RSH/mw7sJvjgUxyzvRv1Pz/7l
         EcFw==
X-Gm-Message-State: AOAM533BEtmdso7Dl+6oLIkjU4IZcIwX1Sk8Gqzg9t1sn0OKOtDSTxqH
        RoHeGehuGDmhl0O1IWI3G0038Frc6A==
X-Google-Smtp-Source: ABdhPJxfjoFZ+5kdBbV/2x6TDuosIgYNNUSX7+mXwQDatQyDU1615j6jym7P5wIhJOXDi1oGs99HFg==
X-Received: by 2002:a9d:6c18:: with SMTP id f24mr8892697otq.250.1638403880534;
        Wed, 01 Dec 2021 16:11:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u40sm772734oiw.56.2021.12.01.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:11:19 -0800 (PST)
Received: (nullmailer pid 3276942 invoked by uid 1000);
        Thu, 02 Dec 2021 00:11:19 -0000
Date:   Wed, 1 Dec 2021 18:11:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: timer: Add Mstar MSC313e timer
 devicetree bindings documentation
Message-ID: <YagPJ6aWLKFunWlG@robh.at.kernel.org>
References: <20211126202144.72936-1-romain.perier@gmail.com>
 <20211126202144.72936-5-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126202144.72936-5-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 09:21:42PM +0100, Romain Perier wrote:
> This adds the documentation for the devicetree bindings of the Mstar
> MSC313e timer driver, found from MSC313e SoCs and newer.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/timer/mstar,msc313e-timer.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> new file mode 100644
> index 000000000000..f4d43e141dd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar MSC313e Timer Device Tree Bindings
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mstar,msc313e-timer
> +      - mstar,ssd20xd-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  start-year: true

This is an rtc property. You would need to $ref rtc.yaml, but then that 
also says the node name is 'rtc'. But why do you need a start year for a 
clocksource?

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    timer@6040 {
> +        compatible = "mstar,msc313e-timer";
> +        reg = <0x6040 0x40>;
> +        clocks = <&xtal_div2>;
> +        interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> -- 
> 2.33.0
> 
> 
