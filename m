Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0875E4987AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiAXSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:04:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:37145 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241599AbiAXSEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643047445; x=1674583445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYmRkE6V3p9QrcyPrJBbLnZSuFH1gmWgXsZXCzijVQU=;
  b=hxotyViaIw/IvKY05yP3zyWyauFGtKTWRMQrn0fxkOh8yck/iFs2Ov9c
   ycbSITN5OPHcceSanmVtlHoXIbX3dtak7xBxHJkU+LeN9XVnZ1dlX51wz
   WSERPpVKn10vFsknt8FrM+A7OH01GXZRJQk0RjkGgwoVAhJ8/QCca4Y6Q
   m8cFQE2744VgeLepK0T0aGN10dYPad+LhEcR0TvoeyUSpNoDQlyFUJuRW
   y/1rQiS60BVKXq1wOEgByzCo24NiF0rjiaFT+N2sBiu6tng34W7pOJXaq
   2diB7k9nuQf3P71I1g3ElsoBhuBru/MvgNgamqD3U3WmpmiMg/pJOelZe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309429841"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309429841"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:04:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="494704523"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:04:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nC3g8-00Dz4t-FG;
        Mon, 24 Jan 2022 20:02:56 +0200
Date:   Mon, 24 Jan 2022 20:02:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        tzimmermann@suse.de, robh@kernel.org, maxime@cerno.tech
Subject: Re: [PATCH] fbdev: Fix file path that does not exist
Message-ID: <Ye7p0Ccmy+lHaRM1@smile.fi.intel.com>
References: <20211208144631.3710-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208144631.3710-1-jj251510319013@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: maintainer

On Wed, Dec 08, 2021 at 10:46:31PM +0800, Wei Ming Chen wrote:
> pvr2fb.c should be under drivers/video/fbdev/
> instead of drivers/video/

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 6ed5e608dd04..93b8d84c34cf 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -829,7 +829,7 @@ config FB_PVR2
>  	  You can pass several parameters to the driver at boot time or at
>  	  module load time.  The parameters look like "video=pvr2:XXX", where
>  	  the meaning of XXX can be found at the end of the main source file
> -	  (<file:drivers/video/pvr2fb.c>). Please see the file
> +	  (<file:drivers/video/fbdev/pvr2fb.c>). Please see the file
>  	  <file:Documentation/fb/pvr2fb.rst>.
>  
>  config FB_OPENCORES
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


