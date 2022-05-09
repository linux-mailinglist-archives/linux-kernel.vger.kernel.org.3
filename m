Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2951F890
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiEIJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiEIJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:32:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516921F1D5;
        Mon,  9 May 2022 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652088485; x=1683624485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jHBUo4IZJ5wDgySYfLtBXCx8yanDJE1x8luvraGTq3g=;
  b=eBgGESmPtUGKX4Ua1nLk8xyHy3ThqikCqvef31goIy7xKxE1Heu5xElV
   b/MoBfpReuqi9Y94DPJp9SpBTdCo331YXkA0r9Bi/ox7IMX/4R57F/YE0
   KGrfCZ4EO7AVBc2AU8MRXXni/XNd8PaRZsFYZ4PLDR2mZzt21agtFcgZ/
   wlhCzen/FAmPyS81HY4+ExjrKE7jKSciFI29DLD3qD61grAMeRiYnpQdU
   PoNde65JV7mfhXDMU9MmcYMcQohn4X5HBC410Xaa6XWA8+bscb1Xf74/+
   ph2SGjPWzc1SPWr113tQQ7CbwBAS5f8XkiXakC4g4qXlderFF1vwImii9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="249531814"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="249531814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:28:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="550934317"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:28:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nnzgN-00DrIB-Q6;
        Mon, 09 May 2022 12:27:59 +0300
Date:   Mon, 9 May 2022 12:27:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fabien DESSENNE <fabien.dessenne@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: stm32: Unshadow np variable in
 stm32_pctl_probe()
Message-ID: <YnjenwfMd6zttOOA@smile.fi.intel.com>
References: <20220507102257.26414-1-andriy.shevchenko@linux.intel.com>
 <30a2c669-693f-45ec-df0e-610e1f94bffd@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a2c669-693f-45ec-df0e-610e1f94bffd@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:39:57AM +0200, Fabien DESSENNE wrote:
> Hi Andy
> 
> 
> Thank you for the patch.
> 
> Will this patch be applied in Linus pinctrl tree, or in the gpio-intel tree
> before being merged (linux-next) in the pinctrl tree?

I believe the pin control tree is a primary here, while applying to GPIO tree
won't harm. But I maintain neither of them :-)

> On 07/05/2022 12:22, Andy Shevchenko wrote:
> > The np variable is used globally for stm32_pctl_probe() and in one of
> > its code branches. cppcheck is not happy with that:
> > 
> >    pinctrl-stm32.c:1530:23: warning: Local variable 'np' shadows outer variable [shadowVariable]
> > 
> > Instead of simply renaming one of the variables convert some code to
> > use a device pointer directly.
> > 
> > Fixes: bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() helper")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


