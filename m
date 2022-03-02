Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740C4CB1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbiCBWAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiCBWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:00:13 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F44C7D6A;
        Wed,  2 Mar 2022 13:59:29 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso3572140ooc.7;
        Wed, 02 Mar 2022 13:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qu1UuB2p88jejBUeTppCLZmThyB2NBuh2qoIYxclrJ0=;
        b=n5bBArR3jkfYhep6CeU4mbyHHnVeOQUI//JdmXqdAKmf9PrgWUa5ycylsMt5Z3Nl79
         remijbuvSEUSq0yuDFYyxKT5E9MXfQeRHvHhAIZudhIj1tFM2rJLvj/NlvEW7zO83cX6
         KQIfjLitE+3fdh6l71llNMyBODj1OxdiMWcp399TzsrjoipTFeTksNBQpgxJQ/CYKFXz
         Ip2fLVqz6QsuBtPvNLJ1qfN0SbbJhYI1bOLGEveUu7AmpNRcBzs2ISEAjPNDeqh/Z7HU
         QNEbDQVcSM6ThCXEaib8GekbqZL9PVsvHwXy5fGVdkWPKIQ++gLPOF55sW1nrt1gFHXE
         3u1A==
X-Gm-Message-State: AOAM533hkHi3odbmpYLlgcfppXt0NaqAz3Yviw6lU/ogMvmgTmR1lDmE
        NO3gIMMC2R+1TbBFJZBCSA==
X-Google-Smtp-Source: ABdhPJyx91JNIzn6Cs8BTFJCDX9woUE85mryXqEj9TpESgDFUDa6M10DSB6TiCbbfyh1zYVWrMO45w==
X-Received: by 2002:a05:6870:c05:b0:d6:fa9f:bcd1 with SMTP id le5-20020a0568700c0500b000d6fa9fbcd1mr1663709oab.108.1646258368953;
        Wed, 02 Mar 2022 13:59:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b002e0e75dcb82sm98740ooq.12.2022.03.02.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:59:26 -0800 (PST)
Received: (nullmailer pid 133360 invoked by uid 1000);
        Wed, 02 Mar 2022 21:59:25 -0000
Date:   Wed, 2 Mar 2022 15:59:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mtd: partitions: add UBI binding
Message-ID: <Yh/ovYMV104jc+CE@robh.at.kernel.org>
References: <20220217102448.27586-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217102448.27586-1-zajec5@gmail.com>
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

On Thu, Feb 17, 2022 at 11:24:48AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> UBI is often used on embedded devices to store UBI volumes with device
> configuration / calibration data. Such volumes may need to be documented
> and referenced for proper boot & setup.
> 
> Some examples:
> 1. U-Boot environment variables
> 2. Device calibration data
> 3. Default setup (e.g. initial password)
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/mtd/partitions/ubi.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> new file mode 100644
> index 000000000000..cd081f06d4cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/ubi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UBI (Unsorted Block Images) device
> +
> +description: |
> +  UBI is a layer providing logical volumes (consisting of logical blocks) on top
> +  of raw flash devices. It deals with low-level flash issues (bit-flips, bad
> +  physical eraseblocks, wearing) providing a reliable data storage.
> +
> +  UBI device is built and stored in a single flash partition.
> +
> +  Some (usually embedded) devices use UBI volumes of specific names or indexes
> +  to store setup / configuration data. This binding allows describing such
> +  volumes so they can be identified and referenced by consumers.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: partition.yaml#
> +
> +properties:
> +  compatible:
> +    const: ubi
> +
> +patternProperties:
> +  "^volume-[0-9a-f]+$":
> +    type: object
> +    description: UBI volume
> +    properties:
> +      volume-name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +      volume-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +    anyOf:
> +      - required:
> +          - volume-name
> +      - required:
> +          - volume-id
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            compatible = "ubi";
> +            reg = <0x0000000 0x1000000>;
> +            label = "filesystem";
> +
> +            env: volume-0 {
> +                volume-name = "u-boot-env";

Why not do 'compatible = "u-boot,env";' to align with normal partitions?

Or 'label'?

We have enough ways to identify things, I don't think we need another.

> +            };
> +
> +            calibration: volume-1 {

Are 0 and 1 meaningful or just made up indexing?

> +                volume-id = <99>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
