Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9358649FAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiA1NY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:24:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:58913 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbiA1NY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643376268; x=1674912268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dee8gZqixv/3uVG/nwblVNmvk6RueJi96F9bnNNOp0I=;
  b=VI/MwdwKH4Xx6gwiyWzuqhWj7xgTI4ZZ6PfVqzHOhM4bR1Lx6XO2F5Tv
   vBxcL24JExEZvfBI2OsbwrYdhGineD+nLVAFrcCLdeR64QWIx1Bf8usWm
   1UpLpMg+TMDmAnhOzclVUWKv3/kEEKQL3bIu7oU3ylYqv7+vYr2ZrkBTW
   58+tfNJ0MFRObEAH0vtVewBeSvd/AVrO4VdqavcCsH9WJhfUPLsTgzU5E
   1tiePjxZoKpqzjtJ4fq/WoVWh0sS4bU38HsWpj+3opUkCWqfb/jnVXHbA
   lI3aIL/XisikDS6hgGmJGAbSz3LIpkg1ldMfZGWE9uxQcmmS5thPsPfzD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307833878"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307833878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 05:24:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="625632618"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 05:24:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDRDj-00FQOE-Os;
        Fri, 28 Jan 2022 15:23:19 +0200
Date:   Fri, 28 Jan 2022 15:23:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 2/3] Input: mt6779-keypad - Add MediaTek keypad driver
Message-ID: <YfPuR/Q5//hSQYKG@smile.fi.intel.com>
References: <20220127111526.3716689-1-mkorpershoek@baylibre.com>
 <20220127111526.3716689-3-mkorpershoek@baylibre.com>
 <YfK4UcuCfF7JfI7H@smile.fi.intel.com>
 <87v8y4p483.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8y4p483.fsf@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:03:08AM +0100, Mattijs Korpershoek wrote:
> On Thu, Jan 27, 2022 at 17:20, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 27, 2022 at 12:15:25PM +0100, Mattijs Korpershoek wrote:

...

> > Up to you.

> Thank you for your review and your suggestions.

Yes, as I said it you need a new version and consider them good.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


