Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B595AFD06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIGHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIGHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:01:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E986FF2;
        Wed,  7 Sep 2022 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534117; x=1694070117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x/ZWYJdUB33uoLU6Tx0MNGsD3ZMVNIWwxXsm0eirUa8=;
  b=jTk7iWwM99zn+M6LdKU2iNBxi0Oe2ite2ibUs/D0lS0+Q0tYYll1iFwy
   YZckQicQWDl9RE91g+8SXDzBBGUH2zYaj2mUwuDKrYqC37BJINx+zeN3S
   PPIifT5wnx9PJxuHC7u+nZcdyYc2KTZEhg9ORNxA20lzjIt1/Er5cIiRw
   LFA0ypsDJ9Gajh7ZnfHEtUhk8a1x54y/AljbxNKfE0UZt+tuDYNKGLePD
   GhS97unpJyNDN/dpKZK+nFss+1pvzstaOYVx55GkwCyP0zrjJVfDk842S
   T1SsUlWHUr5sRCH76EZiNich8REvntMMJwQkaGKMJm/Dk2KNcEdzsg+4S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358514498"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="358514498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:01:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676050658"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:01:54 -0700
Message-ID: <8a4ae419-c5f8-fe2d-7513-faa4e24656fd@intel.com>
Date:   Wed, 7 Sep 2022 10:01:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH Vx 5/5] mmc: sdhci: Fix host->cmd is null
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, lzx.stg@gmail.com
References: <20220907035847.13783-1-wenchao.chen666@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220907035847.13783-1-wenchao.chen666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know what is going on with the "Vx 5/5"?  Ignoring it.

On 7/09/22 06:58, Wenchao Chen wrote:
> From: Wenchao Chen <wenchao.chen@unisoc.com>
> 
> When data crc occurs, the kernel will panic because host->cmd is null.
> 

Fixes: efe8f5c9b5e1 ("mmc: sdhci: Capture eMMC and SD card errors")

> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Cc: stable@vger.kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffe..2511728 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -		if (!mmc_op_tuning(host->cmd->opcode))
> +		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>  			sdhci_err_stats_inc(host, CMD_CRC);
>  	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> @@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -		if (!mmc_op_tuning(host->cmd->opcode))
> +		if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>  			sdhci_err_stats_inc(host, DAT_CRC);
>  	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;

