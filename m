Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D955465E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiFJLje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347758AbiFJLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:39:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6615F78ED2;
        Fri, 10 Jun 2022 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654861154; x=1686397154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kB1eqnECJOqLhsJLFivfDJgKKuQZBPVbbz0sPmE1QZ8=;
  b=J3VR/ws1jS5u/j5Ox6UedPidJPAq2zOh9PY5KVMW0iD69/tZ7+qJugbZ
   YB9R3IcoCfw8l66JC7cz/JDuStlHBwtN1cP/St3QZgcO9T1HwzOLP/fzs
   BfTb2BWTnwLiJPynxSrVWpzM10aCeXIwBS4x8cUa4t3V+C69tPQGcFQar
   gVvRsZKzdpRW2hrq2GKrto7h34ZQmiw5y2xiXttdoP/tEuXC39WlIcbqS
   i6kLYEnFVTwxCLObEhrLMKhA7OtBxymEHduSdkRjBlSoe8pBgDQEFmmTh
   TTjzsF6Cg26oYYLPoG5tQUuKpJqin6iCu49VwnYBRYennLNZJ3WF8qb67
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257436290"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="257436290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:39:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="649797018"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:39:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzcyq-000Yjp-TL;
        Fri, 10 Jun 2022 14:39:08 +0300
Date:   Fri, 10 Jun 2022 14:39:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: trigger: gpio: Convert to use kstrtox()
Message-ID: <YqMtXPVy2q0RRdky@smile.fi.intel.com>
References: <20220609161829.80312-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609161829.80312-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 07:18:29PM +0300, Andy Shevchenko wrote:
> sscanf() is a heavy one and moreover requires additional boundary checks.
> Convert driver to use kstrtox() and replace kstrtoul() by kstrtobool()
> in gpio_trig_inverted_store().

> While here, check the desired brightness against maximum defined for
> a certain LED.

I realize that this part may be wrong. I have to drop it in the next version.

-- 
With Best Regards,
Andy Shevchenko


