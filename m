Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113825403D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbiFGQeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbiFGQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:34:05 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A0140E9;
        Tue,  7 Jun 2022 09:34:04 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id 134so9760052iou.12;
        Tue, 07 Jun 2022 09:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMDg2cEbvmYZ2jmpIpJ905bw2b8xuSefRltCRoDBq/Q=;
        b=fIpS1Q0bEvL7MquMHb2aVLFSgJAh59zRgH+9ANS+FbCi7W5zqu+HnOWt2VeoNPZ6en
         R4jGXHjBow1o1EJK1rnsVVGjY3T+l5drcRa7Uw5o07PvoptBfXWgTIoY3P/pB/KbUnFk
         oyiB8oLhQgkiRAuw5RFwbr091IsmWH8PPADWXnUMSTUmIN3eP/e14axb2ZXH+jUXAbot
         ARMxWXOm4hsUOscqS2ml/6lwvupXsnMqjiA5t9lypvjLl2L9q25BQb0Jn/AYF0BsKpAB
         pR6Hshi0qHUKu22bElXZULyYGhFPaZt2y+cRB17I8JKCWk72kliXDw687aWBURjgvM2u
         THRg==
X-Gm-Message-State: AOAM531ItPJJ1URz54nMw7nFlZy8Yoip9Ak/hIS/YC1SnGar8orDWSPo
        dbNrwDnAQaiLOM/S8C2Dmw==
X-Google-Smtp-Source: ABdhPJzfJRoB5DYzK9lEGJDtW72E0E12VB86z9sQlQhfQttpxLF8ArI8ti9zVjaGkx1WmCX0aKr8pg==
X-Received: by 2002:a02:cd10:0:b0:331:f1d:139b with SMTP id g16-20020a02cd10000000b003310f1d139bmr15777192jaq.151.1654619643878;
        Tue, 07 Jun 2022 09:34:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s4-20020a02ad04000000b003316536ebc1sm6133918jan.73.2022.06.07.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:34:03 -0700 (PDT)
Received: (nullmailer pid 3393807 invoked by uid 1000);
        Tue, 07 Jun 2022 16:34:02 -0000
Date:   Tue, 7 Jun 2022 10:34:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] dt-bindings: arm: freescale: Add fsl,scu-thermal
 yaml file
Message-ID: <20220607163402.GD3384053-robh@kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-9-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105951.1821519-9-abel.vesa@nxp.com>
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

On Tue, Jun 07, 2022 at 01:59:49PM +0300, Abel Vesa wrote:
> This documents separately the thermal child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../arm/freescale/fsl,scu-thermal.yaml        | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
> new file mode 100644
> index 000000000000..d94d378443a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-thermal.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,imx8qxp-sc-thermal
> +          - const: fsl,imx-sc-thermal
> +      - items:
> +          - const: fsl,imx-sc-thermal
> +
> +  '#thermal-sensor-cells':
> +    description: See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml

No.

Need to define how many cells and what they represent.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - '#thermal-sensor-cells'
> -- 
> 2.34.3
> 
> 
