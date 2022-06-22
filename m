Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418AF5546AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355039AbiFVIjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356104AbiFVIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:38:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAD538BC5;
        Wed, 22 Jun 2022 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887118; x=1687423118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E5/CE6oiD+TeTr6UfdQHhOw56DlRLSWQtW65jMArRVY=;
  b=OjxV6xAwvw3V9LzqG32qI/Y0bDxrWo08+yrBc9S8ktvQJw9cMOolr7Eh
   vKSsuM2NuIxLl6GqA5pXohVkHXQCjirL7dCXYqFOx+SdM8F/T7nfdq6fV
   EDYsJAmWcOoexBmz2ZNu/jzvXiCkzAO8onpju04FIPl+VaeKULL9FYWuY
   UG+lWnwLoJIXFiWuOuJZefjib3BzxMFFAE32R6b2zANBzA2LC3dUXkdzj
   2HEzeQ7ukWyb9u/P/GM2aiyuZnpBoF7YKItgWewGeKU9A7yoUoNGe5f9a
   J7W320SIOEjuOtokMcaLoY2E3UIgj3MdUq0w7yvKaUmaM6jSmWnvIfPW5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281430478"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281430478"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:38:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644078281"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:38:36 -0700
Message-ID: <99892edc-fb90-cb68-271b-f978805256e5@intel.com>
Date:   Wed, 22 Jun 2022 11:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc: sdhci-acpi: remove unexpected word "the"
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621094459.80271-1-jiangjian@cdjrlc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220621094459.80271-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/22 12:44, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be removed
> 
> *       instead use the the SDR104 preset register.
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index c0350e9c03f3..93fe6e5a5f9f 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>  	 *       in reading a garbage value and using the wrong presets.
>  	 *
>  	 *       Since HS400 and HS200 presets must be identical, we could
> -	 *       instead use the the SDR104 preset register.
> +	 *       instead use the SDR104 preset register.
>  	 *
>  	 *    If the above issues are resolved we could remove this quirk for
>  	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).

