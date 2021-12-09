Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3146F3DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhLIT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:27:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:60057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhLIT1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:27:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="298979489"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="298979489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:23:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="612639950"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:23:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvP0J-004E8t-6v;
        Thu, 09 Dec 2021 21:22:55 +0200
Date:   Thu, 9 Dec 2021 21:22:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:22:32PM +0300, Sergey Shtylyov wrote:
> On 12/9/21 8:42 PM, Andy Shevchenko wrote:

...

> >>> No need to repeat this.
> >>>
> >>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>> out a big WARN() in such case.
> >>
> >>    And? IRQ0 is still returned! :-(
> > 
> > It should not be returned in the first place.
> 
>    But it still is, despite the WARN(), right?

So, you admit that there is a code which does that? That code should be fixed
first. Have you sent a patch?

...

> >>> -	if (!irq)
> >>> -		return -EINVAL;
> >>
> >>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
> >> platform_get_irq() and friends gets merged....
> > 
> > What patch?
> 
>    https://marc.info/?l=linux-kernel&m=163623041902285
> 
> > Does it fix platform_get_irq_optional()?
> 
>    Of course! :-)

Can you share link to lore.kernel.org, please?
It will make much easier to try and comment.

-- 
With Best Regards,
Andy Shevchenko


