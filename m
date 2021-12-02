Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29F466085
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhLBJhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:37:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:36523 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhLBJhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:37:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="234180304"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="234180304"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:34:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477858873"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:34:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msiSp-001LGD-5E;
        Thu, 02 Dec 2021 11:33:15 +0200
Date:   Thu, 2 Dec 2021 11:33:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH v2 3/3] soc: fsl: Replace kernel.h with the necessary
 inclusions
Message-ID: <YaiS2iHCrGkXgTdX@smile.fi.intel.com>
References: <20211110105952.62013-1-andriy.shevchenko@linux.intel.com>
 <20211110105952.62013-3-andriy.shevchenko@linux.intel.com>
 <YZJExzxJ4j8g6jEY@smile.fi.intel.com>
 <AS8PR04MB8946B4800AE34258F7F2BA688F989@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <YZN7+UlXtJi8/i1L@smile.fi.intel.com>
 <YZ0WlMyS36Gj565C@smile.fi.intel.com>
 <CADRPPNT3yhr3jAPZm=hcON3nd97eLSrkWqFBV6kh6W5gf0w3Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNT3yhr3jAPZm=hcON3nd97eLSrkWqFBV6kh6W5gf0w3Xg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 01:41:16PM -0600, Li Yang wrote:
> On Tue, Nov 23, 2021 at 10:32 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 16, 2021 at 11:38:01AM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 15, 2021 at 10:24:36PM +0000, Leo Li wrote:
> > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Sent: Monday, November 15, 2021 5:30 AM
> > > > > On Wed, Nov 10, 2021 at 12:59:52PM +0200, Andy Shevchenko wrote:
> > >
> > > ...
> > >
> > > > > > v2: updated Cc list based on previous changes to MAINTAINERS
> > > > >
> > > > > Any comments on this, please?
> > > > >
> > > > > I really want to decrease amount of kernel.h usage in the common headers.
> > > > > So others won't copy'n'paste bad example.
> > > >
> > > > There seems to be no problem with the patch although I didn't get time to really compile with it applied.
> > > >
> > > > Will pick them up later after build test.
> > >
> > > Thank you!
> > >
> > > Note, it has two fixes against MAINTAINERS which may be sent, I believe,
> > > sooner than later to Linus.
> >
> > Any new so far?
> 
> The build test is good.  I have applied it for next.  Thanks.

Thanks, what about MAINTAINERS updates? I don't see them neither in next nor in
your tree.

-- 
With Best Regards,
Andy Shevchenko


