Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4AE52A803
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbiEQQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiEQQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:34:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168BB4ECFB;
        Tue, 17 May 2022 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652805286; x=1684341286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pXKemmWg0zSWkgtz6B7q39wTF2OVnZlv0Mo1h+/mPWY=;
  b=as9/b+/SC4irfepoGIfgNDBJIi60cVLGqsUUCCjZXCGFkPARqQ7LuUW4
   3wOAG7xy84NEra6v5cxVhryrcXVnWeYemzMHQ1o22Rd6JBjjHjH8z1hFJ
   YzH0wifG7CMjGUzxe5mOMxbOYUSf0fEBgJ/Xcv0TVKICyhbr0jvT0hymS
   GMKZbXADbS6Aa1UajVEVLj4t6E7sbL43CMb/BQ4fgcJ7Gkv0TWDpFw19V
   szBhuqVA0IhqcRhj9M2NneVqRJs14Z4xJeKJE7sajaj2gGoFS+7VyrCNt
   AD8lZ0ef6bUavN93gN4DYlBebrjGAKdNvImAk7UM3iprmWV0VtmcN0OFJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251754276"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251754276"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:34:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="626563924"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:34:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nr09h-0008CZ-Ni;
        Tue, 17 May 2022 19:34:41 +0300
Date:   Tue, 17 May 2022 19:34:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: cherryview: Use GPIO chip pointer in
 chv_gpio_irq_mask_unmask()
Message-ID: <YoPOof6cckysGT3g@smile.fi.intel.com>
References: <20220516185500.32304-1-andriy.shevchenko@linux.intel.com>
 <YoNz34dfCIrKYn6n@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoNz34dfCIrKYn6n@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:07:27PM +0300, Mika Westerberg wrote:
> On Mon, May 16, 2022 at 09:55:00PM +0300, Andy Shevchenko wrote:
> > The callers already have dereferenced pointer to GPIO chip, no need to
> > do it again in chv_gpio_irq_mask_unmask(). Hence, replace IRQ data pointer
> > by GPIO chip pointer.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


