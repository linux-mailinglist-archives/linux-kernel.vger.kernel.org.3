Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA9498272
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiAXObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:31:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:9369 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238921AbiAXObN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643034673; x=1674570673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gX4SVNGoVO+Y0+OG3nztV8ajdaDJcg5uJdE0l49TVIo=;
  b=TJd/T98pfvPy0wEybs6ZVA1FLgl9yXhMUh0+dM2pWZ1zBtqx12VGYmVB
   y2TekABdGGLTRdSCCU9hrIo8TBq1LpBoWt19Ak+KFV/MVQLy1UtbaCyBd
   V0zUGga5yG7xGURBfboACEXXedTLvKNhwfmdXJs56NbfhsVsVvplfh00T
   Mfi4GEQhH9cHkVzRpas5BWRib3cTTqux+5ynQc955mMevWyQ+4qi3FTPI
   ljh7Q/1ooBbH83oJrXFNP11cPA+Mx9Brbyu735LGEfoxy9UFe3nwKCfVh
   8mYp6073O12b2VraPfgH5X1P0YEJrrkbfPeOXUPyR0EyZnDoeLuDLfhhG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243653131"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243653131"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:31:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="673641847"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:31:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC0M9-00DvJF-3i;
        Mon, 24 Jan 2022 16:30:05 +0200
Date:   Mon, 24 Jan 2022 16:30:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] pinctrl: Place correctly CONFIG_PINCTRL_STMFX in
 the Makefile
Message-ID: <Ye637G6zqfxiq6CP@smile.fi.intel.com>
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

I have pushed rebased version to my review and testing queue, I'll send it in
the PR for fixes to Linus W.

-- 
With Best Regards,
Andy Shevchenko


