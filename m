Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE53B470186
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhLJN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:28:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:43612 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhLJN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:28:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324607061"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="324607061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 05:24:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="462540695"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 05:24:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvfsU-004VNy-8t;
        Fri, 10 Dec 2021 15:23:58 +0200
Date:   Fri, 10 Dec 2021 15:23:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] leds: tca6507: Get rid of duplicate of_node
 assignment
Message-ID: <YbNU7kv2/O7Z2iVI@smile.fi.intel.com>
References: <20211202210613.78584-1-andriy.shevchenko@linux.intel.com>
 <20211203073121.GA27457@amd>
 <YaoLImUJb0K/IVOL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaoLImUJb0K/IVOL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 02:18:42PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 03, 2021 at 08:31:21AM +0100, Pavel Machek wrote:

...

> > > For the details one may look into the of_gpio_dev_init()
> > > implementation.
> > 
> > So... where do you see of_gpio_dev_init called in this particular
> > case?
> 
> Inside GPIO library as stated in the commit message.
> 
>   --> tca6507_probe_gpios()
>     --> gpiochip_add_data()
>       --> gpiochip_add_data_with_key()
>         --> of_gpio_dev_init()

Pavel, do you have any other concerns? Can this be applied?

-- 
With Best Regards,
Andy Shevchenko


