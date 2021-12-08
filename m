Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1246D32B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhLHMY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:24:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:59130 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhLHMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:24:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="261894929"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="261894929"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 04:20:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="462744017"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 04:20:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muvvH-003dZj-DM;
        Wed, 08 Dec 2021 14:19:47 +0200
Date:   Wed, 8 Dec 2021 14:19:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yuchang Hsu <saraon640529@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Cindy1_Hsu@asmedia.com.tw, Andrew_Su@asmedia.com.tw
Subject: Re: [PATCH v2] gpio:amdpt:add new device ID and 24-pin support
Message-ID: <YbCi4zv8247Jgfhe@smile.fi.intel.com>
References: <20211208103621.9253-1-Richard_Hsu@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208103621.9253-1-Richard_Hsu@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 06:36:21PM +0800, Yuchang Hsu wrote:

Thanks for update, my comments below.

> Hi Andy Shevchenko,

> How and what to put the Changelog after '---'?i just remove '---'.

No, you shouldn't remove it, instead you should add the text after it in a free
form of what you have done in the submitted version in comparison to the
previous one.

To achieve this use `git format-patch ...` and then edit it and then send it
with a help of `git send-email ...`.

> This patch adds a ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.

"This patch adds a ..." --> "Add an ..."

> And We retrieve pin number supporting by device_get_match_data().

"And " --> ""
"supporting " --> ""

So, waiting for v3.

-- 
With Best Regards,
Andy Shevchenko


