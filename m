Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5E5A7FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiHaORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHaORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:17:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE466D571
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955435; x=1693491435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4beRg6Cetprg6JFKFTkYoowu4k9VoIgt4AHQU63J3w=;
  b=Gjcv/cgc2NlwPd/neF+B9LwYUR8j8Qp+7o/Ug1aMd9tFmrvwsCTFyIMN
   32mAbi2uqZb5yF4XbIh+prPpzzYwkTQ/li60Ab/wvNrCGCCGFY7sy8XXg
   CwgJPysOG8V9zxjkJUVo4gsLIzjgXiqGOs1CT5V6ciVqAgjMRZT4lhdHw
   bHq/t/qu05QaJ+GIRHmNmuAhQK06FFuCIJbGal2J2vNzcsP7YgiJ/EV4R
   IdWZE6hpbzugw8SlALPTNuvQiJebLw+YjNi7v9AaTYWQfdGBv5GWsdGGw
   GO1VE0xJ4CFMmFNAP9hHO+dy9XWwB48vCnIItH7470E3lAWKJDOp+dr4f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296240930"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296240930"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:17:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="701372873"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:16:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTOWK-006PfW-1u;
        Wed, 31 Aug 2022 17:16:44 +0300
Date:   Wed, 31 Aug 2022 17:16:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make it
 more readable
Message-ID: <Yw9tTD1Qt6LG25bX@smile.fi.intel.com>
References: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 08:05:42PM +0300, Andy Shevchenko wrote:
> Converting fwnode_pointer() to use better swnode API allows to
> make code more readable.
> 
> While at it, rename full_name to full_name_third to show exact
> relation in the hierarchy.

Any comments?

Note, I would like to reduce exported swnode APIs and this will
help to do so.

-- 
With Best Regards,
Andy Shevchenko


