Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427334D6480
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiCKPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiCKPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:25:47 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA661B65E2;
        Fri, 11 Mar 2022 07:24:44 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id n7so9658969oif.5;
        Fri, 11 Mar 2022 07:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wj8G09tyyau5yMZxls0yIJBXoGqCQIhnO/G1icNodFU=;
        b=dQzcaKSHwxCf38e73Xc5fEA62HPy5u2Ofw0f3oetRWPwRkcRr8xKFB3CcxWlJDdV0D
         mCLSPxhLVk7h2zTZvZbsWmMi58O9UqnQV7QLtDtNWECOkwoL/qIRRTy8BLS7Dr6udlTh
         WSifpb7vgf3+n6hlfsFRTtgluki0waB7SExGjtUn35MBs4Gbtx5M5uq3itjmEzObZdV6
         sJPmRtu+J22qa1YgamaL0U55lnvENEZy7hC7EkgAqiaqanF9kqzdWkygIOU9K9ZNY41s
         eMLAvzCEdnSu8+Pzid4A5qpifHouIhqPhXHrERBSikKH+5NfSNqBtSxHKSVS7IusQkE2
         827g==
X-Gm-Message-State: AOAM530Zo5fc56Qk3qssdT6avMwSbkO/CQ6NSFPCSE2mBFpWYhGTe8yB
        gSYghPaZMEr/IhnxsYsWMw==
X-Google-Smtp-Source: ABdhPJzzQzQLbkCyppMXDo/APn8Hm72RdGKl9lKuHngLjJNbvlPq/mreKAsrBqheGl31MgPNNCLJMA==
X-Received: by 2002:a05:6808:2122:b0:2da:3444:9908 with SMTP id r34-20020a056808212200b002da34449908mr7203108oiw.207.1647012283302;
        Fri, 11 Mar 2022 07:24:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a2f15000000b00320fca09b74sm3765248oop.1.2022.03.11.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:24:42 -0800 (PST)
Received: (nullmailer pid 3824535 invoked by uid 1000);
        Fri, 11 Mar 2022 15:24:41 -0000
Date:   Fri, 11 Mar 2022 09:24:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add power-efuse binding
Message-ID: <YitpuR+SlDiKh4eq@robh.at.kernel.org>
References: <20220308011811.10353-1-zev@bewilderbeest.net>
 <20220308011811.10353-2-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308011811.10353-2-zev@bewilderbeest.net>
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

On Mon, Mar 07, 2022 at 05:18:09PM -0800, Zev Weiss wrote:
> This can be used to describe a power output supplied by a regulator
> device that the system controls.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../devicetree/bindings/misc/power-efuse.yaml | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/power-efuse.yaml b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> new file mode 100644
> index 000000000000..5f8f0b21af0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/power-efuse.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/power-efuse.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic power efuse device
> +
> +maintainers:
> +  - Zev Weiss <zev@bewilderbeest.net>
> +
> +description: |
> +  This binding describes a physical power output supplied by a
> +  regulator providing efuse functionality (manual on/off control, and
> +  auto-shutoff if current, voltage, or thermal limits are exceeded).
> +
> +  These may be found on systems such as "smart" network PDUs, and
> +  typically supply power to devices entirely separate from the system
> +  described by the device-tree by way of an external connector such as
> +  an Open19 power cable:
> +
> +  https://www.open19.org/marketplace/coolpower-cable-assembly-8ru/

Not really a helpful link...

I still don't understand what the h/w looks like here. At least I now 
understand we're talking a fuse on power rail, not efuses in an SoC 
used as OTP bits or feature disables.

> +
> +properties:
> +  compatible:
> +    const: power-efuse
> +
> +  vout-supply:
> +    description:
> +      phandle to the regulator providing power for the efuse

Vout is a supply to the efuse and not the rail being fused? 

Sorry, I know nothing about how an efuse is implemented so you are going 
to have to explain or draw it.

> +
> +  error-flags-cache-ttl-ms:
> +    description:
> +      The number of milliseconds the vout-supply regulator's error
> +      flags should be cached before re-fetching them.

How does one fetch/read? the error flags?

> +
> +required:
> +  - compatible
> +  - vout-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    efuse {
> +        compatible = "power-efuse";
> +        vout-supply = <&efuse_reg>;
> +        error-flags-cache-ttl-ms = <500>;
> +    };
> -- 
> 2.35.1
> 
> 
