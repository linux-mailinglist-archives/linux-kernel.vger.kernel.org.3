Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAE464E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbhLANRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:17:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:62904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241930AbhLANRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:17:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236274758"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236274758"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="609547548"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 05:14:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msPPz-000zRg-Uh;
        Wed, 01 Dec 2021 15:13:03 +0200
Date:   Wed, 1 Dec 2021 15:13:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: dwapb: clarify usage of the register file
 version
Message-ID: <Yad032NkgdpL8eSm@smile.fi.intel.com>
References: <20211130164956.37540-1-andriy.shevchenko@linux.intel.com>
 <20211201122734.o7m5xb6zh4ngjpo7@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201122734.o7m5xb6zh4ngjpo7@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:27:34PM +0300, Serge Semin wrote:
> On Tue, Nov 30, 2021 at 06:49:56PM +0200, Andy Shevchenko wrote:
> > First of all, it's obvious that different versions can't be provided
> > simultaneously. Hence, versions can't be bit masks.
> > 
> > Second, due to above we have to mask out the version field in the flags
> > and only that can be evaluated against the certain version.
> > 
> > Clarify all above by:
> >  - introducing GPIO_REG_OFFSET_V1 and GPIO_REG_OFFSET_MASK
> >  - replacing conditional to mask out bits and compare to a version
> > 
> > Luckily there is no functional change (at least intended), so no need
> > to backport this.
> 
> Seems reasonable. Thanks.
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


