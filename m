Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639E552B63
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbiFUG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbiFUG7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:59:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6E1E3F3;
        Mon, 20 Jun 2022 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655794790; x=1687330790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+PfG4Qvm/eYCPzkCXpG1rMCS9Cqy2+246OEW6+7GXU=;
  b=NtAbN9NRDX3aOopqkwa2dZF+EhqBHspcQbzTBqfMhNsA0wdmtURK3eOB
   sO3nvb92Ulopaf0GDCN7uQLxgS1+I08xSWA3RoC9dmjyCcjF7b5D7fSil
   ZExTt06eUqX3X/BR45Ej0srNbmGxwOntvb0JN/qPe1zt0aUD831MuAWhH
   0o+ayJrNZTCU9ZlwXIrr4NxPweGISMv81O3sP9sdAbeGyhqQsWJAz8Yrd
   r3wGXB/aXZuiddjsz3KgXBR5VV4CxBIfMXlsCer+Q8MMpeTPP+QZkbZUi
   ibSNLOeGION8HxyE3UXtPBDJI1z0bFiJMRvPi1ssHsd7ecX7IlSiXygXi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341729815"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341729815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 23:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="729709260"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Jun 2022 23:59:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Jun 2022 09:59:46 +0300
Date:   Tue, 21 Jun 2022 09:59:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Drop wrong dependency to
 INTEL_SOC_PMIC
Message-ID: <YrFsYs/I21wZ/x/s@kuha.fi.intel.com>
References: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 01:43:16PM +0300, Andy Shevchenko wrote:
> Intel SoC PMIC is a generic name for all PMICs that are used
> on Intel platforms. In particular, INTEL_SOC_PMIC kernel configuration
> option refers to Crystal Cove PMIC, which has never been a part
> of any Intel Broxton hardware. Drop wrong dependency from Kconfig.
> 
> Note, the correct dependency is satisfied via ACPI PMIC OpRegion driver,
> which the Type-C depends on.
> 
> Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 557f392fe24d..073fd2ea5e0b 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -56,7 +56,6 @@ config TYPEC_WCOVE
>  	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
>  	depends on ACPI
>  	depends on MFD_INTEL_PMC_BXT
> -	depends on INTEL_SOC_PMIC
>  	depends on BXT_WC_PMIC_OPREGION
>  	help
>  	  This driver adds support for USB Type-C on Intel Broxton platforms
> -- 
> 2.35.1

-- 
heikki
