Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0C464F85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbhLAOYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:24:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:56126 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231340AbhLAOXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:23:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="322711456"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="322711456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:20:26 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="596338620"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:20:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msQSA-0010ZE-89;
        Wed, 01 Dec 2021 16:19:22 +0200
Date:   Wed, 1 Dec 2021 16:19:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v1 00/10] misc: at25: Code cleanups and improvements
Message-ID: <YaeEavK6fHJPlbK7@smile.fi.intel.com>
References: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125213203.86693-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:31:53PM +0200, Andy Shevchenko wrote:
> Code cleanups and improvements. Please read individual commit messages.
> 
> Series depends on the fixes series [1] sent earlier.

Greg, it seem under your realm, can you apply this for the next cycle, please?

> [1]: https://lore.kernel.org/lkml/20211125212729.86585-2-andriy.shevchenko@linux.intel.com/T/#u
> 
> Andy Shevchenko (10):
>   misc: at25: Use at25->chip instead of local chip everywhere in
>     ->probe()
>   misc: at25: Unshadow error codes in at25_fw_to_chip()
>   misc: at25: Check new property ("address-width") first
>   misc: at25: Get platform data via dev_get_platdata()
>   misc: at25: Get rid of intermediate storage for AT25 chip data
>   misc: at25: Switch to use BIT() instead of custom approaches
>   misc: at25: Factor out at_fram_to_chip()
>   misc: at25: Reorganize headers for better maintenance
>   misc: at25: Replace commas by spaces in the ID tables
>   misc: at25: Align comment style
> 
>  drivers/misc/eeprom/at25.c | 210 +++++++++++++++++++------------------
>  1 file changed, 110 insertions(+), 100 deletions(-)
> 
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


