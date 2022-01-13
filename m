Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7888348D617
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiAMKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:51:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:7439 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbiAMKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071071; x=1673607071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNYawhiOmR8z6wfQZHEZQfkWXoG1HGn4PlpAKTtbMFQ=;
  b=QLxCQATbigsQ6l6ZOJCTaezVBVNmALfexV3iUplJnHiWGqvTlPFKNB/x
   4IaQnSJcRYOKuBdj7phF951Aah9IU9RsniH0zcqfrPcgL2pj6ZHRWuiFB
   vrGbF2lx9VV1nwWVBZPKz/HRJVPMceLOca9G1+lwf09YsycC6sMijdPQd
   gllt0R06y6y2mGqyYQuce9fM7uW4zx+5An1WsZlT2W3gTSElTztmh/hbX
   ahtDygW9eN4tn3n7WeWPEIw/Sp8H6MnUhFrjxDqGDh2WrREoFzizKr7m3
   MpZpcWgW3AXj9FzuYNAWk96N4sL3HaLgoZpeesFBTh7sL/2iCi7sD2Mu9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268335069"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="268335069"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:51:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="515881310"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:51:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n7xg4-00AA0z-Hv;
        Thu, 13 Jan 2022 12:49:56 +0200
Date:   Thu, 13 Jan 2022 12:49:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Place correctly CONFIG_PINCTRL_STMFX in
 the Makefile
Message-ID: <YeAD1FnPi0i9th9t@smile.fi.intel.com>
References: <20220112210456.29375-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112210456.29375-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:04:56PM +0200, Andy Shevchenko wrote:
> Keep Makefile entries ordered in the same way as Kconfig ones.

Damn, this is against old next/master.
I will send a new one later on.

-- 
With Best Regards,
Andy Shevchenko


