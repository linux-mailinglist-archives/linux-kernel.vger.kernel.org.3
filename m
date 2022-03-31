Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2509B4EE352
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241545AbiCaVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiCaVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:24:55 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B0236BB8;
        Thu, 31 Mar 2022 14:23:07 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so755358otq.13;
        Thu, 31 Mar 2022 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzLcBKO/XDK59tDp87Wl8eFLtQUNXGUQdW4J6/vdSnM=;
        b=sJnOoIoNnpCOpcojn3p+SMLCY579fG5qEOCu5bcLF9q4hdZsy/SYOEK9pNdo6y6+si
         gxAafF3F66JLNwIDfohbH+FEz0Zn4RbvZQaRibfdpOPZnYoILsXlVEUyXgC27+mVN975
         rc3nl7L+MFGtP3z2p30pQUvfMzodOKn5XMDYWV+z9pte8ljZudkcY5iwLE87rxvzg8b1
         +u+wu85AvkRkrtQ3ivs43rPc/oEtMM4usXuzxAjGFlsfnMwhnLpyX6fNtdQNID7jTXUD
         HKE3LuqIGX/g6GVVtfUUuogKvD5Z5OB6IDYNR2Ju6EahSOofxDkZXoyW44No5R/GFuWG
         Y0kw==
X-Gm-Message-State: AOAM533QFlX4kc2+PdeS7LATpy1/IT9z/TJS19fAp9UBum8Q/dKt1h/P
        BQh4tyN87VuQTfMYnz0/kQ==
X-Google-Smtp-Source: ABdhPJwseFEEdKZk3qwsEVG8HRLBOBuwND9QrZ5NLEH5I03RtbXWF+Qpo07hT4Xv0inLxP4ssIR7fw==
X-Received: by 2002:a05:6830:2099:b0:5c9:4715:2c80 with SMTP id y25-20020a056830209900b005c947152c80mr6518629otq.244.1648761786754;
        Thu, 31 Mar 2022 14:23:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x18-20020a056830245200b005ce01c28c77sm333676otr.1.2022.03.31.14.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:23:06 -0700 (PDT)
Received: (nullmailer pid 1522501 invoked by uid 1000);
        Thu, 31 Mar 2022 21:23:05 -0000
Date:   Thu, 31 Mar 2022 16:23:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: soc: apple: Add Apple SART
Message-ID: <YkYbubNBD+J2XUCg@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-2-sven@svenpeter.dev>
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

On Mon, Mar 21, 2022 at 05:50:41PM +0100, Sven Peter wrote:
> Apple SoCs such as the M1 come with a simple DMA address filter called
> SART. Unlike a real IOMMU no pagetables can be configured but instead
> DMA transactions can be allowed for up to 16 paddr regions.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/soc/apple/apple,sart.yaml        | 52 +++++++++++++++++++

Close enough to an IOMMU in terms of its purpose, so put in 
bindings/iommu/

>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> new file mode 100644
> index 000000000000..d8177b3a3fba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/apple/apple,sart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SART DMA address filter
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description:
> +  Apple SART is a simple address filter for DMA transactions. Regions of
> +  physical memory must be added to the SART's allow list before any
> +  DMA can target these. Unlike a proper IOMMU no remapping can be done and
> +  special support in the consumer driver is required since not all DMA
> +  transactions of a single device are subject to SART filtering.
> +
> +  SART1 has first been used since at least the A11 (iPhone 8 and iPhone X)
> +  and allows 36 bit of physical address space and filter entries with sizes
> +  up to 24 bit.
> +
> +  SART2, first seen in A14 and M1, allows 36 bit of physical address space
> +  and filter entry size up to 36 bit.
> +
> +  SART3, first seen in M1 Pro/Max, extends both the address space and filter
> +  entry size to 42 bit.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - apple,t6000-sart
> +      - apple,t8103-sart
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sart@7bc50000 {
> +      compatible = "apple,t8103-sart";
> +      reg = <0x7bc50000 0x4000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d4a34a..027c3b4ad61c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1774,6 +1774,7 @@ F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/apple*
> +F:	Documentation/devicetree/bindings/soc/apple/*
>  F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
> -- 
> 2.25.1
> 
> 
