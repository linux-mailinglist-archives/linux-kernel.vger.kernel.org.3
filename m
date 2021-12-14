Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35824741C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhLNLpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:45:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:65457 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhLNLpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639482324; x=1671018324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uxe3KXxNRLMySeq/nzGbJAEG8Rn4M5b9I8eEfKOMvJY=;
  b=beMzo1sh5ltrejTon79Jj7pfe9g2GVSvoSxiUEaBsMOiiyGJyGakd9w+
   /hODa3jphF8/6+iAiOiCTC+BQNxminyRfJmGcx+W5cx7GEHiJ6HsZtNaw
   q/TpcChalO6z0dp9NShLRNeT3YR4BOHLXbsBkRjUM8GM8LeuQg/JqeRrs
   k35UCDHDlVnFgng5Nu4dGGYzb0V3GsAqqR1YFshvNFiTETeBjzWdcQC3O
   Mb+/Efe1qmYgdyGu2LQ1bpVL574U6dmY/S/fFb3KI+y1UhzBPhwJRaEUf
   P6qe0ZaH3q9J21+LJTEHJWfbEYegnC9mpXnUUTUnJJLpo+1v1xLga6gz5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226239055"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="226239055"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 03:45:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="682024130"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 03:45:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mx6EM-0066XN-QD;
        Tue, 14 Dec 2021 13:44:26 +0200
Date:   Tue, 14 Dec 2021 13:44:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     broonie@kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 13
Message-ID: <YbiDmp3bJr9/Uctq@smile.fi.intel.com>
References: <20211214030215.3181149-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214030215.3181149-1-broonie@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 03:02:15AM +0000, broonie@kernel.org wrote:
> Hi all,
> 
> Non-merge commits (relative to Linus' tree): 5960
>  6555 files changed, 277265 insertions(+), 120864 deletions(-)

Mark, is it possible to add tags to the releases, please?

When you do them tags are missed, I have to add them manually after my scripts
out of a sudden switched from Linux Next base to latest used vanilla tag with
all nice outcomes...

> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a defconfig for arm64, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf.
> 
> Below is a summary of the state of the merge.
> 
> I am currently merging 346 trees (counting Linus' and 94 trees of bug
> fix patches pending for the current merge release).
> 
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
> 
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
> 
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
> 

-- 
With Best Regards,
Andy Shevchenko


