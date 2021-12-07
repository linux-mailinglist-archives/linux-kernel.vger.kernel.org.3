Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4B46B946
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhLGKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:43:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:56438 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232747AbhLGKnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:43:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323805178"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323805178"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:39:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="611626988"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 02:39:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muXs5-003B0B-O9;
        Tue, 07 Dec 2021 12:38:53 +0200
Date:   Tue, 7 Dec 2021 12:38:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, kbuild-all@lists.01.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [pdx86-platform-drivers-x86:review-hans 41/44]
 drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous
 prototype for 'yogabook_wmi_suspend'
Message-ID: <Ya85vcmiq+MI2Scc@smile.fi.intel.com>
References: <202112070945.X05c2wgI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112070945.X05c2wgI-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:42:46AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
> head:   cb01df9ef827442739051c6457962a5c6bc85d99
> commit: 4709e8b835ec25e8627844e9927804f814b64fd4 [41/44] platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211207/202112070945.X05c2wgI-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=4709e8b835ec25e8627844e9927804f814b64fd4
>         git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>         git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>         git checkout 4709e8b835ec25e8627844e9927804f814b64fd4
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/platform/x86/lenovo-yogabook-wmi.c:278:20: warning: no previous prototype for 'yogabook_wmi_suspend' [-Wmissing-prototypes]
>      278 | __maybe_unused int yogabook_wmi_suspend(struct device *dev)
>          |                    ^~~~~~~~~~~~~~~~~~~~
> >> drivers/platform/x86/lenovo-yogabook-wmi.c:294:20: warning: no previous prototype for 'yogabook_wmi_resume' [-Wmissing-prototypes]
>      294 | __maybe_unused int yogabook_wmi_resume(struct device *dev)
>          |                    ^~~~~~~~~~~~~~~~~~~

Despite missed static, we usually put __maybe_unused between type and function
name in this cases.

-- 
With Best Regards,
Andy Shevchenko


