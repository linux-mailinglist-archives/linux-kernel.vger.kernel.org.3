Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5455C49E780
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbiA0Q33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:29:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:38295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbiA0Q32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643300968; x=1674836968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBiGAjIQzbPWJ3opPss6RcxD54UdZ0W3Vj4dEMXdjUo=;
  b=Kla+JHC/ZUJ0sehaXuFMt0S3ciFoeGDIYb02ZLpiFSy9zUw7WhsohoBy
   c35vnRUC9jV40SeMpg/uEHynd6HZS9hg8I5VgapN02bfFEhoKhIEmUXVP
   X1cZNbUM2Q/AKOXm2QPz2ZHooNgRPyOfworwjj2ZRINMYx6IwSnXu0Xf+
   bG5x98HD2mTANppBUPm9yQVrRlSuXLGfYuctL5BroeJKLav4gitRPRuBa
   viFTVGm+eO1PnKechOxMDalp8fHV7533E3ZGIyx1f2SRlAIcgawfV8pw9
   LBHAiw17u39zJdDHq3RfOe5TDhGXf3Dtx7z3xFQWbSzRrug/LKo9zTiW4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271360010"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="271360010"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:29:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="495786648"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:29:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nD7dE-00F2vP-Ux;
        Thu, 27 Jan 2022 18:28:20 +0200
Date:   Thu, 27 Jan 2022 18:28:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfLIJDQAn7+Ic/m+@smile.fi.intel.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o83xrwk9.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:08:06AM -0700, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > It's unclear from "Submitting Patches" documentation that Reported-by
> > is not supposed to be used against new features. (It's more clear
> > in the section 5.4 "Patch formatting and changelogs" of the "A guide
> > to the Kernel Development Process", where it suggests that change
> > should fix something existing in the kernel. Clarify the Reported-by
> > usage in the "Submitting Patches".
> >
> > Reported-by: Florian Eckert <fe@dev.tdt.de>
> 
> You're sure this added documentation isn't a new feature that shouldn't
> have a Reported-by? :)
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 31ea120ce531..24c1a5565385 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
> >  The Reported-by tag gives credit to people who find bugs and report them and it
> >  hopefully inspires them to help us again in the future.  Please note that if
> >  the bug was reported in private, then ask for permission first before using the
> > -Reported-by tag.
> > +Reported-by tag. A new feature can't be reported since there is no code in the
> > +kernel to fix.
> 
> How about instead something like "Reported-by is intended for bugs;
> please do not use it to credit feature requests"?
> 
> (i.e. I want the shed in green :)

Sure, you are native speaker at the end of the day :-)


-- 
With Best Regards,
Andy Shevchenko


