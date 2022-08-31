Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32675A79BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiHaJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHaJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:07:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763DB7EEE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:07:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oTJgx-0003MS-E4; Wed, 31 Aug 2022 11:07:23 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oTJgw-0005v6-Ho; Wed, 31 Aug 2022 11:07:22 +0200
Date:   Wed, 31 Aug 2022 11:07:22 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio: Add gpio latch driver
Message-ID: <20220831090722.GN24324@pengutronix.de>
References: <20220831055811.1936613-1-s.hauer@pengutronix.de>
 <20220831055811.1936613-2-s.hauer@pengutronix.de>
 <20220831080109.tqzwgm3o47c7wlzi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831080109.tqzwgm3o47c7wlzi@pengutronix.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:01:09AM +0200, Marco Felsch wrote:
> Hi Sascha,
> 
> On 22-08-31, Sascha Hauer wrote:
> > This driver implements a GPIO multiplexer based on latches connected to
> > other GPIOs. A set of data GPIOs is connected to the data input of
> > multiple latches. The clock input of each latch is driven by another
> > set of GPIOs. With two 8-bit latches 10 GPIOs can be multiplexed into
> > 16 GPIOs. GPOs might be a better term as in fact the multiplexed pins
> > are output only.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> apart the one minor nit (see end) feel free to add my
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> > +// SPDX-License-Identifier: GPL-2.0-or-later

[snip]

> > +MODULE_LICENSE("GPL v2");
> 
> checkpatch.pl should complain about this since it it now GPL, see commit
> bf7fbeeae6db. Sorry for not spotted that earlier.

Just checked, checkpatch doesn't complain. Will fix in v3

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
