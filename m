Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE765ABF08
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiICM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiICM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:56:38 -0400
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 05:56:35 PDT
Received: from smtp-out-12.comm2000.it (smtp-out-12.comm2000.it [212.97.32.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBBD5A2F8;
        Sat,  3 Sep 2022 05:56:35 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-12.comm2000.it (Postfix) with ESMTPSA id 01C3CBA25E1;
        Sat,  3 Sep 2022 14:47:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1662209265;
        bh=APUy4pD+abROss/4Re7mQqViE2HTRzQPVmnnE6kjZ7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=qAyKS4uTdZHH0KoCYpGDdd4ujyrOc0PXH4vyAhtAvk5fMvPB6kAYMT/kZlDGr/WPW
         +9q0bRUC4xnlNoYtewDJImT89MPIoKEGqHVV89EE2oEMKzPIoxpkTF2PXe3PDH3owh
         kgKWD/80rqF8uzbC4ssFD/jyog86hmjiDzZygs9l71Ts4psDXwOOhac9s1dfrOhYIw
         2q88JSk297b5MspQQ5LW3zgxMTJRPksRDyT3qe71c4Ons8F4ewjk6XjmIa7rbbRW5B
         5OVteA2sqpcKb8zhBkvIqK16dhvhI3aYeG3HKjWHMpkESK9t2YwWz2LkBEBVS7Bs75
         mTWEnQu1JeKag==
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id B7C277F910;
        Sat,  3 Sep 2022 14:47:43 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.94.2)
        (envelope-from <francesco@dolcini.it>)
        id 1oUSYp-0001Tn-6F; Sat, 03 Sep 2022 14:47:43 +0200
Date:   Sat, 3 Sep 2022 14:47:43 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <YxNM75ZtHVKDjTa/@livingston.pivistrello.it>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
 <20220902155720.GB5699@francesco-nb.int.toradex.com>
 <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 03:24:51AM +0300, Laurent Pinchart wrote:
> Hi Francesco,
> 
> On Fri, Sep 02, 2022 at 05:57:20PM +0200, Francesco Dolcini wrote:
> > Hello Laurent,
> > answering here for both patches (1/2 and 2/2).
> > 
> > On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> > > On Thu, Sep 01, 2022 at 05:40:50PM +0200, Max Krummenacher wrote:
> > > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > > > 
> > > > Add the hdmi connector present on the dsi to hdmi adapter now
> > > > required by the upstream lontium bridge driver.
> > > > The dsi to hdmi adapter is enabled in an device tree overlay.
> > > 
> > > Shouldn't the connector also be in the overlay ? There's certainly no
> > > physical HDMI connector on the i.MX8MP Verdin SoM :-)
> > 
> > Toradex DTS include and overlay files structure so far has been a little
> > bit different and not following the expectation you just stated here,
> > you can just check the current *toradex*dts* files and you'll see that there
> > is other stuff that is not strictly part of the module.
> > 
> > Copying from a previous email thread on a very similar discussion [0]
> > some of the reasons:
> > 
> >  - The SoM dtsi representing not only the functionality implemented into
> >    the SoM, but the whole connector pinout to the carrier makes very easy
> >    to just include a different som.dtsi in the carrier board dts and just
> >    switch SoM, for example from a colibri-imx6 to a colibri-imx7.
> 
> That's fine, but I don't see how that's related to the issue at hand.
> The DSI to HDMI bridge wouldn't be present on either SoM, would it ?
> 
> >  - We avoid code duplication
> > 
> > This is working for us pretty well so far and the majority of the users
> > of ours modules rely on this structure, we would prefer not to change that.
> 
> It may work for your current use cases, but it doesn't make it right :-)

Most of engineering is about compromise, being consistent with what we
did so far and the end-user experience need to be taken into account.

> Someone can integrate a Verdin SoM with a carrier board that has no DSI
> to HDMI (or LVDS) bridge, there should thus be no such device in the
> device tree. The SoM has DSI signals present on its connector, that's
> what the SoM .dtsi should expose.

Just for the record Verdin i.MX8M Plus do have both HDMI and LVDS on the
connector (in addition to DSI) [1], of course we do have also the option to
have LVDS or HDMI using an external add-on DSI bridge as this patches are
about.

Said that it's true that sometime we describe peripherals that are part of the
SOM family into the SOM dtsi, this avoid quite a lot of duplications given the
amount of carrier board that are available on the market that use just the same
building blocks (and this was one of the 2 points I mentioned as a reasoning
for our current DTS files structure).

Of course, we keep these stuff disabled by default, so apart for some small size
increase I do not see a real issue.

Francesco

[1] https://docs.toradex.com/110977-verdin_imx8m_plus_v1.1_datasheet.pdf
