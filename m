Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477D4ED117
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbiCaAzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245288AbiCaAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:55:32 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD0193C9;
        Wed, 30 Mar 2022 17:53:46 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so16150906otk.8;
        Wed, 30 Mar 2022 17:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQOCLW2sewLQSkvDpv6e2/VDt8ehiygLDzP2cJZBDd4=;
        b=BYS2lTW9/AT5Oi+DpySUqF5WJuyhvskynbfygRuDXHKxffX+DF++nGHMeXb6BpBr1V
         vV1irPpa28BSdFipDI/leBQ7kZFaP9ihxKNus8wVTUPsjXOgJ/uJ1OlZZsVh4IJCkv4v
         BogVgxY7Y4orkOclML0HM4wlg0fDBE+zDQhWW9oF1KraxANXfJDKewXyEM9yNUBYIIQ2
         BnBvHYajGJWAuL4Gf5yyVlcm9xJFdVO9xxACv/qtjUDLdoZBSKrpBF3VwikG5j8g+Cud
         YvFEuWIZSaQIs6wc2vnQnWTabFGeCTHxIiuk/f4lwd5FqDrceNyC4umSNEF+5ZcnpJYl
         LNqA==
X-Gm-Message-State: AOAM53160tvZ1EcBpeqICw5qJvEWOvH+YX23h0BJgJhHEHWATVl6O3B5
        A0FYJveR8MwcbLJRytKPKw==
X-Google-Smtp-Source: ABdhPJy2IXGYnatFzBYUTeLTf8DvL4pYh4xD1bgYH/RgOfVeyfVeDByeag2N6mH06BJwImW9swaZyw==
X-Received: by 2002:a05:6830:40a9:b0:5c9:4a8d:ab1f with SMTP id x41-20020a05683040a900b005c94a8dab1fmr4790734ott.288.1648688025324;
        Wed, 30 Mar 2022 17:53:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d5a18000000b005ad458facbdsm11728168oth.27.2022.03.30.17.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 17:53:45 -0700 (PDT)
Received: (nullmailer pid 3988522 invoked by uid 1000);
        Thu, 31 Mar 2022 00:53:44 -0000
Date:   Wed, 30 Mar 2022 19:53:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, krzk+dt@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch v2 2/4] dt-bindings: arm: tegra: Add bindins for
 nvidia,tegra-ccplex-cluster
Message-ID: <YkT7mKas3pJF8tVb@robh.at.kernel.org>
References: <20220330143819.27476-1-sumitg@nvidia.com>
 <20220330143819.27476-3-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330143819.27476-3-sumitg@nvidia.com>
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

On Wed, Mar 30, 2022 at 08:08:17PM +0530, Sumit Gupta wrote:
> The Tegra CCPLEX_CLUSTER area contains memory-mapped
> registers that initiate CPU frequency/voltage transitions.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> new file mode 100644
> index 000000000000..74afa06f695e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra CPU_CLUSTER area device tree bindings
> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +  - Mikko Perttunen <mperttunen@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  The Tegra CCPLEX_CLUSTER area contains memory-mapped
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
> +      Specifies the bpmp node that needs to be queried to get
> +      operating point data for all CPUs.
> +
> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - nvidia,bpmp
> +  - status

status is never required.

> +
> +examples:
> +  - |
> +    ccplex@e000000 {
> +      compatible = "nvidia,tegra234-ccplex-cluster";
> +      reg = <0x0 0x0e000000 0x0 0x5ffff>;
> +      nvidia,bpmp = <&bpmp>;
> +      status = "okay";

Nor should it be in examples.

> +    };
> -- 
> 2.17.1
> 
> 
