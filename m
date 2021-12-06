Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304146A1A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhLFQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:48:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:46969 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233166AbhLFQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:48:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237165772"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237165772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:45:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="542451917"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 08:45:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muH5w-002qvV-Oj;
        Mon, 06 Dec 2021 18:44:04 +0200
Date:   Mon, 6 Dec 2021 18:44:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <Ya491Dtj7HqoMhvW@smile.fi.intel.com>
References: <20211206144901.63529ac9@canb.auug.org.au>
 <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
 <20211206161734.GA4141317@maple.netwinder.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206161734.GA4141317@maple.netwinder.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 11:17:34AM -0500, Ralph Siemsen wrote:
> On Mon, Dec 06, 2021 at 03:43:11PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 06, 2021 at 02:49:01PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > 
> > >   drivers/misc/eeprom/at25.c
> > > 
> > > between commit:
> > > 
> > >   9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")
> 
> This was my original patch from Nov 8th.
> 
> > >   5b557298d7d0 ("misc: at25: Make driver OF independent again")
> > >   a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM case")
> > >   58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case")
> > >   51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywhere in ->probe()")
> > > (and probably more)
> 
> These are newer versions and some cleanups from Andy. I was not aware of
> this work going on. I'm surprised at25 is getting so much attention ;-)

Me neither. :-)

> > > I fixed it up (I just used the latter version) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > non trivial conflicts should be mentioned to your upstream maintainer
> > > when your tree is submitted for merging.  You may also want to consider
> > > cooperating with the maintainer of the conflicting tree to minimise any
> > > particularly complex conflicts.
> > 
> > The result from char-misc.current should be used as is and I guess it's
> > what you have done, thanks!
> 
> Agreed - Andy's version is cleaner, and includes my fixes. I've run some
> quick tests locally and all seems to be working as expected.

Thanks, Ralph!

-- 
With Best Regards,
Andy Shevchenko


