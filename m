Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006DE47BF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhLUMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:22:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:20237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhLUMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640089355; x=1671625355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KxjKTxfIDQIJ0L4wXu6WXYwtURw23ovXt86O0TxEARE=;
  b=dBtO6WkMLA/W0Um2XmRJkrAfqCzVAH1PsdTbfOkl9kT0Lu2xx84nz2hs
   8fggNaUeMfNeNj+4Zz56tUWu3qqmVgZxDWV1TnOROB1uiLVghzEg5mF9H
   lryn730gmyNTAxlDmsJnHEvEnAzDUwJ37p4GK+Kn379dmCVZwrfPHUHvY
   RfiICYGBn16+tKCAzj0D6VU7nNEo6lpUJIRHEKxHulEVewagy+woDt5Lk
   LKl4AN/LgIBEqPBkiPxO8o3tVrVowYSSFlDQ4GeLcpu5kn90p8JFQgRBr
   KfbSX6NkabvzYs850suFbVToj9EY3AnXw4CDek1n/PyJo9f0FOuGZT+mD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="301151824"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="301151824"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 04:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="663932038"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 21 Dec 2021 04:22:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Dec 2021 14:22:31 +0200
Date:   Tue, 21 Dec 2021 14:22:31 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Message-ID: <YcHHB82r7qT/yJmg@kuha.fi.intel.com>
References: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:14:09AM +0200, Andy Shevchenko wrote:
> There are two updates to the MAINTAINERS regarding to software node API:
> - add Dan Scally to be designated reviewer
> - add rather tightly related device property files to the list
> - adjust section name accordingly
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Another way would be to have a separate entry for the unified device
property API, and that could then have you (Andy), Sakari and Daniel
as the reviers. I don't think I have much to say about those parts -
I'm only interested in the software nodes. But it's up to you. FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Based on the latest Dan's involvement and amount of patches seen recently
> I went ahead and added his name to the list. Dan, please tell me if it's
> not appropriate.
> 
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8912b2c1260c..ccb4aa744540 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17666,12 +17666,16 @@ F:	drivers/firmware/arm_sdei.c
>  F:	include/linux/arm_sdei.h
>  F:	include/uapi/linux/arm_sdei.h
>  
> -SOFTWARE NODES
> +SOFTWARE NODES AND DEVICE PROPERTIES
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +R:	Daniel Scally <djrscally@gmail.com>
>  L:	linux-acpi@vger.kernel.org
>  S:	Maintained
> +F:	drivers/base/property.c
>  F:	drivers/base/swnode.c
> +F:	include/linux/fwnode.h
> +F:	include/linux/property.h
>  
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:	Song Liu <song@kernel.org>
> -- 
> 2.34.1

thanks,

-- 
heikki
