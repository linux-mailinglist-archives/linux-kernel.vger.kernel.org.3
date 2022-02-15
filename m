Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB984B7978
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244276AbiBOVHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:07:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiBOVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:07:00 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F92BB31;
        Tue, 15 Feb 2022 13:06:49 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id z18so15865233iln.2;
        Tue, 15 Feb 2022 13:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B1+ZJcMtyBX3FqM5G6Lma2k2jOm6NmZZ5jVlCb7Pess=;
        b=vm4okpL9pAugoi/rMRbjTEvoVLhdNuLjIY3/q5UBjMOxtzL1dH2WmgJ4Htd16X5uvR
         K4ENaNvccU+CGCvx+MliGqlEYd4NG7x52fuI4bqd5FJADl+nxNlIez1d3LeOBXETHRKs
         mscqSbnsytiP0vn4Id529CAs/8ipLeiFDzFXYj3h4uo4CPayxFMhtgvklltzHWyPVDa2
         BOUhv9Xeprsa5m6ZByG9Z6qp5/Xfi9/U4KDNY1u7haPk45toInxPIzUybGbwUQLbAT4n
         P+12t0fKBPxC4idtDYyhdDLAxK22HxsiKE3gQMxxx0UXpVQT60tFHif8s9if6zi+8//Y
         Ba5A==
X-Gm-Message-State: AOAM532Waz8S64Y2M+EbEwpevIh9L64aY/5Gryggf2KCku3esu5URorr
        7PzEvGdJneCteyCAv648JA==
X-Google-Smtp-Source: ABdhPJx/uzMzNSMXMusiikoo4Gc24MlhELBj8Wua6sRn0ptpOYyIhLnne+CKrcXbcNur4Z/7s9dxng==
X-Received: by 2002:a05:6e02:20c6:: with SMTP id 6mr569254ilq.242.1644959208389;
        Tue, 15 Feb 2022 13:06:48 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y29sm3877610iox.46.2022.02.15.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:06:47 -0800 (PST)
Received: (nullmailer pid 3921594 invoked by uid 1000);
        Tue, 15 Feb 2022 21:06:45 -0000
Date:   Tue, 15 Feb 2022 15:06:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Message-ID: <YgwV5ZGCbrNhlk0s@robh.at.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214094231.3753686-3-clg@kaod.org>
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

On Mon, Feb 14, 2022 at 10:42:23AM +0100, Cédric Le Goater wrote:
> The "interrupt" property is optional because it is only necessary for
> controllers supporting DMAs (Not implemented yet in the new driver).
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> new file mode 100644
> index 000000000000..ed71c4d86930
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed SMC controllers bindings
> +
> +maintainers:
> +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> +  - Cédric Le Goater <clg@kaod.org>
> +
> +description: |
> +  This binding describes the Aspeed Static Memory Controllers (FMC and
> +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-fmc
> +      - aspeed,ast2600-spi
> +      - aspeed,ast2500-fmc
> +      - aspeed,ast2500-spi
> +      - aspeed,ast2400-fmc
> +      - aspeed,ast2400-spi
> +
> +  reg:
> +    items:
> +      - description: registers
> +      - description: memory mapping
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +patternProperties:
> +  "@[0-9a-f]+":
> +    type: object
> +
> +    properties:
> +      spi-rx-bus-width:
> +        enum: [1, 2, 4]
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +
> +    spi@1e620000 {
> +        reg = < 0x1e620000 0xc4
> +                0x20000000 0x10000000 >;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "aspeed,ast2600-fmc";
> +        clocks = <&syscon ASPEED_CLK_AHB>;
> +        status = "disabled";

Why is your example disabled? Drop 'status'.

> +        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +        flash@0 {
> +                reg = < 0 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                status = "disabled";

Ditto.

> +        };
> +        flash@1 {
> +                reg = < 1 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                status = "disabled";
> +        };
> +        flash@2 {
> +                reg = < 2 >;
> +                compatible = "jedec,spi-nor";
> +                spi-max-frequency = <50000000>;
> +                status = "disabled";
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
