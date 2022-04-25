Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5212150E582
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbiDYQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiDYQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:25:27 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671BB71A25;
        Mon, 25 Apr 2022 09:22:22 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-e2442907a1so16580715fac.8;
        Mon, 25 Apr 2022 09:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4CENEZKLdazSfBwTXd/Wd5rug0RnZCb0GE0cZM8DZsw=;
        b=IdR/kSsBa2TuG8roUhmM4ijt85cZP2kVzQgEM4YpqdxA44Qcuo4q6IleFXGbDCzdX3
         8d/fSRMiH6EEWD/q+31ScR5fDILWJuSWEYf/e+ZW0B1mMwUNGm6Y5Sk1XOCKy+oIzA+j
         bIIC8a15VKLNfIA36840ch1iaoKCEuHzlwubvSwkBasoIyKCV3sOnS/d+foiwz98hnm3
         RGYEZCjuPWmaKJMT2LUjMv6rHKTfFdIzwXnNj6y1UsY6FVnoJ+qqjZD1iGp8Gf+ZYYEY
         HeFYa3S+VWpwA+Z/dHuqYvD9pTICCelpH/dMpD0XyBrg/ndDp8osEmnRfXt/QsZslWDd
         l4gA==
X-Gm-Message-State: AOAM533gqysl+HFiBhgLj0/kkCF8vHfuxJEloBMegFyNNgEJIQCV36hy
        Cv+KwMx9vZ5AJo/Fagp1+g==
X-Google-Smtp-Source: ABdhPJyI/nEGtLPHWlc0Symt/VRUWTe4lUKlOBu98Q75GPEnylf//TQhRgBUI583eoUOFky3f9Ezxw==
X-Received: by 2002:a05:6870:ac06:b0:e9:cba:68cc with SMTP id kw6-20020a056870ac0600b000e90cba68ccmr5631933oab.144.1650903741623;
        Mon, 25 Apr 2022 09:22:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p17-20020a4a3651000000b0035d9b838f21sm4534439ooe.10.2022.04.25.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:22:21 -0700 (PDT)
Received: (nullmailer pid 3999297 invoked by uid 1000);
        Mon, 25 Apr 2022 16:22:20 -0000
Date:   Mon, 25 Apr 2022 11:22:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add ti,scale-data-fw
 property
Message-ID: <YmbKvN00F6vGawpE@robh.at.kernel.org>
References: <20220425052806.484590-1-dfustini@baylibre.com>
 <20220425052806.484590-2-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425052806.484590-2-dfustini@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 10:28:05PM -0700, Drew Fustini wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add documentation for ti,scale-data-fw property to enable I2C PMIC
> voltage scaling during deep sleep. The property contains the name of a
> binary file for the CM3 firmware to load.
> 
> Based on previous work by Russ Dill.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [dfustini: split from driver patch and convert to json-schema]
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> index 88d690de050c..d2c248d82384 100644
> --- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
> @@ -40,6 +40,12 @@ description: |+
>    override the pin's existing bias (pull-up/pull-down) and value (high/low) when
>    IO isolation is active.
>  
> +  Support for I2C PMIC Voltage Scaling
> +  ====================================
> +  It is possible to pass the name of a binary file to load into the CM3 memory.
> +  The binary data is the I2C sequences for the CM3 to send out to the PMIC
> +  during low power mode entry.
> +
>  properties:
>    compatible:
>      enum:
> @@ -67,6 +73,11 @@ properties:
>        mbox_wkupm3 child node.
>      maxItems: 1
>  
> +  ti,scale-data-fw:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Name of the firmware binary in /lib/firmware to copy to CM3 aux data

The location of firmware files is up to the OS.

Is there other firmware? If not, 'firmware-name' is the somewhat 
standard property for this.

What's the default name?

> +
>    ti,vtt-gpio-pin:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: GPIO pin connected to enable pin on VTT regulator
> -- 
> 2.32.0
> 
> 
