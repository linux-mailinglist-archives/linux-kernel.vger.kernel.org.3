Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337554B4868
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbiBNJxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:53:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiBNJun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:50:43 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62320652FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644831691; x=1676367691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwMG1Msmq7wP+CnyNpGNvaguvuIfnBpNtR58j+TK1TM=;
  b=Wx7kYbW/IAXi+1Hmu7WZosVApnE0vhWi2jxaptgO8G09bykh/fWbKbRZ
   tbpyA+oRxxnxf/dWvQho6iKJ6KlBcJ5Nkhm89ImEwQBIazdbneUQZ3H3I
   VWoaGCVEfi019TnGgkJ0I6jXsnNx7DR52I0Eb6qIYtsQwpc3I2C1OEih5
   VeHw3OOUnPEtPYlc/YkWMviqdFvEgGGUKsJBKkYzPF4KiNaqEMw9yv8l2
   RP1lq2MLGC3pWGhJ9Q0BAXA4y6Cav6ufhhli4FFZ2jAyEZcT6U90AZ19u
   yXIucwrTXtmiuqO3VjazFTSQnbLu7cALLIlXn3XbtDZugPN106irlN4dW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310790582"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="310790582"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:41:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="624081514"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:41:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJXqE-004Odc-E6;
        Mon, 14 Feb 2022 11:40:18 +0200
Date:   Mon, 14 Feb 2022 11:40:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: intel-lpss: Add Intel Raptor Lake PCH-S PCI IDs
Message-ID: <YgojfVd6qVyXl4S4@smile.fi.intel.com>
References: <20220211145055.992179-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211145055.992179-1-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 04:50:55PM +0200, Jarkko Nikula wrote:
> Add Intel Raptor Lake PCH-S LPSS PCI IDs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index 5513fae6be92..962ee14c62dd 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -353,6 +353,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
>  	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
>  	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
> +	/* RPL-S */
> +	{ PCI_VDEVICE(INTEL, 0x7a28), (kernel_ulong_t)&bxt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a29), (kernel_ulong_t)&bxt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a2a), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a2b), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a4c), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a4d), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a4e), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a4f), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a5c), (kernel_ulong_t)&bxt_uart_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a79), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a7b), (kernel_ulong_t)&bxt_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a7c), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a7d), (kernel_ulong_t)&bxt_i2c_info },
> +	{ PCI_VDEVICE(INTEL, 0x7a7e), (kernel_ulong_t)&bxt_uart_info },
>  	/* ADL-S */
>  	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
>  	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


