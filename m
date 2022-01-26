Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74349CBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiAZOM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:12:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:38658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241952AbiAZOMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:12:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="271007429"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="271007429"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:12:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="532768877"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:12:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nCj1P-00EcVH-3h;
        Wed, 26 Jan 2022 16:11:39 +0200
Date:   Wed, 26 Jan 2022 16:11:38 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFWmmJFtEB93jUi@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
 <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com>
 <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:47:33PM +0100, Javier Martinez Canillas wrote:
> On 1/26/22 14:27, Andy Shevchenko wrote:
> > On Wed, Jan 26, 2022 at 12:18:30PM +0100, Javier Martinez Canillas wrote:
> >> On 1/26/22 11:59, Helge Deller wrote:
> >>> On 1/26/22 11:02, Andy Shevchenko wrote:

...

> >>>> P.S. For the record, I will personally NAK any attempts to remove that
> >>>> driver from the kernel. And this is another point why it's better not
> >>>> to be under the staging.
> >>>
> >>> I agree. Same as for me to NAK the disabling of fbcon's acceleration
> >>> features or even attempting to remove fbdev altogether (unless all
> >>> relevant drivers are ported to DRM).
> >>
> >> But that will never happen if we keep moving the goal post.
> >>
> >> At some point new fbdev drivers should not be added anymore, otherwise
> >> the number of existing drivers that need conversion will keep growing.
> > 
> > This thread is not about adding a new driver.
> 
> It was about adding a new drivers to drivers/video/ (taken from staging).

Does it mean gates are open to take any new fbdev drivers to the staging?
If not, I do not see a point here.

-- 
With Best Regards,
Andy Shevchenko


