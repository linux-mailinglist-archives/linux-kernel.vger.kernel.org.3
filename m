Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55F51779E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiEBUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEBUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:00:10 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F48BC39;
        Mon,  2 May 2022 12:56:40 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id a10so16226065oif.9;
        Mon, 02 May 2022 12:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ntv7zv1FrmWHb+PvRkaGud3vEWnl0ReBjk0xBH+pec=;
        b=oI4uw+2RFPN9b4EnFnSII/con/7rOKKCOV3yeDqZ2P44mBTzAN5g1wAJWuPBXI4MUL
         yA6np3Bj6kDx167nxodKlIjWcBhvynGq9OEvbGccO6Y68z4X532cwwV77iRz1JURON8R
         R1R8MWzEEOcK43mZ7yCJcWLU9NrXq9QNFvU1erUrtD/I9mwXd2vmd/ZyN6ITSHAe8fcB
         8Hj/hNBohHMwT6GtgtY2+8qMb/TxErCzxO0a/432IBqshk7NuQY1p4yzq825IqNQNSTL
         40rNwp0lJFCG+6yEyupzix0gdpHK9b1cO0C17leiyL26pwhi+SsIHvefVdm+ENFjNNu9
         K5Iw==
X-Gm-Message-State: AOAM531UofO/etTDnfouy62MFLquqjrspStK8+YEENYAOEONVcqkruc7
        1NMTcOWz8E6LtvLpr1B1mw==
X-Google-Smtp-Source: ABdhPJw4pS6LeKZi5JhLEsijb5NRAYNdn7qYs4P7Vo1OpIrOD/8nj4swffT/m5Bedph4WORdHZEbXw==
X-Received: by 2002:aca:5b45:0:b0:2fa:7d3b:6997 with SMTP id p66-20020aca5b45000000b002fa7d3b6997mr365355oib.258.1651521399580;
        Mon, 02 May 2022 12:56:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w2-20020a056830110200b006060322127esm3205340otq.78.2022.05.02.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 12:56:39 -0700 (PDT)
Received: (nullmailer pid 1633203 invoked by uid 1000);
        Mon, 02 May 2022 19:56:38 -0000
Date:   Mon, 2 May 2022 14:56:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com
Subject: Re: [PATCH v3 1/5] dt-bindings: remoteproc: Add PRU consumer bindings
Message-ID: <YnA3dtaqptLgZBrV@robh.at.kernel.org>
References: <20220418104118.12878-1-p-mohan@ti.com>
 <20220418104118.12878-2-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418104118.12878-2-p-mohan@ti.com>
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

On Mon, Apr 18, 2022 at 04:11:14PM +0530, Puranjay Mohan wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add a YAML binding document for PRU consumers. The binding includes
> all the common properties that can be used by different PRU consumer
> or application nodes and supported by the PRU remoteproc driver.
> These are used to configure the PRU hardware for specific user
> applications.
> 
> The application nodes themselves should define their own bindings.
> 
> Co-developed-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> new file mode 100644
> index 000000000000..5b1f1cb2f098
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common TI PRU Consumer Binding
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  A PRU application/consumer/user node typically uses one or more PRU device
> +  nodes to implement a PRU application/functionality. Each application/client
> +  node would need a reference to at least a PRU node, and optionally define
> +  some properties needed for hardware/firmware configuration. The below
> +  properties are a list of common properties supported by the PRU remoteproc
> +  infrastructure.
> +
> +  The application nodes shall define their own bindings like regular platform
> +  devices, so below are in addition to each node's bindings.
> +
> +properties:
> +  ti,prus:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandles to the PRU, RTU or Tx_PRU nodes used
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      firmwares for the PRU cores, the default firmware for the core from
> +      the PRU node will be used if not provided. The firmware names should
> +      correspond to the PRU cores listed in the 'ti,prus' property

So should be the name number of entries?:

minItems: 1
maxItems: 6

> +
> +  ti,pruss-gp-mux-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

minItems: 1

> +    maxItems: 6
> +    items:
> +      enum: [0, 1, 2, 3, 4]
> +    description: |
> +      array of values for the GP_MUX_SEL under PRUSS_GPCFG register for a PRU.
> +      This selects the internal muxing scheme for the PRU instance. Values
> +      should correspond to the PRU cores listed in the 'ti,prus' property. The
> +      GP_MUX_SEL setting is a per-slice setting (one setting for PRU0, RTU0,
> +      and Tx_PRU0 on K3 SoCs). Use the same value for all cores within the
> +      same slice in the associative array. If the array size is smaller than
> +      the size of 'ti,prus' property, the default out-of-reset value (0) for the
> +      PRU core is used.
> +
> +required:
> +  - ti,prus
> +
> +dependencies:
> +  firmware-name: [ 'ti,prus' ]
> +  ti,pruss-gp-mux-sel: [ 'ti,prus' ]

This doesn't make sense because 'ti,prus' is already required. Should 
all 3 properties always be required?

> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    /* PRU application node example */
> +    pru-app {
> +        ti,prus = <&pru0>, <&pru1>;
> +        firmware-name = "pruss-app-fw0", "pruss-app-fw1";
> +        ti,pruss-gp-mux-sel = <2>, <1>;

This example never validates, but okay I guess.

> +    };
> -- 
> 2.17.1
> 
> 
