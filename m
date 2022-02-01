Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA64A593F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiBAJdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:33:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:55429 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235894AbiBAJdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643707990; x=1675243990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ziky2M7C1UqU0dFMGza2JJFco5ugvRYxY1sxp7+XL7I=;
  b=SvNilgu0fpV7BpyUG9gauTVRsEsdLwVUAEQ3uot3V9ohupZnfPE+Lod5
   UnSzzmBv281ZkKmV9Anc0I1/X+BFKXcwA5BIrutJa37DK2uREooNQWV+N
   DohdebA9rj0IhFpE0tOJCY0nmePhBkaWuRtun99ezKLRn/pjrxzjb2Fi4
   R66Pz73jTiuV87widb41opai91dzhnh3vWZVg/G3IW/6QHapJ9DIoRUO5
   8L8ien+6AE1fbgz2fvKLqjvmsTHeJ20bNCVtMWniRaloWXfGzlmErbKmp
   FURVvEpg6pna25gA3pUWrBrm+iKyT2/GpUGdhwGSrDS5bKgJ6mftLNm4X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308385758"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="308385758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:33:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="626677567"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:33:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEpW8-00HFId-SB;
        Tue, 01 Feb 2022 11:32:04 +0200
Date:   Tue, 1 Feb 2022 11:32:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED
 displays DRM driver
Message-ID: <Yfj+FOELlbtdhvRa@smile.fi.intel.com>
References: <20220131201537.2325487-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131201537.2325487-1-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:15:37PM +0100, Javier Martinez Canillas wrote:
> To make sure that tools like the get_maintainer.pl script will suggest
> to Cc me if patches are posted for this driver.
> 
> Also include the Device Tree binding for the old ssd1307fb fbdev driver
> since the new DRM driver was made compatible with the existing binding.

Dunno why you have patches 3 and 4 missed references (in terms of email
thread).

> +DRM DRIVER FOR SOLOMON SSD1307 OLED DISPLAYS
> +M:	Javier Martinez Canillas <javierm@redhat.com>
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +F:	drivers/gpu/drm/tiny/ssd1307.c

I think it makes sense to add ssd1307fb as well. At least you may point out
people patching old driver about new one until it's gone completely.

-- 
With Best Regards,
Andy Shevchenko


