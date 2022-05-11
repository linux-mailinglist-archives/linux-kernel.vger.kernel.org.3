Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96C523612
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiEKOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245053AbiEKOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:37 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A20EBA;
        Wed, 11 May 2022 07:46:33 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3065774fac.7;
        Wed, 11 May 2022 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfuehUssF8wu6LG3RnYdg+lZQPY12BDtvzgK0Zdpdx0=;
        b=wOK4dWIocgR1rwbEKAnuTBdSCX/qTtvEDcMtx1cjQwsA1SZ3WMvEBm634lQRFb6swI
         aS3ic8KPGhbqvjYLOKJ4sAk9bMz9XMDgAohmAajuu8y73annoJUmGvbpodQFCFhtzPF6
         XnXBuAptzorfXR6cQP2ZSuP7PtLw8EFlcFv6t7Byzkg35yI0/EqC5Csi+yrWje5w6t8F
         Zb+48vJS2Mr0SLfdg1b2m0GN/EM0HJexI9GL928ldJ8ikiAv4x2mctcU0minfLsduu+4
         gbzPhNcaiOK9HU6BVGFIkVgqfLRSYXivVuNqZCv/2pih7o53CKXI8MRXWNq4KONQRYUG
         ksPw==
X-Gm-Message-State: AOAM532iyf67SCnsmjDpv3Et7jTiarDj6xeHMWj1HGp47gr3m3NOT+R3
        UUQde8UR6EgCLjXbxYKSHbGw/twjwQ==
X-Google-Smtp-Source: ABdhPJwQ6FVOdvVGJwNLOcsZAf2TDK642Er/IkyYDEfsDMwwC8KKHolJ5JWYjnJAjlRRvEJwuoo1Qg==
X-Received: by 2002:a05:6870:3c1b:b0:ee:1585:7a58 with SMTP id gk27-20020a0568703c1b00b000ee15857a58mr2995725oab.110.1652280392928;
        Wed, 11 May 2022 07:46:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020a4a9642000000b0035eb4e5a6d2sm952107ooi.40.2022.05.11.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:46:32 -0700 (PDT)
Received: (nullmailer pid 285281 invoked by uid 1000);
        Wed, 11 May 2022 14:46:31 -0000
Date:   Wed, 11 May 2022 09:46:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kbuild-all@lists.01.org, bbasu@nvidia.com,
        vsethi@nvidia.com, jsequeira@nvidia.com
Subject: Re: [Patch v5 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 CBB1.0 binding
Message-ID: <20220511144631.GA272915-robh@kernel.org>
References: <20220506111217.8833-1-sumitg@nvidia.com>
 <20220506111217.8833-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506111217.8833-3-sumitg@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:42:10PM +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent the error handling
> driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.

Bindings are for h/w not drivers.

> The driver prints debug information about failed transactions due to
> illegal register accesses on receiving interrupt from CBB.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra194-cbb.yaml        | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
> new file mode 100644
> index 000000000000..3167f0450298
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra194 CBB 1.0 device tree bindings

'device tree bindings' is redundant

> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +
> +description: |+
> +  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
> +  register configuration space. CBB 1.0 has multiple hierarchical sub-NOCs (Network-on-Chip) and
> +  connects various initiators and targets using different bridges like AXIP2P, AXI2APB.
> +
> +  This driver handles errors due to illegal register accesses reported by the NOCs inside the CBB.
> +  NOCs reporting errors are cluster NOCs "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB
> +  Central NOC" which is the main NOC.
> +
> +  By default, the access issuing initiator is informed about the error using SError or Data Abort
> +  exception unless the ERD (Error Response Disable) is enabled/set for that initiator. If the ERD
> +  is enabled, then SError or Data Abort is masked and the error is reported with interrupt.
> +
> +  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So, the errors due to illegal
> +    accesses from CCPLEX are reported by interrupts. If ERD is not set, then error is reported by
> +    SError.
> +  - For other initiators, the ERD is disabled. So, the access issuing initiator is informed about
> +    the illegal access by Data Abort exception. In addition, an interrupt is also generated to
> +    CCPLEX. These initiators include all engines using Cortex-R5 (which is ARMv7 CPU cluster) and
> +    engines like TSEC (Security co-processor), NVDEC (NVIDIA Video Decoder engine) etc which can
> +    initiate transactions.
> +
> +  The driver prints relevant debug information like Error Code, Error Description, Master, Address,
> +  AXI ID, Cache, Protection, Security Group etc on receiving error notification.

Please wrap at 80. Longer is allowed, but should still be the exception.

> +
> +properties:
> +  $nodename:
> +    pattern: "^[a-z]+-noc@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra194-cbb-noc
> +      - nvidia,tegra194-aon-noc
> +      - nvidia,tegra194-bpmp-noc
> +      - nvidia,tegra194-rce-noc
> +      - nvidia,tegra194-sce-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      CCPLEX receives secure or nonsecure interrupt depending on error type. A secure interrupt is
> +      received for SEC(firewall) & SLV errors and a non-secure interrupt is received for TMO & DEC
> +      errors.
> +    items:
> +      - description: non-secure interrupt
> +      - description: secure interrupt
> +
> +  nvidia,axi2apb:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      Specifies the node having all axi2apb bridges which need to be checked for any error logged
> +      in their status register.
> +
> +  nvidia,apbmisc:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      Specifies the apbmisc node which need to be used for reading ERD register.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - nvidia,axi2apb
> +  - nvidia,apbmisc
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cbb-noc@2300000 {
> +        compatible = "nvidia,tegra194-cbb-noc";
> +        reg = <0x02300000 0x1000>;
> +        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
> +        nvidia,axi2apb = <&axi2apb>;
> +        nvidia,apbmisc = <&apbmisc>;
> +        status = "okay";

Don't need status in examples.


> +    };
> -- 
> 2.17.1
> 
> 
