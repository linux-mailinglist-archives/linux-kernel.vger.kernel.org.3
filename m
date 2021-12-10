Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FDF46FEE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhLJKsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:48:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:33143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233090AbhLJKsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:48:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324588169"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="324588169"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:45:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="480693137"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 02:45:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvdNv-004SNS-TD;
        Fri, 10 Dec 2021 12:44:15 +0200
Date:   Fri, 10 Dec 2021 12:44:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbMvfzKsc4CcQzSa@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
 <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:29:07PM +0300, Sergey Shtylyov wrote:
> On 12/9/21 10:22 PM, Andy Shevchenko wrote:

...

> >>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>>>> out a big WARN() in such case.
> >>>>
> >>>>    And? IRQ0 is still returned! :-(
> >>>
> >>> It should not be returned in the first place.
> >>
> >>    But it still is, despite the WARN(), right?
> > 
> > So, you admit that there is a code which does that?
> 
>    I admit *what*?! That platfrom_get_irq() and its ilk return IRQ0 while they
> shouldn't? =)

That there is a code beneath platform_get_irq() that returns 0, yes.

> > That code should be fixed first. Have you sent a patch?
> 
>    Which code?! You got me totally muddled. =)

Above mentioned.

...

> >>>>> -	if (!irq)
> >>>>> -		return -EINVAL;
> >>>>
> >>>>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
> >>>> platform_get_irq() and friends gets merged....
> >>>
> >>> What patch?
> >>
> >>    https://marc.info/?l=linux-kernel&m=163623041902285
> >>
> >>> Does it fix platform_get_irq_optional()?
> >>
> >>    Of course! :-)
> > 
> > Can you share link to lore.kernel.org, please?
> > It will make much easier to try and comment.
> 
>    I don't know how to uise it yet, and I'm a little busy with other IRQ0 issues ATM,
> so I'm afraid you're on your own here...

lore.kernel.org is the official mailing list archive for Linux kernel work
AFAIU. Other sites may do whatever they want with that information, so -->
they are unreliable. If you wish to follow the better process, use
lore.kernel.org. Understanding how it works takes no more than 5 minutes
by engineer with your kind of experience with Linux kernel development.

-- 
With Best Regards,
Andy Shevchenko


