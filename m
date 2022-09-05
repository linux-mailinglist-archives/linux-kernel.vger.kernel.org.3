Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6B5ADB10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiIEWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:03:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F32B25B;
        Mon,  5 Sep 2022 15:03:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54FCC6BC;
        Tue,  6 Sep 2022 00:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662415430;
        bh=m4TKbAl1A87gPnt2CNIsocJYJ+XEr3vdGXNPIz1nCWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhOgkEZCkRWKa7EjpoLTZajFnDHNU8Z6k1YlaSOANVZNSwK9C6k6Y7GUm4SSzmVAX
         mknI5mNl6Uw0iHRPmm7HixBcZ16nAQJWNuNLCEFNVUBVnHy/OuBcXRUJaGfwL2a7hQ
         /sVG3XdD0QWx+1/+8Gmyayl0nQ5zf9V7QGrVL3G4=
Date:   Tue, 6 Sep 2022 01:03:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
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
Message-ID: <YxZyN+ynx9q/3GK6@pendragon.ideasonboard.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
 <20220902155720.GB5699@francesco-nb.int.toradex.com>
 <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
 <YxNM75ZtHVKDjTa/@livingston.pivistrello.it>
 <YxZNVoMKly9eQ2xE@pendragon.ideasonboard.com>
 <20220905211703.GA6180@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220905211703.GA6180@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Mon, Sep 05, 2022 at 11:17:03PM +0200, Francesco Dolcini wrote:
> On Mon, Sep 05, 2022 at 10:26:14PM +0300, Laurent Pinchart wrote:
> > On Sat, Sep 03, 2022 at 02:47:43PM +0200, Francesco Dolcini wrote:
> > > On Sat, Sep 03, 2022 at 03:24:51AM +0300, Laurent Pinchart wrote:
> > > > On Fri, Sep 02, 2022 at 05:57:20PM +0200, Francesco Dolcini wrote:
> > > > > On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> > > > Someone can integrate a Verdin SoM with a carrier board that has no DSI
> > > > to HDMI (or LVDS) bridge, there should thus be no such device in the
> > > > device tree. The SoM has DSI signals present on its connector, that's
> > > > what the SoM .dtsi should expose.
> > > 
> > > Just for the record Verdin i.MX8M Plus do have both HDMI and LVDS on the
> > > connector (in addition to DSI) [1], of course we do have also the option to
> > > have LVDS or HDMI using an external add-on DSI bridge as this patches are
> > > about.
> > > 
> > > Said that it's true that sometime we describe peripherals that are part of the
> > > SOM family into the SOM dtsi, this avoid quite a lot of duplications given the
> > > amount of carrier board that are available on the market that use just the same
> > > building blocks (and this was one of the 2 points I mentioned as a reasoning
> > > for our current DTS files structure).
> > 
> > If those "SoM family" peripherals are on the carrier board, what's the
> > issue with describing them in the carrier board .dtsi ? And if they're
> > on an add-on board (such as, if I understand correctly, the DSI to HDMI
> > encoder for the Dahlia carrier board), what's the issue with describing
> > them in an overlay ?
> 
> These SOM family peripherals are in multiples(!) carrier boards AND on
> accessories. The drawback of being strict as you are asking is that we
> would end-up with a massive duplication of this small DTS building
> blocks, therefore the decision in the past to put those in the base SOM
> dtsi file.

OK, I got it now.

> Maybe adding something like imx8mp-verdin-dsi-hdmi.dtsi and
> imx8mp-verdin-dsi-lvds.dtsi that can be included by both overlay and
> carrier dts files as needed would solve both the need of being strict on
> the board definition in the dts file and avoid duplications?
> Not sure if that would work smoothly, it looks like adding some
> complexity and maintenance overhead, but maybe is the correct solution.

That sounds good to me. Would you be able to give it a try to see if it
works well ?

> Anyway, while I fully understand your reasoning, I'm still not happy to
> change this for the current toradex products, since users of
> our dts file currently rely on the expectations I tried to explain in
> this email thread and Max patches are implementing (and this is
> currently uniform over the whole toradex product range).

This sounds like a broader question, not specific to Toradex, opinions
from Rob and Krzysztof would be useful.

> > Maybe I'm missing something ?
> 
> I tried to give more insights.

Thank you, that's very appreciated.

-- 
Regards,

Laurent Pinchart
