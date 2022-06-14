Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2175654BCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbiFNVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiFNVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:39:57 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01113CDA;
        Tue, 14 Jun 2022 14:39:56 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id r5so10837076iod.5;
        Tue, 14 Jun 2022 14:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unZFsQoQAWR2pVZAAakZd6F7Dh1f8xGDIsqx3gD2nuk=;
        b=tC6JmVsagFPfswDSCsdJGMq0uVN5Y5zImsQQeZFXdJ+ztgmAJF1o2iRh/clPTzc9cF
         0GinG1U/PhQzAbdbgSOFNbtkTDDUJZ8J+/XHIZ2gXBQSI33xPVmL4kV3n+3JaHXyTRiR
         1w6ro/68/eR1uGWMgWdmUDCAZOsM7yXbSS1Nq6Y2gXrqQlX8t7hsJznla4RexDFo+FfP
         cEq5ymsNKbKiyoktfhmrIDv0FD0NvmoPY1ymILE40kPF1EmPw5hwJzG19bRt+mMWxs1S
         TJxKgdALoSy//F/eL/V2y6IXA1wYMbIUTGlOyYWNX0751xp/xzzV1bwlGq+N1M/3nPsg
         HhUA==
X-Gm-Message-State: AOAM530HFx87xY/Q9IGAFuIKTObGoTPfEwvC0l4/xSQ1LklGJmn21RkV
        g3cVSjMu7RDIkM6NBbHt6Q==
X-Google-Smtp-Source: ABdhPJz09xbYRZDNi3/YsjjW6r/15AnlT22h/DBiEtxoVg3gRd4IjQT+4XzXcBpF5u5Q6wibbUz2sA==
X-Received: by 2002:a05:6602:1592:b0:669:f7c7:885b with SMTP id e18-20020a056602159200b00669f7c7885bmr3582962iow.54.1655242796097;
        Tue, 14 Jun 2022 14:39:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b0032ec5c47c17sm5258876jah.46.2022.06.14.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:39:55 -0700 (PDT)
Received: (nullmailer pid 2702517 invoked by uid 1000);
        Tue, 14 Jun 2022 21:39:53 -0000
Date:   Tue, 14 Jun 2022 15:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
Message-ID: <20220614213953.GA2693578-robh@kernel.org>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609125100.3496633-2-peng.fan@oss.nxp.com>
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

On Thu, Jun 09, 2022 at 08:50:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> resets and power gating for mixes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/power/fsl,imx93-src.yaml         | 96 +++++++++++++++++++
>  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
>  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> new file mode 100644
> index 000000000000..880500a841f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/fsl,imx93-src.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX93 System Reset Controller
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  The System Reset Controller (SRC) is responsible for the generation of
> +  all the system reset signals and boot argument latching.
> +
> +  Its main functions are as follows,
> +  - Deals with all global system reset sources from other modules,
> +    and generates global system reset.
> +  - Responsible for power gating of MIXs (Slices) and their memory
> +    low power control.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx93-src
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  slices:

power-controller

But if there aren't any other child nodes for the SRC, then why do you 
need this level at all? If there are others, then your binding is 
incomplete.

> +    type: object
> +    description: list of power domains provided by this controller.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "power-domain@[0-9]$":
> +        $ref: /schemas/power/power-domain.yaml#
> +
> +        type: object
> +        properties:
> +          '#power-domain-cells':
> +            const: 0
> +
> +          reg:
> +            description: |
> +              Power domain index. Valid values are defined in
> +              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
> +            maxItems: 1
> +
> +          clocks:
> +            description: |
> +              A number of phandles to clocks that need to be enabled
> +              during domain power-up sequencing to ensure reset
> +              propagation into devices located inside this power domain.
> +            minItems: 1
> +            maxItems: 5
> +
> +        required:
> +          - '#power-domain-cells'
> +          - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - slices
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx93-clock.h>
> +    #include <dt-bindings/power/fsl,imx93-power.h>
> +
> +    system-controller@44460000 {
> +        compatible = "fsl,imx93-src", "syscon";
> +        reg = <0x44460000 0x10000>;
> +
> +        slices {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mediamix: power-domain@0 {
> +                        reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
> +                        #power-domain-cells = <0>;
> +                        clocks = <&clk IMX93_CLK_MEDIA_AXI>,
> +                                 <&clk IMX93_CLK_MEDIA_APB>;
> +                };
> +        };
> +    };
> diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
> new file mode 100644
> index 000000000000..27fb7df80f93
> --- /dev/null
> +++ b/include/dt-bindings/power/fsl,imx93-power.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + *  Copyright 2022 NXP
> + */
> +
> +#ifndef __DT_BINDINGS_IMX93_POWER_H__
> +#define __DT_BINDINGS_IMX93_POWER_H__
> +
> +#define IMX93_POWER_DOMAIN_MEDIAMIX		0
> +
> +#endif
> -- 
> 2.25.1
> 
> 
