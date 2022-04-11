Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2774FBDF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiDKOBo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Apr 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiDKOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:01:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD262BB08
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:59:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nduZY-0008MD-Ft; Mon, 11 Apr 2022 15:59:16 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nduZW-002OkN-Bq; Mon, 11 Apr 2022 15:59:12 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nduZU-000CHv-8G; Mon, 11 Apr 2022 15:59:12 +0200
Message-ID: <2a8732442ffab2ca03fbc0153c1cdfd1f8dc1233.camel@pengutronix.de>
Subject: Re: [PATCH 09/14] dt-bindings: reset: snps,dw-reset: Convert to yaml
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:59:12 +0200
In-Reply-To: <YlB+Hd6IGdM8SD8X@robh.at.kernel.org>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
         <20220407154338.4190674-9-p.zabel@pengutronix.de>
         <YlB+Hd6IGdM8SD8X@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2022-04-08 at 13:25 -0500, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 05:43:33PM +0200, Philipp Zabel wrote:
> > Convert the device tree bindings for the Synopsys DesignWare reset
> > controller to YAML schema to allow participating in DT validation.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>

Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

> > ---
> >  .../bindings/reset/snps,dw-reset.txt          | 30 -------------
> >  .../bindings/reset/snps,dw-reset.yaml         | 44 +++++++++++++++++++
> >  2 files changed, 44 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> >  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > deleted file mode 100644
> > index 0c241d4aae76..000000000000
> > --- a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -Synopsys DesignWare Reset controller
> > -=======================================
> > -
> > -Please also refer to reset.txt in this directory for common reset
> > -controller binding usage.
> > -
> > -Required properties:
> > -
> > -- compatible: should be one of the following.
> > -	"snps,dw-high-reset" - for active high configuration
> > -	"snps,dw-low-reset" - for active low configuration
> > -
> > -- reg: physical base address of the controller and length of memory mapped
> > -	region.
> > -
> > -- #reset-cells: must be 1.
> > -
> > -example:
> > -
> > -	dw_rst_1: reset-controller@0000 {
> > -		compatible = "snps,dw-high-reset";
> > -		reg = <0x0000 0x4>;
> > -		#reset-cells = <1>;
> > -	};
> > -
> > -	dw_rst_2: reset-controller@1000 {
> > -		compatible = "snps,dw-low-reset";
> > -		reg = <0x1000 0x8>;
> > -		#reset-cells = <1>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> > new file mode 100644
> > index 000000000000..f9b36ddc0ea1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/snps,dw-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DesignWare Reset controller
> > +
> > +maintainers:
> > +  - Luis Oliveira <Luis.Oliveira@synopsys.com>
> 
> Mail bounces, needs a new one.

Gustavo, would you take on maintainership of this file?

regards
Philipp
