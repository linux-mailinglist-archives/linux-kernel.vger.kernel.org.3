Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3A47E2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbhLWMEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:04:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:54141 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348085AbhLWMEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640261088; x=1671797088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7Iz0oIwoUZhkLnHFpLk+ZAFJFPFIJXK1GEWhh4vA2M=;
  b=AXCiiWfGF8NgRWt25uvrX09lDuS33/EHDuHtBHyF2lRNbTzZtZ6rXv8u
   qNoPj7QLA5eOJVzQN8RbI7/KEmMucOTjA6035vBEUTDed3pywl4lTCD9m
   xCcmGmpinK6VGuN/RjRxscXEWeQHP9CTaGsf5bxbend9gVNfoMp9E+qcu
   BnuiN3obuAEIM6GIxX0baIXynzOzJhlzrOWXCdF33lnymFyEgzb0siONC
   3fhJ5BvmZ7IW9n04LsFrTy/SsERydn3/b53X5Y1gIBe0hfc546KKptrFF
   2GBOQIv6nvz2oyLLsnqTfKnd+/LgX3NH+vfNhxZSBcTLZr/tISkCYGd7z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="265022973"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="265022973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:04:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="570912439"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:04:45 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 23 Dec 2021 14:04:43 +0200
Date:   Thu, 23 Dec 2021 14:04:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: make fwnode take precedence in
 struct gpio_chip
Message-ID: <YcRl29vhMQrNBF+e@lahna>
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:38:08PM +0200, Andy Shevchenko wrote:
> If the driver sets the fwnode in struct gpio_chip, let it take
> precedence over the parent's fwnode.
> 
> This is a follow up to the commit 9126a738edc1 ("gpiolib: of: make
> fwnode take precedence in struct gpio_chip").
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
