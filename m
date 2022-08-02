Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEB58797B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiHBI7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiHBI7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:59:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B2E81;
        Tue,  2 Aug 2022 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659430776; x=1690966776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rhx2mjzECQhwFJuSSVWaFi/hh3YiP+uH0x/KGzMUvpo=;
  b=RLLqlDlQ3fdJe4ESHaHv8tlbSHK9WEajXcBCmOOSDLOzi5xYvQ14xVXy
   SiqZ9oKN2IZQMKUkvgigBf4vrmaXgYCvXgas7NnB9oQ1skPerZeoK7Z+i
   78rWiG4VFhRInd7HwNzF/Et9bCibRT8IwqSUyQqLVPgMfPChcI7NQwG/x
   YaZaoNg9ivaZw4S7thn8PFEwKdXhWbVBstPd2GBr4p/6yDAdHyHSVXfs7
   wdnJGktx+anyxVIRIhYYIAFtFw/ZwFiaJCWc2GGWNOwY/LxGMT2DVxeQa
   BxF3niZ2xtn26/jimNtD+1cHnO4Pl4A3B5NW9BGYUQX0nUGIoanDqU0rJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="286920956"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="286920956"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 01:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744596705"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2022 01:59:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Aug 2022 11:59:32 +0300
Date:   Tue, 2 Aug 2022 11:59:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rajmohan.mani@intel.com
Subject: Re: [PATCH] usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor
 Lake IOM device
Message-ID: <YujndMdpS+4L0AiL@kuha.fi.intel.com>
References: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Thu, Jul 28, 2022 at 05:30:33PM -0700, Utkarsh Patel wrote:
> Intel Meteor Lake IOM uses 64bit IOM BASE address than previous Intel
> Generations which use 32bit.
> 
> Added code to support 64bit IOM BASE address change with necessary ACPI
> resource extraction support.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> index 47b733f78fb0..a8e273fe204a 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -571,9 +571,11 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
>  
>  static int is_memory(struct acpi_resource *res, void *data)
>  {
> -	struct resource r;
> +	struct resource_win win = {};
> +	struct resource *r = &win.res;
>  
> -	return !acpi_dev_resource_memory(res, &r);
> +	return !(acpi_dev_resource_memory(res, r) ||
> +		 acpi_dev_resource_address_space(res, &win));
>  }

I realised that now that is_memory() function is basically just a copy
of the is_memory() function that's in drivers/acpi/resources.c, so I
think we need to handle this a bit differently. There are a few places
in kernel that have that same check.

One way would be to just export the is_memory() function that's in
drivers/acpi/resources.c, but since we have already a wrapper function
acpi_dev_get_dma_resources() for DMA resouces, I think we could have a
similar wrapper for common memory resources.

I'll prepare a patch(s) where I'll propose a new wrapper function
acpi_dev_get_memory_resources() that will take care of the is_memory()
check, and then convert the users (including this driver). After that,
this patch only needs to add the ID.


thanks,


>  /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
> @@ -583,6 +585,9 @@ static const struct acpi_device_id iom_acpi_ids[] = {
>  
>  	/* AlderLake */
>  	{ "INTC1079", 0x160, },
> +
> +	/* Meteor Lake */
> +	{ "INTC107A", 0x160, },
>  	{}
>  };
>  
> -- 
> 2.25.1

-- 
heikki
