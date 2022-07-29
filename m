Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B96584DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiG2Its (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiG2Itq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:49:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD677A5D;
        Fri, 29 Jul 2022 01:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659084585; x=1690620585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fKTCNCY3yUBltG+96gLo8Nmj+3drJD5/kMapSzBWqjk=;
  b=kXcCp2rw+Y/6JzqD0gPg9iwxfxu74rHAE1sM20jA32BtI1OxsM40fgLt
   +CNQcq0iOtAIRXVHAHUwo1LwUBKqwOLd91G1/2HTRVw7uLbYzwyVH464S
   qd0hHVfpgvmf5JDDdLrWoNIV1l3/LqDRKCon9sOO5yyR18qIS4evfH+sr
   6NltFJy26BKRvGPvRDOzcdSIVDxhCKHxrzykVjI1u4l+wYYyldAPQyqNZ
   uC1TEEqx3/JSNJg7m86GM4p3dyNL489Sn3y/9iys0CRAS1hmae9stKvzq
   NMAszfY/VjkCipkj1mxbjFzNfKv9JEs3KU/aVDvhnWWxmtaYW/bGB4hVf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="275610155"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="275610155"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 01:49:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="629299371"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 01:49:42 -0700
Message-ID: <c297fc36-5d0e-6c89-af4a-0d63977811c4@intel.com>
Date:   Fri, 29 Jul 2022 11:49:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix some SD cards
 compatibility issue at ddr50 mode
Content-Language: en-US
To:     Chevron Li <chevron.li@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, shirley.her@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com
References: <20220727033123.304-1-chevron.li@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220727033123.304-1-chevron.li@bayhubtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/22 06:31, Chevron Li wrote:
> Bayhub chips have better compatibility support for sdr50 than ddr50

Upper case would be better for SDR50 and DDR50

> and both mode have the same R/W performance.

Only if the max frequency is 100 MHz.  Is that always the case?

Perhaps comment on that in the commit message.

> Disable ddr50 mode and use sdr50 instead.

Upper case would be better for SDR50 and DDR50

> 
> Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>

For neatness, a space before "<" above would be better, and
also a space after ":" in the subject

> ---
> Changes on V1:
> 1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
> 2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 0d4d343dbb77..ad457cd9cbaa 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -317,11 +317,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	u32 reg_val;
>  
>  	/*
> -	 * This handler only implements the eMMC tuning that is specific to
> +	 * This handler implements the hardware tuning that is specific to
>  	 * this controller.  Fall back to the standard method for other TIMING.
>  	 */
>  	if ((host->timing != MMC_TIMING_MMC_HS200) &&
> -		(host->timing != MMC_TIMING_UHS_SDR104))
> +		(host->timing != MMC_TIMING_UHS_SDR104) &&
> +		(host->timing != MMC_TIMING_UHS_SDR50))
>  		return sdhci_execute_tuning(mmc, opcode);
>  
>  	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> @@ -631,6 +632,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  		if (reg & 0x1)
>  			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>  
> +		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
> +
>  		sdhci_pci_o2_enable_msi(chip, host);
>  
>  		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
> 
> base-commit: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983

