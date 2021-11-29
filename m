Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4237B46167D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbhK2Nfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:35:55 -0500
Received: from muru.com ([72.249.23.125]:33200 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236165AbhK2Ndy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:33:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DD7B280C0;
        Mon, 29 Nov 2021 13:31:14 +0000 (UTC)
Date:   Mon, 29 Nov 2021 15:30:33 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-omap@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ARM: dts: Fix timer regression for beagleboard revision c
Message-ID: <YaTV+UJjbD2HLnR9@atomide.com>
References: <20211125144834.52457-1-tony@atomide.com>
 <6ce29c03-03ce-8e65-76e1-40fe2bf23caa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce29c03-03ce-8e65-76e1-40fe2bf23caa@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Daniel Lezcano <daniel.lezcano@linaro.org> [211129 09:57]:
> On 25/11/2021 15:48, Tony Lindgren wrote:
> >  .../devicetree/bindings/arm/omap/omap.txt     |  3 ++
> >  arch/arm/boot/dts/Makefile                    |  1 +
> >  arch/arm/boot/dts/omap3-beagle-ab4.dts        | 47 +++++++++++++++++++
> >  arch/arm/boot/dts/omap3-beagle.dts            | 33 -------------
> >  drivers/clocksource/timer-ti-dm-systimer.c    |  2 +-
> >  5 files changed, 52 insertions(+), 34 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/omap3-beagle-ab4.dts
> 
> Usually, bindings DT and driver changes are separate patches

Not always for fixes :) In this case we need to patch both the dts for
timer quirks, and also update the related driver quirk. The driver quirk
I originally added to deal with possble older dtb files complicating the
fix unncessarily..

If you have better ideas for a fix please let me know.

Regards,

Tony
