Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A99489890
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbiAJM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:27:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:46136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245449AbiAJM0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641817599; x=1673353599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8B0E3h5mL4njMB7e9ZJWWy8Me+SECuCSc9ip73ybvA=;
  b=VIudun+CsrvgyXYLCwpxHDUFsU1+BUcGKYftKvGVXKO94uTbm1V8CkvN
   v6KsNAYy2L6NF2EoDu7JhEVXIrrQzyjxoq5VqKsALhJnvaecboA2/Z/bV
   OG93hCZPXF8Y2Lvk+P90ocVQWvwQK4ud5eO55WCqs7P7osBCBOOQsA9eA
   Xq6gAJqj26SH79zfhXXItbyaTHIHW/TSZf0y3GQ9e58dvHRevzwyWFw09
   Msma/vVIxvl+/04KgNq17jaNzRyEXLBuss/YE8NWEPU24FQulQKKuqhKB
   YLhgrY/o7nIAXrbZJpy2b3jkKKSKpFlXL5wpHayBGlPkG9c0Dov9LlGK9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="242025593"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="242025593"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 04:26:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="575803454"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 04:26:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6tjn-008ftV-2k;
        Mon, 10 Jan 2022 14:25:23 +0200
Date:   Mon, 10 Jan 2022 14:25:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: stm: don't always auto-enable I2C and SPI
 interface drivers
Message-ID: <Ydwlsr8WjdsSWvoZ@smile.fi.intel.com>
References: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 03:43:26PM +0300, Nikita Yushchenko wrote:
> This patch makes I2C and SPI interface drivers for STMicroelectronics
> sensor chips individually selectable via Kconfig.
> 
> The default is kept unchanged - I2C and SPI interface drivers are still
> selected by default if the corresponding bus support is available.
> 
> However, the patch makes it is possible to explicitly disable drivers
> that are not needed for particular target.

Just noticed, what stm supposed to mean? `git log` against those drivers
suggests something else.

-- 
With Best Regards,
Andy Shevchenko


