Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440894A5963
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiBAJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:42:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:57976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236025AbiBAJmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643708540; x=1675244540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tZyjAxsCP4hOqAR4pjEHIEl2lCJLcdsBpV7uLY4i/0=;
  b=Ph+MafzjuqWGzMOH5PBIIKeIJLYLc4v2AQVj/ZmiMR03ISN5Hcu5dc6C
   xGH5JjfHYLz12IiL5HKaVVAxv1tVrxuANeBY0FFdZsQYnFLDRdVK8cPWh
   FJFX2Qmaghtozg8zsL9B9eI+KNNwMoP8NVSJcmB9BICDO+a9v5nGng6IF
   vzd4ZZLo9KZqlJxk3qvO2xgH+l/mtZJgUoC2haE3a+lIHdqZNk08j4zSj
   ouN/xO+BpaNXQMKld00f4ZiBGPrBff1oKWnAyeLOhOkFY9eNMtI40hYTm
   QabRKglr4ayqBnDrPZbYSLVlzzRXNzW9Q9L0ubmJZ/G5ug6e25ak0oQp1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247425762"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247425762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:42:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="619743874"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:42:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEpf0-00HFTZ-Cc;
        Tue, 01 Feb 2022 11:41:14 +0200
Date:   Tue, 1 Feb 2022 11:41:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 3/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <YfkAOiSlIMZrKXyl@smile.fi.intel.com>
References: <20220131202916.2374502-1-javierm@redhat.com>
 <YfhVBtv1UIA7bJja@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhVBtv1UIA7bJja@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:30:46PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 09:29:16PM +0100, Javier Martinez Canillas wrote:

...

> > +config TINYDRM_SSD1307
> > +	tristate "DRM support for Solomon SSD1307 OLED displays"
> Use SSD130X here - so SSD1306 users can find it.

It's better to list them all in the "help". How user would grep this?

`git grep -n -i ssd1306` ==> no match.

> > +	depends on DRM && I2C
> > +	select DRM_KMS_HELPER
> > +	select DRM_GEM_SHMEM_HELPER
> > +	select BACKLIGHT_CLASS_DEVICE
> > +	help
> > +	  DRM driver for the SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
> > +	  OLED controllers that can be programmed via an I2C interface.
> > +
> > +	  If M is selected the module will be called ssd1307.

-- 
With Best Regards,
Andy Shevchenko


