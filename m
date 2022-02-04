Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4554D4A9AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359292AbiBDO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:29:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:5573 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359280AbiBDO3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643984953; x=1675520953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3pQRZIYFfG++lCfuR7gxtikGSTVR3XAR5ZqOfqUBk84=;
  b=e1GuPCEpeYDSIc/nqzg8+PWFJ/dmgmMWVI7BNj171xOeILPJs1DGItc1
   B9Z07MXwmCsLCofFe71jahR9ruJSTw3mdd4hgJSDzm7K9IxFcE5rcoNSp
   1R77lTpx+ry9oNcCKJlvSLHfrotIdcdY32E6s5zxnfs8EI3fwPx4LjtYq
   pcmCdMrQnou4Y2ig4anWe39VZCWu1EsQWkihQg6vWvjK2Qk3dBiI1QRHJ
   VKCi3/IN5aFtJl4E4pZIh52xrJKyH3SHcqaqdkTPzC1H/f2onhpVFz3dg
   AxTsL9xQq9AhPVsCDJtrCrnKviAak12tMibJD6RQprkHZ6S1SjUXQnnp/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="231942548"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="231942548"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 06:29:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="524322677"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 06:29:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFzZI-000oW4-CM;
        Fri, 04 Feb 2022 16:28:08 +0200
Date:   Fri, 4 Feb 2022 16:28:08 +0200
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
Message-ID: <Yf03+MsbqRp+uQff@smile.fi.intel.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-4-javierm@redhat.com>
 <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
 <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:12:17PM +0100, Javier Martinez Canillas wrote:
> On 2/4/22 14:57, Andy Shevchenko wrote:
> > On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:

...

> > Stray change?
> 
> Sigh, I'm not sure how added that change. Just ignore it, I'll fix it
> on v3 or when applying if there isn't another revision of this series.

I believe v3 is warranted due to the other patch review.

-- 
With Best Regards,
Andy Shevchenko


