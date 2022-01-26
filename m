Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD149CA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiAZNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:19:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:47593 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234798AbiAZNTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:19:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246764661"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246764661"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628300420"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:19:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nCiC5-00Ebgm-A1;
        Wed, 26 Jan 2022 15:18:37 +0200
Date:   Wed, 26 Jan 2022 15:18:37 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFKLfSKUdo1UVfF@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
 <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
 <YfFE61IQus3SMQRZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFE61IQus3SMQRZ@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:56:11PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 26, 2022 at 01:37:00PM +0100, Javier Martinez Canillas wrote:
> > On 1/26/22 11:28, Dan Carpenter wrote:

...

> >    fb_hx8347d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
> >    fb_hx8357d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
> >    fb_ili9163.c (DRM driver in drivers/gpu/drm/tiny/ili9163.c)
> >    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
> >    fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
> >    fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
> >    fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
> 
> I'll gladly take a patch that deletes the fb_* files that are already
> handled by a DRM driver like you list here.

None of the DRM driver supports parallel interface for these devices.

-- 
With Best Regards,
Andy Shevchenko


