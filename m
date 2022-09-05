Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A059E5AD99D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiIET12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiIET1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:27:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF5A2A40A;
        Mon,  5 Sep 2022 12:26:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75CB26BC;
        Mon,  5 Sep 2022 21:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662405989;
        bh=izZvMBjhr/bvNoYQGDtF2V3g+eGXqt7u558BOi7zzh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o+X+vJW8hZaFFG6GuYfb8yA+ApbPr801obKPxgfofa5BhL0dumnOH/8rkgB+JFRdf
         a6RcVNtIShr2rQ9ifr+3TfCt0/OmkubtPNHf0OOshh950odmH/j0RY8m13X6Cb3MWl
         4R7H4YRilHsKo+VuFBdldnshTX/Y7iB1TziRSBJ8=
Date:   Mon, 5 Sep 2022 22:26:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp-verdin: add dsi to hdmi
 functionality
Message-ID: <YxZNVoMKly9eQ2xE@pendragon.ideasonboard.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
 <20220902155720.GB5699@francesco-nb.int.toradex.com>
 <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
 <YxNM75ZtHVKDjTa/@livingston.pivistrello.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxNM75ZtHVKDjTa/@livingston.pivistrello.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Sat, Sep 03, 2022 at 02:47:43PM +0200, Francesco Dolcini wrote:
> On Sat, Sep 03, 2022 at 03:24:51AM +0300, Laurent Pinchart wrote:
> > On Fri, Sep 02, 2022 at 05:57:20PM +0200, Francesco Dolcini wrote:
> > > Hello Laurent,
> > > answering here for both patches (1/2 and 2/2).
> > > 
> > > On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Sep 01, 2022 at 05:40:50PM +0200, Max Krummenacher wrote:
> > > > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > > > > 
> > > > > Add the hdmi connector present on the dsi to hdmi adapter now
> > > > > required by the upstream lontium bridge driver.
> > > > > The dsi to hdmi adapter is enabled in an device tree overlay.
> > > > 
> > > > Shouldn't the connector also be in the overlay ? There's certainly no
> > > > physical HDMI connector on the i.MX8MP Verdin SoM :-)
> > > 
> > > Toradex DTS include and overlay files structure so far has been a little
> > > bit different and not following the expectation you just stated here,
> > > you can just check the current *toradex*dts* files and you'll see that there
> > > is other stuff that is not strictly part of the module.
> > > 
> > > Copying from a previous email thread on a very similar discussion [0]
> > > some of the reasons:
> > > 
> > >  - The SoM dtsi representing not only the functionality implemented into
> > >    the SoM, but the whole connector pinout to the carrier makes very easy
> > >    to just include a different som.dtsi in the carrier board dts and just
> > >    switch SoM, for example from a colibri-imx6 to a colibri-imx7.
> > 
> > That's fine, but I don't see how that's related to the issue at hand.
> > The DSI to HDMI bridge wouldn't be present on either SoM, would it ?
> > 
> > >  - We avoid code duplication
> > > 
> > > This is working for us pretty well so far and the majority of the users
> > > of ours modules rely on this structure, we would prefer not to change that.
> > 
> > It may work for your current use cases, but it doesn't make it right :-)
> 
> Most of engineering is about compromise, being consistent with what we
> did so far and the end-user experience need to be taken into account.

Sure, and so do mainline requirements :-)

> > Someone can integrate a Verdin SoM with a carrier board that has no DSI
> > to HDMI (or LVDS) bridge, there should thus be no such device in the
> > device tree. The SoM has DSI signals present on its connector, that's
> > what the SoM .dtsi should expose.
> 
> Just for the record Verdin i.MX8M Plus do have both HDMI and LVDS on the
> connector (in addition to DSI) [1], of course we do have also the option to
> have LVDS or HDMI using an external add-on DSI bridge as this patches are
> about.
> 
> Said that it's true that sometime we describe peripherals that are part of the
> SOM family into the SOM dtsi, this avoid quite a lot of duplications given the
> amount of carrier board that are available on the market that use just the same
> building blocks (and this was one of the 2 points I mentioned as a reasoning
> for our current DTS files structure).

If those "SoM family" peripherals are on the carrier board, what's the
issue with describing them in the carrier board .dtsi ? And if they're
on an add-on board (such as, if I understand correctly, the DSI to HDMI
encoder for the Dahlia carrier board), what's the issue with describing
them in an overlay ?

> Of course, we keep these stuff disabled by default, so apart for some small size
> increase I do not see a real issue.

It's the same issue as adding any DT node for peripherals that do not
exist, I fail to see a compelling reason to do so here, given that this
seems to be easy to handle in the carrier board .dtsi or in overlays.
Maybe I'm missing something ?

> [1] https://docs.toradex.com/110977-verdin_imx8m_plus_v1.1_datasheet.pdf

-- 
Regards,

Laurent Pinchart
