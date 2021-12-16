Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A985C477452
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhLPOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:20:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:26385 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhLPOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664412; x=1671200412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtoqBpdkR2HHnUltaVX/SRE7Wk0WyJU9gZuR3pl9tSI=;
  b=S8kMyNGISXJy85C0eaFkrQYGlPw94IJl2ZAuUF/gAe+7rScENYQ9Bn6C
   oB0lP2ItjhezCYe/QiJfxv9IPcKgeFLFHderfTC0/B1nlGjH4MU6kKTD/
   1+jWVOX59dWxroDuo1srj2fjcKs6d8amQ/+0biRDKuSS7QPbbY7V+jUPb
   tlGYOSryzNtJb9280PddG5aXA8INIWL5mX3NqUW9uPT9SV74lPaBzu/5K
   YkKnPDgMGp3ZxR15g9iJmS5pAIr45rQOD+2/0OIF44uWCy/mmNNLUMTLV
   XN8So8YgbdMaecV9w4kW8QOJSg06QIbwbWepWX3yXuWXioGXMg5ldkB5A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220181746"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220181746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:20:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="605535740"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:20:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mxrbH-007475-3j;
        Thu, 16 Dec 2021 16:19:15 +0200
Date:   Thu, 16 Dec 2021 16:19:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Arseny Demidov <arsdemal@gmail.com>
Cc:     rahul.tanwar@linux.intel.com, Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
Message-ID: <YbtK4mHxpdF5VtOk@smile.fi.intel.com>
References: <20211216083302.986-1-a.demidov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216083302.986-1-a.demidov@yadro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:33:02AM +0300, Arseny Demidov wrote:
> In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256,
> the correct value should be 0x100. The register ip_tmr is expressed
> in units of IP clk cycles, in accordance with the datasheet.
> Typical power-up delays for Temperature Sensor are 256 cycles i.e. 0x100.

Should you provide Fixes tag?

...

> -#define POWER_DELAY_CYCLE_256	0x80
> +#define POWER_DELAY_CYCLE_256	0x100
>  #define POWER_DELAY_CYCLE_64	0x40

I;m wondering why they are in hex? Perhaps the decimal is better for both.

-- 
With Best Regards,
Andy Shevchenko


