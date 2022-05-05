Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4051CAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385699AbiEEV16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245352AbiEEV15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:27:57 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD7E5E16C;
        Thu,  5 May 2022 14:24:12 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q8so5641782oif.13;
        Thu, 05 May 2022 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYBkCrOjKsNELWgFHk4Rh2mSLPo6p/XEUcMC/Y8n7so=;
        b=QLx6Dsr5kDEheU2O26ElBO0o5+yVyseG4+bpINUVi2CnDJTcRJmya4mb86DqZPQx0L
         PdfXpvNlLr3vAoTNwug0VWTYnxn9nvTF8Se/b474gQjhmcmmpmrlM5PYB2v3x9soEJSX
         1kF26eiHrp1yjRHAsaZ7+hdZdZg7VE4qlOLSu9QOxnVp7DRi/N2DE0Vl7la3s9sasU+D
         EUQXVUCebHRpBlx2vj0TVqT+UOIfIjLy/PkBRRcO0mjX5cc2cFxAks6T8qNQAn91m+Lg
         8qZ+NJUi3wCUq+F0eb16vHOFvV9hE7zr24TUhxwE+4hUzo3cHV7KIwnYKXWqBJYfHhXm
         9dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mYBkCrOjKsNELWgFHk4Rh2mSLPo6p/XEUcMC/Y8n7so=;
        b=MEyi4g4oxd/jcttNH7O1SR71kRR9yghkZaXXltwM8BIlJCdz4CpX5ySKehrOVeykma
         8vT0T9Z++N+0ajYPp9nVRNehuTrGAsFxxc/8Ng5mdaiEAWdbHkw+933/RRSCXQCqlou7
         wmhiUIKEwwcCNGf+ZzMAo6phshhsdyitLdjQQj+wy6wfwWD82g4r4+UmTcg3ob3lesiZ
         82mUV2vj0uYNzmIqa4B2MrVbWTD1sZ1Br1/PJ+ZItpvmc8kfh5jdQctGo/4V5OOq89+z
         q84Es1lNuaBYAwT3NSnENbrVvVzc3k0HMlxbzO2bRmcOBM1a44ibDSCa89Fn6lLBwdZ5
         YZrg==
X-Gm-Message-State: AOAM532MI53AIT6d0+njPzfeVkAGCsObWOGE6QRtvXZGueX8QPISOto5
        ruF2OLuZUPvlnlXEAtiFrDEqwYIw5zwIGQ==
X-Google-Smtp-Source: ABdhPJzb9+zk/Sp0SpidIkLIL8lnEDsKvmCJ3xNQmU8wf2aCLh8MHh09qJNpiUTPE9bTwWyoCxHsVg==
X-Received: by 2002:a05:6808:1151:b0:326:479f:4413 with SMTP id u17-20020a056808115100b00326479f4413mr3411562oiu.63.1651785852103;
        Thu, 05 May 2022 14:24:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l8-20020aca1908000000b00325cda1ffbbsm980249oii.58.2022.05.05.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:24:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 May 2022 14:24:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, tzungbi@kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] watchdog: iTCO_wdt: Using existing macro define
 covers more scenarios
Message-ID: <20220505212409.GA1988522@roeck-us.net>
References: <1650967905-3199-1-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650967905-3199-1-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:11:45PM +0800, Liu Xinpeng wrote:
> For power management, SET_NOIRQ_SYSTEM_SLEEP_PM_OPS defined for
> CONFIG_PM_SLEEP, will point ->suspend_noirq, ->freeze_noirq and
> ->poweroff_noirq to the same function. Vice versa happens for
> ->resume_noirq, ->thaw_noirq and ->restore_noirq.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3f2f4343644f..34693f11385f 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -596,7 +596,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  /*
>   * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
>   * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
> @@ -604,15 +603,15 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>   */
>  
>  #ifdef CONFIG_ACPI
> -static inline bool need_suspend(void)
> +static inline bool __maybe_unused need_suspend(void)
>  {
>  	return acpi_target_system_state() == ACPI_STATE_S0;
>  }
>  #else
> -static inline bool need_suspend(void) { return true; }
> +static inline bool __maybe_unused need_suspend(void) { return true; }
>  #endif
>  
> -static int iTCO_wdt_suspend_noirq(struct device *dev)
> +static int __maybe_unused iTCO_wdt_suspend_noirq(struct device *dev)
>  {
>  	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
>  	int ret = 0;
> @@ -626,7 +625,7 @@ static int iTCO_wdt_suspend_noirq(struct device *dev)
>  	return ret;
>  }
>  
> -static int iTCO_wdt_resume_noirq(struct device *dev)
> +static int __maybe_unused iTCO_wdt_resume_noirq(struct device *dev)
>  {
>  	struct iTCO_wdt_private *p = dev_get_drvdata(dev);
>  
> @@ -637,20 +636,15 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops iTCO_wdt_pm = {
> -	.suspend_noirq = iTCO_wdt_suspend_noirq,
> -	.resume_noirq = iTCO_wdt_resume_noirq,
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
> +				      iTCO_wdt_resume_noirq)
>  };
>  
> -#define ITCO_WDT_PM_OPS	(&iTCO_wdt_pm)
> -#else
> -#define ITCO_WDT_PM_OPS	NULL
> -#endif /* CONFIG_PM_SLEEP */
> -
>  static struct platform_driver iTCO_wdt_driver = {
>  	.probe          = iTCO_wdt_probe,
>  	.driver         = {
>  		.name   = DRV_NAME,
> -		.pm     = ITCO_WDT_PM_OPS,
> +		.pm     = &iTCO_wdt_pm,
>  	},
>  };
>  
> -- 
> 2.23.0
> 
