Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A408646DA5C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhLHRxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:53:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:30010 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhLHRx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:53:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218573410"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="218573410"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:39:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="679966470"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:39:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mv0tV-003mm8-3H;
        Wed, 08 Dec 2021 19:38:17 +0200
Date:   Wed, 8 Dec 2021 19:38:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <YbDtiC5CJJGSL/9C@smile.fi.intel.com>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <20211129122052.GA7921@alpha.franken.de>
 <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:30:17PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 29, 2021 at 1:21 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> > On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:

...

> > are you ok with completly removing rbtx4938 support ? Can I rbtx4939
> > board support, too ?
> 
> Fine for me, I only have rbtx4927.

Is there any news? I still see my patch well applied against latest Linux Next.
If the removal is going to be postponed, consider applying this patch then. So
we may move forward.

-- 
With Best Regards,
Andy Shevchenko


