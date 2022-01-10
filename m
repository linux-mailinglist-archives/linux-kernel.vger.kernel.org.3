Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8410E489F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbiAJSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:51:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:18507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241986AbiAJSvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641840704; x=1673376704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWcyZfu0zV/E0m/O9x2TQoChBExtoI+yu9H4BVJDPSs=;
  b=N1AG7oW/fb1f6NZnvghhQDx0aGJw8Xc3nP7nyKsLMYywYrjQsk/zzFop
   t7hkN1KvLgnfmeFmFKL+fBbe3Y/wIHDNG2ByZb2ZhH+ILgyjc6Cddy6mx
   Br5ukJL5UUBw6tb+NiGE2wjn0VKxw5TbJcm6D2YUirRpOxXLn+bQ4rTjQ
   rPNob3LAVlqLE4867mc/RsL1y3zhmIPYf+sX0xezg/c4HDt33qKZ96a5U
   R0JpiTyq3NnWmR7Mhz+oPqTRHUzG+mOVVUKRVhrUkNsfOsGWWw+6JUZ2V
   IP13MMHYCXMQCjwjmftEoe8FMyOvAnat3vLssLs8NQuhRqa+RP7mdYGgj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242111264"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242111264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:51:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="575917216"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:51:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6zkQ-008z5l-SX;
        Mon, 10 Jan 2022 20:50:26 +0200
Date:   Mon, 10 Jan 2022 20:50:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 4/5] iio: adc: qcom-vadc-common: Re-use generic struct
 u32_fract
Message-ID: <Ydx/8vZj1jvkkkm0@smile.fi.intel.com>
References: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
 <20220110181711.65054-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110181711.65054-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:17:10PM +0200, Andy Shevchenko wrote:
> Instead of custom data type re-use generic struct u32_fract.
> No changes intended.

...

> -/**
> - * struct vadc_prescale_ratio - Represent scaling ratio for ADC input.
> - * @num: the inverse numerator of the gain applied to the input channel.
> - * @den: the inverse denominator of the gain applied to the input channel.
> - */
> -struct vadc_prescale_ratio {
> -	u32 num;
> -	u32 den;
> -};

Definitely forgot to compile this one.

-- 
With Best Regards,
Andy Shevchenko


