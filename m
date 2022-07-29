Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D0585128
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiG2NxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiG2Nw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:52:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565F4E629;
        Fri, 29 Jul 2022 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659102776; x=1690638776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T4oYnFR8eMrAv8J1qLxL2Fa4Ck7WG4S9YZv0+0Ue2UQ=;
  b=EwjtTRdo5a5NXdTWRyrlBSGykkFqsWTCcBO3zdO+lFdPxhHMDtQ1z/eI
   COEIyOhlxzk0w8pYnStKzvQtW1d/1Y97njrI86L4xeC/vBLGJQmyOlJSe
   ZgoZ4q/Iel7K2ddERPADog1ikzAMgaX/GeBRQGhXTbnOXM0wnbO0v0iB8
   loPhgcvNha+EYPMjh2dIddSM7CZacPK4KFBUYoJmR0wazMBB1zd4ot0Bn
   Hl+xOrvJfCFEzNH5WU3/w1sul/YiLVsFJYJpY8juO7gf+sQL9spQNaoqM
   gqURG9s+eJyDj++5lYOUji8crDjueUuPHq3AumpBKKf0SNt7P9xkI4ds7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="352767446"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="352767446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:52:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="601292708"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:52:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHQQ6-001eY1-2u;
        Fri, 29 Jul 2022 16:52:50 +0300
Date:   Fri, 29 Jul 2022 16:52:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3]  ads7846: fix support for ADS7845
Message-ID: <YuPmMlq2+dvb8N+2@smile.fi.intel.com>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:34:55AM +0200, Luca Ellero wrote:
> ADS7845 support is buggy in this driver.
> These patches fix various issues to get it work properly.
> 
> Changes for v2:
>  - add missing period in patch 0001 message
>  - elaborate comment in patch 0002

All three looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Luca Ellero (3):
>   ads7846: don't report pressure for ads7845
>   ads7846: always set last command to PWRDOWN
>   ads7846: don't check penirq immediately for 7845
> 
>  drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


