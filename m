Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58844498154
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiAXNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:46:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:36514 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbiAXNqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643031982; x=1674567982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JqT7w+jmr16g6nhf2sFMCeI70E8Qapcp3FqDAj0rZUQ=;
  b=cHNeGHa9kV9WsH4Cq3/VOxQ+e8WE7MUE42kH6c/6mxUPleEGo7BJku+p
   vFuLS8LULhICbMVhrxKBJoPu8uRbooSaKCx6HI9hq9fLofw1fKAFDtNcB
   ryr1cSRdS5xqGkQcKq7Ej1oOpgcuqhS7D0vYIdcUz0JrIyxXCq09roQw3
   RBd9bB6kafv1IyHKMbdCd5ZX7Zr5Cab5ibLjn8hk8ajtWwwzlAZLsVzyN
   NgBzu2lVZ8f5gDjGRQA/xJUKyy5iuudcPN+b2BouzaodzgT8phG6GP4aX
   1kM1uPTkDo2NZjKaDOwxBWKAjNUbuhMmJKBAnIxx5BAPPcVaV9ro7L7ww
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246262724"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246262724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:46:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695424489"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 05:46:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nBzej-00DuDp-H8;
        Mon, 24 Jan 2022 15:45:13 +0200
Date:   Mon, 24 Jan 2022 15:45:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Grace Kao <grace.kao@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kane Chen <kane.chen@intel.com>
Subject: Re: pinctrl: intel: Fix a glitch when updating IRQ flags on a
 preconfigured line
Message-ID: <Ye6taW8fCoLj83Pa@smile.fi.intel.com>
References: <20220121093426.6336-1-grace.kao@intel.com>
 <CAHp75VfD72ZzTw4wc4Oteg+XvRqRipN-YjLqQjUGGy8f83By+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfD72ZzTw4wc4Oteg+XvRqRipN-YjLqQjUGGy8f83By+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:27:40PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 21, 2022 at 11:35 AM Grace Kao <grace.kao@intel.com> wrote:
> 
> > Tested-by: Grace Kao <grace.kao@intel.com>
> 
> Thanks for testing. I will apply the tag to the original patch. The
> idea that you simply reply to the original message with the line above
> and that's it, no need to resend a full patch.
> 
> > Change-Id: I6ff5cf0c42a76dce709a445c1820c8f3a84d6d89
> 
> I see it comes from the internal tree.

Original patch with your tag has been pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


