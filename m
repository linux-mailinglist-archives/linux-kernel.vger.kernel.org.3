Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765446E66D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhLIKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:16:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:41301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232856AbhLIKQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:16:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238291700"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="238291700"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:13:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="463163094"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 02:13:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvGPC-0042mr-K1;
        Thu, 09 Dec 2021 12:12:02 +0200
Date:   Thu, 9 Dec 2021 12:12:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] MIPS: TXx9: Convert SPI platform data to software
 nodes
Message-ID: <YbHWcvrYXiS5sCm1@smile.fi.intel.com>
References: <20211126102339.28908-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3GuGgdp7Gq5N9XKTGhKbBUym9BiEb94RWyL1CDxS0ffw@mail.gmail.com>
 <CAMuHMdV4HVn+GcCBNQ+1-Kva2XiHQ03L5y9JLXH7qONtBvkV+w@mail.gmail.com>
 <20211129122052.GA7921@alpha.franken.de>
 <CAMuHMdWbvpzZCs4HOXErbVYQTiQAB0syuiR6Wd7=sTA2vFpXzw@mail.gmail.com>
 <YbDtiC5CJJGSL/9C@smile.fi.intel.com>
 <20211208220759.GA6406@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208220759.GA6406@alpha.franken.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:07:59PM +0100, Thomas Bogendoerfer wrote:
> On Wed, Dec 08, 2021 at 07:38:16PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 29, 2021 at 01:30:17PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Nov 29, 2021 at 1:21 PM Thomas Bogendoerfer
> > > <tsbogend@alpha.franken.de> wrote:
> > > > On Fri, Nov 26, 2021 at 01:16:22PM +0100, Geert Uytterhoeven wrote:

...

> > > > are you ok with completly removing rbtx4938 support ? Can I rbtx4939
> > > > board support, too ?
> > > 
> > > Fine for me, I only have rbtx4927.
> > 
> > Is there any news? I still see my patch well applied against latest Linux Next.
> > If the removal is going to be postponed, consider applying this patch then. So
> > we may move forward.
> 
> https://lore.kernel.org/all/20211130164558.85584-1-tsbogend@alpha.franken.de/
> 
> The second patch in that series touches drivers/mtd so I'm waiting for
> a Acked-by. But I could apply the first patch...

Yes, please!


-- 
With Best Regards,
Andy Shevchenko


