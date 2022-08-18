Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9D598C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbiHRTO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiHRTOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:14:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E00A1D21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:14:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d20so2398221pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=QId2PQg5ckf5MnfvKTDPRtg/5WK1WO6YOakmsoH9XG8=;
        b=MblhfIHNAJGheLxC4qrpmeyzVaQ/LavfNam7C1czo/NBCtlRnbh1/LHbwe2B5E6pwt
         z2Cdr5gcbC74nwWBO9VPLJ8IaTO1eL/sbt9xvohEC+deLO02Z4ErbMRm+8zhYGNpuQtd
         EIX554P4DOnfh6x1peAAaZZZfQAf1Wjz2F11jxDS6AZNbpte0v/cIikyJJUsNkwENu13
         2SX5gPZa+8pd3EPqfQt0dX+FCbulP4uge95kEYcfSebwea0mQQ1Msv4V6s3xUjDd0Yoo
         5WCo3TyzkQTHR6DGoOo77MASN8wCfc9+J3H+5FOod+D9nWRoTE44/eziefYImV42954q
         0UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=QId2PQg5ckf5MnfvKTDPRtg/5WK1WO6YOakmsoH9XG8=;
        b=6BxNiga96Z8GaoKpmtrfIYn0q/30sqJOWMYIgT0n4EeNOI+mtrxZGHnupSIiSrOb9I
         L71LP3Xf3wjgiqoTzK0fZ+BFFkl7mE0tPYCCrygngyLJ8Z0dFZxPdp+DVdituiT1RPr+
         MXHg2l4vAT/krtFSfBdkEAgii4By+oFxVQYe1K9Iv5zAZQ7NMbguBRGnMLJmdyA+OOMM
         Cr+0rFiNR9H9S3PmTx8cuK51nYsR7ExhfMj1KQTHiJeYbb38Nkgi62+A6xO0G2kTkeb/
         91iXNa+ut/u2zV4nZANuE9hK/+BplCi8Dc2KfhbUJxCBPd14mZqOqbK9PtcxApQ8e+ff
         AINw==
X-Gm-Message-State: ACgBeo3aSkDdCKxzDviEb1vV5sYXGQjD50IOkU064G7H+q4wz9wt9c/o
        oT6d1BrPcMlPylfsioRbjjY=
X-Google-Smtp-Source: AA6agR6tdTZs9aa6PP4APozqOBVx5FQB00M+iSfJAOp53gwqOUAuT3BnmAxb7+3uee+tPVtaZP0auw==
X-Received: by 2002:a05:6a00:23d1:b0:52f:39e9:9150 with SMTP id g17-20020a056a0023d100b0052f39e99150mr4323080pfc.16.1660850059098;
        Thu, 18 Aug 2022 12:14:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902ce0100b0016f04c098ddsm1715171plg.226.2022.08.18.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:14:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 12:14:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] amba: Fix use-after-free in amba_read_periphid()
Message-ID: <20220818191416.GA2917298@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:46:12AM -0700, Isaac J. Manjarres wrote:
> After commit f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device
> addition"), it became possible for amba_read_periphid() to be invoked
> concurrently from two threads for a particular AMBA device.
> 
> Consider the case where a thread (T0) is registering an AMBA driver, and
> searching for all of the devices it can match with on the AMBA bus.
> Suppose that another thread (T1) is executing the deferred probe work,
> and is searching through all of the AMBA drivers on the bus for a driver
> that matches a particular AMBA device. Assume that both threads begin
> operating on the same AMBA device and the device's peripheral ID is
> still unknown.
> 
> In this scenario, the amba_match() function will be invoked for the
> same AMBA device by both threads, which means amba_read_periphid()
> can also be invoked by both threads, and both threads will be able
> to manipulate the AMBA device's pclk pointer without any synchronization.
> It's possible that one thread will initialize the pclk pointer, then the
> other thread will re-initialize it, overwriting the previous value, and
> both will race to free the same pclk, resulting in a use-after-free for
> whichever thread frees the pclk last.
> 
> Add a lock per AMBA device to synchronize the handling with detecting the
> peripheral ID to avoid the use-after-free scenario.
> 
> The following KFENCE bug report helped detect this problem:
> ==================================================================
> BUG: KFENCE: use-after-free read in clk_disable+0x14/0x34
> 
> Use-after-free read at 0x(ptrval) (in kfence-#19):
>  clk_disable+0x14/0x34
>  amba_read_periphid+0xdc/0x134
>  amba_match+0x3c/0x84
>  __driver_attach+0x20/0x158
>  bus_for_each_dev+0x74/0xc0
>  bus_add_driver+0x154/0x1e8
>  driver_register+0x88/0x11c
>  do_one_initcall+0x8c/0x2fc
>  kernel_init_freeable+0x190/0x220
>  kernel_init+0x10/0x108
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> kfence-#19: 0x(ptrval)-0x(ptrval), size=36, cache=kmalloc-64
> 
> allocated by task 8 on cpu 0 at 11.629931s:
>  clk_hw_create_clk+0x38/0x134
>  amba_get_enable_pclk+0x10/0x68
>  amba_read_periphid+0x28/0x134
>  amba_match+0x3c/0x84
>  __device_attach_driver+0x2c/0xc4
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xb0/0x1f0
>  bus_probe_device+0x88/0x90
>  deferred_probe_work_func+0x8c/0xc0
>  process_one_work+0x23c/0x690
>  worker_thread+0x34/0x488
>  kthread+0xd4/0xfc
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> freed by task 8 on cpu 0 at 11.630095s:
>  amba_read_periphid+0xec/0x134
>  amba_match+0x3c/0x84
>  __device_attach_driver+0x2c/0xc4
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xb0/0x1f0
>  bus_probe_device+0x88/0x90
>  deferred_probe_work_func+0x8c/0xc0
>  process_one_work+0x23c/0x690
>  worker_thread+0x34/0x488
>  kthread+0xd4/0xfc
>  ret_from_fork+0x14/0x3c
>  0x0
> 
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: patches@armlinux.org.uk
> Fixes: f2d3b9a46e0e ("ARM: 9220/1: amba: Remove deferred device addition")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/amba/bus.c       | 8 +++++++-
>  include/linux/amba/bus.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Guenter,
> 
> Thanks for testing this patch out. Can you please add your Tested-by?
> 
> Thanks,
> Isaac
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 32b0e0b930c1..110a535648d2 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -209,6 +209,7 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>  	struct amba_device *pcdev = to_amba_device(dev);
>  	struct amba_driver *pcdrv = to_amba_driver(drv);
>  
> +	mutex_lock(&pcdev->periphid_lock);
>  	if (!pcdev->periphid) {
>  		int ret = amba_read_periphid(pcdev);
>  
> @@ -218,11 +219,14 @@ static int amba_match(struct device *dev, struct device_driver *drv)
>  		 * permanent failure in reading pid and cid, simply map it to
>  		 * -EPROBE_DEFER.
>  		 */
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&pcdev->periphid_lock);
>  			return -EPROBE_DEFER;
> +		}
>  		dev_set_uevent_suppress(dev, false);
>  		kobject_uevent(&dev->kobj, KOBJ_ADD);
>  	}
> +	mutex_unlock(&pcdev->periphid_lock);
>  
>  	/* When driver_override is set, only bind to the matching driver */
>  	if (pcdev->driver_override)
> @@ -532,6 +536,7 @@ static void amba_device_release(struct device *dev)
>  
>  	if (d->res.parent)
>  		release_resource(&d->res);
> +	mutex_destroy(&d->periphid_lock);
>  	kfree(d);
>  }
>  
> @@ -584,6 +589,7 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
>  	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>  	dev->dev.dma_parms = &dev->dma_parms;
>  	dev->res.name = dev_name(&dev->dev);
> +	mutex_init(&dev->periphid_lock);
>  }
>  
>  /**
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index e94cdf235f1d..5001e14c5c06 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -67,6 +67,7 @@ struct amba_device {
>  	struct clk		*pclk;
>  	struct device_dma_parameters dma_parms;
>  	unsigned int		periphid;
> +	struct mutex		periphid_lock;
>  	unsigned int		cid;
>  	struct amba_cs_uci_id	uci;
>  	unsigned int		irq[AMBA_NR_IRQS];
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
