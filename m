Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0924668AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359767AbhLBQ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:56:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:29754 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347848AbhLBQz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:55:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223982987"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="223982987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 08:52:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="541288981"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 08:52:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mspIs-001SXx-Vt;
        Thu, 02 Dec 2021 18:51:26 +0200
Date:   Thu, 2 Dec 2021 18:51:26 +0200
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
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: Re: [PATCH v11 3/5] iio: adc: Add Xilinx AMS driver
Message-ID: <Yaj5jnRzAUvGxeFq@smile.fi.intel.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-4-anand.ashok.dumbre@xilinx.com>
 <YZ9+HxSRmT1XHld2@smile.fi.intel.com>
 <BY5PR02MB69163D602A61CE502527CE11A9699@BY5PR02MB6916.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB69163D602A61CE502527CE11A9699@BY5PR02MB6916.namprd02.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:32:33PM +0000, Anand Ashok Dumbre wrote:

...

> > > +/**

> > > + * struct ams - Driver data for xilinx-ams

(1)

> > > + * @base: physical base address of device
> > > + * @ps_base: physical base address of PS device
> > > + * @pl_base: physical base address of PL device
> > > + * @clk: clocks associated with the device
> > > + * @dev: pointer to device struct
> > > + * @lock: to handle multiple user interaction
> > > + * @intr_lock: to protect interrupt mask values
> > > + * @alarm_mask: alarm configuration
> > > + * @current_masked_alarm: currently masked due to alarm
> > > + * @intr_mask: interrupt configuration
> > > + * @ams_unmask_work: re-enables event once the event condition
> > > +disappears
> > 
> > > + * This structure contains necessary state for Sysmon driver to
> > > + operate
> > 
> > Shouldn't be this "state for Sysmon driver to operate" a summary above?
> 
> I don't understand.

(1) is not so informative, this one is better.

> > > + */

-- 
With Best Regards,
Andy Shevchenko


