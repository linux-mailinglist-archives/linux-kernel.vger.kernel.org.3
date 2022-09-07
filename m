Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59E5B0750
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIGOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIGOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:43:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C494125;
        Wed,  7 Sep 2022 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662561828; x=1694097828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SWhK9pxbsTouDvkXfe9bAxd00KsUs9iqZtP8MgSCS5s=;
  b=BFg+Z3jB+WMGu45M4vYy78q6Um5M6FoHjrS9PlVe+wRXApvXU3/iC0vY
   VvdDAAl17ppLmy4XqiWgleB0MvcGJCGiTdO2NrtrKz2HpSTi1atrone8H
   9X9pa12e0yMSxA61oqmBJ9JskXsnOCkayhdaPvB67d5C2ObUsdkEWY2WV
   Rg00Y3HxgeWk/BetLbVv3K3ZS16fkBzpNydlau9KvZz+MjPl6y/5Zr5IN
   fEn8ZAGT+04FpNdbTTmxaLbw9vzBu9TT+y7DdSYuMkVvuPi94bs6bGf8z
   wT8sFUZvRUp12x7ko+rebY6L1nQB0uYTOeBTakUbnAGrasQw02YnRtUsv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="294476073"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="294476073"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:42:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="617105435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:42:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVwG9-009gfE-2C;
        Wed, 07 Sep 2022 17:42:33 +0300
Date:   Wed, 7 Sep 2022 17:42:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v4 01/21] hwmon: (mr75203) fix coding style space errors
Message-ID: <Yxit2fq1kwzIN9x0@smile.fi.intel.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-2-farbere@amazon.com>
 <20220906165229.GA594012@roeck-us.net>
 <9323b609-cb9d-8b3d-2894-65296487cdb1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9323b609-cb9d-8b3d-2894-65296487cdb1@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:50:00AM +0300, Farber, Eliav wrote:
> On 9/6/2022 7:52 PM, Guenter Roeck wrote:
> > On Tue, Sep 06, 2022 at 08:33:36AM +0000, Eliav Farber wrote:
> > > Fix: "ERROR: space required before the open parenthesis '('"
> > > 
> > > Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for
> > > Moortec MR75203 PVT controller")
> > 
> > Coding style "fixes" do not fix the code. I consider using the Fixes: tag
> > for those to close to an abuse of that tag (and it would be great if that
> > was spelled out somewhere). As it is, I can not with good conscience
> > apply
> > this patch to the mainline kernel (especially not for -rc5), meaning the
> > entire series will have to wait for the next release window unless there
> > are no conflicts.
> Because as you mentioned  it is not a functional fix in the code I’ll
> remove the Fixes tag in v5.
> I checked older kernel versions and patch applies without conflicts.
> That’s also why I moved it to be first in the series, so it will be
> before any of my other changes that night cause merge problems for
> other branches.

If it's not a fix, it should go _after_ real fixes.
And by nature this kind of patch is usually at the end of the series.

-- 
With Best Regards,
Andy Shevchenko


