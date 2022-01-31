Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D614A3FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358075AbiAaKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:19:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:8189 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232024AbiAaKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643624332; x=1675160332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+4KBIisyHEFl81YzQOnG17jTyC8lc+mEqx8k4t2pj94=;
  b=N8JBRXpQ1s02aD14EBOMWTpIoIPt1mChM0u4Z+B5ryRSbsnnuGMnqf6G
   nIwsFjtyx0pkI/xTU0+MsM6diqn4Gp34k3ckMIilmqGF0l1R1z5KRNWTJ
   8D426NVlrUrV5PuZYJN4Xesk5FoLSqQ5/6N1icwMrT9/CmsgC0ZCv11ln
   H4TeKvTEVZr/aozGG5xbVkdz9/54yMe/bud3udBOA8NpFtPzQoc7AZTXf
   sjqJj5wV0Pstuhh/r/S3Ryo5PX1TahtJaRZvCj6P5es0D1ccQQoB2yfSG
   7Mw50nxjDcg9vH8ETbn4rcHPhHRXAr6eLwCi3b/Y8orH33j51Ox2clDfL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="333791235"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="333791235"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:18:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="629970286"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:18:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nETkm-00GpEg-FG;
        Mon, 31 Jan 2022 12:17:44 +0200
Date:   Mon, 31 Jan 2022 12:17:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/4] math.h: Introduce data types for fractional
 numbers
Message-ID: <Yfe3SK88LeJ8Iebf@smile.fi.intel.com>
References: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
 <20220130123034.708543ad@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130123034.708543ad@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 12:30:47PM +0000, Jonathan Cameron wrote:
> On Wed, 26 Jan 2022 15:53:50 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Introduce a macro to produce data types like
> > 
> > 	struct TYPE_fract {
> > 		__TYPE numerator;
> > 		__TYPE denominator;
> > 	};
> > 
> > to be used in the code wherever it's needed.
> > 
> > In the following changes convert some users to it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I'm not 100% sold on this, but I'm going to give them the benefit
> of the doubt as to long term usefulness and apply them.
> 
> Basically I'm taking the view Andy is often right :)

Time will show :-)

> Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to see if we missed anything.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


