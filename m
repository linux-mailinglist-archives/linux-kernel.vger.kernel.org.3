Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC0A475C67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbhLOPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:55:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:35328 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244245AbhLOPzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639583752; x=1671119752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRsWa48y/byo17HMgXnE4YpysdyN8WNOzyMTAo/9P/k=;
  b=Jy0JwEYTOhS1LkUlbN1dVhHEHdwTCUhSyL/ck3BOoa5/lRaJRE6yomNh
   bjzuwTcLyDkEcFIJMJZv2Oqo3vhkBILMCK6AHocV8sNthS1VEL6SnQOUM
   007k3Pxb4eJ6m4bCHn+n6axvrNA0GaO8OWr3nr3VGmUs/uc/dvvH1OSgF
   izOP3JcwSvz23G6HrczRbftNjmj755zAhvuEY7nnTMnVOCJWWOicRdPpt
   WiioeZ1wnSLCWZPT8nY4cmzY2+tkvgyFLZuHCG59Bgz8xGEAc//1BhL5a
   uw83dczyRiKnZO847OwMBPtDf8kQLjhh4UlSz/rd83mG49I0SzI4+rU2R
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219940220"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219940220"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:55:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465647970"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 07:55:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mxWcJ-006fgn-H6;
        Wed, 15 Dec 2021 17:54:55 +0200
Date:   Wed, 15 Dec 2021 17:54:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     broonie@kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 14
Message-ID: <YboPz454GCe6ZA7g@smile.fi.intel.com>
References: <20211214223228.1745315-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214223228.1745315-1-broonie@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:32:22PM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> News: Releases may or may not happen over the next few days since I'm
> getting a vacciene dose tomorrow.
> 
> Changes since 20211213:

> The drm-intel tree gained a conflict with the drm-intel-fixes tree.
> 
> The dmaengine tree gained a conflict with the dmaengine-fixes tree.
> 
> Non-merge commits (relative to Linus' tree): 6251
>  6873 files changed, 291130 insertions(+), 138903 deletions(-)

Thanks, I see tags now.

The other issue I have noticed is that gpio-intel branches [1] are out of the
merge. I haven't got any email about any issues with them.

Do you have the latest and greatest list of repositories to merge?

[1]: For example in next-20211203

e24d0a695952 Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git


-- 
With Best Regards,
Andy Shevchenko


