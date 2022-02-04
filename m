Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2724A9527
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357026AbiBDIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:32:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:32448 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbiBDIcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643963571; x=1675499571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ya+H/qbBKwEDidorAqx+h4Eq4WDFhmNIIGAdgynX4iU=;
  b=P84oKcn7OlrysGNQ1lJaWfegPSISPTkQYVNosi+Uf3Tfb4jQXHKRxeFA
   devRk6FU1rY+dLg1WkX7tZukFYcr0cHzWtHx2U6VjvgCQJPJKfwmHmKqF
   3YDr0KGe73jaPYiubi1dMFDmKNTWaoyYHF0LgwsV2nnK41F/aeMV5+0lK
   GzO25kVqp+DPpHadNWwUW/m+FZ3/+hm5WYIE5crWt9ZFQbfdDnvrXErhJ
   +VID1vU6X6BG7uODSP0mtBG7x0QJyCIKX4XvAWJ3eayCVMBv60fEelm/I
   4hOUplVHXTphqV9Qq2ugUfMH/QNiEBpAg5Eh5UrOGUJhe1kZmArsJwV/a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228304845"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="228304845"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 00:32:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="769900920"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 00:32:29 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C78E6204FB;
        Fri,  4 Feb 2022 10:32:27 +0200 (EET)
Date:   Fri, 4 Feb 2022 10:32:27 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Don't split fwnode_get_irq*()
 APIs in the code
Message-ID: <Yfzkm1CVNNRqHzd7@paasikivi.fi.intel.com>
References: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203125613.1166-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Feb 03, 2022 at 02:56:13PM +0200, Andy Shevchenko wrote:
> New fwnode_get_irq_byname() landed after an unrelated function
> by ordering. Move fwnode_iomap(), so fwnode_get_irq*() APIs will
> go together.
> 
> No functional change intended.

I have no problem with the patch as such, but I have four patches moving
the implementation of this and other similar functions to OF and ACPI
frameworks. I moved what was here to OF/ACPI FWs as part of the fwnode
graph API implementation but some firmware type checks have crept back in
since that.

I'd prefer to prepend this patch to the rest of the set I have and get it
all merged through linux-pm tree, on the dependent patch reaches it.

-- 
Kind regards,

Sakari Ailus
