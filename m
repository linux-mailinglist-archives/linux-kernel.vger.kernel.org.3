Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4028553E81A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiFFKIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiFFKGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0511339C7;
        Mon,  6 Jun 2022 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509959; x=1686045959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jfeo6+IyM07NX4hwT+xuXSfjRX2zx0+JnpASEafhZtY=;
  b=lhq597q1q7hbwCXhViIRV3cIEV2TbM2uvdG5CDJG+9HRxs2n+VPCUYpP
   4HeLIOu6Li9zXQYUBl3Gr/6RLrxvBALN0VfwR3z35FQrfaeqw5DYFwU6Q
   LcWvdGslweQcfOw+9h/6x1b231uSoVZlVOMT/E93USyHVRsCQmkYLIaF0
   btcWl8ZR/Gkqn0eqjv6V2haMyjpsJ0My3zzlh4RHwmnj/SCuzikRU1ntf
   ltgpGaIPflhfg0ON5z08LFW3dKm9BC5fSlrF95Mm4qmxiaZ8onkrUjc2x
   6BC+CEZ274MkeJVyFKd2Sb9R3Eyt/cqUG+NkCUj+59xutwVylIT/n1trc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="257086899"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257086899"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825745751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ny9cQ-000UX5-8M;
        Mon, 06 Jun 2022 13:05:54 +0300
Date:   Mon, 6 Jun 2022 13:05:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Message-ID: <Yp3Rgo4/09/bsvna@smile.fi.intel.com>
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
 <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
 <YppEqYTZyWaulKjI@smile.fi.intel.com>
 <YppEwbZSad/pRdUv@smile.fi.intel.com>
 <CA+PwDYdf7JEimfYG9ChTHp=Dds_Ljx1Y2KK-H5zfeu52=NxXFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PwDYdf7JEimfYG9ChTHp=Dds_Ljx1Y2KK-H5zfeu52=NxXFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 01:11:54AM +0200, Thierry Reding wrote:
> On Fri, 3 Jun 2022, 19:28 Andy Shevchenko, <
> andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Jun 03, 2022 at 08:28:09PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 20, 2022 at 10:10:49AM -0700, Dipen Patel wrote:
> > > > Acked-by: Dipen Patel <dipenp@nvidia.com>
> > >
> > > Thanks!
> > >
> > > Bart, this can be applied, I think.
> >
> > Or do you want it in my PR?
> >
> 
> This would need to go in through the HTE tree.
> 
> I can pick it up, but it looks like Linus isn't happy with this yet anyway.

It's merged as far as I can see. Feel free to pick it up, I'll drop it from my
tree.

-- 
With Best Regards,
Andy Shevchenko


