Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF73A46E777
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhLILXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:23:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:42812 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236558AbhLILXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:23:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237882996"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="237882996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:19:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="680296755"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 03:19:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvHRT-0043zm-GH;
        Thu, 09 Dec 2021 13:18:27 +0200
Date:   Thu, 9 Dec 2021 13:18:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yuchang Hsu <saraon640529@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        Richard_Hsu@asmedia.com.tw, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Cindy1_Hsu@asmedia.com.tw, Andrew_Su@asmedia.com.tw
Subject: Re: [PATCH v3] gpio:amdpt:add new device ID and 24-pin support
Message-ID: <YbHmAyVka7w814g7@smile.fi.intel.com>
References: <20211209022605.11250-1-Richard_Hsu@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209022605.11250-1-Richard_Hsu@asmedia.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:26:05AM +0800, Yuchang Hsu wrote:
> From: Hsu Yuchang <Richard_Hsu@asmedia.com.tw>

Thanks for v3, my comments below.

As I pointed out the subject should be

	gpio: amdpt: add new device ID and 24-pin support

(mind the white spaces).

> This patch add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.

As Submitting Patches documentation advises the description should be in
imperative form:

	Add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.

> And we retrieve pin number by device_get_match_data().
> 
> Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>

> --- Add AMDIF031 support

After cutter '--- ' line means _after_, and not on the same line.
The changelog contents should explain the changes in the patch versions,
and not the changes which is done in the patch against the code base, for
the latter the commit message suffices.

Look at the plenty of the examples you may find in the mail archive:
https://lore.kernel.org/linux-gpio/.

-- 
With Best Regards,
Andy Shevchenko


