Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CC5B0AED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIGRCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIGRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:02:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D57DB275A;
        Wed,  7 Sep 2022 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662570119; x=1694106119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m8q1cRyJn4QGSaHSkQWRLJ2c+Tc4QSATGJwzbx5HRMc=;
  b=AoCVAg3qONK/5ylWuH5vEB3VJqWOFmZ5TJFNja/LeQi5TIkzguIQ/ETe
   uawkyS0GXrg7Fzlc9XWNemUZHBQgpOlAM+9AN2LM3K0JmonWwV9MV1D3G
   iugitvmRE8oyljiyCGVJkzcin/UNAcOSHcanYB8mJ9VAU41hYguoi9+kI
   PI/9QcIYhm5lC79sK4wD77mycFuhWMQRyQ9XT/fDdtxKdwTl+U5WpUAxO
   eYi94+7SYXEQjkVizAHqOApRMvFCGdZBM8NaQ9TCkHE3TTJYWWCB+fnqG
   2H5BOKtcPbKW/iCoWzSO76Tlc/IORZw3ziC+YOVbjSTAgMW1hU0XFm2EW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="360903181"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="360903181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 10:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="682893714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 10:00:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVyPq-009jHI-1W;
        Wed, 07 Sep 2022 20:00:42 +0300
Date:   Wed, 7 Sep 2022 20:00:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <YxjOOpfkSRPcUQfn@smile.fi.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220906195735.87361-2-andriy.shevchenko@linux.intel.com>
 <20220907091144.picr3byckxco7w6m@pengutronix.de>
 <YxipACrMCQbE4xmk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxipACrMCQbE4xmk@smile.fi.intel.com>
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

On Wed, Sep 07, 2022 at 05:21:53PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 07, 2022 at 11:11:44AM +0200, Uwe Kleine-König wrote:
> > On Tue, Sep 06, 2022 at 10:57:28PM +0300, Andy Shevchenko wrote:

...

> > > -EXPORT_SYMBOL_GPL(pwm_lpss_probe);
> > > +EXPORT_SYMBOL_NS_GPL(pwm_lpss_probe, PWM_LPSS);
> > 
> > There is something possible with more magic:
> > 	#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
> > 
> > which you only need once in pwm-lpss.c and then all exports use that
> > namespace. (And if you pick up my suggestion for patch 1 you also
> > benefit from that.)
> 
> For a single export (even for a few of them) it's an overkill.

Ah, you adding there 4 more. But still I think it's an overkill. It's so small
driver that duplicating namespace in each of the exported symbols is not an
issue, is it?

-- 
With Best Regards,
Andy Shevchenko


