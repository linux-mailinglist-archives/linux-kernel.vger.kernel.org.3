Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEF9489C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiAJPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:37:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:32474 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236276AbiAJPh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641829046; x=1673365046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRy0VkEeeNFo0vpP3NHDQc5UwUuR79j9L4aV96ycq+E=;
  b=JfPm7a+xq1dIIUDOJbWhMvwj4lbQSgxz6MfA9Ui+u7tzArdfCNSvCj6B
   W942AmGFoTIU8jV80mWzq4VEu+F7yZyFxbLVpo3WKvcWW0tMMQuWvBFI7
   ggCG76V36gu4EDdMmPdfSsxc2HSlgkXVUQ+ikV9Xn5Qe0spcWNRILMqC0
   NybAvFVKvBWhrAyo42QI8jTAW/Uf0Twd1Tb0sOnxXBUnMyUa0WuiwgMkB
   rITdBNnHIgA+5LBIKLiSZFlUPLeQC8OHqpUdNe64Vam/L+uDlv/juGBUO
   hZhzDmuWs3zGsifVeZXACyogaPT869rOemSEQnU/ys3DMd6ZEbWb6GY5N
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223232051"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223232051"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:37:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="514709971"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:37:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6wiO-008udy-31;
        Mon, 10 Jan 2022 17:36:08 +0200
Date:   Mon, 10 Jan 2022 17:36:07 +0200
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
Message-ID: <YdxSZ53cBGcNjbvb@smile.fi.intel.com>
References: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
 <Ydwlsr8WjdsSWvoZ@smile.fi.intel.com>
 <13907dd6-2a30-c6b1-fb71-e88dba98f5ca@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13907dd6-2a30-c6b1-fb71-e88dba98f5ca@cogentembedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 03:30:08PM +0300, Nikita Yushchenko wrote:
> > Just noticed, what stm supposed to mean? `git log` against those drivers
> > suggests something else.
> 
> I copied it from git log, can't remember from where exactly.
> Perhaps 'st_sensors' is better.

% git log --no-merges --oneline -- drivers/iio/common/st_sensors/ drivers/iio/*/st_* | cut -f2-4 -d' ' | grep -o "[ :]st[^:]\+:" | tr -d ':' | tr -d ' ' | sort | uniq -c | sort -n
      1 st_accel_core
      1 st_accel_i2c
      1 st_gyro_spi
      1 st_lsm9ds0
      1 st_lsmdsx
      1 st-magn
      1 st_magn_core
      1 st_pressure_core
      1 stsensors
      2 st_accel_i2c.c
      2 st_magn_spi
      2 st_press
      2 st_pressure_spi
      3 st-accel
      4 st_accel_spi
      4 st_uvis25
      5 st-sensors
     11 st_gyro
     15 st_magn
     21 st_pressure
     27 st_accel
     68 st_sensors
    140 st_lsm6dsx

(Yes, I know that command line can be simplified :-)

-- 
With Best Regards,
Andy Shevchenko


