Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB464EF909
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbiDARjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbiDARjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:39:17 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706C20A96C;
        Fri,  1 Apr 2022 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648834647; x=1680370647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tWYhwZNDUcxCpd1s+9Q7UujJtONrw/WOyrIwvHKdDq0=;
  b=ghyk0aulfNpldHMoEBBcmdWScFxssN4aSpyFISPkVuliUKWITYaeiBPT
   /MdbgdJSG3HvflF61bAc6oG2OQxXseV9nflLfHrYxvws497lW4Lf5wJI6
   PZFLhyIA5Hxb6N9AwCtuWYXoddo5uaRPaP7qwIUTapHioo/ZfYrPnw2fo
   wCfZLqxl/QgIrZTA+u/FWhhAr7ENOzWQ4+2E7h0ccOHH1LkDyKlOE46rO
   EtR6cOqyNugQbpBlOtGv49BL1yZBDbpQ1Y0AfHoMNhgf2m3vFyAbnNMdq
   2eX0ogxuUFbvn/pYSfqh19GoshqBqQhgbdc0t0aKW7xjw1JMGMmz1GRje
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320891977"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="320891977"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:37:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="504243961"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 10:37:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1naLCL-00Aq8N-A4;
        Fri, 01 Apr 2022 20:36:33 +0300
Date:   Fri, 1 Apr 2022 20:36:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        ulf.hansson@linaro.org, cai.huoqing@linux.dev, bbasu@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3] soc/tegra: pmc: update Tegra234 reset sources
Message-ID: <Ykc4IBtQK1voGTGL@smile.fi.intel.com>
References: <20220401143343.31989-1-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401143343.31989-1-spatra@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 08:03:43PM +0530, Sandipan Patra wrote:
> Reset_sources list is updated to add all reset sources
> and removing ones that do not actually exist.

This LGTM, but I am not a maintainer.
So, if it helps and FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> Update on V3 patch:
>     Added more frequent comments to specify every 8 offsets
> Update on V2 patch:
>     space inside comment and
>     Changed decimal to hexadecimal notation in the comments.
> 
>  drivers/soc/tegra/pmc.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index fdf508e03400..c01db5309b5e 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -3766,7 +3766,7 @@ static const struct tegra_pmc_regs tegra234_pmc_regs = {
>  };
>  
>  static const char * const tegra234_reset_sources[] = {
> -	"SYS_RESET_N",
> +	"SYS_RESET_N",	/* 0x0 */
>  	"AOWDT",
>  	"BCCPLEXWDT",
>  	"BPMPWDT",
> @@ -3774,19 +3774,36 @@ static const char * const tegra234_reset_sources[] = {
>  	"SPEWDT",
>  	"APEWDT",
>  	"LCCPLEXWDT",
> -	"SENSOR",
> -	"AOTAG",
> -	"VFSENSOR",
> +	"SENSOR",	/* 0x8 */
> +	NULL,
> +	NULL,
>  	"MAINSWRST",
>  	"SC7",
>  	"HSM",
> -	"CSITE",
> +	NULL,
>  	"RCEWDT",
> -	"PVA0WDT",
> -	"PVA1WDT",
> -	"L1A_ASYNC",
> +	NULL,		/* 0x10 */
> +	NULL,
> +	NULL,
>  	"BPMPBOOT",
>  	"FUSECRC",
> +	"DCEWDT",
> +	"PSCWDT",
> +	"PSC",
> +	"CSITE_SW",	/* 0x18 */
> +	"POD",
> +	"SCPM",
> +	"VREFRO_POWERBAD",
> +	"VMON",
> +	"FMON",
> +	"FSI_R5WDT",
> +	"FSI_THERM",
> +	"FSI_R52C0WDT",	/* 0x20 */
> +	"FSI_R52C1WDT",
> +	"FSI_R52C2WDT",
> +	"FSI_R52C3WDT",
> +	"FSI_FMON",
> +	"FSI_VMON",	/* 0x25 */
>  };
>  
>  static const struct tegra_wake_event tegra234_wake_events[] = {
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


