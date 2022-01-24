Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA9498338
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiAXPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:12:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:6733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235253AbiAXPMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643037163; x=1674573163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WCTc9IlDADP2jY46oae/kFECkfhZYD5oZQG3OOtRZo8=;
  b=AHtn7gFGb5gzTz3UOS4pZgthUcBcPJYFvrnhTFdUQ62SARbEFkvNGyhk
   8SP28YpC6wPUQ1uP0Hk2TzBWeecRQ//Tx5tMuWJ0rWhszZ27EBdip36e5
   P/qruDvHV4YSptrGbsSoBARuQkvtbQhOvgOX4x4k6TiMtqYb8f5H7HyO0
   HyKhTprrSXZr0z3WclY6Grn70P0uXR2PhMCvBLP4nfh3Dp+RbzwckV1YH
   gtPn234V0meYT+jrNNQH4qPCMW72TN1WrSjXB9IvVmw7r9YUl40zthjWl
   7xfe0kGlhSZ/tZ6z2VjDuYvEGyDkwWejwZTry78+/gtYVLkMcw+xys7bw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226046688"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226046688"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:12:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562684284"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:12:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC10I-00DvvF-IT;
        Mon, 24 Jan 2022 17:11:34 +0200
Date:   Mon, 24 Jan 2022 17:11:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: altera-a10sr: Switch to use fwnode instead
 of of_node
Message-ID: <Ye7BpogQzgKZtqse@smile.fi.intel.com>
References: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYRLDqgKjuW8W6NobaTP4dTjnkmepu=T-GhO7fMNcMEzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYRLDqgKjuW8W6NobaTP4dTjnkmepu=T-GhO7fMNcMEzA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 01:24:02AM +0100, Linus Walleij wrote:
> On Thu, Dec 23, 2021 at 1:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > GPIO library now accepts fwnode as a firmware node, so
> > switch the driver to use it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> LGTM!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


