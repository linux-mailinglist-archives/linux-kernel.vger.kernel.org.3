Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76C489CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiAJPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:54:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:50108 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236627AbiAJPy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641830066; x=1673366066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rX4Yeo72fBejr7EJ901BTYv9hMR6JNoo7ubEPirAX/4=;
  b=jRLP6ZF4dTgCf8yn7Nzdo4BSEIOfY5KupehSp510JoqvpHHeSvuNIyZf
   gWT2mjEe6H530kNN4DABAjhxPQpv56/twoe5qbq09+ZVl2nY/AbWX9CMs
   7W8zBjYQw4JPL/lXxoL/yvxSEYBNcPWusK1aipLbeywU5j71S9iAkUlTo
   ZNVpeFH2Mriy2PWx/UFIna5fI3yvshygZWELbfl2b3dhqm+kVWW0M0wzp
   QuclCLnOJFLkOefGp4oDHbmGs+NBqtl2UqOCgzVuN/iQAG2Fw751cpAVa
   +Vpk7+5vElQUU36zcobRPlqArLm4/6LOS/GJbC3LYZFh4jQ7RpZ2O2usV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="267581623"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="267581623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:54:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="490034711"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:54:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6wyr-008v0u-2w;
        Mon, 10 Jan 2022 17:53:09 +0200
Date:   Mon, 10 Jan 2022 17:53:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_sensors: don't always auto-enable I2C and SPI
 interface drivers
Message-ID: <YdxWZEz1GXXxQ+7h@smile.fi.intel.com>
References: <20220110152432.3799227-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110152432.3799227-1-nikita.yoush@cogentembedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 06:24:32PM +0300, Nikita Yushchenko wrote:
> This patch makes I2C and SPI interface drivers for STMicroelectronics
> sensor chips individually selectable via Kconfig.
> 
> The default is kept unchanged - I2C and SPI interface drivers are still
> selected by default if the corresponding bus support is available.
> 
> However, the patch makes it possible to explicitly disable drivers
> that are not needed for a particular target.

...

The same question as per v2.

> +	default I2C && IIO_ST_ACCEL_3AXIS

What will be the results when I2C=y and the second ones =m?

-- 
With Best Regards,
Andy Shevchenko


