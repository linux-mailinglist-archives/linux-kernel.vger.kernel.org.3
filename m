Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40B15767B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGOTsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGOTsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:48:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A5C624C;
        Fri, 15 Jul 2022 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657914524; x=1689450524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MilUhzh+T5K7OKYmpSSzhAgM8qxY12ZE5AeVvwctYIg=;
  b=ENLwp5TQ06MUqVsAaPm700pEs0mdqrZQRSSeOYviXkBea3L1EvJuaUA4
   O2NB9xVtQg2Uy1Ge6rzaLSe6e3OEjx0+rIBTeQYmVtLuVtyu+ZYz0o/Xl
   w5BJ4tCDrSGmp0Q7aEHLXJKZAFVSOnGVu+wj/xOIu/VxKt/SlYZ436HxY
   o9xZ/rD9gsq2G2XtO+AcBtDzLBTYEdiZ3Q/RTB1jOTctZ4DDsBlvoWmSH
   lTMVnURUMmd75z6VomrkmRW4JWOujgL4Qb8VjKxNWyW5l/UjbZjlk3Klc
   bSXHw4QUpcoG3VtBNHZhpgFZyeVLuUPz9EeifumapwjwZaqhmtO/QlbY5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266298361"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="266298361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:48:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="664319203"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:48:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oCRIl-001JDk-2o;
        Fri, 15 Jul 2022 22:48:39 +0300
Date:   Fri, 15 Jul 2022 22:48:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powercap: RAPL: Add Power Limit4 support for Alder
 Lake-N and Raptor Lake-P
Message-ID: <YtHEl73BL1BRyl9r@smile.fi.intel.com>
References: <20220715165228.28044-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715165228.28044-1-sumeet.r.pawnikar@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:22:28PM +0530, Sumeet Pawnikar wrote:
> Add Alder Lake-N and Raptor Lake-P to the list of processor models
> for which Power Limit4 is supported by the Intel RAPL driver.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You may not convert people's review into a tag without their consent.
But taking into account this is trivial patch, it's fine. Just follow
the rules next time.

Also, where is v1? What are the differences to it?

> ---
>  drivers/powercap/intel_rapl_msr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 9d23984d8931..bc6adda58883 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -140,7 +140,9 @@ static const struct x86_cpu_id pl4_support_ids[] = {
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
>  	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
>  	{}
>  };

-- 
With Best Regards,
Andy Shevchenko


