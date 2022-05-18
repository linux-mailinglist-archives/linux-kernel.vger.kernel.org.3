Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B952C20C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiERS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbiERS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:26:15 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FB163F6D;
        Wed, 18 May 2022 11:26:13 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-f1eafa567cso409349fac.8;
        Wed, 18 May 2022 11:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWZ7C/lhWG2oI1miVY3LMoG5gzpA7R0lnj8FHo4aXdI=;
        b=3JTprWOUgf1WZgfSwNLmfnSyd8TK8cc+ENcPkbVOGBWapQHISmKOV+33RPG1gl6H/Q
         Fc+qOW0yHOwpECODnI40BUmA0xi153jMHc2Z1GzLIWxrG2hWV6w91qZEdYYTLkL7LkDm
         IaKPfy4jelrZxVsnJRlpbyGK96i1BsH6NRSeuTJ1to+NvUedV6inQXQUlbSe2Ak/9F5L
         YHlgK+mPYjJUSOsvkRNTQmEUwTmiWjVN7q4wrvcWfUYdS63J8qaV7StQWR4RQR/s5xBj
         DZp7NE14TdHiIFhtkwrVEl/XI44O+MUvn3NDWiawyoyrFQGi5NvHioO/g12yp2fjGC6q
         gvQQ==
X-Gm-Message-State: AOAM5301IVXxMZ26DqhhpkzVFW8Wp14csID6lL7if5oJUmO9i2wc02tY
        3NlhHVM2D0MiYYVJgB1LvA==
X-Google-Smtp-Source: ABdhPJy3uudsBcvneIRwvZe8xIbN0zJdv/ouIeOaWcfxym37QioDFrURrrXjGAKGF+I9+13Rp+d3XQ==
X-Received: by 2002:a05:6870:15ce:b0:e9:894f:d9ce with SMTP id k14-20020a05687015ce00b000e9894fd9cemr477654oad.121.1652898372430;
        Wed, 18 May 2022 11:26:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w4-20020a056830060400b0060603221234sm1017418oti.4.2022.05.18.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:26:11 -0700 (PDT)
Received: (nullmailer pid 3640827 invoked by uid 1000);
        Wed, 18 May 2022 18:26:10 -0000
Date:   Wed, 18 May 2022 13:26:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
        "a.kartashev@yadro.com" <a.kartashev@yadro.com>,
        "patrick.rudolph@9elements.com" <patrick.rudolph@9elements.com>,
        "dphadke@linux.microsoft.com" <dphadke@linux.microsoft.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: aspeed: Add eSPI controller
Message-ID: <20220518182610.GI3302100-robh@kernel.org>
References: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
 <20220516005412.4844-2-chiawei_wang@aspeedtech.com>
 <20220517183154.GA1352926-robh@kernel.org>
 <HK0PR06MB3779B567DE70F859E28F66C991D19@HK0PR06MB3779.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB3779B567DE70F859E28F66C991D19@HK0PR06MB3779.apcprd06.prod.outlook.com>
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

On Wed, May 18, 2022 at 12:15:10AM +0000, ChiaWei Wang wrote:
> Hi Rob,
> 
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, May 18, 2022 2:32 AM
> > 
> > On Mon, May 16, 2022 at 08:54:09AM +0800, Chia-Wei Wang wrote:
> > > Add dt-bindings for Aspeed eSPI controller
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  .../devicetree/bindings/soc/aspeed/espi.yaml  | 162
> > > ++++++++++++++++++
> > 
> > bindings/spi/ includes SPI slaves. Is there a reason this doesn't fit there?
> 
> eSPI resues the timing and electrical specification of SPI but runs completely different protocol.
> Only the flash channel is related to SPI and the other 3 channels are for EC/BMC/SIO.
> Therefore, an eSPI driver does not fit into the SPI model.
> 
> > 
> > >  1 file changed, 162 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > new file mode 100644
> > > index 000000000000..aa91ec8caf6a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> > > @@ -0,0 +1,162 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # #
> > > +Copyright (c) 2021 Aspeed Technology Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Aspeed eSPI Controller
> > > +
> > > +maintainers:
> > > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > +  - Ryan Chen <ryan_chen@aspeedtech.com>
> > > +
> > > +description:
> > > +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> > > +  supporting the four eSPI channels, namely peripheral, virtual wire,
> > > +  out-of-band, and flash.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - aspeed,ast2500-espi
> > > +          - aspeed,ast2600-espi
> > > +      - const: simple-mfd
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  ranges: true
> > > +
> > > +patternProperties:
> > > +  "^espi-ctrl@[0-9a-f]+$":
> > > +    type: object
> > > +
> > > +    description: Control of the four basic eSPI channels
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        items:
> > > +          - enum:
> > > +              - aspeed,ast2500-espi-ctrl
> > > +              - aspeed,ast2600-espi-ctrl
> > > +
> > > +      interrupts:
> > > +        maxItems: 1
> > > +
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> > > +      perif,memcyc-enable:
> > 
> > What vendor is 'perif'?
> 
> It refers to the eSPI peripheral channel.

The convention for properties is <vendor-prefix>,<property-name>. Fix 
your property names to follow this. 

> 
> > 
> > > +        type: boolean
> > > +        description: Enable memory cycle over eSPI peripheral channel
> > > +
> > > +      perif,memcyc-src-addr:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The Host side address to be decoded into the
> > > + memory cycle over eSPI peripheral channel
> > > +
> > > +      perif,memcyc-size:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        description: The size of the memory region allocated for the
> > memory cycle over eSPI peripheral channel
> > > +        minimum: 65536
> > 
> > This region is defined by the h/w or just some carveout of system memory? In
> > the former, perhaps this should be part of 'reg'. In the latter case, use a
> > /reserved-memory node and memory-region here.
> 
> The region is going to be allocated at runtime phase.
> It is a kind of shared memory between Host and BMC.

Use /reserved-memory.

> 
> > 
> > > +
> > > +      perif,dma-mode:
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI peripheral channel
> > > +
> > > +      oob,dma-mode:
> > 
> > What vendor is 'oob'?
> 
> It refers to the eSPI out-of-band channel.
> 
> > 
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI out-of-band channel
> > > +
> > > +      oob,dma-tx-desc-num:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        minimum: 2
> > > +        maximum: 1023
> > > +        description: The number of TX descriptors available for eSPI
> > > + OOB DMA engine
> > > +
> > > +      oob,dma-rx-desc-num:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        minimum: 2
> > > +        maximum: 1023
> > > +        description: The number of RX descriptors available for eSPI
> > > + OOB DMA engine
> > > +
> > > +      flash,dma-mode:
> > > +        type: boolean
> > > +        description: Enable DMA support for eSPI flash channel
> > 
> > Why does this need to be in DT. It's configuration.
> 
> The property is used to decide the operation mode (i.e. FIFO or DMA) of the eSPI flash channel.
> Is it a wrong idea to use the DTS property for?
> 
> > 
> > > +
> > > +      flash,safs-mode:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [ 0, 1, 2 ]
> > > +        default: 0
> > > +        description: Slave-Attached-Sharing-Flash mode, 0->Mix,
> > > + 1->SW, 2->HW
> > > +
> > > +    dependencies:
> > > +      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
> > > +      perif,memcyc-size: [ "perif,memcyc-enable" ]
> > > +      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
> > > +      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - interrupts
> > > +      - clocks
> > > +
> > > +  "^espi-mmbi@[0-9a-f]+$":
> > > +    type: object
> > > +
> > > +    description: Control of the PCH-BMC data exchange over eSPI
> > > + peripheral memory cycle
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: aspeed,ast2600-espi-mmbi
> > > +
> > > +      interrupts:
> > > +        maxItems: 1
> > > +
> > > +    required:
> > > +      - compatible
> > > +      - interrupts
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  - ranges
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/clock/ast2600-clock.h>
> > > +
> > > +    espi: espi@1e6ee000 {
> > > +        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
> > > +        reg = <0x1e6ee000 0x1000>;
> > > +
> > > +        #address-cells = <1>;
> > > +        #size-cells = <1>;
> > > +        ranges = <0x0 0x1e6ee000 0x1000>;
> > > +
> > > +        espi_ctrl: espi-ctrl@0 {
> > > +            compatible = "aspeed,ast2600-espi-ctrl";
> > > +            reg = <0x0 0x800>;
> > > +            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > > +            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
> > > +        };
> > > +
> > > +        espi_mmbi: espi-mmbi@800 {
> > > +            compatible = "aspeed,ast2600-espi-mmbi";
> > > +            reg = <0x800 0x50>;
> > > +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> > > +        };
> > 
> > Why do you need these child nodes? Are the subblocks somehow useful on
> > their own or reuseable in another configuration? If not, looks like this could all
> > be 1 node.
> 
> espi-mmbi has individual function and control registers.
> However, espi-mmbi is also a feature extended based on the memory cycle of eSPI peripheral channel.
> Thereby, it has dependency on the eSPI channel initialization conducted by espi-ctrl.
> The scenario is similar to the lpc-ctrl and other lpc-xxx drivers of Aspeed SoCs.

Doesn't LPC have independent downstream devices like a bus? Is this a 
bus where the ESPI controls access to MMBI and espi-ctrl devices? If so, 
then the devices need their own binding and descriptions. But it doesn't 
really look like that to me given the limited description.

Rob
