Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FC53CE10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbiFCR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiFCR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:28:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE41F627;
        Fri,  3 Jun 2022 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654277332; x=1685813332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLTeXAoeUUyhIsn/tZNjxHo1eP+7orIJezeKvINLa2Y=;
  b=TF38aOPWljVl9gVptNqffHzwNYln/IyddnclFhjssEJeM2ZOZUZZ7nNi
   kSTOK1P9oZo45YQtK2WuNxFlGTr5lzja69Zve+jf6d6vyH4G/pYYKeJe5
   qSmGepl5R9+UEt2blPYcIBU4WGuQ5HLpt27wZzhcoiGcGjtOtGZKTBGho
   5EvjP/sFfCL6jEYneF4skm2aqAYuAkm53jLNiAWDjBm+KyadcumprhuzI
   VKeDRrUSben8vUQAyL+7B53ldp5SoreUozandWLx8I1d1UZ9qw+8t0nId
   f4osccBl6aiRcDohavWAQg334pqN4evyaUWdtnLN9dcufv2oDO8MnGFnw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="273868600"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="273868600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:28:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="553428640"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:28:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxB69-000Sdg-8Z;
        Fri, 03 Jun 2022 20:28:33 +0300
Date:   Fri, 3 Jun 2022 20:28:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, thierry.reding@gmail.com
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Message-ID: <YppEwbZSad/pRdUv@smile.fi.intel.com>
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
 <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
 <YppEqYTZyWaulKjI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YppEqYTZyWaulKjI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 08:28:09PM +0300, Andy Shevchenko wrote:
> On Fri, May 20, 2022 at 10:10:49AM -0700, Dipen Patel wrote:
> > Acked-by: Dipen Patel <dipenp@nvidia.com>
> 
> Thanks!
> 
> Bart, this can be applied, I think.

Or do you want it in my PR?

-- 
With Best Regards,
Andy Shevchenko


