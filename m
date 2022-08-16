Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84A595727
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiHPJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiHPJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:53:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C005CBC10F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:14:27 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oNriC-00087l-C0; Tue, 16 Aug 2022 10:14:08 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oNriB-000640-9A; Tue, 16 Aug 2022 10:14:07 +0200
Date:   Tue, 16 Aug 2022 10:14:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: imx8m: introduce
 fsl,protected-clocks property
Message-ID: <20220816081407.GH17485@pengutronix.de>
References: <20220815033632.1687854-1-peng.fan@oss.nxp.com>
 <20220815033632.1687854-2-peng.fan@oss.nxp.com>
 <20220815135756.GC17485@pengutronix.de>
 <DU0PR04MB9417593B87BB5A23A29D732E886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417593B87BB5A23A29D732E886B9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Tue, Aug 16, 2022 at 07:13:27AM +0000, Peng Fan wrote:
> Hi Sascha,
> 
> > Subject: Re: [PATCH 1/2] dt-bindings: clock: imx8m: introduce fsl,protected-
> > clocks property
> > 
> > Hi Peng,
> > 
> > On Mon, Aug 15, 2022 at 11:36:31AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX8M Linux run on top of Jailhouse hypervisor, the root cell Linux
> > > should not disable clocks used by inmate. This would also benifit AMP
> > > to avoid Linux disable clocks used by Cortex-M4/M7.
> > >
> > > So introduce fsl,protected-clocks for above case.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > index 458c7645ee68..0ec490ff9a09 100644
> > > --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > > @@ -39,6 +39,10 @@ properties:
> > >        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-
> > clock.h
> > >        for the full list of i.MX8M clock IDs.
> > >
> > > +  fsl,protected-clocks:
> > > +    description: List of the Protected clock.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > 
> > There already is a generic protected-clocks property described in
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
> > b.com%2Fdevicetree-org%2Fdt-
> > schema%2Fblob%2F0d1b78cd0c3d9a3d523ced17d7da64b03f6c18ea%2Fdtsc
> > hema%2Fschemas%2Fclock%2Fclock.yaml%23L131&amp;data=05%7C01%7
> > Cpeng.fan%40nxp.com%7C5dbc72639c9147765af208da7ec63315%7C686ea
> > 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637961686968811809%7CUn
> > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=D%2BfJA5h
> > wblaX8VH%2BdQoN0pEFmCipfZHHf0ZVo07B4kg%3D&amp;reserved=0
> > We probably shouldn't add a property with the same name but different
> > meaning.
> > 
> 
> Thanks for sharing the info. I should check the common bindings before
> cook this patchset.
> 
> > I am not sure if we want to go the route of a fsl specific property, it looks
> > like other SoCs could have similar problems and it might be worth solving
> > this problem with a broader view.
> > 
> 
> I see qcom just drop the clock entries before registering the clocks. But to
> i.MX8M, it is not feasible to drop those clocks, unless check the
> protected-clocks property before registering every clock. This is odd.
> 
> So here I just wanna let i.MX8M clk driver prepare enable the clocks listed
> in protected-clocks property to avoid linux disable those clocks.
> > Anyway, please add a description to the binding what this property actually
> > does.
> I will switch to use the common bindings.

There were cases when a property first started with a "soc," prefix and
later when people realized that it could be useful for other
drivers/SoCs as well, the prefix was removed. With that in mind I
would expect that a "fsl,protected-clocks" property behaves the same
as a "protected-clocks" property without the prefix.

If it doesn't please pick a different name. I didn't want to suggest
to just drop the "fsl," prefix and to use the generic property name
when the properties have a different meaning.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
