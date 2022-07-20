Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3B57BF67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiGTVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGTVD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:03:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7C545F2;
        Wed, 20 Jul 2022 14:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF3EFB821E4;
        Wed, 20 Jul 2022 21:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05165C3411E;
        Wed, 20 Jul 2022 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658351003;
        bh=aj6UO8Ihws6az1SxXTAlGhE4lWZvJVkqKcmBOdaQF20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QEDt7d99a8MFNFKgEj6etFQiTj6aOfNWFIaLKOc/jqnyK+DuxY5uLfKuNfrn8n+pa
         NABaEwgPSNdbJrSlCxVczWDvvy/8Kqy8ucsI9XPqbtllR7guo2FMNZBBlJphmopEov
         N+1HSEoUjMXLMCvN5wzZcDB/Vbdl7pDkTLcQsl++40WxD8wKZm+Wzs8EL8NIaptHDJ
         r6JKfTgl/J+iE1zJvqG1RVasieSnG0ckSoJnBva8hRQ1IjrApETA/Ci2FIJM421BeA
         XY7iDTRoxDrjZVRqpb6N8NOX9W8fQoDKlew8/Ls8wm8j9wedHH10rX5atE3bn08djy
         WNA6uwo2Yw80g==
Date:   Wed, 20 Jul 2022 16:03:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
 controller to dtschema
Message-ID: <20220720210321.GA1656074@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676C863CEDCCE1C0D1B04578C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 01:16:45AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 2022年7月20日 2:00
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; l.stach@pengutronix.de; galak@kernel.crashing.org;
> > shawnguo@kernel.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de
> > Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
> > controller to dtschema
> > 
> > On Fri, Aug 27, 2021 at 02:42:58PM +0800, Richard Zhu wrote:
> > > Convert the fsl,imx6q-pcie.txt into a schema.
> > > - ranges property should be grouped by region, with no functional
> > >   changes.
> > > - only one propert is allowed in the compatible string, remove
> > >   "snps,dw-pcie".
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  .../bindings/pci/fsl,imx6q-pcie.txt           | 100 ---------
> > >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 202
> > ++++++++++++++++++
> > >  MAINTAINERS                                   |   2 +-
> > >  3 files changed, 203 insertions(+), 101 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > 
> > > -Optional properties:
> > > -- fsl,tx-deemph-gen1: Gen1 De-emphasis value. Default: 0
> > > -- fsl,tx-deemph-gen2-3p5db: Gen2 (3.5db) De-emphasis value. Default:
> > > 0
> > 
> > > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > 
> > > +  fsl,tx-deemph-gen1:
> > > +    description: Gen1 De-emphasis value (optional required).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 0
> > > +
> > > +  fsl,tx-deemph-gen2-3p5db:
> > > +    description: Gen2 (3.5db) De-emphasis value (optional required).
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 0
> > 
> > What does "optional required" mean in all these properties?
> > "Optional" is the opposite of "required."
>
> Regarding my understands, the "optional required" means that these properties
>  are not mandatory required. The default values are used if there are no such
>  kind of properties. If HW board designers want to shape their PCIe signals
>  (E.X eye diagram), they should define these properties.

That sounds like "optional" to me.

"Optional required" is meaningless.  A property can be either optional
OR required, but not both at the same time.

If the driver can function without these properties, they are
optional.  If designers can use these properties to optimize signal
characteristics, the properties are still optional.

The properties you describe as "optional required" are:

  fsl,tx-deemph-gen1
  fsl,tx-deemph-gen2-3p5db
  fsl,tx-deemph-gen2-6db
  fsl,tx-swing-full
  fsl,tx-swing-low
  fsl,max-link-speed
  reset-gpio
  reset-gpio-active-high
  vpcie-supply
  vph-supply

From reading the code, the driver uses default values for all the
"fsl," properties if they don't exist.  And the driver always checks
whether the others exist before using them.

So I think you should describe all these as "optional".

Bjorn
