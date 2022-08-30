Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E75A610C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiH3Kqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiH3Kqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:46:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FEDB062;
        Tue, 30 Aug 2022 03:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661856409; x=1693392409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l1e3sLsvZsD5plicJS6nkkJnl6a8/uElddMk1TkHv64=;
  b=Rh+gNBAhKmafuDgwfvLV/CWLHV1F07+EETgafEjDNn8NswATYiOJip7b
   4Ram4KK7pWSjexFu6k0lXJYV1Kt439ausC8f86qL1uoQTK+hbrEFOn6mA
   FJRkSdj82Q/2U9j8S3EajyHge8Xuow2kApT55lsMHz9kNBKdhUOdPl8Ci
   L2z8af6LE4sJ7k4ldoT8MjpWNUxisD9hcJgeabdaFyh73yKfWTWiKaCU+
   qG6ATR3G3J6Wiq/r9FXejOAtkiuhjJYN2pkZzyn1yWjbKjBRNcFNS721U
   ZTswyfgeA0UefdyhMUAyBeUyPIXLBvz50nttca7MzXwwXPp/teQXX0kKl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295144102"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="295144102"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:46:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672808754"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.185])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:46:30 -0700
Message-ID: <6af830e7-9098-a16c-9af1-957cf38a7b3f@intel.com>
Date:   Tue, 30 Aug 2022 13:46:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] mmc: sdhci_am654: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220830083349.276709-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/22 11:33, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value cqhci_init() directly instead of storing it in another
> redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e7ced1496a07..8f1023480e12 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -554,7 +554,6 @@ static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
>  static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>  {
>  	struct cqhci_host *cq_host;
> -	int ret;
>  
>  	cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
>  			       GFP_KERNEL);
> @@ -568,9 +567,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>  
>  	host->mmc->caps2 |= MMC_CAP2_CQE;
>  
> -	ret = cqhci_init(cq_host, host->mmc, 1);
> -
> -	return ret;
> +	return cqhci_init(cq_host, host->mmc, 1);
>  }
>  
>  static int sdhci_am654_get_otap_delay(struct sdhci_host *host,

