Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA6467B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353044AbhLCQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:30:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:2762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234626AbhLCQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:30:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="323258721"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="323258721"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 08:26:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="678146833"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 08:26:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mtBNb-001pDg-LZ;
        Fri, 03 Dec 2021 18:25:47 +0200
Date:   Fri, 3 Dec 2021 18:25:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate
 of_node assignment
Message-ID: <YapFC9ksQmGy6llL@smile.fi.intel.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
 <1a2831d2-49bb-f1fc-14e8-d6a0d53664cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a2831d2-49bb-f1fc-14e8-d6a0d53664cf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:45:31PM +0200, Péter Ujfalusi wrote:
> On 02/12/2021 22:56, Andy Shevchenko wrote:
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove assignment here.
> 
> Thanks, looks good,
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Thanks!

> > For the details one may look into the of_gpio_dev_init() implementation.
> 
> Which works after commit 1df62542e0161.

Actually even before that.

-- 
With Best Regards,
Andy Shevchenko


