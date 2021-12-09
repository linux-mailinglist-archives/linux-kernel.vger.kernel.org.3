Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDA046F0AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhLIRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:18604 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238808AbhLIRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:10:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238095485"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="238095485"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:02:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="601625797"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:02:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvMnG-004B17-4s;
        Thu, 09 Dec 2021 19:01:18 +0200
Date:   Thu, 9 Dec 2021 19:01:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/1] pinctrl: Sort Kconfig and Makefile entries
 alphabetically
Message-ID: <YbI2Xb7gBfN4Kyid@smile.fi.intel.com>
References: <20211209113456.33977-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209113456.33977-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:34:56PM +0200, Andy Shevchenko wrote:
> Sort Kconfig and Makefile entries alphabetically for better maintenance
> in the future.
> 
> While at it fix some style issues, such as:
>   - "Say Y"/"Say yes"/"Say Yes" --> "Say Y"
>   - "pullup/pulldown" --> "pull-up and pull-down"
>   - wrong indentation

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: fixed more grammar issues in AMD text
> v2: rebased on top of very recent pinctrl/devel (Linus), added some grammar fixes

I have noticed that you applied v2, thanks!
Do you want me to sent a followup that fixes AMD help text?

-- 
With Best Regards,
Andy Shevchenko


