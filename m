Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054D568C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiGFPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiGFPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:07:30 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748418390;
        Wed,  6 Jul 2022 08:07:29 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id z191so14254075iof.6;
        Wed, 06 Jul 2022 08:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I+N5AebuQqH0jlQLRd239QoK9Ox33sEr2sOU9qmAdeI=;
        b=XCnztQaDgc/sNAitwWmgRKjOmHoJ17a8DU7mosO8cYyuO5/yKDdIOzY80Tc45zxiZB
         3eCFiP1CW8oeTSgYuJDxM3CqINWb9wA4kQUNPOu8jupxUpQjrW6O1AydeUfTmLcCvmUJ
         BsTGIsqLt0raL05IUFiXNWLrVqBk3QlRd960EX4Ba2NCwSqQwYobILeaB5gJO2gflbqf
         BkhsyymuRPI6ff8ol3wQpx8y8tM4BcG0seEtbQZd6AGJJppao0xxS5EYW8DGSyS+iJ8x
         nW3QeSEF37MtTjWGU10jzUn8vWM7ckI7twku820jtbHEGvHFxNFmOjl2vPZKqAyp7mXV
         vwXQ==
X-Gm-Message-State: AJIora/Lbs5ZQ7qZ2YOHXdu+5B+l/NDhRpsj8YzdgmsKuXkmRQWcnGP/
        VLIfqyznZrLDLNzpxJgffFL5mzPrWg==
X-Google-Smtp-Source: AGRyM1u/v+SlHrKVZCbVrdRrUDL35cvfBUpgBdQqM1X6lZXvh4bPTZSzxIS4OlVZ6WnVzumcugqeVw==
X-Received: by 2002:a02:aa1a:0:b0:331:9183:9136 with SMTP id r26-20020a02aa1a000000b0033191839136mr24435755jam.242.1657120048487;
        Wed, 06 Jul 2022 08:07:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k1-20020a926f01000000b002dbee570531sm5683827ilc.18.2022.07.06.08.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:07:28 -0700 (PDT)
Received: (nullmailer pid 48246 invoked by uid 1000);
        Wed, 06 Jul 2022 15:07:26 -0000
Date:   Wed, 6 Jul 2022 09:07:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Message-ID: <20220706150726.GA40600-robh@kernel.org>
References: <20220705001023.14660-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705001023.14660-1-pali@kernel.org>
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

On Tue, Jul 05, 2022 at 02:10:22AM +0200, Pali Rohár wrote:
> GPIO is optional and used for WDI logic.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Changes in v3:
> * Extend description
> ---
>  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> index ab9641e845db..a0cf9e6c371d 100644
> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> @@ -27,6 +27,10 @@ properties:
>      description: This is a 1-byte memory-mapped address
>      maxItems: 1
>  
> +  gpios:

As I said before, add a name prefix: wdi-gpios

> +    description: Optional GPIO used for controlling WDI (watchdog input) when WDI bit is not mapped to memory

Wrap lines at 80 unless wrapping at 100 provides some benefit.

yamllint is set to 110 because I don't want to fix everyone's line wrap, 
not because that's the standard.


> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.20.1
> 
> 
