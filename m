Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C274EC7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347650AbiC3PDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347826AbiC3PDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:03:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A61FCE3;
        Wed, 30 Mar 2022 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652479; x=1680188479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YXbpZaJqhuCQp74NS4nN+yF5HwzcDtttnsG/ebBknnQ=;
  b=PMErXi7sCfBQ3KvFJyeoNJCQ4S1206fU1ZGH6NdOFUG9LBW3uChIkJjl
   6C/kppKKeXepFS0vZmNaIe1K+c/ci8ID/jH4bSBew0ZASztfjgiy4qsry
   8Tb5dWKF8R6DFjgEKbBHKXjlOFmtL1sZuAl3Ghv4nJWDEPzilw/Njclnq
   ImlzmtpQ5JivnuV+Q9Pl2DUE6iuuwbC4jRLilBQBOzMBqWvhg0LYsGhiJ
   +2ZqBHz/elHBKgYH7LmbdEAFfWixPi8Lm1qvkSY3da/yREzwxKM41VUB0
   Bvzjn53QBCAK6KaJzcctCojBJAViv5F01KhWT+++EjEV7ca8EcbNz2yCA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239493572"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="239493572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:01:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="586029475"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:01:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZZoS-009StT-OO;
        Wed, 30 Mar 2022 18:00:44 +0300
Date:   Wed, 30 Mar 2022 18:00:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Get rid of redundant 'else' (part 2)
Message-ID: <YkRwnJE511c6aK0y@smile.fi.intel.com>
References: <20220328112856.404-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112856.404-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 02:28:56PM +0300, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it by using switch-case pattern.
> Note that the pattern seems more usual for IOCTL handlers.

It appears that part 1 (as per subject) was never submitted before.
So, I unify them in v2 of this patch.

-- 
With Best Regards,
Andy Shevchenko


