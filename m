Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFC561366
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiF3Hlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF3Hlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:41:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63583A1A3;
        Thu, 30 Jun 2022 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656574908; x=1688110908;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kas1K4p5XFnaaEkpjH7XsCiCA1U1Q5VLT4/8BRUEXFI=;
  b=BPFL4UZIrY/d4wgl9sRfHOZZpo8kSjKiQZdRJZNEOxiossyAovRCR6N8
   ywgTEFZzf0tQ73kXDTRAHqx8SbghcS9x0e4A+f3Sl0IFPITvT5v7WMNAz
   QclNC+mIJHIwdRfMi0BglBiOjE1nYPTrz2wJ1NClv3jXntqgiX8G0Rj2d
   5mStLlRyqKBUOlJKaamuw9IQsJREu/mq58Qd3/SzalBbLimLs/UX51Xfu
   PHOhio3zgJEIiS5Ddrib1UxWh6/33+ZR8Vix59UdZ6pqvFtgl3U0Cy2So
   x2d2nVV+xxo707Od22C77+Rwu2bdU0ytj0QtFvEZefaneBD+7ZQQsdhbD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="271041862"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="271041862"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:41:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647777264"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:41:46 -0700
Date:   Thu, 30 Jun 2022 10:41:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
In-Reply-To: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com>
Message-ID: <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com>
References: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-800567806-1656574908=:1605"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-800567806-1656574908=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting dw8250_pm_ops
> to use new PM macros.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Not directily related to the patch itself but do you have any idea why 
1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones") 
didn't wrap RUNTIME_PM_OPS() pointers with pm_ptr()? I'm asking this 
because in SET_RUNTIME_PM_OPS() the callbacks are only created with
#ifdef CONFIG_PM so I'd have expected RUNTIME_PM_OPS() to maintain that 
behavior but it didn't? Was it just an oversight that should be fixed?

-- 
 i.

> ---
>  drivers/tty/serial/8250/8250_dw.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f71428c85562..adcc869352b1 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -691,7 +691,6 @@ static int dw8250_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int dw8250_suspend(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
> @@ -709,9 +708,7 @@ static int dw8250_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -#ifdef CONFIG_PM
>  static int dw8250_runtime_suspend(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
> @@ -733,11 +730,10 @@ static int dw8250_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops dw8250_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
> -	SET_RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
> +	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
>  };
>  
>  static const struct dw8250_platform_data dw8250_dw_apb = {
> 

--8323329-800567806-1656574908=:1605--
