Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7683A49FBED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349375AbiA1OoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:44:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:9044 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239527AbiA1OoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643381047; x=1674917047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03BCVhQWgRy3l9VLGQsE2lheSMUyT2B9E/jISlaxeCk=;
  b=Ijm+VgcGcoOLKZrfcIM305g0+8mQD/26OJ1IRZyC2tQQf9mkVU/4XGXW
   PkNGgVP1aUslykEJ6aV1r7/Zv2LYxW1ea0lXpb+O57It4GLeSOvRgkmyk
   q4Dm1BWYezs7GLpsVJD4WnkxrtneQ5XNkHS3Q2R+Gh37GAPr8IVhqM+qK
   5Olh8/D6nLFJJMQvLG9Ro2uM3gaJ03/7qZX1qMbXsplrc2uW15ncw30Vb
   HO5IFzogOseO3WpVuidFgL+yEyUHMMNng41LOkbnQTw570EyYf83H0oNZ
   kxbGFbM+aJOo0ZujWVo+L1I5QDi8yEdFBiJSXjia/e+i2U9YEEPpza1Dr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227108150"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227108150"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:44:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="496149565"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:44:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDSSq-00FRde-5w;
        Fri, 28 Jan 2022 16:43:00 +0200
Date:   Fri, 28 Jan 2022 16:42:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     jagath jogj <jagathjog1996@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, aardelean@deviqon.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: IIO Device Driver for Maxim DS3502 potentiometer
Message-ID: <YfQA8wRpauq058WK@smile.fi.intel.com>
References: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
 <20220128103554.000028ff@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128103554.000028ff@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:35:54AM +0000, Jonathan Cameron wrote:
> On Fri, 28 Jan 2022 09:11:28 +0530
> jagath jogj <jagathjog1996@gmail.com> wrote:
> 
> > Hello,
> > 
> > I have a Maxim DS3502 potentiometer breakout and I have written an IIO
> > driver for learning purposes and tested with Raspberry pi and wanted
> > to send patches of the driver for the IIO sub-system.
> > 
> > Can I send the patches for DS3502 POT for review?
> > 
> > The setup used to write driver
> > Raspberry pi 3b
> > DS3502 breakout board
> > Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux

> Welcome to IIO.
> 
> Absolutely on sending the patches for review.
> You'll need to rebase them on latest mainline from kernel.org
> (pick a tagged version which would currently be 5.17-rc1_
> 
> and then follow the documentation for how to submit a patch in
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> Feel free to ask if you have any questions about the process.
> 
> Looking forwards to seeing your code.

Agree with Jonathan.

One remark though, can you double check that drivers/iio/potentiometer
doesn't have any similar driver that can be expanded (usually it can be
done by analyzing a register file of the devices, like register offsets
and their meanings or bit fields)?

-- 
With Best Regards,
Andy Shevchenko


