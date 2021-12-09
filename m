Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6438C46F16A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbhLIRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:18:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:29899 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239204AbhLIRSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:18:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="236894401"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="236894401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:12:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="462215498"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:12:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvMxT-004BEu-Hb;
        Thu, 09 Dec 2021 19:11:51 +0200
Date:   Thu, 9 Dec 2021 19:11:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/1] pinctrl: Sort Kconfig and Makefile entries
 alphabetically
Message-ID: <YbI411MeojRNlc2+@smile.fi.intel.com>
References: <20211209113456.33977-1-andriy.shevchenko@linux.intel.com>
 <YbI2Xb7gBfN4Kyid@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbI2Xb7gBfN4Kyid@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 07:01:18PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 09, 2021 at 01:34:56PM +0200, Andy Shevchenko wrote:

...

> > v3: fixed more grammar issues in AMD text
> 
> I have noticed that you applied v2, thanks!
> Do you want me to sent a followup that fixes AMD help text?

I sent a follow up, do what you think is better (reapply v3 or
the mentioned follow up), thanks!

-- 
With Best Regards,
Andy Shevchenko


