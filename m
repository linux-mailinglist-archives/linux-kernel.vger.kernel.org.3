Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23546772A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380745AbhLCMXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:23:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:38604 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352004AbhLCMXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:23:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="260972895"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="260972895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:19:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513685871"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:19:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mt7WU-001lI0-GJ;
        Fri, 03 Dec 2021 14:18:42 +0200
Date:   Fri, 3 Dec 2021 14:18:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] leds: tca6507: Get rid of duplicate of_node
 assignment
Message-ID: <YaoLImUJb0K/IVOL@smile.fi.intel.com>
References: <20211202210613.78584-1-andriy.shevchenko@linux.intel.com>
 <20211203073121.GA27457@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203073121.GA27457@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:31:21AM +0100, Pavel Machek wrote:
> Hi!
> 
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove assignment here.
> > 
> > For the details one may look into the of_gpio_dev_init()
> > implementation.
> 
> So... where do you see of_gpio_dev_init called in this particular
> case?

Inside GPIO library as stated in the commit message.

  --> tca6507_probe_gpios()
    --> gpiochip_add_data()
      --> gpiochip_add_data_with_key()
        --> of_gpio_dev_init()


-- 
With Best Regards,
Andy Shevchenko


