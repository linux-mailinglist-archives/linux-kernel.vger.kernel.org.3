Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5084AE867
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347166AbiBIEJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbiBIDUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:20:32 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40690C0613CC;
        Tue,  8 Feb 2022 19:20:31 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso644240ott.7;
        Tue, 08 Feb 2022 19:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdQVNApM57taqQgD/NZRSOMXZsBoQXgaGeZXyEv+t4I=;
        b=QqombAXYQZa/PGhtpCItQ0hJV38gvViubn757gp/sUNAz73mIIevOVxYiaJUOkLdxZ
         V4HiEFJ0WhPornk6A1tPq0uf9VvJHoPnF7fGyResrnDI/djQbvKcf7nG+Qb75fP/jNoz
         58Aq+9AofZzvtzWI3ONKkWkgVy/Qt/rTQOGIort4FITJw8mQhFnvPEnyCrMYHDmXRqTL
         fERsvCx4Drix16ecYrA5LlVp/aOwjCHRq4JixMTcFsD0C2imEa9bfmXqb/gMmzKQYd6k
         CPXGd3AShUWMbO0OOcSXtZEfIpsa88BNjAbrUxtLf3wHVZGH9pC5iaK8/GV4u6KcSC5T
         T37w==
X-Gm-Message-State: AOAM5338TvqpHkUdQTd0lzm8x46zYx2xGZuXn0V+3xokGOnBeAqZQDT9
        5hoYOcQDORnlm37/5S4agQahj819Fg==
X-Google-Smtp-Source: ABdhPJyDXby0X48vpe/WjclBIIse+1y7tQFhP5v+u0kUS+sXrbfyjK6JDuWFThkBPr1v+Zg0wgZ9zg==
X-Received: by 2002:a05:6830:2466:: with SMTP id x38mr162568otr.33.1644376830320;
        Tue, 08 Feb 2022 19:20:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t2sm6190687ooo.24.2022.02.08.19.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:20:29 -0800 (PST)
Received: (nullmailer pid 3567489 invoked by uid 1000);
        Wed, 09 Feb 2022 03:20:28 -0000
Date:   Tue, 8 Feb 2022 21:20:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
Message-ID: <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
References: <20220125200009.900660-1-hugo@hugovil.com>
 <20220125200009.900660-11-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125200009.900660-11-hugo@hugovil.com>
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

On Tue, Jan 25, 2022 at 03:00:09PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The PCF2131 has two output interrupt pins, named INT_A and INT_B.
> 
> Add properties to identify onto which pin we want the alarm interrupt
> to be routed. It can be either one, or both.
> 
> These properties are automatically set to false for variants other
> than PCF2131 (ex: PCF2127).
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> index 57eb0a58afa3..83656dd2f97f 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -24,6 +24,16 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  alarm-output-a:

nxp,alarm-output-a

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable alarm interrupt on INT_A output pin.
> +
> +  alarm-output-b:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable alarm interrupt on INT_B output pin.
> +
>    start-year: true
>  
>    reset-source: true
> @@ -32,6 +42,18 @@ required:
>    - compatible
>    - reg
>  
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          enum:
> +            - nxp,pcf2131
> +then:
> +  properties:
> +    alarm-output-a: false
> +    alarm-output-b: false
> +
>  additionalProperties: false
>  
>  examples:
> @@ -62,6 +84,7 @@ examples:
>              pinctrl-0 = <&rtc_nint_pins>;
>              interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
>              reset-source;
> +            alarm-output-b;
>          };
>      };
>  
> -- 
> 2.30.2
> 
> 
