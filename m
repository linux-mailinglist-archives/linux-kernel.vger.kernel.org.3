Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E64791CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhLQQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:46:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:52997 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235989AbhLQQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639759605; x=1671295605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rm2HVh8P6X4lFzTcgUHbjmh5k/gA7K+fk7L5EqTG4Zs=;
  b=FBZKQew7si8NjXHjWYQRq1TYLrVLaD5yFgnyQafnHcI37tpMfykwVMfo
   lTH04k3Nl/FHXHFCxRB6tfpBkHhauVIT0FWDxehZRy+DwWolMxDJW5a/1
   yzyuNJfXDoWt5eOzdq3pX75ZCkEKz/kaFYSqhRVYLCHINkUNoI+jFaWzv
   MySZE47nr3HQQ7I11VsjvmqOS2dnAi4N9pi5iYITzDgyLyB7nWzqKvXof
   vIAQJ1BJQC546E2cFoTuJJo+eFNoHXwPzAnNQuNfEHR12OqnMpA5umEoo
   Q39ERi2BcOdRbm6PYKy9PGmWh/fzNKJTBC/ZkRfb4Vr+4xPRSKLQzE157
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303162499"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303162499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:46:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="605941128"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:46:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1myGMK-007W5K-4t;
        Fri, 17 Dec 2021 18:45:28 +0200
Date:   Fri, 17 Dec 2021 18:45:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arseny Demidov <arsdemal@gmail.com>, rahul.tanwar@linux.intel.com,
        Arseny Demidov <a.demidov@yadro.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
Message-ID: <Yby+pwwCg4gagNEf@smile.fi.intel.com>
References: <20211216083302.986-1-a.demidov@yadro.com>
 <YbtK4mHxpdF5VtOk@smile.fi.intel.com>
 <4a93a4cc-5b37-4524-add9-541bfbe3980e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a93a4cc-5b37-4524-add9-541bfbe3980e@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 08:05:17AM -0800, Guenter Roeck wrote:
> On 12/16/21 6:19 AM, Andy Shevchenko wrote:
> > On Thu, Dec 16, 2021 at 11:33:02AM +0300, Arseny Demidov wrote:

...

> > > -#define POWER_DELAY_CYCLE_256	0x80
> > > +#define POWER_DELAY_CYCLE_256	0x100
> > >   #define POWER_DELAY_CYCLE_64	0x40
> > 
> > I;m wondering why they are in hex? Perhaps the decimal is better for both.
> > 
> Maybe, but that is POV, and I tend to leave it up to driver authors to decide.
> It is definitely not something we would want to change as part of a bug fix.

Agreed on both points.

-- 
With Best Regards,
Andy Shevchenko


