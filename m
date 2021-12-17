Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111B5478B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhLQMRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:17:24 -0500
Received: from muru.com ([72.249.23.125]:39494 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236062AbhLQMRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:17:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8DBEB80FB;
        Fri, 17 Dec 2021 12:18:05 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:17:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc:     linux-omap@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: Fix timer regression for beagleboard revision c
Message-ID: <Ybx/0fIXWDD09c42@atomide.com>
References: <20211125144834.52457-1-tony@atomide.com>
 <ef843afa-c99d-328d-853a-00ef293a47f2@bitmer.com>
 <20211212190455.qbggbhmr5nquw7bw@bitmer.com>
 <Ybbdnr96H58TkytD@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybbdnr96H58TkytD@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [211213 05:44]:
> * Jarkko Nikula <jarkko.nikula@bitmer.com> [211212 19:05]:
> > On Sat, Dec 11, 2021 at 05:30:57PM +0200, Jarkko Nikula wrote:
> > This I used years before your patch and by some reason I confused to use
> > new omap3-beagle-ab4.dtb when testing your patch yesterday:
> > 
> > > cat arch/arm/boot/dts/omap3-beagle-ab4.dtb >>arch/arm/boot/zImage
> > 
> > without realizing my Beagle Board version is not between A to B4 but C2.
> > So when using the omap3-beagle.dtb your patch fixes the regression I
> > found.
> > 
> > Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> OK good to hear omap3-beagle.dtb now works for beagles that don't have
> the A to B4 hardware timer issue :) And thanks for testing.
> 
> It seems the beagle revisions A to B4 are broken for any kind of power
> management as the clockevent timer for those boards is not always on.
> Probably not worth spending much effort on those. Maybe the PMIC could
> be reconfigured on the buggy revisions in addition to the timer quirks
> if somebody still cares for those board revisions.

Anyways, applying this fix into omap-for-v5.17/fixes-not-urgent.

Regards,

Tony
