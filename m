Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6F4ED98C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiCaMWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiCaMWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:22:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B365170;
        Thu, 31 Mar 2022 05:20:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VCK404046663;
        Thu, 31 Mar 2022 07:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648729204;
        bh=U/Bd5JEPMZiETyPMjxTZkK0xTLGPXruq7bxamvC/BPE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=p/8v7ChWKtnstAQkNaNKlPYO5HNv82HVDZDet7QGSG/V+7MQvfJ0L1rLZSrS3cYVQ
         L60fynQTGf9ZeFkH483HHSEwH8AuIsvGGAlRHDANvK833a3Z8cySbMJzx2T82HQjcI
         FeQy5iJdInmuqxeeAnxXgE+wrN+S9S16BOMbqRyk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VCK4cX045704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 07:20:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 07:20:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 07:20:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VCK2XC083438;
        Thu, 31 Mar 2022 07:20:03 -0500
Date:   Thu, 31 Mar 2022 17:50:02 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 02/11] dt-bindings: spi: Add Aspeed SMC controllers
 device tree binding
Message-ID: <20220331122002.55vwda6fnnenuqhf@ti.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-3-clg@kaod.org>
 <20220330191908.nhg52a5ayzczpzai@ti.com>
 <2a411a3e-4b7f-c116-b595-f33bffccb4e7@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a411a3e-4b7f-c116-b595-f33bffccb4e7@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/22 09:36AM, Cédric Le Goater wrote:
> Hello Pratyush,
> 
> On 3/30/22 21:19, Pratyush Yadav wrote:
> > On 25/03/22 11:08AM, Cédric Le Goater wrote:
> > > The "interrupt" property is optional because it is only necessary for
> > > controllers supporting DMAs (Not implemented yet in the new driver).
> > > 
> > > Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> > > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Cédric Le Goater <clg@kaod.org>
> > > ---
> > >   .../bindings/spi/aspeed,ast2600-fmc.yaml      | 87 +++++++++++++++++++
> > >   MAINTAINERS                                   |  9 ++
> > >   2 files changed, 96 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > new file mode 100644
> > > index 000000000000..e16bbcd38560
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
> > > @@ -0,0 +1,87 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Aspeed SMC controllers bindings
> > > +
> > > +maintainers:
> > > +  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > > +  - Cédric Le Goater <clg@kaod.org>
> > > +
> > > +description: |
> > > +  This binding describes the Aspeed Static Memory Controllers (FMC and
> > > +  SPI) of the AST2400, AST2500 and AST2600 SOCs.
> > > +
> > > +allOf:
> > > +  - $ref: "spi-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - aspeed,ast2600-fmc
> > > +      - aspeed,ast2600-spi
> > > +      - aspeed,ast2500-fmc
> > > +      - aspeed,ast2500-spi
> > > +      - aspeed,ast2400-fmc
> > > +      - aspeed,ast2400-spi
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: registers
> > > +      - description: memory mapping
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +patternProperties:
> > > +  "@[0-9a-f]+":
> > > +    type: object
> > > +
> > > +    properties:
> > > +      spi-rx-bus-width:
> > > +        enum: [1, 2, 4]
> > 
> > No need for this. It should already be taken care of by
> > spi-peripheral-props.yaml
> 
> So we could drop the whole 'patternProperties' section ?

Yes.

[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
