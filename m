Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226B5688D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiGFNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGFNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:00:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EF013F58;
        Wed,  6 Jul 2022 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657112451; x=1688648451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+1AryKkWiclJSbsUrT7PWIY2iA0tRQQVuHEMz2TLsEs=;
  b=NWKD+mxm31V2AHLxicPsszDc3JAAUxw8+FoHP1+wypI5nOiocmoj+3RP
   3D+mD711DvHDYuvWh7Q04VKKr3yOfOlp8zKtESWM6UrozuzyMDZibhQR3
   QtvNwFG2Bz5Ajm9TGJAT3bnjfU8FnjuwoBXVMydwTvN2K+cqLZY8QN7IL
   TdcmkaclTqbiBxga5zWBdE2KcIUroaf+bdfSFRRpYnqzN0fXvfUJ3EP/K
   8/rv8nBjzZyaU2qkraj+UzDdGogFbjDraHBGIHWQaIni4wHRy0EySGEy9
   NxgA553kvvDihlrG93GATUN5AxFYviyICWa99AkBiX3cN8Z6fWD1QBG8Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="370056318"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="370056318"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 06:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="543386607"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 06:00:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o94bw-0016Wi-1S;
        Wed, 06 Jul 2022 15:58:32 +0300
Date:   Wed, 6 Jul 2022 15:58:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Use device_match_of_node() helper
Message-ID: <YsWG+F4Ao+6gbjbU@smile.fi.intel.com>
References: <20220629113058.79617-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629113058.79617-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Jun 29, 2022 at 02:30:58PM +0300, Andy Shevchenko wrote:
> Instead of open coding, use device_match_of_node() helper.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


