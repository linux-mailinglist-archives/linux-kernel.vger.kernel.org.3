Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562149791E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbiAXHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAXHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:08:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA9C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 23:08:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nBtSY-0006XK-PD; Mon, 24 Jan 2022 08:08:14 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nBtSX-00087w-V5; Mon, 24 Jan 2022 08:08:13 +0100
Date:   Mon, 24 Jan 2022 08:08:13 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 1/2] iio: adc: tsc2046: add .read_raw support
Message-ID: <20220124070813.GB31542@pengutronix.de>
References: <20220117082852.3370869-1-o.rempel@pengutronix.de>
 <20220122171420.7036e031@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220122171420.7036e031@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:50:29 up 44 days, 14:36, 45 users,  load average: 0.07, 0.05,
 0.07
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Jan 22, 2022 at 05:14:20PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Jan 2022 09:28:51 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Add read_raw() support to make use of iio_hwmon and other iio clients.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> > ---
> 
> Change log? If it's just the check against PAGE_SIZE then I'm fine with it, but
> maybe I missed something. 

yes, only PAGE_SIZE.

> Much better to have a short description of what
> changed here.

OK

> Anyhow, I'll assume that's it.  Applied to the togreg branch of iio.git and
> pushed out as testing to let 0-day poke at it and see if it can find any
> problems.
> 
> There was a little fuzz here for patch 2, presumably because the fix that is
> in flight.  Hopefully that won't cause us too many problems in linux-next or
> at merge time.

Thank you!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
