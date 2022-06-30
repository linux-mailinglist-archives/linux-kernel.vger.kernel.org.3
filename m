Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E5561687
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiF3Jir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiF3JiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771D43ACD;
        Thu, 30 Jun 2022 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656581880; x=1688117880;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h9hiZU4+lOFqwvmcta5Kr0YvtgJ9akYhZmrAbliodHQ=;
  b=MLSGivn5cBo909uufwaWC6YnYTLrTp2I2MXNERo51sdW43zRFJhDW0cM
   hbNbeTqH/qwk5VKDVXlBL5fz439wmvZ8vFvYool9//ExCBqXzLnnVQ3Tb
   jfaqTvQ/Vy0Ut2R/cDL1KrB5dRDVPpYBivkNzajBK3pJaBxou/tjHHPNQ
   PDXt20XSASSlNuTimYiBxlFEqkEPariodIRVPMvJa0W2THWrFsRXm1/q2
   Qm75ma3jnBtfdqbefWUxh91JW7RDouJDhl348yhuyKlgXJ0kLpFw6UgJk
   tgFfB1YqR3birzvL3v5LPBfoqp5UzC+RSLVabyr4s3HJxntlWuknAUAaM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307806832"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="307806832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:38:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="595624374"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:37:58 -0700
Date:   Thu, 30 Jun 2022 12:37:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Drop PM ifdeffery
In-Reply-To: <20220630093351.27926-1-andriy.shevchenko@linux.intel.com>
Message-ID: <742f18aa-e04-1ce1-1bd5-b8a55f3f9e10@linux.intel.com>
References: <20220630093351.27926-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1852794778-1656581880=:1605"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1852794778-1656581880=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jun 2022, Andy Shevchenko wrote:

> Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting dw8250_pm_ops
> to use new PM macros. Since we are using runtime PM, wrap dw8250_pm_ops into
> pm_ptr().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
> v2: wrapped dw8250_pm_ops into pm_ptr() macro (Paul)
>  drivers/tty/serial/8250/8250_dw.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 921ac5c8cb38..927a4a85367a 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -743,7 +743,6 @@ static int dw8250_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int dw8250_suspend(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
> @@ -775,9 +774,7 @@ static int dw8250_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -#ifdef CONFIG_PM
>  static int dw8250_runtime_suspend(struct device *dev)
>  {
>  	struct dw8250_data *data = dev_get_drvdata(dev);
> @@ -808,11 +805,10 @@ static int dw8250_runtime_resume(struct device *dev)
>  	/* TODO: Check if it needs more than it's done in serial8250_console_restore() */
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
> @@ -870,7 +866,7 @@ MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
>  static struct platform_driver dw8250_platform_driver = {
>  	.driver = {
>  		.name		= "dw-apb-uart",
> -		.pm		= &dw8250_pm_ops,
> +		.pm		= pm_ptr(&dw8250_pm_ops),
>  		.of_match_table	= dw8250_of_match,
>  		.acpi_match_table = dw8250_acpi_match,
>  	},
> 
--8323329-1852794778-1656581880=:1605--
