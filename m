Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6C464F80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbhLAOXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:23:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:17107 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242777AbhLAOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:23:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="235195533"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="235195533"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:20:07 -0800
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="609570027"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:20:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msQRr-0010Yu-4d;
        Wed, 01 Dec 2021 16:19:03 +0200
Date:   Wed, 1 Dec 2021 16:19:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v1 0/3] misc: at25: Fix issues brought with FRAM support
Message-ID: <YaeEVn2ge+LzFaG5@smile.fi.intel.com>
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:27:26PM +0200, Andy Shevchenko wrote:
> A few fixes to the AT25 driver that have been brought by FRAM support series.
> 
> Andy Shevchenko (3):
>   misc: at25: Make driver OF independent again
>   misc: at25: Don't copy garbage to the at25->chip in FRAM case
>   misc: at25: Check proper value of chip length in FRAM case
> 
>  drivers/misc/eeprom/at25.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Greg, it seem under your realm, can you apply this for current cycle, please?

-- 
With Best Regards,
Andy Shevchenko


