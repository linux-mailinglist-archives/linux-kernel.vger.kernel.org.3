Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0554049CBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbiAZONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:13:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:19421 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235281AbiAZONu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206430; x=1674742430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=69IwR4MRt1UJaVt9klo3HOzfBpM8++sjavE1VkWUzjw=;
  b=V+Bvr9sUHxpULOJ6E59FbhEoxfXp1jzHS/lGMkd/sAmG/l1W08Hxfc03
   C9lMZTzNd6k+1pybQJ7q6LhF7EJUikbkAusvKzeOMM2FfQHQ7aujK8o1a
   L+ozDqEvWZSuF0VwkgXO6dKAuOyJ0sR+gzHiwsaocVzPcuKzzAEn7Gl9y
   RbcN6Z8et8g31aRLnxLaZLgCm7u5VfdinpYXRCSDFtgfj0ALk7YVTU8zQ
   sL+CxTFUHZoZ2MWi7ptM7cC6kb4tUWCm8gYu4v0E/BL0l/JG6p6Pi9V1W
   1mxhxQLAyb/9mpzKdH1WxktJovZEbdbORyuYk9S+NmvK0Z2kZ4fjCVeLo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226533468"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="226533468"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:13:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="597472761"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:13:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCj2P-00EcWv-Rl;
        Wed, 26 Jan 2022 16:12:41 +0200
Date:   Wed, 26 Jan 2022 16:12:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/4] math.h: Introduce data types for fractional
 numbers
Message-ID: <YfFW2ejWZQnQuivs@smile.fi.intel.com>
References: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:53:50PM +0200, Andy Shevchenko wrote:
> Introduce a macro to produce data types like
> 
> 	struct TYPE_fract {
> 		__TYPE numerator;
> 		__TYPE denominator;
> 	};
> 
> to be used in the code wherever it's needed.
> 
> In the following changes convert some users to it.

The context of v4 is the dropped AFE patches.

-- 
With Best Regards,
Andy Shevchenko


