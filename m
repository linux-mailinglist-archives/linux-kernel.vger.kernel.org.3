Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B1E57985D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiGSLZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiGSLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:25:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C7DEEF;
        Tue, 19 Jul 2022 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658229942; x=1689765942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndkgKEe4xEhufL1VbtNDAZ1EDUCVZK8z8B35R5zLA7E=;
  b=PsfF756aDKATpAWdAKh4RDyzUtRmFLm0CELrPDQwyGF3Yt8mcZ1oQE6C
   8PR15tgRP3vSPBofATb0SlXNwjkiRKLOx1ClLLExvPBuoGYaNxVXIIZiB
   KcY3aVISTAmCLv1Alc+gvDA+tXT1BUD2i6BVmv0Cm/U3q9bunb6T2ZMmP
   f3LOC9+Yh63iBMKiq/816vTH0jfwcG0i5PWDyG38S6B6U1WfwZ6wKW2Q1
   ZTvQeMpBCir/98p2C4ZhbT50XUBRi9M8foVALSOvIOAJf7LCWyZf2MdIJ
   vJiwvTrQ4RxNEI2wNuw9g2N3iqwhxXeo1nQHYUMMGdQ+YONpp6cP4rAgM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312152373"
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="312152373"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 04:25:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="597626946"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 04:25:36 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5DB25202EA;
        Tue, 19 Jul 2022 14:25:34 +0300 (EEST)
Date:   Tue, 19 Jul 2022 11:25:34 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: media: Add Allwinner A31 ISP
 bindings documentation
Message-ID: <YtaUrvkAmCQI50z+@paasikivi.fi.intel.com>
References: <20220704173523.76729-1-paul.kocialkowski@bootlin.com>
 <20220704173523.76729-2-paul.kocialkowski@bootlin.com>
 <YtP0YfPteyzsBWn3@paasikivi.fi.intel.com>
 <YtaBr3B5JMrdFVgV@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtaBr3B5JMrdFVgV@aptenodytes>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jul 19, 2022 at 12:04:31PM +0200, Paul Kocialkowski wrote:
> Hi Sakari,
> 
> On Sun 17 Jul 22, 11:37, Sakari Ailus wrote:
> > Hi Paul,
> > 
> > On Mon, Jul 04, 2022 at 07:35:18PM +0200, Paul Kocialkowski wrote:
> > > This introduces YAML bindings documentation for the Allwinner A31 Image
> > > Signal Processor (ISP).
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../media/allwinner,sun6i-a31-isp.yaml        | 97 +++++++++++++++++++
> > >  1 file changed, 97 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > new file mode 100644
> > > index 000000000000..2fda6e05e16c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/allwinner,sun6i-a31-isp.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allwinner A31 Image Signal Processor Driver (ISP) Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - allwinner,sun6i-a31-isp
> > > +      - allwinner,sun8i-v3s-isp
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Bus Clock
> > > +      - description: Module Clock
> > > +      - description: DRAM Clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: bus
> > > +      - const: mod
> > > +      - const: ram
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: CSI0 input port
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: CSI1 input port
> > 
> > Do both support a single PHY with a single data only? If multiple data lanes
> > are supported, please require data-lanes property (on endpoint).
> 
> There's actually no PHY involved here: the ISP drivers gets its video stream
> from these CSI controllers which are the ones interfacing with a MIPI CSI-2
> receiver (on A31/V3 it uses an external D-PHY, on A83T the D-PHY is collocated
> with the controller).
> 
> So I think the data-lanes property is not relevant here.
> 
> What do you think?

Ah, indeed, if it's an internal bus, then data-lanes isn't relevant.

-- 
Sakari Ailus
