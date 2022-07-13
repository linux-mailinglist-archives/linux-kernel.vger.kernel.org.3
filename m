Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3588573170
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiGMIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiGMIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:47:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B15BCAF22
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:46:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oBY1E-0005PI-Sh; Wed, 13 Jul 2022 10:46:52 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oBY1D-0005lt-Q4; Wed, 13 Jul 2022 10:46:51 +0200
Date:   Wed, 13 Jul 2022 10:46:51 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 5/6] arm64: dts: Add support for Kontron SL/BL i.MX8MM
 OSM-S
Message-ID: <20220713084651.kf5f63xidhpbov5c@pengutronix.de>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-6-frieder@fris.de>
 <20220713083603.wjb3znctugrerep5@pengutronix.de>
 <5cd2bd6b-30e9-582f-5e28-74b49429103c@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cd2bd6b-30e9-582f-5e28-74b49429103c@kontron.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
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

On 22-07-13, Frieder Schrempf wrote:
> Hi Marco,
> 
> Am 13.07.22 um 10:36 schrieb Marco Felsch:
> > Hi Frieder,
> > 
> > On 22-07-13, Frieder Schrempf wrote:
> > 
> > 
> >> +	aliases {
> >> +		ethernet1 = &usbnet;
> >> +	};
> > 
> > Out of curiosity, why do you prefer usbnet instead of the fec?
> 
> We don't. In imx8mm.dtsi there is:
> 
> ethernet0 = &fec1;
> 
> We only assign the alias for the second ethernet, which is the USB adapter.

Ah.. I see, thanks :)

Regards,
  Marco
