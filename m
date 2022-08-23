Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B7159E7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245451AbiHWQrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbiHWQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF05642D4;
        Tue, 23 Aug 2022 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264835; x=1692800835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o03KNF4optRGN8k8KrM3fNHOVsntLtSO9eiF32f+P90=;
  b=XNBttPnebLQGcpd4Zg14yZ67I2V5r9gu6d7NYYuA9vbNL5VOKtJt4mIx
   9BrspBgM/axhFt+62VKEmj71So8nPOz/az6PEN9eof5Gfu5L762Yhx6BI
   O1mybXgjFA6YkvFGljJgSW+V3aHd2z8DHAEGhVWM99Y+CKQ9tuF7s8fOZ
   BO5QBV5w6vaBD4XXPVcC2dqVzNurzM8eZLz9VBF1tVXAu/YpvlrZUbUBz
   4Ddr7LL/4Wgpe8cxNDKWKnYHyn1hX4JXbXJYt67nqJnxClc0kBqdJV5xV
   vN6TQrCXXKJUbbAeYAGtMFPkoGC3oBM/Qed9e2NU5HbVF8IpUqIoKjPcm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="273452600"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="273452600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:27:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="612422383"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:26:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUro-002TUD-01;
        Tue, 23 Aug 2022 17:26:56 +0300
Date:   Tue, 23 Aug 2022 17:26:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ads7846: fix support for ADS7845
Message-ID: <YwTjr3091RYewcgp@smile.fi.intel.com>
References: <20220812084248.9270-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812084248.9270-1-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 10:42:45AM +0200, Luca Ellero wrote:
> ADS7845 support is buggy in this driver.
> These patches fix various issues to get it work properly.

Don't remember if I given a tag already (note, it's contributor's
responsibility to carry tags if received), so here it is:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Changes for v2:
>  - add missing period in patch 0001 message
>  - elaborate comment in patch 0002
>  
> Changes for v3:
>  - send from the same email address of "Signed-off"
> 
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


