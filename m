Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C194AE780
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiBIDD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359736AbiBICvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:51:24 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175FBC061A73;
        Tue,  8 Feb 2022 18:49:39 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so627338otf.1;
        Tue, 08 Feb 2022 18:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jclCyrtXWfZiL4Vm3TsnMlAc9202oTga5v9E2y8S6Fc=;
        b=3AyHLw1ErTyomYMTus5YVq68jAL4EzLC1RJkoiK5uS+OkODEF729XiXL1Zt1g3hg+R
         StX/YC83HaSiYBbmFj2F3fAZK0xc2G73uILEoYFjt/bzbEaZNkoPEXBJY8V1WNSTK5Da
         jY5r07ejKl4PfNurWVm7eUyjDT21ynC5i+/2xTBRwdi411JvtOv3pvNn2qZmc2KQATTW
         sFpPZT1/OyAqjA3t14xRgxrAOgAYn5sNyb3DmpEvYNwIms7tYRuUwNmMc4nymEmBF49M
         Zm93kyCDUyDCW4Oy/3rboLDoEOCezNRsWqbzPeIG4XbKPb5EPoPiWl2tWAsclhCkwjE2
         IeZg==
X-Gm-Message-State: AOAM5330jsFxxHL+xuNVcrcMLJGnm9RUQZrIBm9Zggu4lyHdQ3s7/RlG
        3aGYJBLzFbKiDNs3yhSt5YJY/R6nzA==
X-Google-Smtp-Source: ABdhPJx5OHmjfCcXuOIwzjlCPm0lRM3HjNwQdZsy/ZJnSzxKqEg7e/efy9c9zqoKuHfIFT/b35La8w==
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr133492otu.224.1644374978393;
        Tue, 08 Feb 2022 18:49:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t13sm945095oai.37.2022.02.08.18.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:49:37 -0800 (PST)
Received: (nullmailer pid 3519040 invoked by uid 1000);
        Wed, 09 Feb 2022 02:49:36 -0000
Date:   Tue, 8 Feb 2022 20:49:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add realtek,otto-tc binding
Message-ID: <YgMrwEXraoiJxSXe@robh.at.kernel.org>
References: <cover.1642369117.git.sander@svanheule.net>
 <7c53821386b8f4c1c0ac440f1cd186e09f4a0456.1642369117.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c53821386b8f4c1c0ac440f1cd186e09f4a0456.1642369117.git.sander@svanheule.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 10:39:24PM +0100, Sander Vanheule wrote:
> New binding for the timer/counter blocks found on the Realtek Otto MIPS
> platform.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/timer/realtek,otto-tc.yaml       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> new file mode 100644
> index 000000000000..12971b9ecdf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/realtek,otto-tc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek Otto platform timer/counter bindings
> +
> +description:

'|' at the end if you want to keep formatting.

> +  "Up-counting 28-bit timer that can operate in oneshot or repeating mode,

And drop the quotes.

> +  providing an interrupt at roll-over.
> +
> +  The timer is driven by a divided clock, derived from the bus clock. The clock
> +  divisor is configurable from 2 to 65535. Divisor values of 0 and 1 disable
> +  the timer clock. The timer can also be enabled or disabled independently from
> +  the clock (divisor) selection.
> +
> +  The number of timers supported by the different SoC families is:
> +  - RTL8380: 5 timers
> +  - RTL8390: 5 timers
> +  - RTL9300: 6 timers
> +  - RTL9310: 7 timers"
> +
> +maintainers:
> +  - Sander Vanheule <sander@svanheule.net>
> +
> +properties:
> +  compatible:
> +    const: realtek,otto-tc

4 SoCs with differences in the block, you need 4 SoC specific 
compatibles. With a fallback if appropriate.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Parent clock from peripheral bus
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    timer0: timer@3100 {

Drop unused labels.

> +      compatible = "realtek,otto-tc";
> +      reg = <0x3100 0x10>;
> +
> +      interrupts = <29 4>;
> +
> +      clocks = <&lx_clk>;
> +      clock-names = "bus";
> +    };
> -- 
> 2.34.1
> 
> 
