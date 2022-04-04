Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695C4F1E14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380976AbiDDWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379039AbiDDQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:23:03 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A24BC0B;
        Mon,  4 Apr 2022 09:21:07 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id w20-20020a4ae9f4000000b003243aa2c71aso1843365ooc.0;
        Mon, 04 Apr 2022 09:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r0w3/IM/DK8MLze3NA1pY1MLeIm5PKANbh8od1nv6a8=;
        b=4mP9vbh5nbMmPCqmNPaZBRonRx5Tdx0wBIN7/kONuYAz/Rx+88VFPo2hetx5WeSgOU
         4bIYZbuRojDGY8fmx1Yc70rvFMRAwGRm3tVqL8whcmg9s25d1tyi0z6//zziu3kxJ6w6
         tyLnx7a+SWCTRIdxOqC+8jPLNhyHtpbGQ8kyC4STCOV7P8vzZSyMye5wIFKmD4g7KGNO
         jlX6B5WS9TsHskznIb654GTrwOrEI6HfkftOJ80IkizHM7wqeATh7bD46mgrwqJBwcgT
         qEWdduRKw6DlKuMY3hfYIAq7GBPvxzR54dyBqokQyNPvomMuuyw17S1fU1mKj/BTj1Pi
         Nr7A==
X-Gm-Message-State: AOAM531YQLzA25DRSP3RyT3wJGgHBKYgOet7KmkCt4sSKhXRYAcLYcol
        YknM9M1wt2yfHDCfIhEmUg==
X-Google-Smtp-Source: ABdhPJxZ2lRegJdMFkA7tUuOd3c5O6j+eHuUYGOmr3EKlhr7AoxqAk3be7/vjFqAeCZEN/co7BV85A==
X-Received: by 2002:a4a:3e02:0:b0:320:fdab:dcfd with SMTP id t2-20020a4a3e02000000b00320fdabdcfdmr149477oot.16.1649089266803;
        Mon, 04 Apr 2022 09:21:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm4391548oig.52.2022.04.04.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:21:06 -0700 (PDT)
Received: (nullmailer pid 1458009 invoked by uid 1000);
        Mon, 04 Apr 2022 16:21:05 -0000
Date:   Mon, 4 Apr 2022 11:21:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, krzk+dt@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v3 1/4] dt-bindings: Document Tegra CCPLEX Cluster
Message-ID: <Yksa8cvCvB2Zn7tn@robh.at.kernel.org>
References: <20220404121713.22461-1-sumitg@nvidia.com>
 <20220404121713.22461-2-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404121713.22461-2-sumitg@nvidia.com>
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

On Mon, Apr 04, 2022 at 05:47:10PM +0530, Sumit Gupta wrote:
> The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---

Changes from v2? None perhaps because you ignored my comments there.

>  .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> new file mode 100644
> index 000000000000..d89457e0bd7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra CPU COMPLEX CLUSTER area device tree bindings
> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +  - Mikko Perttunen <mperttunen@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  The Tegra CPU COMPLEX CLUSTER area contains memory-mapped
> +  registers that initiate CPU frequency/voltage transitions.
> +
> +properties:
> +  $nodename:
> +    pattern: "ccplex@([0-9a-f]+)$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra186-ccplex-cluster
> +      - nvidia,tegra234-ccplex-cluster
> +
> +  reg:
> +    maxItems: 1
> +
> +  nvidia,bpmp:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Specifies the BPMP node that needs to be queried to get
> +      operating point data for all CPUs.
> +
> +additionalProperties: true

Additionally, true is only allowed for incomplete, common bindings which 
this is not.

> +
> +required:
> +  - compatible
> +  - reg
> +  - nvidia,bpmp
> +  - status
> +
> +examples:
> +  - |
> +    ccplex@e000000 {
> +      compatible = "nvidia,tegra234-ccplex-cluster";
> +      reg = <0x0 0x0e000000 0x0 0x5ffff>;
> +      nvidia,bpmp = <&bpmp>;
> +      status = "okay";
> +    };
> -- 
> 2.17.1
> 
> 
