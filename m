Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31946E79C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhLILcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:32:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:17405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235897AbhLILcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:32:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298869236"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="298869236"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:29:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="612468428"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:29:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvHaz-00449T-QP;
        Thu, 09 Dec 2021 13:28:17 +0200
Date:   Thu, 9 Dec 2021 13:28:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: Sort Kconfig and Makefile entries
 alphabetically
Message-ID: <YbHoUXnojMGspYYO@smile.fi.intel.com>
References: <20211209111255.67044-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209111255.67044-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:12:55PM +0200, Andy Shevchenko wrote:
> Sort Kconfig and Makefile entries alphabetically for better maintenance
> in the future.
> 
> While at it fix some style issues, such as:
>   - "Say Y/yes/Yes" --> "Say Y"
>   - "pullup/pulldown" --> "pull-up and pull-down"
>   - wrong indentation

Scratch this, I have noticed more indentation and grammar issues int the moving
texts.

-- 
With Best Regards,
Andy Shevchenko


