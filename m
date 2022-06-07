Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DE5403CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiFGQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiFGQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:31:42 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48321100509;
        Tue,  7 Jun 2022 09:31:42 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id u2so13680001iln.2;
        Tue, 07 Jun 2022 09:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJKGhb8UA8ftLQiLW2HZ/VI3O7hRW3Q7CKvhnRR3Wyc=;
        b=iJXP2u82IGN8Y5g41TKvVnKZmMusYJSP9Jx1A9q2gh4e20w0ri2V0OWjmR4zWouZLm
         kSGo1jgk1mdNGnGENzmi/9EtcHKT7U9v/BTEHdguP69bE+9jrhijlnVOkJVNzvilEhrN
         ZTdn+Wdfwy6SuIB+mkLpALJABMsnRlM6og5pEphHloyGNvEmGF1li7tqPXH/oF4okqRc
         VJdMqwl4efM0IMjljBAhXqlA/1e0DM7cgkDmAXvDHG5cXiabZ7EzkNr/81abKAQabYBG
         DfWvYt8qAGqwbP4bXCIEIPsQ/52xAEStOetm7E6gSrsHQ7yanSsfczoQgFE/mb8c47JI
         kdEA==
X-Gm-Message-State: AOAM531sOmkFWBFoZcGVJrLAI0eZ22kyjgHqXmHI5Wil0HyD076E88UL
        jx+tIe7N/wkjLFYQ5busrg==
X-Google-Smtp-Source: ABdhPJxZ2e9f/GPzKiGOzWSqqqrzNBfftwOkf9KMuD8bgc4uKKKkl43HQ+APql1YAWetQUDDR0ouOA==
X-Received: by 2002:a05:6e02:2142:b0:2d3:c681:dab4 with SMTP id d2-20020a056e02214200b002d3c681dab4mr17043391ilv.63.1654619501556;
        Tue, 07 Jun 2022 09:31:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j10-20020a92200a000000b002d3bb071d5bsm7473566ile.0.2022.06.07.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:31:41 -0700 (PDT)
Received: (nullmailer pid 3389792 invoked by uid 1000);
        Tue, 07 Jun 2022 16:31:39 -0000
Date:   Tue, 7 Jun 2022 10:31:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] dt-bindings: arm: freescale: Add fsl,scu-key yaml
 file
Message-ID: <20220607163139.GB3384053-robh@kernel.org>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
 <20220607105951.1821519-5-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607105951.1821519-5-abel.vesa@nxp.com>
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

On Tue, Jun 07, 2022 at 01:59:45PM +0300, Abel Vesa wrote:
> This documents separately the key child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu-key.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
> new file mode 100644
> index 000000000000..0b52f2f33bd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-key.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,scu-key.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8qxp-sc-key
> +      - const: fsl,imx-sc-key
> +  linux,keycodes:
> +    description: See Documentation/devicetree/bindings/input/input.yaml

No free form references. Need to add:

allOf:
  - $ref: schemas/input/input.yaml#

And here just:

     linux,keycodes: true


> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - linux,keycodes
> -- 
> 2.34.3
> 
> 
