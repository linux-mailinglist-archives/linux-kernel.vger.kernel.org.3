Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A055E273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiF1JkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbiF1JkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:40:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79421E3F9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656409218; x=1687945218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SLdTvaaO95qiRCjWkdMM6zlrkiLfUUu65NMrMNQ30s=;
  b=EEpPIGpdYWTO7d7qsd92gTC+InwfVQPUdek6HptKB3WWwDNFYWpMvYVv
   gZdtT6hmKS+KMQe86BAygzC8Ey9/yFGpThoR6fQF50DdSTWiV0sA0b4IL
   kMBRAO5Y+f4QXvlFcEwunCpFdeEfUj/mGKP8e8mBu5L0DvWA7kiKGnOoN
   x/Z2K/z5yGx31YuM+CWvU2AJpyq3wBXlWT1QInJQaYFYi2eP2Tj5sXMFw
   7KXhSeV88uJcW4m1l/WCm0kWdV5f8driIZZcpALXkQ1aMHKJYJODNNoqu
   OmTQeNY2Q07v1fUFFmcZ7VBQ1hT81vsRHugY4fjY9B10Gn6dps40oUkUG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282428571"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282428571"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:40:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="658067585"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:40:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o67fU-000web-S0;
        Tue, 28 Jun 2022 12:38:00 +0300
Date:   Tue, 28 Jun 2022 12:38:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the
 comment
Message-ID: <YrrL+Mil/B1Gh5VN@smile.fi.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
 <Yrl5XZOgD8abd+Qm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrl5XZOgD8abd+Qm@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:33:17AM +0100, Lee Jones wrote:
> On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> > - * Copyright (C) 2015 Intel Corporation. All rights reserved.
> > + * Copyright (C) 2015-2017, 2022 Intel Corporation. All rights reserved.
> 
> I do not profess to be an expert.  What happened between 2017-2022?

Nothing?

I mean that before I become a reviewer/maintainer of this code I have no
evidence that anyone at Intel worked on the code (I mean really working,
not some whitespace cleanup). After that I don't remember I was doing
anything (important) either.

...

> > -	 * There is known hw bug. Upon reset BIT 5 of register
> > +	 * There is known HW bug. Upon reset BIT 5 of register
> 
> You may as well fix the grammar while you're at it.

Any suggestion from a native speaker? I can propose a few changes, but I'm
totally unsure.

> >  	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
> >  	 * later it's set to 1(masked) automatically by hardware. So we
> > -	 * have the software workaround here to unmaksed it in order to let
> > -	 * charger interrutp work.
> > +	 * have the software workaround here to unmasked it in order to let
> > +	 * charger interrupt work.
> 
> Likewise.

Likewise.

-- 
With Best Regards,
Andy Shevchenko


