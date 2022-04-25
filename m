Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA250EBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiDYW0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbiDYWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:08:07 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FFA13DF5;
        Mon, 25 Apr 2022 15:05:00 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-deb9295679so17562657fac.6;
        Mon, 25 Apr 2022 15:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/357n4d4PC5YAq5NidvohooacKB5fUdQBW6Hucbgps=;
        b=f9e2kPji76y7S8LW8opig1/hPl0HNqz+V6/gMyw5DoR22aUIGIKC9B4eXQVAz7S7OO
         +GkqKNXgXF6+4gmCGaK9T7Z9ihQliygU1tjXpJHGQ7U2HrhN0j3pd3MV78ToS1X3ELR4
         okDyC1qz1Fe7OSQdmg8XmmiJCiLSXh9ncnnN4K6EZJUq/VO6/uVzCplML+E/z7Qrgdr9
         xnT3e4gaNBBJc6H5vDRcVA8Jo2fM2/Jzlpm9EJYz/av6+gbTPZWU3djV0z/pVj2fz+B+
         gA8Wmbe5nZdunvQVvBKPSVTv3du36OItWISqxJoSrN/OyYbEo7qHVdkBt5bwKJoRKnDa
         /muQ==
X-Gm-Message-State: AOAM533Qw64PXUAaT+9zA5C2GWMipyQdQtEjXmg8PcGSQhjg7iOa6dVF
        VvtXsaM0gZLo0QcNRZYgzA==
X-Google-Smtp-Source: ABdhPJw+13gRwqKTE4KCf4uh5v9udRaFyOju2a4GrnrwgI4sxoE14O7swvkeJZIz+clMKl759cYWfQ==
X-Received: by 2002:a05:6870:e3d1:b0:e9:25a0:f5d8 with SMTP id y17-20020a056870e3d100b000e925a0f5d8mr4284283oad.132.1650924299987;
        Mon, 25 Apr 2022 15:04:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a056870440700b000e686d1387asm165030oah.20.2022.04.25.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 15:04:59 -0700 (PDT)
Received: (nullmailer pid 377536 invoked by uid 1000);
        Mon, 25 Apr 2022 22:04:58 -0000
Date:   Mon, 25 Apr 2022 17:04:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, joel@jms.id.au, arnd@arndb.de,
        openbmc@lists.ozlabs.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Message-ID: <YmcbCgjD85lIRMSf@robh.at.kernel.org>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-7-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421192132.109954-7-nick.hawkins@hpe.com>
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

On Thu, Apr 21, 2022 at 02:21:27PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the hpe gxp watchdog timer binding hpe,gxp-wdt.
> This will enable support for the HPE GXP Watchdog.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v5:
> * Fixed version log
> v4:
> * Made watchdog a child of timer because of same register
>   area based on review feedback
> * Simplified the watchdog yaml as it will get information
>   from parent device
> v3:
> * Used proper patchset format.
> v2:
> * Converted from txt to yaml
> ---
>  .../bindings/watchdog/hpe,gxp-wdt.yaml        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> new file mode 100644
> index 000000000000..c20da146352f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/hpe,gxp-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Controlled Watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-wdt
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog0:  watchdog {
> +      compatible = "hpe,gxp-wdt";

How is this h/w controlled? I'm guessing it's part of the timer? If so, 
you don't need this node. A single node can implement multiple 
functions.

Rob
