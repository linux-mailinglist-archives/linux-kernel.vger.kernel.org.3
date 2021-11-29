Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C44613E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbhK2LeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:34:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:33743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236392AbhK2LcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:32:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="216644486"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="216644486"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:28:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="476663912"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:28:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mreq9-00BhiZ-6O;
        Mon, 29 Nov 2021 13:28:57 +0200
Date:   Mon, 29 Nov 2021 13:28:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <YaS5ePueppEHb5AN@smile.fi.intel.com>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <YaDx/MaMuajAEp1H@smile.fi.intel.com>
 <20211126173707.GA13686@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126173707.GA13686@alpha.franken.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 06:37:07PM +0100, Thomas Bogendoerfer wrote:
> On Fri, Nov 26, 2021 at 04:41:00PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Nov 26, 2021 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Nov 26, 2021 at 11:23 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > ...
> > 
> > > Probably all of this can be removed, given the SPI controller driver
> > > itself was removed in commit 74523a5dae0c96d6 ("spi: txx9: Remove
> > > driver")?
> > 
> > Even better! Let Thomas speak on this.
> 
> let's remove it then.

Okay, who will send a patch?

P.S. I'm not a MIPS expert, I feel I'm not the right person to do,
but I can try my best.

-- 
With Best Regards,
Andy Shevchenko


