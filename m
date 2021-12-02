Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10F946608C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356486AbhLBJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:41:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:25482 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345914AbhLBJlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:41:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="297469623"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="297469623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:38:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="609920216"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:38:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1msiWZ-001LKK-It;
        Thu, 02 Dec 2021 11:37:07 +0200
Date:   Thu, 2 Dec 2021 11:37:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v11 1/5] device property: Add fwnode_iomap()
Message-ID: <YaiTw1RVgxkOvFj8@smile.fi.intel.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
 <YZ92mTURrFWZPUXp@smile.fi.intel.com>
 <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
 <BY5PR02MB6916F7BC6ACE5326DB92DB2BA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6916F7BC6ACE5326DB92DB2BA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:10:02AM +0000, Anand Ashok Dumbre wrote:
> > From: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> > Sent: Tuesday 30 November 2021 9:58 PM
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday 25 November 2021 11:42 AM
> > > On Wed, Nov 24, 2021 at 10:54:03PM +0000, Anand Ashok Dumbre wrote:

...

> > > > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> > > index) {
> > >
> > > > +	if (is_of_node(fwnode))
> > > > +		return of_iomap(to_of_node(fwnode), index);
> > >
> > > It seems this part should be wrapped in some ifdeffery according to
> > > kbuild bot report.
> > 
> > I see that of_iomap is wrapped in #ifdef I will fix that and send a new patch.
> 
> I am unable to reproduce the conditions for the error shown by the kernel bot.
> Not sure if I am doing something wrong. Any help/suggestion would be appreciated to fix this issue.

Kbuild bot gives you a config file and command line with which it tried to
build. It's quite rare that it gives you false positives (and here it's not
the case, because you need to have ifdeffery like other APIs in this category
have).

> > > > +	return NULL;
> > > > +}


-- 
With Best Regards,
Andy Shevchenko


