Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FEA4EDB56
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiCaOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCaOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:09:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31917ECE0;
        Thu, 31 Mar 2022 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648735641; x=1680271641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yifzU5rFm1OtJGITqIk6n5GweD95AgrLZBnlElGXMcU=;
  b=MQRNxdhfqbN1QY0EmIi9Ydr4yVNSrAq3OEfBqPApMs318YgkqVvAvTgz
   yyYcMhceLqE5Rr2WIJtkiaP2IcJ6ikryYxUTrI475/1OSGD5FGGw3LIW+
   /zsdhMFOjU+8Bv2otou6N2f0zmb2LPhJusVaWjnEivlbUFqgAQ0VPjQ4C
   zbI8wM9Ymq/bwxhAT5ji7iwPUO6hdxG5i6kfs/2buq7rH4/CSoRNvGC2C
   GxmnsTptzVrW3PVxYeHKw2+DEJv9MxiSuZYN81kNuWq0Hnq94/RDdQnpl
   hWvFgOqWR7SvC9Sxr0IXiWiUikFfmmYFrF/6Q2EDhMDgkr/cMzTuAoTDH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258677650"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="258677650"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 07:07:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720476243"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 07:07:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZvRd-00A2CN-Ee;
        Thu, 31 Mar 2022 17:06:37 +0300
Date:   Thu, 31 Mar 2022 17:06:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Subject: Re: [PATCH 1/2] mmc: mmc_spi: parse speed mode options
Message-ID: <YkW1beKzd5LfxZgG@smile.fi.intel.com>
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
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

On Thu, Mar 31, 2022 at 07:28:47AM +0000, Christian Löhle wrote:
> Since SD and MMC Highspeed modes are also valid for SPI let's parse
> them too.

Makes sense to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/host/of_mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 3629550528b6..bf54776fb26c 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -70,6 +70,10 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  	} else {
>  		oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
>  	}
> +	if (device_property_read_bool(dev, "cap-sd-highspeed"))
> +		oms->pdata.caps |= MMC_CAP_SD_HIGHSPEED;
> +	if (device_property_read_bool(dev, "cap-mmc-highspeed"))
> +		oms->pdata.caps |= MMC_CAP_MMC_HIGHSPEED;
> 
>  	dev->platform_data = &oms->pdata;
>  	return dev->platform_data;
> --
> 2.34.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 

-- 
With Best Regards,
Andy Shevchenko


