Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD8473598
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhLMUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:07:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:33289 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240824AbhLMUHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:07:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226096562"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="226096562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:07:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="544904772"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:07:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwraP-005lQy-7N;
        Mon, 13 Dec 2021 22:06:13 +0200
Date:   Mon, 13 Dec 2021 22:06:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        lianzhi chang <changlianzhi@uniontech.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, 282827961@qq.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v20] tty: Fix the keyboard led light display problem
Message-ID: <YbentBpPYZjz5Fu4@smile.fi.intel.com>
References: <20211213061244.13732-1-changlianzhi@uniontech.com>
 <Ybc5XPfd5f66L92i@smile.fi.intel.com>
 <97eb3c3f68042443aa71c10766f3bef364e8f90b.camel@perches.com>
 <Ybeh1VGMvL7DkG2I@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybeh1VGMvL7DkG2I@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:41:09AM -0800, Dmitry Torokhov wrote:
> On Mon, Dec 13, 2021 at 04:41:24AM -0800, Joe Perches wrote:
> > On Mon, 2021-12-13 at 14:15 +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 13, 2021 at 02:12:44PM +0800, lianzhi chang wrote:
> > 
> > > > +	struct kbd_struct *kb = &kbd_table[console];
> > > > +	int ret = 0;
> > > > +	unsigned long flags;
> > > 
> > > Slightly better to read:
> > > 
> > > 	struct kbd_struct *kb = &kbd_table[console];
> > > 	unsigned long flags;
> > > 	int ret = 0;
> > 
> > I don't think so.  Why do you?
> 
> I wonder why we comment on cosmetics of a patch

> (and have the submitter rush to fix that)

Not sure where you got this from...

> without considering if the proposed solution makes
> sense in the first place?

...but answering your question it's quite natural in open source mailing list
that people give a comment regarding their area of expertise. One does for
style another for the whole solution. I don't think anything is wrong with this
approach, do you?

-- 
With Best Regards,
Andy Shevchenko


