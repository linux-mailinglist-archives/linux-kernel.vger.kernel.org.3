Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0745AEDA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiIFOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiIFOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:38:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82DD81B0C;
        Tue,  6 Sep 2022 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662472813; x=1694008813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jgV2lWWjq/uG5FoAvxLpsU0/ppNVg7RQVY9CZ4CndCM=;
  b=QWsTLFVxvCrEHGn/8G/cudWmai0MRXrAoPO4oM78wCo8l/T7De7eXIQ3
   Nghz1yCicOk1AMt3hbjBfNF2JQH+8IQzW5yahhwWKtflQpFVCeIT7x0dw
   jauZd+d1Gg7b50aayw4qVOHIWWo8cbo2crFXDHIouHyyDlmTBmkrxsz0s
   vcCrRoH9vMrtID2rsvTXAAkS9VVlS4s/DPT088H5rCHY+An6RQpZWHTLS
   9TGkjcT89Ra3QU8JnV0mki0GAX+iQdX3PDiqUiRaGerFgRDE5I8VNc3Ds
   iNNTGIJl5fOnE2Ty0b7hc/mRCtNww1EJeb5W3HK0vBLLKzWSNa24adv0O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279612176"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279612176"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:57:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565100120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:57:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVZ51-009909-1d;
        Tue, 06 Sep 2022 16:57:31 +0300
Date:   Tue, 6 Sep 2022 16:57:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <YxdRy5NRRUkXU156@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:07:13PM +0300, Andy Shevchenko wrote:
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.

Anything I should have done for this to be applied?

-- 
With Best Regards,
Andy Shevchenko


