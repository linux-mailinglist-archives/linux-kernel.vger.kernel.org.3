Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2035C524981
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352315AbiELJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352347AbiELJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:53:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515BA41F8E;
        Thu, 12 May 2022 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652349219; x=1683885219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4TYar24BS8z9BAEdBn2NWcy025EmsZ82r5lezSySu8=;
  b=gOhDad7JLC8IR+xec1QWxVlbnWv7InnjEcmEX67BwimGj6JT3o2+gwje
   yoVnuaVuHAvHFDvorHdz3L0dvTf+b6E0vZyI1xv7GTGnDkkfYJDpmt96q
   U+x+gtywUv6QvTLo/bqm01qTQQiqdQAYmkGR7Yi9lI9MYi8JOXHeCSCQ9
   U8BKgn4exzFcMxvzmmwHbzqjTDhWGSYuHaG+jP/OtcPucsWK6C4DbmIu/
   dS+AZJGO+lIyxfO8PNifROJjLvi4BQLIDUaOpKUV7gGQozsanru1hE/7A
   aF8LRP3lcjs3M2FEce4O4reuINlHR1RvpTnYtNSCWL8kjFDwi65/Qau/8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267538153"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="267538153"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:53:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="739621649"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 02:53:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1np5Vm-00F9k1-2I;
        Thu, 12 May 2022 12:53:34 +0300
Date:   Thu, 12 May 2022 12:53:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: broxton: Add module alias for Intel
 Apollo Lake
Message-ID: <YnzZHTNEOglqkiCh@smile.fi.intel.com>
References: <20220511123421.88439-1-andriy.shevchenko@linux.intel.com>
 <Ynu3sbnWwQgOUK4H@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynu3sbnWwQgOUK4H@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 04:18:41PM +0300, Mika Westerberg wrote:
> On Wed, May 11, 2022 at 03:34:21PM +0300, Andy Shevchenko wrote:
> > We have platform device IDs for Broxton and Apollo Lake, but
> > module alias is provided only for the former. Make it consistent
> > by providing an alias for Apollo Lake.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko


