Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB37474415
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhLNN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:59:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:9957 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232416AbhLNN7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="219664744"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="219664744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:59:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="545173484"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 05:59:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mx8KN-0069FM-6D;
        Tue, 14 Dec 2021 15:58:47 +0200
Date:   Tue, 14 Dec 2021 15:58:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH v1 1/1] ARM: orion/gpio: Get rid of unused first
 parameter in orion_gpio_init()
Message-ID: <YbijFsYMshx7Sy4g@smile.fi.intel.com>
References: <20211214133243.53199-1-andriy.shevchenko@linux.intel.com>
 <YbifCSYfbKoYuzDX@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbifCSYfbKoYuzDX@shell.armlinux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:41:29PM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 14, 2021 at 03:32:43PM +0200, Andy Shevchenko wrote:
> > The OF node pointer is always NULL, get rid of unused parameter in
> > orion_gpio_init(). As a side effect it will allow to switch GPIO
> > library to the fwnode API, as well as in case of resurrecting it here
> > it should be fwnode_handle anyways.
> 
> Please ensure the new code follows the existing style - especially in
> terms of wrapping. Some of us still use 80 columns as a general rule.
> Thanks.

Ah, okay, I will fix that for v2.

-- 
With Best Regards,
Andy Shevchenko


