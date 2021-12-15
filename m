Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE884760E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbhLOSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:41:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:22549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234977AbhLOSlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639593669; x=1671129669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApidIX6nwQUZTYZQJExSqeAHWvjA68F4rXo5Gp4mB4Q=;
  b=d/21i3cWr1wgBuzo7Yl40hRFyehyM8NXNCzkK53gRnkQg9g1XtQ7oKTI
   mHJjwY/IikHDk7UZsRUYNEDjkrpPPL+7Ou2XTxVVGO6EQMy3vT+Cjb/Va
   djqVnxbJtyQowZbfHTAWPLgE8MH2+HLQaBcH0Y2AshcZOnwepyYCf0ZRu
   OlF1LPHOmSexnvaMVGva8hEGC4O/zmsIQd0aq9cZnad7PWhXytW1blshN
   HyHCJ7bsWne3HyYOdPNgK308zPkTJM/217diMRg3AGEr6iOV1B3goVclH
   UbpWYCJOc+TIewqumqwwk0oxZkXTZW5ndtXgcAfrb8kNxIaYkSGdykYA/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226165287"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226165287"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:41:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505936654"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 10:41:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mxZCG-006jkN-1H;
        Wed, 15 Dec 2021 20:40:12 +0200
Date:   Wed, 15 Dec 2021 20:40:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <Ybo2i0lmD2kx/cg6@smile.fi.intel.com>
References: <20211214223228.1745315-1-broonie@kernel.org>
 <YboPz454GCe6ZA7g@smile.fi.intel.com>
 <Yboui5aym4eB6oP8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yboui5aym4eB6oP8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 06:06:03PM +0000, Mark Brown wrote:
> On Wed, Dec 15, 2021 at 05:54:55PM +0200, Andy Shevchenko wrote:

> > The other issue I have noticed is that gpio-intel branches [1] are out of the
> > merge. I haven't got any email about any issues with them.
> 
> > Do you have the latest and greatest list of repositories to merge?
> 
> You can see in the merge log that it's getting skipped due to an issue
> with the previous tree (which also has a build failure causing me to
> need to revert it) upsetting the script.

Yes, I see now. But as far as I know my repo doesn't have issues (neither
compilation nor merge), or at least nobody so far informed me about.

-- 
With Best Regards,
Andy Shevchenko


