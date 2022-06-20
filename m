Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5A551629
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiFTKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbiFTKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:44:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E513F3D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721875; x=1687257875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xvsOTELv8MJG/5HFmG/TU/grmUBnZPStDe6N1zoGGIs=;
  b=BUqRdE2YjGUAPc+lDIxE2g2W4n0fMjVBOYomsahXTlXCVh1V9hLwJETe
   Hj2oMkjtm7HATRuqprTVwwAA15zuNHLDG11osaQZj7WykCN1aavp+3AWn
   1cVdbQqpsTDx+59j9GtISKXy+dxx1+YwLu5L/mh//hmNpejOYjJvyzRGO
   b99UCvYK+E/SIU9fKbTLCXLjJxYr3bwNjRp8YGtLj+eHvb3Gygd8hN2lh
   BJcHy802UDOALcPe/IfSBelVuDbiS2jDr1QGjEM8ZrHAfHs135nd0SFEq
   aOm3P+eQP9NN7jF/8xFE+BySFjGLkqY5aaoCwGlGI62hT+8rcdcgr7Fdn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="366187377"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="366187377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:44:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="729321974"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:44:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3EtT-000kHN-7e;
        Mon, 20 Jun 2022 13:44:31 +0300
Date:   Mon, 20 Jun 2022 13:44:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YrBPjzOaAjqSZBqD@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <f000cf13-5e73-3c76-700c-a087954d4050@redhat.com>
 <YrBA+XOzefxSfi72@smile.fi.intel.com>
 <ff5ac808-fde9-57ee-7d47-a4999428210e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5ac808-fde9-57ee-7d47-a4999428210e@redhat.com>
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

On Mon, Jun 20, 2022 at 12:00:35PM +0200, Hans de Goede wrote:
> On 6/20/22 11:42, Andy Shevchenko wrote:
> > On Mon, Jun 20, 2022 at 10:51:33AM +0200, Hans de Goede wrote:

...

> >> Maybe do a follow up renaming CONFIG_INTEL_SOC_PMIC to
> >> CONFIG_INTEL_SOC_PMIC_CRC and also change the module name
> >> from intel-soc-pmic to intel-soc-pmic-crc ?
> > 
> > I thought about that, but decided to leave it for later since it will take a
> > lot of subsystems and better to be considered out of the scope of this series.
> > 
> > Do you agree?
> 
> Sure we can do this later. Note that there are not that much dependencies
> on INTEL_SOC_PMIC though. The ones which I could find are:
> 
> drivers/usb/typec/tcpm/Kconfig: config TYPEC_WCOVE
> -which is wrong regardless of the rename and should just be dropped
>  in a separate/unrelated patch. can you submit a patch for this ?

Sure...

Done!

> drivers/gpio/Kconfig: config GPIO_CRYSTAL_COVE
> drivers/pwm/Kconfig: config PWM_CRC
> drivers/acpi/pmic/Kconfig: config BYTCRC_PMIC_OPREGION &&
>                            config CHTCRC_PMIC_OPREGION
> 
> So not that much, but still 3 subystems, so yeah probably best
> to do that cleanup later,

Yup, let's do it later with Type-C fix in mind, that will save us
doing unneeded churn.

-- 
With Best Regards,
Andy Shevchenko


