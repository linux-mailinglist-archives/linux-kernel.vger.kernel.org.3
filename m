Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6024A9A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359170AbiBDN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:58:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:15833 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354349AbiBDN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643983118; x=1675519118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BxfKJHDVoUG3oQffGXWyy/SJf5pROrxwoiqlC67rMU=;
  b=TI1NhDpZhXepQgWgiprKEzaMKI+CVzUPs++elz69MIp4iIXf6vfq+RTC
   GW5RyluGKu+HBlf/f73G3HXBFzd+XYhw6nVHzRYZYtpfT7HQg2J6vDkyu
   IhYABTmYFy9F1AaeJuxB3E7dtoGiTvUj6QsI8Ja5tUhNGyyudOclXKv3H
   T3Em81JN6W4FV6fVUsA6hqd7lgBP1K2mnS0Km9vA3SV2SEpmkmn1a51Qy
   SnmlbIxNQaOZMqJmiV5OHef93uE3fiWPXNG7/K/axqWvHzthO7/oS+od0
   GiBmn7IPi+0cYUb2Xh8G82TWnwtn6sRc4AdaQDIBLnsoCTLxkockWOE0e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309114782"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="309114782"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:58:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="627783155"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:58:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFz5g-000o5W-Pc;
        Fri, 04 Feb 2022 15:57:32 +0200
Date:   Fri, 4 Feb 2022 15:57:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED
 displays DRM driver
Message-ID: <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204134347.1187749-4-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:
> To make sure that tools like the get_maintainer.pl script will suggest
> to Cc me if patches are posted for this driver.
> 
> Also include the Device Tree binding for the old ssd1307fb fbdev driver
> since the new DRM driver was made compatible with the existing binding.

...

>  drivers/gpu/drm/drm_format_helper.c | 2 +-

Nothing about this in the commit message...

Stray change?

-- 
With Best Regards,
Andy Shevchenko


