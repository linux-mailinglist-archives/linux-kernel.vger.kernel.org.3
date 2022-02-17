Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4914BADEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiBRAAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:00:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiBRAAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:00:50 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09E43EDC;
        Thu, 17 Feb 2022 16:00:21 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id c14so1940698ioa.12;
        Thu, 17 Feb 2022 16:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Il/wZD+B4VL/ZBasXxovAwbatloL66gP+RpomVECt8w=;
        b=RLCfaQ7GhScBtu0amYjmOjumkgXhe3+HavMRFl2ctgJ587vmZPrryPtwzETgxURMuR
         bz2nj6BnZCsFC4K7kR4xzUlEI6sAfSgxX98DsRA6t9XBXCwD6amFZLN5K/b3Ze8XcEcv
         OBCPaeui/tXfzfWljyyFseAO6zRvEHoN9+gyUZXxpAQ2xEwmNIH5N7ExvrS7Ck1bblvj
         4kCFA+0FycN6sfm0/9WM7mKyX05fMkDNAD5YTpUGMaVfM3oQS0EnFQmifw560ozN9p5s
         M7RAGDIzIhQrqGJUXOC/m5S2p7EDpy6ZL/dIkOy6Nf7jF/EgJEdyvcrv9auXUr1UaW3B
         AHqA==
X-Gm-Message-State: AOAM531Bv+dsZE2b64dISo/jl8RJllxbr18LmzcWU691I7X/jZqXaYzv
        voV2x66sjm7b6nL6OMNeDbmNmL2w5Q==
X-Google-Smtp-Source: ABdhPJzGwfUv+iWf5iBYNyH6g/xHd5+slKxLYGt8kOXzTx5aIOjksgpcxSoJSYHT0umAK410egSZFw==
X-Received: by 2002:a02:a804:0:b0:30e:4778:559a with SMTP id f4-20020a02a804000000b0030e4778559amr3519947jaj.291.1645142363273;
        Thu, 17 Feb 2022 15:59:23 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q9sm2732858ilo.56.2022.02.17.15.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:59:22 -0800 (PST)
Received: (nullmailer pid 4014766 invoked by uid 1000);
        Thu, 17 Feb 2022 23:59:21 -0000
Date:   Thu, 17 Feb 2022 17:59:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 14/14] dt-bindings: rtc: pcf2127: add PCF2131
Message-ID: <Yg7hWRlxNY2zzg+B@robh.at.kernel.org>
References: <20220211205029.3940756-1-hugo@hugovil.com>
 <20220211205029.3940756-15-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211205029.3940756-15-hugo@hugovil.com>
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

On Fri, Feb 11, 2022 at 03:50:29PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add support for new NXP RTC PCF2131.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> index cde7b1675ead..57eb0a58afa3 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -14,7 +14,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: nxp,pcf2127
> +    enum:
> +      - nxp,pcf2127
> +      - nxp,pcf2131
>  
>    reg:
>      maxItems: 1
> @@ -48,4 +50,19 @@ examples:
>          };
>      };
>  
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        rtc@53 {
> +            compatible = "nxp,pcf2131";
> +            reg = <0x53>;
> +            pinctrl-0 = <&rtc_nint_pins>;
> +            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
> +            reset-source;
> +        };
> +    };

Just a new compatible doesn't really justify another example.

Rob
