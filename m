Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B87B4A874E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351670AbiBCPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:10:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:11960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235565AbiBCPKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643901005; x=1675437005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KkQWMRG/BiG6x1on16dg0jKvrMttocgOupcE3YPxgZE=;
  b=ThXTynC9l90188k44Ym6sXR3LtYnwpcfSlxFqjG5/AI3x5Jiz9vkkgqz
   CAuZYFPmNU8+4z0x5Oqr3w8OIMMXHVMsVLy2AfEYWDQ0ePc+cMCLUmdHv
   HBXuyt3hbUrm3iwJiaCKN6fH0a1Ya1CScXu2SSognidTUYJPm2hlLcIdW
   vkRhotxBPf4maGkJk1gArgjLznf1eB0V3x30vLuwxc8j1pfyUv744wj3d
   8VKOMT96/5OQoNDeFDtobOHnBew7Y8+rYBSOV19C5/pxFv4HwS5eElsGb
   p8IEsh22eOwsvRCyvuCbyYfb3+RdX6SckMIin5J/pZS1yUnae09/f0k0C
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248375516"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248375516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:10:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="483264177"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:10:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFdjL-000S1G-8L;
        Thu, 03 Feb 2022 17:09:03 +0200
Date:   Thu, 3 Feb 2022 17:09:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <lasaine@lvk.cs.msu.su>
Subject: Re: [PATCH v2 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <YfvwDg3juv5k9OUA@smile.fi.intel.com>
References: <20211001150316.12545-1-andriy.shevchenko@linux.intel.com>
 <bd72ecdb-7d7c-726d-85a4-84ea1088eb70@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd72ecdb-7d7c-726d-85a4-84ea1088eb70@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:54:50AM +0200, Rodolfo Giometti wrote:
> On 01/10/21 17:03, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Thanks!

I believe you should send this to Greg. I don't see that his name popped up
in the Cc list (which is generated from MAINTAINERS).

-- 
With Best Regards,
Andy Shevchenko


