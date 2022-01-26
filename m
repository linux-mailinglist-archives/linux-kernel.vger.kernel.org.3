Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61FD49CADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiAZNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:31:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:1573 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbiAZNbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:31:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246493197"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246493197"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:31:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="477480490"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:31:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nCiNf-00EbsA-L1;
        Wed, 26 Jan 2022 15:30:35 +0200
Date:   Wed, 26 Jan 2022 15:30:35 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
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
Message-ID: <YfFM+6pvJLmtY0Zg@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
 <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <CAKMK7uEqwyZuVheqyNG33Un4WK1cd1B+WBYbCmi20fZi0qVG2w@mail.gmail.com>
 <88ea01b8-3fdd-72cc-c3d8-e2890c68533b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ea01b8-3fdd-72cc-c3d8-e2890c68533b@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:38:09PM +0100, Helge Deller wrote:
> On 1/26/22 12:24, Daniel Vetter wrote:
> > On Wed, Jan 26, 2022 at 12:18 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
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
> > And that point was about 5 years ago, and has been discussed at some
> > plumbers meanwhile, resulting in the staging TODO patches to make
> > these drm drivers to destage them.
> >
> > Fixing bugs in fbdev is all fine, reopening it for merging new drivers is not.
> 
> We are on the same page!
> I'm not at all proposing to include new drivers for (relatively) new
> hardware into fbdev, which is capable to be written as DRM driver.

Agree. The point here is neither in opening it for new comers nor for
expanding, the drivers in question are all in the kernel in different folder
that is not suitable for them, but I gave up. I see that nobody wants
maintainers to be appearing for the old _working_ code, as it was shown
already by the DVB case few month ago.

-- 
With Best Regards,
Andy Shevchenko


