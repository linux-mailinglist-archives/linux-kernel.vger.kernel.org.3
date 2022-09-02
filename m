Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963A85AABC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiIBJu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiIBJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:50:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0E193DD;
        Fri,  2 Sep 2022 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662112206; x=1693648206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IaIr/VGI/rpzpeneCz+2giuJhgGkXrDlzgjqfyGBTt0=;
  b=XNkTVRDmdjYHpc2zFXWAZdqZpACq+NCba3Ncih6zotmMe7WIDd76MfKA
   tz7osbCFVke4sAMyNUagTq4E74VnYOYvI1q5XhAO9NMwx5aymVwsSEqBD
   /VmMQ/xyPAdLayyItkKqB8tgPPl/4RhBcGqOcp/2mrqp8/gMy5cSnOYBS
   MHrE+nWMU2OjlrCehVWjH1MwD6tmq/wxr7gJstOvpVttJnZU/T1QSGJiu
   R0tZ3QMtw7O3IFGxYgzUh53NWwdCCaoxeDXwRVUWo/G/yEr3otor7DGGw
   vkKh4atgyoQzUiNhnWLxBC3Q4H1gAawh+U7/zVdigDvN8dFVsZPmPqKPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="359904491"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="359904491"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 02:50:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563913638"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 02:50:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oU3HE-007Jfu-1v;
        Fri, 02 Sep 2022 12:47:52 +0300
Date:   Fri, 2 Sep 2022 12:47:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / property: Silence missing-declarations warning in
 apple.c
Message-ID: <YxHRSPUWtQdP1w/4@smile.fi.intel.com>
References: <202209020412.Ts31BZrs-lkp@intel.com>
 <a6030c5943ccd2965261a92320b1ae1adb909116.1662084833.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6030c5943ccd2965261a92320b1ae1adb909116.1662084833.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 04:15:55AM +0200, Lukas Wunner wrote:
> Silence an annoying message emitted for W=1 builds:
> 
> drivers/acpi/x86/apple.c:30:6: warning: no previous declaration for 'acpi_extract_apple_properties' [-Wmissing-declarations]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/acpi/x86/apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
> index c285c91a5e9c..8812ecd03d55 100644
> --- a/drivers/acpi/x86/apple.c
> +++ b/drivers/acpi/x86/apple.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/uuid.h>
> +#include "../internal.h"
>  
>  /* Apple _DSM device properties GUID */
>  static const guid_t apple_prp_guid =
> -- 
> 2.36.1
> 

-- 
With Best Regards,
Andy Shevchenko


