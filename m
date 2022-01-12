Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA14F48C51D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbiALNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:49:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:14395 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353855AbiALNtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641995381; x=1673531381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4uT74+eGVQ4XFax5yE63YjVb5fZ/QUjX2nXmFMP+WRw=;
  b=DVPjHikjBetJcMnQ2l6cgtTvgXG3kWkJ+HaQE7NhJCQp9cE2K8ohfum6
   jx1AlMNJotPY2K4A6Qxq5ANMq8uL2tX5KFABSkQ02oqBmaUYIsLCQsU3U
   LMWMgAkOa/LEr/hmCiNeHUYgiGHY9OF4hDIyWCBCAkCJ414PVCBcctp9y
   fI7gRhAOhHUhI4O9XUOcpHkbEbnr6nuniDIdMh0sGvNnYDIafMo/2WUfr
   QuzR0qheNv29NqidI/Plu3+6BE6kR2mq7GRm8nWG2oYGmTvw6m3gd2RhW
   F/U0GapQOveBZQFkTUzsCKh5HQ3BMOtZws7u/9z75aZblnaIlPWsbBShj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="304473145"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="304473145"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:49:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="691390578"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:49:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7dzF-009hfh-BP;
        Wed, 12 Jan 2022 15:48:25 +0200
Date:   Wed, 12 Jan 2022 15:48:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra: Get rid of duplicate of_node
 assignment
Message-ID: <Yd7cKeGk4CzG3gAX@smile.fi.intel.com>
References: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
 <Yd7TkUKo2g2Asbna@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd7TkUKo2g2Asbna@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 02:11:45PM +0100, Thierry Reding wrote:
> On Thu, Dec 23, 2021 at 02:26:39PM +0200, Andy Shevchenko wrote:
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove these assignment all at once.

...

> Yep, this is indeed not necessary (anymore), so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> I've also given this a quick spin on a Tegra124 device (Venice 2) and
> everything seems to be working fine, so also:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>

Thanks!


-- 
With Best Regards,
Andy Shevchenko


