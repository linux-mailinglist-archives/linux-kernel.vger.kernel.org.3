Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26FF5514A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiFTJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbiFTJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:42:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7755E13DFF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718160; x=1687254160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqwcpRJEPXMSpAq5T9rlPN8eIacQEWEJX0zhcrKDNOg=;
  b=BHrUL6Ux0FbIifCoJ6z2NyOZi67Hy57UbzjNiPSo1hL4Kd+K3YPNQGtm
   xzOrisRy3j2tA8HP9FLqFgdMf0kVBOm+GgFQAAkNQlbbBk57mMw2xNai9
   jODUJu5cEimiFHMy4DwbkuoPQ8L0QpIw76vWinveGDZTHel60NS2vIB+T
   Yggsdd1o3UvbvGM85rUtI/pi6oR2ICFG3LVO5/j2R3FVIV5hb2hoGF5/8
   EbxvSQM1FAIVXQly8BuE5VS1qIt24NljNPMTtqhpMhRlACwplInpXqS7b
   JdsMPak6UjNAF4UXnFm2ok2MCj0TM8iqDeEAGCzUSozjFlaau6P5INhTf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280582462"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280582462"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:42:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833035732"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:42:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3DvG-000h2g-6G;
        Mon, 20 Jun 2022 12:42:18 +0300
Date:   Mon, 20 Jun 2022 12:42:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YrBA+XOzefxSfi72@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <f000cf13-5e73-3c76-700c-a087954d4050@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f000cf13-5e73-3c76-700c-a087954d4050@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:51:33AM +0200, Hans de Goede wrote:
> Hi,
> 
> Thank you for this series, cleaning this up is long overdue.
> 
> The entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for the series.

Thanks!

> Maybe do a follow up renaming CONFIG_INTEL_SOC_PMIC to
> CONFIG_INTEL_SOC_PMIC_CRC and also change the module name
> from intel-soc-pmic to intel-soc-pmic-crc ?

I thought about that, but decided to leave it for later since it will take a
lot of subsystems and better to be considered out of the scope of this series.

Do you agree?

> I don't expect any userspace dependencies on the module-name
> (there are no module parameters) so this should be fine.

-- 
With Best Regards,
Andy Shevchenko


