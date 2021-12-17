Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8733D4793DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbhLQSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:18:29 -0500
Received: from mga05.intel.com ([192.55.52.43]:20727 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240391AbhLQSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:18:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="326099760"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="326099760"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:18:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="465211052"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:18:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1myHn4-007Yew-Ki;
        Fri, 17 Dec 2021 20:17:10 +0200
Date:   Fri, 17 Dec 2021 20:17:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
Message-ID: <YbzUJkCsmkz5jraQ@smile.fi.intel.com>
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mct9FuYvT-0gFrpUuNBnCVdmCp_cNESkL5NSgVVP6vezQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mct9FuYvT-0gFrpUuNBnCVdmCp_cNESkL5NSgVVP6vezQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:54:00PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Queued the series for next, thanks!

Thanks!

I hope that v2 is actually queued. There is a tag from Matti and addressed
comment from Linus.

-- 
With Best Regards,
Andy Shevchenko


