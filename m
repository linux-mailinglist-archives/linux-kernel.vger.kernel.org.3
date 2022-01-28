Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FD49FC08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349445AbiA1OqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:46:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:15609 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349429AbiA1OqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643381181; x=1674917181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gngqOiUeR2m46p7MVs22OwqlK1CJHBbYd0zK1GE/vrQ=;
  b=Xm9soSbJM/vpwWUgXDp7Ygrjfs+WU9ZRp3K/NvDs9gKkxdZEX+rMt8qX
   FQYmEStwQk3jnNpc/6W1b+zjM75MhT9bHFBiz6AUOiIea6cr+CqPr+03z
   hMdthx+eIwyeU2vnTg1u7ffqeiXM8vFb3B21tjQG2gUTIclvWn6mQ1VOY
   bP8jTyvft4XT9WZteyV6URTc1ghkfDLuYqBx915h2irZp77gU+5lMkTNR
   8Th4ymdea5tR9E74u/wESG85oFs9PCHDxuaeNv5M1gqH0zYGK54k9iYSS
   5ExFV3Omi0F2dkTgGb4zw5JF/CiSAshiOvH8rgwSXkIf+XDv/8jmo8Hnw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="271592687"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="271592687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:46:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="478305093"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:46:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDSV0-00FRfY-Ko;
        Fri, 28 Jan 2022 16:45:14 +0200
Date:   Fri, 28 Jan 2022 16:45:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     linus.walleij@linaro.org, michal.simek@xilinx.com,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "pinctrl: zynqmp: Unify pin naming"
Message-ID: <YfQBemA3bCz0FdYS@smile.fi.intel.com>
References: <20220127194602.21987-1-gerhard@engleder-embedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127194602.21987-1-gerhard@engleder-embedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:46:02PM +0100, Gerhard Engleder wrote:
> From: Gerhard Engleder <gerhard@engleder-embedded.com>

Thanks for your report, my comments below.

> This reverts commit 54784ff24971ed5bd3f1056edce998148709d0a7.
> 
> This patch changes the pin names from "MIO%d" to "MIO-%d", but all dts
> in arch/arm64/boot/dts/xilinx still use the old name. As a result my
> ZCU104 has no output on serial terminal and is not reachable over
> network.

And question here again, is the pin names ABI or not?
If it's an ABI, then it should be clarified in the documentation.
Otherwise, I'm wondering how this even may break anything.

-- 
With Best Regards,
Andy Shevchenko


