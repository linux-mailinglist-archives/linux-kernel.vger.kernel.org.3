Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC954A6158
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbiBAQ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:27:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:39728 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241011AbiBAQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643732839; x=1675268839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjCqHD8/V1vqyEmvbFu9K9UGXEt5yJ4/eIvcCOZxK5E=;
  b=dNEUE5Fd5LTbm0Nk0BOFWpP8OjhFnJD2R5VcgcOM9MhFdh/WieGLcjEd
   LdLYcYNIVGfIISCp+FllvlrUIu/GVEPDOOAxd8AVEbTOaskq6yLxRLhcY
   u4KNao/zR3i1iyZkjERL9XcLuyRfMG01t1otZRvTKPhGKu9uV/6X2qRpy
   yLusQEWHw+puu20oUBpr3oBcjFZQ27kJeq7nMc2Q/Tp4hPCNLNTpWXwzc
   YV/qBoaV3SeKVU+ydRI23waWlKYSpnRvd4zKPYp9OQINYsGyf9MvupyD0
   iwqjZJywuiPMA7Qtjo5JoA81AlqFjPXynZEF+ObMEkWriDoHcv8rFxRM3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247946572"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247946572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 08:26:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="619841918"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 08:26:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEvyc-00HNi8-KU;
        Tue, 01 Feb 2022 18:25:54 +0200
Date:   Tue, 1 Feb 2022 18:25:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        heikki.krogerus@linux.intel.com, kuba@kernel.org,
        saravanak@google.com, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl355: use fwnode_irq_get_byname()
Message-ID: <YflfEpKj0ilHnQQm@smile.fi.intel.com>
References: <20211109200840.135019-1-puranjay12@gmail.com>
 <20211109200840.135019-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109200840.135019-3-puranjay12@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 01:38:40AM +0530, Puranjay Mohan wrote:
> Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
> to get the IRQ number from the interrupt pin.

Heads up, the fwnode_irq_get_byname() is in I2C tree and if Jonathan wants to
apply this one, the PR [1] can be used.

[1]: https://lore.kernel.org/linux-i2c/YfRiGR3AT8tzyweG@shikoro/T/#u

-- 
With Best Regards,
Andy Shevchenko


