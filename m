Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C949836B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiAXPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:20:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:26698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238469AbiAXPUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643037620; x=1674573620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gn8dQ1lpyy0l1sUfM5Xu0wwNP5CH0wMiMJhjueSDfqI=;
  b=SJWIhGPdY1rGxA1BfGEt6SKGNuAmF+DiX66rPZ6UEr2wFjtqnos1Ub1j
   PFYj0aPL+cQmd1vihtY+U8XvFAiVdW9YbNWfJMFt+qYPn3vxuJy7hsPLw
   SMJiE/iqgkUVnMHWJBxt8O81KiB3NSZwqDAl9iiQkcFVFrHsY8WrcBUBT
   S7fVJ1OhtTN7Nm15Y6LgMG4DojMbEioS0iH/qnXDQnN/8OnPCqjqW9yLz
   Ol0tembKzCgMX6GTHUbrvCmzVJSb5FNLljSCiv+eMkVdLqRGkuGBFbMYL
   RrMe/HPU3DmtVmTst3Yu/lQDcnhAsr53JpcQKhch6eqvl1kP1YDBUiEHH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245849276"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245849276"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:20:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695454733"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:20:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC17Z-00Dw2L-WB;
        Mon, 24 Jan 2022 17:19:06 +0200
Date:   Mon, 24 Jan 2022 17:19:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <Ye7DaYNuXL30Oh/q@smile.fi.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 05:18:33PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> > On Mon, 10 Jan 2022 21:31:04 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > I'm not totally sold on this series showing there is a strong case for
> > these macros so interested to hear what others think.
> 
> So far no news :-)
> 
> > Boiler plate removal is always nice of course...
> 
> That's what I considered nice as well.

Ah, and thanks for review!

-- 
With Best Regards,
Andy Shevchenko


