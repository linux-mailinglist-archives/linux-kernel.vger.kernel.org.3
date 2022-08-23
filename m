Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9E59E85F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbiHWRBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbiHWQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8057CC2766;
        Tue, 23 Aug 2022 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264029; x=1692800029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7APbvX2V8uAvesMiYvjU1K7Y7LesFT1rI+JPouLO254=;
  b=bY2blsMw1SZqai+YTHYcfeTOeGNyfdQ0qomYKxFwvjpHI9fof6UtLWTE
   iGZvrfFuCjIDR9r6VJvvPW1VPho0AIVCNiXZaJFfBcOQY/8aZzq2t1oSq
   BaaN1t/1Xa2boIqPqfAmez3NpOhzAy3p4U20/Q6MAIEf9fv0Y8BN6K7vl
   wVmomaAmqZtATKUeCUCkLFJ2gIOQc4+1NZAvmXZSb/Q0D2AhxwlcMfVgx
   inTOJKkhs3Li5uMPj0Z1ch4DvYIKkq+ikOzac9oBrqgfAx5A2y61/EUFS
   udGB/Vyov56AAHVPHx3iWIaGZRc89Ktiqrg2xXH0eO+9/mRkfBui0hcje
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="379986975"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="379986975"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:13:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="612419046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:13:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUf3-002TBG-1W;
        Tue, 23 Aug 2022 17:13:45 +0300
Date:   Tue, 23 Aug 2022 17:13:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
 providing driver
Message-ID: <YwTgmSwTo8d3ihWj@smile.fi.intel.com>
References: <20220805120343.5027-1-henning.schild@siemens.com>
 <20220805141920.78967d15@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805141920.78967d15@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 02:19:20PM +0200, Henning Schild wrote:
> This applies on top of
> "[PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper"
> 
> where it could also be squashed into p12.

Can't be squashed, since P2SB series is now part of upstream.

-- 
With Best Regards,
Andy Shevchenko


