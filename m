Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC74614F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhK2M0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:26:20 -0500
Received: from elvis.franken.de ([193.175.24.41]:48727 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236912AbhK2MYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:24:19 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrfeW-0005RM-00; Mon, 29 Nov 2021 13:21:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 28140C2FBD; Mon, 29 Nov 2021 13:20:52 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:20:52 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <20211129122052.GA7921@alpha.franken.de>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Nov 26, 2021 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Nov 26, 2021 at 11:23 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > In order to get rid of legacy platform data in AT25 driver,
> > > convert its users to use software nodes.
> > >
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > This looks good to me, thanks for cleaning this up! I think Geert has this
> > hardware, adding him to Cc in case he wants to give it a spin.
> 
> The SPI controller is only present on TX4938, not on TX4927, so it is
> unused on my rbtx4927 board.
> 
> > >  arch/mips/include/asm/txx9/spi.h    |  4 ++--
> > >  arch/mips/txx9/generic/spi_eeprom.c | 32 +++++++++++++++++------------
> > >  arch/mips/txx9/rbtx4938/setup.c     |  6 +++---
> > >  3 files changed, 24 insertions(+), 18 deletions(-)
> 
> Probably all of this can be removed, given the SPI controller driver
> itself was removed in commit 74523a5dae0c96d6 ("spi: txx9: Remove
> driver")?

are you ok with completly removing rbtx4938 support ? Can I rbtx4939
board support, too ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
