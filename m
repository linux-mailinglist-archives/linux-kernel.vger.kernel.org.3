Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A685B0684
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiIGO2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIGO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:27:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C57E820;
        Wed,  7 Sep 2022 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662560843; x=1694096843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5S1FLXojfm5RxIPVIfBw2/jOopEeQKEXob0foK9yKy0=;
  b=lmO42N+e/U9ToVEpzPaOPGYghTC2jQH8hgF7XnDfoJwDaRWL2vSx3XSj
   FKf4wqhDyP6WexM76jzxm+w7KvTYdnlH/6zObXxxbryutn1lMMFzDTVxY
   bEETQMh2EOzjhhXnvjuUzcuUVKzP3xbNdFS3r8mmBh7H9ErN/eHYs3EXc
   C4e6IwQf2Gciaf3S94xz9378A9yZgSxwetXP8j3PsQuYQbmSN6hpFcpYJ
   OB/QGe6+mSmvw7H5qwBdCs3xuONjbCSQvmZ4Q8UlfYe/eNS+d8tUo5QT6
   cT+Pu/YPD4TwBpePQOY27wCckLt438LPZyJe/LHyMYrsfvUVA4tVi7kAQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294469443"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="294469443"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:23:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="703615153"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:23:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVvxi-009gFs-2o;
        Wed, 07 Sep 2022 17:23:30 +0300
Date:   Wed, 7 Sep 2022 17:23:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 4/9] pwm: lpss: Include headers we are direct user of
Message-ID: <YxipYkbIfBkBC/iQ@smile.fi.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220906195735.87361-4-andriy.shevchenko@linux.intel.com>
 <20220907091335.zls4vnacbtyrj5t5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220907091335.zls4vnacbtyrj5t5@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 11:13:35AM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 06, 2022 at 10:57:30PM +0300, Andy Shevchenko wrote:
> > For the sake of integrity, include headers we are direct user of.
> > 
> > While at it, replace device.h with a forward declaration.

...

> > +struct pwm_lpss_boardinfo;
> 
> the commit log doesn't explain the pwm_lpss_boardinfo part?!

Indeed, during one of amendment I rephrased it forgetting about
this small detail. (It was written in generic way to cover all
forward declarations)

I will add a word or two about this.

-- 
With Best Regards,
Andy Shevchenko


