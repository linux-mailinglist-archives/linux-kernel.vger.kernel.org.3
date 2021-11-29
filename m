Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEA4614E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhK2MX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:23:27 -0500
Received: from elvis.franken.de ([193.175.24.41]:48713 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235068AbhK2MV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:21:26 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mrfbj-0005Q2-00; Mon, 29 Nov 2021 13:18:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 38BC0C2FBA; Mon, 29 Nov 2021 13:02:03 +0100 (CET)
Date:   Mon, 29 Nov 2021 13:02:03 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <20211129120203.GA7857@alpha.franken.de>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <YaDx/MaMuajAEp1H@smile.fi.intel.com>
 <20211126173707.GA13686@alpha.franken.de>
 <YaS5ePueppEHb5AN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaS5ePueppEHb5AN@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:28:56PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 26, 2021 at 06:37:07PM +0100, Thomas Bogendoerfer wrote:
> > On Fri, Nov 26, 2021 at 04:41:00PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, Nov 26, 2021 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Fri, Nov 26, 2021 at 11:23 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > ...
> > > 
> > > > Probably all of this can be removed, given the SPI controller driver
> > > > itself was removed in commit 74523a5dae0c96d6 ("spi: txx9: Remove
> > > > driver")?
> > > 
> > > Even better! Let Thomas speak on this.
> > 
> > let's remove it then.
> 
> Okay, who will send a patch?
> 
> P.S. I'm not a MIPS expert, I feel I'm not the right person to do,
> but I can try my best.

ok, I'll do it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
