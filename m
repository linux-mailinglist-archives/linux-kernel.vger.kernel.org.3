Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962E652EDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350166AbiETONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:13:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9AD1271A5;
        Fri, 20 May 2022 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653056016; x=1684592016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L/lmQDzhbd4ivl9WlnPrjIiwo8gtHK4o18nW4N/6hEY=;
  b=aBQeacVUZoIRKf5QEpNy31VVj/o0BlzlFnB/mZ0UaU+vnlpD+B323wzy
   MTUdE/+nvnCDbi+V/K2nQJ8anQuXZfT+2oNp/oo7MXHav8SktSz43d7vk
   dBXbyDn6RfNeAwB6dipPPqXU5ocA7GR2LkCWqDOr2XA5eqqWDaV2Sasx8
   l4urJnZoU9gjrL1f18M1pt3nHIqZcX9uaZwdiBB5MMZdLZ20GOiw04pB9
   FQZA3WV/xDMXO8Sw8tKJ/rkrfRy4vsVFTKUQRuyxa9SqKTNJ1eFI/7KE2
   UHPiCM6TkATyKIPkSVR362FsplJ74iM0zM6qGWNP4CuJvee5knHSzRwcV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272323632"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="272323632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:13:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="607031059"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:13:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ns3Nj-000Gpr-RP;
        Fri, 20 May 2022 17:13:31 +0300
Date:   Fri, 20 May 2022 17:13:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Fix kernel doc format, i.e. add
 return sections
Message-ID: <YoeiCzCIBbIJhRsB@smile.fi.intel.com>
References: <20220519212645.47177-1-andriy.shevchenko@linux.intel.com>
 <YodYCMgqI9GznHeo@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YodYCMgqI9GznHeo@lahna>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:57:44AM +0300, Mika Westerberg wrote:
> On Fri, May 20, 2022 at 12:26:45AM +0300, Andy Shevchenko wrote:
> > Kernel doc validator is not happy:
> > 
> >   pinctrl-intel.c:865: warning: No description found for return value of 'intel_gpio_to_pin'
> >   pinctrl-intel.c:904: warning: No description found for return value of 'intel_pin_to_gpio'
> >   2 warnings
> > 
> > Add return sections to the kernel documentation of the above mentioned
> > functions.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!


-- 
With Best Regards,
Andy Shevchenko


