Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6546E86D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhLIM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:29:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:64180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhLIM3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:29:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218778862"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="218778862"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:26:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="462109743"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:25:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mvITo-0045BO-MA;
        Thu, 09 Dec 2021 14:24:56 +0200
Date:   Thu, 9 Dec 2021 14:24:56 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 1/1] drm: Replace kernel.h with the necessary
 inclusions
Message-ID: <YbH1mBlbuysch15b@smile.fi.intel.com>
References: <20211110102423.54282-1-andriy.shevchenko@linux.intel.com>
 <887a15cb-3a3b-4ba2-aa0f-a241e70a19fa@suse.de>
 <CAHp75VdY57xQBLN8vT3RdagQx=4kLx69qAyuzLwqTvNGC2xUbQ@mail.gmail.com>
 <d536e7d2-891e-e0a8-6abc-6694987a65f7@suse.de>
 <YZJGEi6Qqh1aGCxa@smile.fi.intel.com>
 <YZ0Xrus5wZar3QN7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ0Xrus5wZar3QN7@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 06:32:46PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 01:35:47PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 10, 2021 at 05:39:33PM +0100, Thomas Zimmermann wrote:
> > > Am 10.11.21 um 17:34 schrieb Andy Shevchenko:
> > > > On Wed, Nov 10, 2021 at 3:55 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > > Am 10.11.21 um 11:24 schrieb Andy Shevchenko:
> > 
> > ...
> > 
> > > > > > +#include <linux/container_of.h>
> > > > > 
> > > > > I built this patch on a recent drm-misc-next, but there's no
> > > > > linux/container_of.h
> > > > 
> > > > Thank you for trying. It's in the upstream, whenever drm-misc-next
> > > > switches to newer/newest upstream it will be there. I assume it will
> > > > happen after v5.16-rc1?
> > > 
> > > Yes, we'll certainly backmerge soon after rc1 has been released. If I forget
> > > to add the patch then, please send a reminder.
> > > 
> > > Once the necessary headers are available,
> > 
> > $ git log --oneline v5.16-rc1 -- include/linux/container_of.h
> > e1edc277e6f6 linux/container_of.h: switch to static_assert
> > d2a8ebbf8192 kernel.h: split out container_of() and typeof_member() macros
> > 
> > > the patch is
> > > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > 
> > Thanks!
> 
> Maybe I misunderstood something, I thought that DRM people may apply this,
> is it incorrect assumption?

It still does not appear in Linux Next...
What should I do to move this forward, please?

-- 
With Best Regards,
Andy Shevchenko


