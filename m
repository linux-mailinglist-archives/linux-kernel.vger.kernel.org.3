Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09F476E42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhLPJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:50:49 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34295 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhLPJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:50:48 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7102024000D;
        Thu, 16 Dec 2021 09:50:45 +0000 (UTC)
Date:   Thu, 16 Dec 2021 10:50:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alessandro Zummo <a.zummo@towertech.it>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rtc: nintendo: Add a RTC driver for the GameCube,
 Wii and Wii U
Message-ID: <YbsL9C6qjo/8SgjU@piout.net>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
 <87tuf9kv6c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuf9kv6c.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 16/12/2021 15:52:59+1100, Michael Ellerman wrote:
> > Emmanuel Gil Peyrot (5):
> >   rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U
> >   rtc: gamecube: Report low battery as invalid data
> >   powerpc: wii.dts: Expose HW_SRNPROT on this platform
> >   powerpc: gamecube_defconfig: Enable the RTC driver
> >   powerpc: wii_defconfig: Enable the RTC driver
> >
> >  drivers/rtc/Kconfig                     |  11 +
> >  drivers/rtc/Makefile                    |   1 +
> >  drivers/rtc/rtc-gamecube.c              | 377 ++++++++++++++++++++++++
> 
> This is basically an rtc series as far as I'm concerned.
> 
> >  arch/powerpc/boot/dts/wii.dts           |   5 +
> >  arch/powerpc/configs/gamecube_defconfig |   2 +-
> >  arch/powerpc/configs/wii_defconfig      |   2 +-
> 
> I have nothing queued in the powerpc tree that touches any of those
> files, so conflicts are unlikely.
> 
> So I'm happy for this to go via the rtc tree whenever it's ready.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

That's done, thanks.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
