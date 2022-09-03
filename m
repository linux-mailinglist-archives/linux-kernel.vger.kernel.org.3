Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F014D5ABBD0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiICA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiICA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:28:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECD11EB5F;
        Fri,  2 Sep 2022 17:26:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EDEB6DD;
        Sat,  3 Sep 2022 02:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662164704;
        bh=H2oIKKpl7vDJ+UZWMIb/3wmlWoyGMna5rxAUCLWh4mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Me420Y6rkhnnjE3cmtE1eQhJLjVnyqoxTJulX2e9n1z/YSEpUTbVY03AFsoZdS+6m
         QKRU+jSdrp1Ll1vBPqQLs379abGsgkxlNG3mF0N7IMZIBP0C4pkdkKFdHiI2kyFKwV
         i6x72SSeG9MqHcxYqURlKq09XYaRXpnWRgnw/gww=
Date:   Sat, 3 Sep 2022 03:24:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
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
Message-ID: <YxKe00H2S9AzF0Yi@pendragon.ideasonboard.com>
References: <20220901154051.1885509-1-max.oss.09@gmail.com>
 <YxD09SqpcbB3dt8I@pendragon.ideasonboard.com>
 <20220902155720.GB5699@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220902155720.GB5699@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On Fri, Sep 02, 2022 at 05:57:20PM +0200, Francesco Dolcini wrote:
> Hello Laurent,
> answering here for both patches (1/2 and 2/2).
> 
> On Thu, Sep 01, 2022 at 09:07:49PM +0300, Laurent Pinchart wrote:
> > On Thu, Sep 01, 2022 at 05:40:50PM +0200, Max Krummenacher wrote:
> > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > > 
> > > Add the hdmi connector present on the dsi to hdmi adapter now
> > > required by the upstream lontium bridge driver.
> > > The dsi to hdmi adapter is enabled in an device tree overlay.
> > 
> > Shouldn't the connector also be in the overlay ? There's certainly no
> > physical HDMI connector on the i.MX8MP Verdin SoM :-)
> 
> Toradex DTS include and overlay files structure so far has been a little
> bit different and not following the expectation you just stated here,
> you can just check the current *toradex*dts* files and you'll see that there
> is other stuff that is not strictly part of the module.
> 
> Copying from a previous email thread on a very similar discussion [0]
> some of the reasons:
> 
>  - The SoM dtsi representing not only the functionality implemented into
>    the SoM, but the whole connector pinout to the carrier makes very easy
>    to just include a different som.dtsi in the carrier board dts and just
>    switch SoM, for example from a colibri-imx6 to a colibri-imx7.

That's fine, but I don't see how that's related to the issue at hand.
The DSI to HDMI bridge wouldn't be present on either SoM, would it ?

>  - We avoid code duplication
> 
> This is working for us pretty well so far and the majority of the users
> of ours modules rely on this structure, we would prefer not to change that.

It may work for your current use cases, but it doesn't make it right :-)
Someone can integrate a Verdin SoM with a carrier board that has no DSI
to HDMI (or LVDS) bridge, there should thus be no such device in the
device tree. The SoM has DSI signals present on its connector, that's
what the SoM .dtsi should expose.

> [0] https://lore.kernel.org/all/20220413094449.GB118560@francesco-nb.int.toradex.com/

-- 
Regards,

Laurent Pinchart
