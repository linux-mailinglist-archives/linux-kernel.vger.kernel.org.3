Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4075B0665
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIGOWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIGOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:22:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12777B2B0;
        Wed,  7 Sep 2022 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662560538; x=1694096538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fizAyjXY+bxoAErvuoxhgX8OBGPwMh/zYZZrL+bLqL0=;
  b=LjZzAmrw5/sokz/GmDKy4OQtw5WIIILwhBJzUVxtp2XjJ9IEldXWE/py
   /Bduy79wRuVyep8wOYzufhAu5F4wLWnyJBcvCL3qKNChi4Dgn4ECJ5rmK
   y6nXkdQjNHI8h5YH7FRfnX9mw+n2x430rSUN35JAWXdypPY5DyO+q3PHo
   TTzpRQE3/0XEtDnVFSkTeQlN2TEO7gXS0UZk0xwZAaOI9phwg4ay8yNCN
   n2b6QsHuzeVbz74MsMlrX2AHadMgY5MbBCzWcwsvK2cgJX5bkwZ3s2xq0
   L4a31wEvt9lWDCn599C94wM0S53eY/H9PdIyQMA5uVMSX4M7xded/TPuP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277277424"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="277277424"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:22:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="591721253"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:21:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVvw9-009gDJ-05;
        Wed, 07 Sep 2022 17:21:53 +0300
Date:   Wed, 7 Sep 2022 17:21:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <YxipACrMCQbE4xmk@smile.fi.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220906195735.87361-2-andriy.shevchenko@linux.intel.com>
 <20220907091144.picr3byckxco7w6m@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907091144.picr3byckxco7w6m@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:11:44AM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 06, 2022 at 10:57:28PM +0300, Andy Shevchenko wrote:

> >  MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
> >  MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(PWM_LPSS);
> >  MODULE_ALIAS("platform:pwm-lpss");
> 
> While it's not wrong to add the IMPORT_NS statement to each file, I'd
> had added it to pwm-lpss.h. IMHO that makes sense as every includer of
> that header needs that IMPORT_NS to actually use the symbols declared
> there.

If you have an optional dependency you may not need to include namespace
to avoid dragging it for peanuts.

...

> > -EXPORT_SYMBOL_GPL(pwm_lpss_probe);
> > +EXPORT_SYMBOL_NS_GPL(pwm_lpss_probe, PWM_LPSS);
> 
> There is something possible with more magic:

I know.

> 	#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
> 
> which you only need once in pwm-lpss.c and then all exports use that
> namespace. (And if you pick up my suggestion for patch 1 you also
> benefit from that.)

For a single export (even for a few of them) it's an overkill.

Taking above into consideration I don't think we need to alter
a proposed change.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


