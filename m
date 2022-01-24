Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1049832F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbiAXPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:11:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:6566 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbiAXPLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643037082; x=1674573082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPoO0UpQDTtomNmCEeSw5WFs51jU0nY+bce3pE812xs=;
  b=JTbJXvGOkDI5hLU8WGQK9DPmIB4OXnyH8WnD9bL6AY5haKmK6P8Dy3+S
   9DMWy9IfGnU9v34gAOhnkcDBCaTeDqRp98LcDNecc+CObRRO4Cb3QVGiH
   WoQLbeauGNfebd0efbEAaUQeiVXRMmpB65jyZMMZBayPFcqvn+f4jVi6A
   IZ209gvCd41wjMeDLWHW1ns+JMZs9kkDxYiT5X5voUlgU8wyMbQ7g2yQv
   zTZ5SGmbjKLXKnXfAp60IFgTpCeHs5GZAjfDQzBpRxzNageGpXWPuJlfe
   JeHRNcKlX1okNjHFMYPGWXABPOXt0jwVUnBsB2F+yrYiuamT8qRYBWRV6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226046456"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226046456"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:11:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476747480"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:11:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC0yy-00DvuI-Ay;
        Mon, 24 Jan 2022 17:10:12 +0200
Date:   Mon, 24 Jan 2022 17:10:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra: Get rid of duplicate of_node
 assignment
Message-ID: <Ye7BVEvepBTLgtWO@smile.fi.intel.com>
References: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
 <YdWp09bj4SP5oNvc@smile.fi.intel.com>
 <CAMRc=McdH7EebcM5AJb1jT2T_cP_yXyS7t+TP675f6kw92wbRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McdH7EebcM5AJb1jT2T_cP_yXyS7t+TP675f6kw92wbRA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:42:15AM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 5, 2022 at 3:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Dec 23, 2021 at 02:26:39PM +0200, Andy Shevchenko wrote:
> > > GPIO library does copy the of_node from the parent device of
> > > the GPIO chip, there is no need to repeat this in the individual
> > > drivers. Remove these assignment all at once.
> > >
> > > For the details one may look into the of_gpio_dev_init() implementation.
> >
> > Any comments on this one?
> 
> It looks good to me but I wanted to wait for Thierry's ack.

We have got a tag, I'll incorporate this to my usual PR, since we got into
a new cycle anyway and this is not a fix. Same for other similar patches.

-- 
With Best Regards,
Andy Shevchenko


