Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E1846E75A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhLILS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:18:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:41599 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhLILS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:18:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218100152"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="218100152"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:14:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="503453271"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:14:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvHN1-0043tW-Mv;
        Thu, 09 Dec 2021 13:13:51 +0200
Date:   Thu, 9 Dec 2021 13:13:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: Sort Kconfig and Makefile entries
 alphabetically
Message-ID: <YbHk7wenlrhlizCA@smile.fi.intel.com>
References: <20211208092049.20792-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdb2ZnH7gi8TAQ_8hvbaAw=hqBZBjQftPOtyNMLR+c541g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb2ZnH7gi8TAQ_8hvbaAw=hqBZBjQftPOtyNMLR+c541g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:34:59AM +0100, Linus Walleij wrote:
> On Wed, Dec 8, 2021 at 10:20 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Sort Kconfig and Makefile entries alphabetically for better maintenance
> > in the future.
> >
> > While at it fix some style issues, such as wrong indentation.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Nice! I tried to apply it but I was queueing patches from other
> unreviewed threads and creating misc problems.
> Ideally I'd like a patch close to the merge window,  but if
> you rebase this on linux-next (or the "devel" branch in my
> tree that I insist on using) I can try to apply it again anyways,

Sure.

> we need to take the hit at some point.

v2 just has been sent!

-- 
With Best Regards,
Andy Shevchenko


