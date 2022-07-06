Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D193568829
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiGFMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:17:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F4272D;
        Wed,  6 Jul 2022 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657109840; x=1688645840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tNAH5fgyOX6KUFlxpl3UlwYmfjF8ZR/DYcS5EN+RM3U=;
  b=QdYOW23UEqIFw9zvAxxbjWIWXMGI9JXugPW0rBQQBXk3F7rakHNfU8sm
   6jjIxmB82ViDfEsSEF3DCOdAaQGNzuzY64fsktp5jF8CApKtRC/rouJ3T
   y29ZQ/dtk9nuP9pTtZ9JhwZKRyOn2LB03mMcG3tjUW+HDSqGkMbB0t0OX
   sEebsZjQ7B3pZVJOocu9ObCEJmpQ4hqVcCEaonRb0ZvEZ3qm1YCLwGBpa
   1Za77Dk/UV5PkHtw8+lEiWbbJyNsUVS/Sn2dFtIT713HqHDIWuuoPS5vK
   ScIlPhlN3fTJXZhGjaLUJKeZtg2KSff04VIAs3z0viUdvE1vJbgc5X1OO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284851122"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="284851122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:17:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="660947182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 05:17:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o93y0-0016T7-0F;
        Wed, 06 Jul 2022 15:17:16 +0300
Date:   Wed, 6 Jul 2022 15:17:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Use device_match_of_node() helper
Message-ID: <YsV9S4U/zsE1Q6JG@smile.fi.intel.com>
References: <20220629115840.16241-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629115840.16241-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:58:40PM +0300, Andy Shevchenko wrote:
> Instead of open coding, use device_match_of_node() helper.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


