Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EF51792D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387693AbiEBViD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387692AbiEBVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:37:59 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE26E0C1;
        Mon,  2 May 2022 14:34:29 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e189so16476037oia.8;
        Mon, 02 May 2022 14:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=od6wMrq3lWnqrs7gES4cSd3TdydkjWLYV24mBMiDKlo=;
        b=ryu7IolfbV1Ci5DV6G6814yde9E7bmZXUkr3XYto6uVna08L9xMxIzSAovTf7O9nLg
         cYEoriy/T2XP+3mCrC4eA9EOwxKcPMI6FxxIFp1NQkVh41RNasiPy5bZ/ZG2rH2Er8Su
         rvMhHu09jCf4nZQljaxsvZUdLr3DrePdiMgekMLDSaYoc9NNrsigIJNfbEr47CZy36Mq
         CPCe9Pbh+2yhRUwvI0rnPeQrY6zWDtQDSkpJ1O2Y/MtE/sRSYeUbziWCi7oSQRGEYu2B
         HShUJFBJxjhVLsCHKpwVZ+O5TVD2RgqkLF1cIrt69dome7C05V2papYlWhhcKHY6dGWa
         dn1Q==
X-Gm-Message-State: AOAM533/gddxx+B+PrC2kX4NxIfv7ziXa6K3fORnPQWCRuAo203Se96X
        nanBAbON+OxxoDjWOetxEQ==
X-Google-Smtp-Source: ABdhPJyorpEtmSdSN93uztknxDKv7UFnv79sElzFayQ+fURlJoaG5dnYnrGeD0zEldZ5z611/L9B+w==
X-Received: by 2002:a54:4513:0:b0:325:5f69:19ea with SMTP id l19-20020a544513000000b003255f6919eamr528831oil.111.1651527268665;
        Mon, 02 May 2022 14:34:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d3605000000b005b2353c5f4fsm3323863otb.0.2022.05.02.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:34:28 -0700 (PDT)
Received: (nullmailer pid 1797635 invoked by uid 1000);
        Mon, 02 May 2022 21:34:27 -0000
Date:   Mon, 2 May 2022 16:34:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     icenowy@outlook.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 05/12] dt-bindings: clock: sunxi-ng: add bindings for
 R329 CCUs
Message-ID: <YnBOY2EjW5ZWCAkx@robh.at.kernel.org>
References: <20220422140902.1058101-1-icenowy@aosc.io>
 <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR20MB2472A5F7269F56C2C6BB3104BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
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

On Fri, Apr 22, 2022 at 11:41:08PM +0800, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> R329 has a CPUX CCU and a R-CCU, with all PLLs in R-CCU.
> 
> Add bindings for them, with R-CCU only taking 3 oscillators as input and
> main CCU taking oscillators + PLLs as input.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../clock/allwinner,sun4i-a10-ccu.yaml        | 62 ++++++++++++++--
>  include/dt-bindings/clock/sun50i-r329-ccu.h   | 73 +++++++++++++++++++
>  include/dt-bindings/clock/sun50i-r329-r-ccu.h | 45 ++++++++++++
>  include/dt-bindings/reset/sun50i-r329-ccu.h   | 45 ++++++++++++
>  include/dt-bindings/reset/sun50i-r329-r-ccu.h | 24 ++++++
>  5 files changed, 241 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun50i-r329-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-r329-r-ccu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> index 15ed64d35261..c7a429e55483 100644
> --- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> +++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> @@ -45,6 +45,8 @@ properties:
>        - allwinner,sun50i-h6-r-ccu
>        - allwinner,sun50i-h616-ccu
>        - allwinner,sun50i-h616-r-ccu
> +      - allwinner,sun50i-r329-ccu
> +      - allwinner,sun50i-r329-r-ccu
>        - allwinner,suniv-f1c100s-ccu
>        - nextthing,gr8-ccu
>  
> @@ -106,6 +108,7 @@ else:
>            - allwinner,sun50i-a100-ccu
>            - allwinner,sun50i-h6-ccu
>            - allwinner,sun50i-h616-ccu
> +          - allwinner,sun50i-r329-r-ccu
>  
>    then:
>      properties:
> @@ -118,14 +121,57 @@ else:
>          maxItems: 3
>  
>    else:
> -    properties:
> -      clocks:
> -        minItems: 2
> -        maxItems: 2
> -
> -      clock-names:
> -        minItems: 2
> -        maxItems: 2
> +    if:
> +      properties:
> +        compatible:
> +          const: allwinner,sun50i-r329-ccu
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 13
> +          maxItems: 13

This is (or should be) implied by the size of 'items'. Did you find that 
to not be the case?

> +          items:
> +            - description: High Frequency Oscillator (usually at 24MHz)
> +            - description: Low Frequency Oscillator (usually at 32kHz)
> +            - description: Internal Oscillator
> +            - description: CPUX PLL
> +            - description: Peripherals PLL
> +            - description: Peripherals PLL (2x)
> +            - description: Peripherals PLL derivated 800MHz clock
> +            - description: Audio PLL 0
> +            - description: Audio PLL 0 (/2)
> +            - description: Audio PLL 0 (/5)
> +            - description: Audio PLL 1
> +            - description: Audio PLL 1 (2x)
> +            - description: Audio PLL 1 (4x)

> diff --git a/include/dt-bindings/clock/sun50i-r329-ccu.h b/include/dt-bindings/clock/sun50i-r329-ccu.h
> new file mode 100644
> index 000000000000..116f8d13a9b3
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun50i-r329-ccu.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Sipeed

It's 2022.

> diff --git a/include/dt-bindings/clock/sun50i-r329-r-ccu.h b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> new file mode 100644
> index 000000000000..c327d1a1b602
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun50i-r329-r-ccu.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

> diff --git a/include/dt-bindings/reset/sun50i-r329-ccu.h b/include/dt-bindings/reset/sun50i-r329-ccu.h
> new file mode 100644
> index 000000000000..bb704a82443f
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun50i-r329-ccu.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */

> diff --git a/include/dt-bindings/reset/sun50i-r329-r-ccu.h b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> new file mode 100644
> index 000000000000..40644f2f21c6
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun50i-r329-r-ccu.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */

Why the different licenses? GPL-2.0 OR BSD-2-Clause is preferred. MIT is 
fine if that's what matches the dts files.

Rob
