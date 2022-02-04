Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C354A9A23
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358921AbiBDNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:41:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:38991 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbiBDNlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643982104; x=1675518104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCLtfGRdg2eK4tCTVwB9mnCFieiupKXpacDs0E7kFjI=;
  b=dmTtFB0Ld+cgxGJ3Qg9rRUdq5MaAXfF7Vmzau4tVvhLl3B+FPkqSaLpF
   xU0bgiQS9k83P2aBV/V6NsIxxGe/HOHChmBlAjbtkfYi9j3cCMjBqazLB
   krcdYDq38iUNRDsCrfcd03u06Lk8u7VguEl2/375osNLqSXZYpBNVM/g9
   ChU+LC+uUn/fF2syHPv4BBJ9p1YQy01MpXquz3LQVkAxWXSb+y5xWItxu
   /Ck+f0F1EGJ0koN6/Ev97JgcanTbKIeTpsPPjjVJVEatBw/nMKkZ9Ghbk
   b6DUHVkhWcS+nGh19R9wz6UFKNqISxEDwJpYjCJ5zikMGYznCwR6nklQW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248580848"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248580848"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:41:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="631705313"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:41:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFypI-000nqd-7l;
        Fri, 04 Feb 2022 15:40:36 +0200
Date:   Fri, 4 Feb 2022 15:40:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Don't split fwnode_get_irq*()
 APIs in the code
Message-ID: <Yf0s0/JjSKx/R4Ww@smile.fi.intel.com>
References: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
 <Yfzkm1CVNNRqHzd7@paasikivi.fi.intel.com>
 <Yfz0v7oqDkgfZyky@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfz0v7oqDkgfZyky@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:41:19AM +0200, Sakari Ailus wrote:
> On Fri, Feb 04, 2022 at 10:32:27AM +0200, Sakari Ailus wrote:
> > I'd prefer to prepend this patch to the rest of the set I have and get it
> > all merged through linux-pm tree, on the dependent patch reaches it.
> 
> I rebased mine on this patch and I was quite surprised to see it doesn't
> conflict! So either way works fine for me.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you, Sakari!

-- 
With Best Regards,
Andy Shevchenko


