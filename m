Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622B04676A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352213AbhLCLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:40:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:1872 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380494AbhLCLkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:40:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="297755269"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="297755269"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 03:36:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="678068982"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 03:36:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mt6qu-001kLf-EV;
        Fri, 03 Dec 2021 13:35:44 +0200
Date:   Fri, 3 Dec 2021 13:35:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] platform/x86: Support Spi in i2c-multi-instantiate
 driver
Message-ID: <YaoBEKJtuAb9xUAk@smile.fi.intel.com>
References: <20211202162421.7628-1-sbinding@opensource.cirrus.com>
 <20211202162421.7628-3-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211202162421.7628-3-sbinding@opensource.cirrus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:24:21PM +0000, Stefan Binding wrote:
> Add support for spi bus in i2c-multi-instantiate driver
> and rename it for a multiple purpose driver name
> By adding spi support into this driver enables devices
> to use the same _HID string for i2c and spi uses and
> minimize the support for two drivers doing the same thing
> for different busses

Please take care about periods at the end of sentences.
But this is minor in comparison to the following issues:

 - you enable this for existing I²C multi-instantiate devices,
   are you sure it is fine?

 - continuing above, how can you guarantee that the same ID would
   be used I²C and SPI versions of the same chip and not, let's say,
   for UART?

 - or other way around, how do we know that the same component will
   have the same ID for different bus types? (Yes, I understand that
   this is logically appropriate assumption, but you never know OEMs
   and others in their ways to (ab)use ACPI specifications and common
   sense)

 - if we even go this way, it should be under drivers/acpi


-- 
With Best Regards,
Andy Shevchenko


