Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1649FC20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbiA1Ouq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:50:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:34145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240449AbiA1Oup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643381445; x=1674917445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KENKt9ih+Iecy5W/jOM89XmtX4xsj3KyDe4f17+4BZk=;
  b=jgvW6ke0JjW7CYezUdEtesIRv1VNt62pJnD65Y6SmhzGhbPWisxFSncQ
   R5wQNURm3l70crcrusucS9ss43Jy95/RTgb9ATIbqk8wc0kPRkQmzvuaQ
   /g0CgUp46u/vUVZQK7MQGa5w1e6zJCsCUP/xmYicTnq3Nu+1le6lZnXe6
   g1CCAAswYp22cvIoZRsHeyrcy/SYLo7CgYXYGBEPW1UkXpMDQ4ANDYY0Z
   ypGzAmoG36XZ30h5tDltWuoFRfif8GwMxXfue603Kvr/NVBcYzynBkHUo
   Iax34ryoZVgGQGnXOm8EW6E18sgVjUO058SSv+59T/fu4ZXXIIEiRVCsa
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="247078286"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="247078286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:50:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="564215331"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:50:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nDSZG-00FRjI-V2;
        Fri, 28 Jan 2022 16:49:38 +0200
Date:   Fri, 28 Jan 2022 16:49:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     linus.walleij@linaro.org, michal.simek@xilinx.com,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "pinctrl: zynqmp: Unify pin naming"
Message-ID: <YfQCgnmyMOvB0V/k@smile.fi.intel.com>
References: <20220127194602.21987-1-gerhard@engleder-embedded.com>
 <YfQBemA3bCz0FdYS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfQBemA3bCz0FdYS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:45:14PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 27, 2022 at 08:46:02PM +0100, Gerhard Engleder wrote:
> > From: Gerhard Engleder <gerhard@engleder-embedded.com>
> 
> Thanks for your report, my comments below.
> 
> > This reverts commit 54784ff24971ed5bd3f1056edce998148709d0a7.
> > 
> > This patch changes the pin names from "MIO%d" to "MIO-%d", but all dts
> > in arch/arm64/boot/dts/xilinx still use the old name. As a result my
> > ZCU104 has no output on serial terminal and is not reachable over
> > network.
> 
> And question here again, is the pin names ABI or not?
> If it's an ABI, then it should be clarified in the documentation.
> Otherwise, I'm wondering how this even may break anything.

Meanwhile I apply this to my tree and send as fix PR to Linus.

-- 
With Best Regards,
Andy Shevchenko


