Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4657549B5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577840AbiAYOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:11:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:34418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578027AbiAYOIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643119705; x=1674655705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XgfYTpAKCUjsVgEWndslqumPAtQ3LFT5BEWLwncUR10=;
  b=KFvdTrXcfZS+/+Ks3U5nreMdxBo8uXt4h7ZXI5fZdfrqcCW+u8cqayOK
   42AmSrp5f2KxJxeK3m3uKJJ16GZCqU1hfqwBD5364OohARCVyLKHUlikt
   zDitERCgaQsXuDwEOrRYqXceFxGauAV+D0kBlD5BSldQbln/JqRZZk/fQ
   hCpBbaLpQa3bngiXiE7wRY2mVIPxvCRl8cowFhqUfW3+lzRWZczQJgjfw
   rj8f8lX8jQGTsrR5308lrkw7S0seuO42Oh7CuYPqqVJ0dthhREs2dPj5T
   1Tm84Twr+Czg+xiNgigl19ofiIp7b1M/MzoWzFIfxlIvpc8HAwh7QWWkH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="270752320"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="270752320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:05:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="580757906"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:05:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCMQd-00EGe2-Nv;
        Tue, 25 Jan 2022 16:04:11 +0200
Date:   Tue, 25 Jan 2022 16:04:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH v2 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Message-ID: <YfADW9YZ8Hbt8Phq@smile.fi.intel.com>
References: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
 <11caff0e-6bf3-9d66-6312-c2c2a6fc862a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11caff0e-6bf3-9d66-6312-c2c2a6fc862a@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:35:24AM +0000, Srinivas Kandagatla wrote:
> On 24/01/2022 18:00, Andy Shevchenko wrote:
> > There are no users and seems no will come of the devm_nvmem_unregister().
> > Remove the function and remove the unused devm_nvmem_match() along with it.

> Applied 1/5, 2/5 and 3/5 patches.

Thanks!

> Others can go via there own subsystems as I do not see any dependencies.

They are dependent on the patch 3 ("nvmem: core: Check input parameter for
NULL in nvmem_unregister()"). Since there are tags, can you apply them as
well?

-- 
With Best Regards,
Andy Shevchenko


