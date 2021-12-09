Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2D46F3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhLITcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:32:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:56925 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhLITcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:32:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225057913"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225057913"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:28:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680461349"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 11:28:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvP4x-004EI4-SO;
        Thu, 09 Dec 2021 21:27:43 +0200
Date:   Thu, 9 Dec 2021 21:27:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbJYr7jg162RVP12@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:22:55PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 09, 2021 at 09:22:32PM +0300, Sergey Shtylyov wrote:
> > On 12/9/21 8:42 PM, Andy Shevchenko wrote:

...

> > > Does it fix platform_get_irq_optional()?
> > 
> >    Of course! :-)
> 
> Can you share link to lore.kernel.org, please?
> It will make much easier to try and comment.

For the record it does not fix platform_get_irq_optional() AFAICS.

Have you read the discussion:
https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u
?

-- 
With Best Regards,
Andy Shevchenko


