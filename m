Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8157506B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiGNOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiGNOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:10:45 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361F4B0F4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:10:44 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id d4so1007139ilc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdD/5MjcvRSypR8gVKFCvLm+xBKhFvbh6ia5PmYh4sE=;
        b=R1Qx53dpj34uBpYvf5LdpVioJ1JT5c5w8md+KB3aGhGSJuj2bAYJJ7w6uUXQp7o/Vu
         mjTGPvSWcVll6Uqd/aESmL3N5KrUKRTzlyHUVGmI66X/4+KpsB1q7R1+Pobmsh0SLg1h
         wxltEYWM4cQy3rjlQfLdn6JGKtY8DNRWUXPQEYicT6HzfJ0L1bxgMeHNHGG67ye1ByH8
         YpqS5qNsnOO1LiPjtrPWEoL6VZ/W6ypQ9fCavpm9u83Q7gStpQhO4V/+apLV7TrXzuCw
         58Cu7jVPKc4wzTKPzD6KcBPI+40YAEX+ns+eiuUoFcqcy/DD0ib8xdxjZJ0qok/SB1zf
         rrRw==
X-Gm-Message-State: AJIora8HqGSUz2fB3exLpRSWV4pAyaZKwZdO/FGf+VdmDN2/oDaRjzAg
        6SX/bzsBNaVYC9fwt5PROA==
X-Google-Smtp-Source: AGRyM1sPMV4W2UBrwLl8cXpTXjNRBW+X62579GqLa6ROiWu7HZU3vo7nbCEfSdnxT3ML2yVUdErf1A==
X-Received: by 2002:a05:6e02:148c:b0:2dc:386c:9a1a with SMTP id n12-20020a056e02148c00b002dc386c9a1amr4727971ilk.188.1657807843139;
        Thu, 14 Jul 2022 07:10:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a19-20020a027353000000b0033f3fcba96bsm759794jae.100.2022.07.14.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:10:42 -0700 (PDT)
Received: (nullmailer pid 2246944 invoked by uid 1000);
        Thu, 14 Jul 2022 14:10:41 -0000
Date:   Thu, 14 Jul 2022 08:10:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <20220714141041.GB2229197-robh@kernel.org>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707081826.953449-3-Naresh.Solanki@9elements.com>
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

On Thu, Jul 07, 2022 at 10:18:24AM +0200, Naresh Solanki wrote:
> Add a devicetree binding for the 9elements,output-supply driver.

Bindings are for h/w, not drivers.

> Example is also provided.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../regulator/9elements,output-supply.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml b/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml
> new file mode 100644
> index 000000000000..e4b67bc0794f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/userspace-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulator output-supply driver
> +
> +maintainers:
> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
> +
> +description: |
> +  Regulator output-supply driver helps interact with regulator.
> +  Provides regulator events & sysfs notify to capture regulator events
> +  in realtime for userspace application.
> +  This enables userspace application to monitor events in regulator(s) &
> +  handle them appropriately.

What does userspace have to do with hardware description?

> +
> +
> +properties:
> +  compatible:
> +    enum:
> +      - 9elements,output-supply

Why does this have a vendor prefix when it appears to be a s/w 
construct?

> +
> +  regulator-name:
> +    description: Name of the consumer line
> +
> +  regulator-boot-on:
> +    description: Enable regulator during boot
> +
> +  regulator-supplies:
> +    description: Supply names for this regulator. This can be multiple strings

What's the type for this? 

The supply names are the prefix on -supply properties.

> +
> +patternProperties:
> +  ".*-supply$":
> +    description: |
> +      Input supply phandle(s) for this node. There should be
> +      <supply-name>-supply to pass regulators handle
> +
> +required:
> +  - compatible
> +  - regulator-supplies
> +  - ".*-supply$"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    p12v_b_consumer {
> +        compatible = "9elements,output-supply";
> +        regulator-name = "BCM1";
> +        regulator-supplies = "vbus";
> +        vbus-supply = <&p12v_b>;
> +    };
> +
> +    ssb_rssd32 {
> +        compatible = "9elements,output-supply";
> +        regulator-name = "ssb_rssd32";
> +        regulator-supplies = "sw0", "sw1";
> +        sw0-supply = <&sw0_ssb_rssd32>;
> +        sw1-supply = <&sw1_ssb_rssd32>;
> +    };
> +...
> -- 
> 2.35.3
> 
> 
