Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A7053AAAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354525AbiFAQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiFAQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:04:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC449A5A91;
        Wed,  1 Jun 2022 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654099464; x=1685635464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5IltHzVrjl2ez+5L3gajjTy1OZUNh8Rt5OgpnWLaUjw=;
  b=IKmas5mUKOIQ5WSkmvYxgQi64GBJW0OFIL1iOA77XhvbWulyWNT+YLbd
   nCpdGGjlaAfNiRaGuB+4YKW7tPTs88YBws2DeHdr+NB/kx+egARsy8DIh
   8luHeC6/rO/zh0gFW4xxhpu+CCszd1fOPR6CDX2RBoN8qW6/mj8WedzBB
   Le1NEWLzdFHIp8ONjTHIHfJnroDPKhI4UW3RHNX4nk7Lmu4vKyMiFy8mj
   w4rbwTWgK9fVAdK1nyXKFwU2a9CpFc0tGOFoqskHw+9bOwaT8frqcdyVK
   2+/UriPbx89CbewdsXpmq4DZ+qrOTznJ+DSidV2yOFnaibvRxzAXvLhsQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257706978"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257706978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:04:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="552375374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:04:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwQpU-000QnL-Jl;
        Wed, 01 Jun 2022 19:04:16 +0300
Date:   Wed, 1 Jun 2022 19:04:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update GPIO ACPI library to Supported
Message-ID: <YpeOAJVyC+4LUChI@smile.fi.intel.com>
References: <20220530115653.70423-1-andriy.shevchenko@linux.intel.com>
 <YpTC4luTe41b0xy1@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpTC4luTe41b0xy1@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:13:06PM +0300, Mika Westerberg wrote:
> On Mon, May 30, 2022 at 02:56:53PM +0300, Andy Shevchenko wrote:
> > The actual status of the code is Supported.
> > 
> > Reported-by: dave.hansen@linux.intel.com
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


