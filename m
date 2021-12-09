Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A815646F265
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbhLIRrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:47:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:47013 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242729AbhLIRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:47:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225031556"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225031556"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:43:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="543679880"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:43:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvNQf-004Bok-01;
        Thu, 09 Dec 2021 19:42:01 +0200
Date:   Thu, 9 Dec 2021 19:42:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:24:59PM +0300, Sergey Shtylyov wrote:
> On 12/9/21 5:59 PM, Andy Shevchenko wrote:
> 
> > platform_get_irq() will print a message when it fails.
> > No need to repeat this.
> > 
> > While at it, drop redundant check for 0 as platform_get_irq() spills
> > out a big WARN() in such case.
> 
>    And? IRQ0 is still returned! :-(

It should not be returned in the first place.

...

> > -	if (!irq)
> > -		return -EINVAL;
> 
>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
> platform_get_irq() and friends gets merged....

What patch?

Does it fix platform_get_irq_optional()?

-- 
With Best Regards,
Andy Shevchenko


