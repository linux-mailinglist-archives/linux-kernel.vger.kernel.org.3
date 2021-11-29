Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204154616A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377934AbhK2Ni5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:38:57 -0500
Received: from elvis.franken.de ([193.175.24.41]:48864 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377816AbhK2Ngy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrgmk-000649-00; Mon, 29 Nov 2021 14:33:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C790FC2FEA; Mon, 29 Nov 2021 14:05:35 +0100 (CET)
Date:   Mon, 29 Nov 2021 14:05:35 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <20211129130535.GA8644@alpha.franken.de>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <20211129122052.GA7921@alpha.franken.de>
 <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:30:17PM +0100, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Mon, Nov 29, 2021 at 1:21 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> > On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Nov 26, 2021 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Nov 26, 2021 at 11:23 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > In order to get rid of legacy platform data in AT25 driver,
> > > > > convert its users to use software nodes.
> > > > >
> > > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > This looks good to me, thanks for cleaning this up! I think Geert has this
> > > > hardware, adding him to Cc in case he wants to give it a spin.
> > >
> > > The SPI controller is only present on TX4938, not on TX4927, so it is
> > > unused on my rbtx4927 board.
> > >
> > > > >  arch/mips/include/asm/txx9/spi.h    |  4 ++--
> > > > >  arch/mips/txx9/generic/spi_eeprom.c | 32 +++++++++++++++++------------
> > > > >  arch/mips/txx9/rbtx4938/setup.c     |  6 +++---
> > > > >  3 files changed, 24 insertions(+), 18 deletions(-)
> > >
> > > Probably all of this can be removed, given the SPI controller driver
> > > itself was removed in commit 74523a5dae0c96d6 ("spi: txx9: Remove
> > > driver")?
> >
> > are you ok with completly removing rbtx4938 support ? Can I rbtx4939
> > board support, too ?
> 
> Fine for me, I only have rbtx4927.
> 
> BTW, I'm using it in 32-bit mode, as the VxWorks bootloader cannot boot
> 64-bit images. Are there other boards with such a limitation? Perhaps
> there's even shim support for booting 64-bit kernels on such boards,
> so I can test both 32-bit and 64-bit kernels?

maybe BOOT_ELF32 could help here.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
