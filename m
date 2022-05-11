Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09978523623
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbiEKOuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiEKOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:50:02 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33E418A696;
        Wed, 11 May 2022 07:50:00 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3077501fac.7;
        Wed, 11 May 2022 07:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vs/jdIARLyUS4R/MgWXE0Jf8IecR+BWK4A0tuDfDDvc=;
        b=Bj5PQ3Vj8Ojvqwm9ZJP7NyF/317fy0xLoaTCansYx7tsB7pSC1EpiLRr0S7GXMxjWS
         XmO53syaHI7eK2XQCGKmOLXsKrE1P7quigrMrLyhrH5PndJdTC6D7T9ziSlKYywBgVd0
         LUlhiwB+GvfCmpF1DQ90RnHF743DDU3UlN0kXYPP7pv9YDJoTcYd4oS4UblnCsWQNndJ
         g6a4BNiS745Uq3ZWjmTYsS2HsaoNo7yMPPs8y9d0uQ/4HAiUQJt6caWMTFQ0EfIAisps
         eVZv0vox86c+8eMh25K4RXRybz11seEDM/5L1rV/M6RslT99lHmwu4Hw/k/IBsO1YkmU
         ZtnQ==
X-Gm-Message-State: AOAM5321pIotsf2m1A8zcL0BamkwtgJ5nI/SEDX4LPSlilg/962Lq0gB
        A+xzAvVSEgcTcqhesmQnoi1K5K4elw==
X-Google-Smtp-Source: ABdhPJzYqCqK6laB4KY/1/LWDt9Koobdw5SCAgQ9xC1F7/rvPhI1m57kq1o2hKFVYDaeySj/7NYuYg==
X-Received: by 2002:a05:6870:f143:b0:e6:6c21:3593 with SMTP id l3-20020a056870f14300b000e66c213593mr2982132oac.55.1652280600164;
        Wed, 11 May 2022 07:50:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q31-20020a056830441f00b0060603221257sm944797otv.39.2022.05.11.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:49:59 -0700 (PDT)
Received: (nullmailer pid 290281 invoked by uid 1000);
        Wed, 11 May 2022 14:49:58 -0000
Date:   Wed, 11 May 2022 09:49:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kbuild-all@lists.01.org, bbasu@nvidia.com,
        vsethi@nvidia.com, jsequeira@nvidia.com
Subject: Re: [Patch v5 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234
 CBB2.0 binding
Message-ID: <20220511144958.GA286838-robh@kernel.org>
References: <20220506111217.8833-1-sumitg@nvidia.com>
 <20220506111217.8833-7-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506111217.8833-7-sumitg@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:42:14PM +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent CBB2.0 (Control
> Backbone) error handling driver. The driver prints debug information
> about failed transaction on receiving interrupt from CBB2.0.

Same issues in this one that I won't repeat...

> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> new file mode 100644
> index 000000000000..fa4383be19d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +
> +description: |+
> +  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
> +  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
> +  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
> +  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
> +
> +  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
> +  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
> +  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
> +  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
> +  interrupt controller.
> +
> +  The driver handles errors from CBB due to illegal register accesses and prints debug information
> +  about failed transaction on receiving the interrupt from EN. Debug information includes Error
> +  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
> +  etc on receiving error notification.
> +
> +  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
> +  exception error response is masked and an interrupt is used for reporting errors due to illegal
> +  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
> +  compatibility with PCIE.
> +
> +properties:
> +  $nodename:
> +    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra234-aon-fabric
> +      - nvidia,tegra234-bpmp-fabric
> +      - nvidia,tegra234-cbb-fabric
> +      - nvidia,tegra234-dce-fabric
> +      - nvidia,tegra234-rce-fabric
> +      - nvidia,tegra234-sce-fabric
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: secure interrupt from error notifier
> +
> +additionalProperties: true

True is only allowed for common bindings included in other bindings.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cbb-fabric@1300000 {
> +      compatible = "nvidia,tegra234-cbb-fabric";
> +      reg = <0x13a00000 0x400000>;
> +      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
> +      status = "okay";
> +    };
> -- 
> 2.17.1
> 
> 
