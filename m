Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53543506B55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiDSLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351945AbiDSLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:48:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA833A02;
        Tue, 19 Apr 2022 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650368737; x=1681904737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nXvv6I9Mx8UNUdA9ZNMVZJ7CfWBPlua0s960ddgVcJg=;
  b=FAOAPsts2aKfr5nszOcU/5R42dPnM4r+jQLPGKo7+xVD6Nvt31H8nEsa
   pgD9fV3NTo46QChiYabNl7oxDX+EaZX/U62iIxOdrekKrWRBsFxE+z3Cn
   MNBt/XMp8ODd4CPH3SDA/Klxmo6eRCbYMAnI2uLUxAG11KuBj0xYC7LXJ
   hy+3hdcACRS/epfIH+xDpRyN3x3lRcXPXYoHuCWTZ3ziiXAwHY2t+tdui
   BXMj+lOt34PlS8srJ7RpU1Wjme9pxSYke6EgoA2gBoZwXDG72hjXYzy9X
   id64xZbX3pLadRmiAJZNd25Z9G1GtPBxBpI00ZsOxBgRh6enFsAE6sFsB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326642928"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="326642928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 04:45:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576062896"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.44.237])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 04:45:32 -0700
Message-ID: <19948f89-80fe-a726-2a03-db16bf5d66ef@intel.com>
Date:   Tue, 19 Apr 2022 14:45:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: A workaround to allow GL9755
 to enter ASPM L1.2
Content-Language: en-US
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     SeanHY.Chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20220414094945.457500-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220414094945.457500-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/22 12:49, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> When GL9755 enters ASPM L1 sub-states, it will stay at L1.1 and will not
> enter L1.2. The workaround is to toggle PM state to allow GL9755 to enter
> ASPM L1.2.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..52230857388f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -137,6 +137,9 @@
>  #define PCI_GLI_9755_SerDes  0x70
>  #define PCI_GLI_9755_SCP_DIS   BIT(19)
>  
> +#define PCI_GLI_9755_PM_CTRL     0xFC
> +#define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>  
>  /* Genesys Logic chipset */
> @@ -597,6 +600,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  			    GLI_9755_CFG2_L1DLY_VALUE);
>  	pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
>  
> +	/* toggle PM state to allow GL9755 to enter ASPM L1.2 */
> +	pci_read_config_dword(pdev, PCI_GLI_9755_PM_CTRL, &value);
> +	value |= PCI_GLI_9755_PM_STATE;
> +	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> +	value &= ~PCI_GLI_9755_PM_STATE;
> +	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> +
>  	gl9755_wt_off(pdev);
>  }
>  

