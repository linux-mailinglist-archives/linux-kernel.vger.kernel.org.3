Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30904854A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiAEOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:32:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:17307 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240913AbiAEOcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641393172; x=1672929172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mubmu9RPixbi5TiZQepwRzGoG99UemGHfUe1VS/usmU=;
  b=K12BkOyXPH2krTkGr/KYVv1zwCeHVFQO0fzj67jeSPn5QVoeG3u0W7BV
   up7cA8CbbU50sC7oaYdJE8OTW5xXGhfwZqE3tNtQGj+EDiSaV4aFWbKRq
   JAEBqTxE5J+W4SyRxOrevsIzjqw9MeqJpbvd39U/HK1MEq3s6H3Q8/DFB
   WFUrKrjPDvFrW889bUs1N6tBAbPThSrTe4+TXl2KtOSAP/GUO7ITJP4nS
   8s19Dmr7sJZnRIyH5gC6DeyERCAV+1QpP6TBsJ8LcJbRIl4pBEC5mFVbB
   ynh+Kje41R7GM8XIGjz37sMuXIj+TwfWOjWWp2VYlBORxx7ZR4VcXjwuN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241273926"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="241273926"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:24:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="470582650"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:24:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n57C7-006jGY-Vp;
        Wed, 05 Jan 2022 16:23:15 +0200
Date:   Wed, 5 Jan 2022 16:23:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra: Get rid of duplicate of_node
 assignment
Message-ID: <YdWp09bj4SP5oNvc@smile.fi.intel.com>
References: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:26:39PM +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
> 
> For the details one may look into the of_gpio_dev_init() implementation.

Any comments on this one?

-- 
With Best Regards,
Andy Shevchenko


