Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C0059E550
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbiHWOrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiHWOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:45:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9732E0D87;
        Tue, 23 Aug 2022 05:07:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g8so8724022plq.11;
        Tue, 23 Aug 2022 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=M5pm4/VJrTNRCgV/1Wc0seJfX5yLDcrWOklZuTfCCtY=;
        b=mZogj9xQ/+Vr8S1jpK658n2Aj6QC8la6Mu9cjfOmB9kNWjGGC9cQXzFTKC79hcf2Al
         iApFcNWbN+fGk4x4EwXIpvjKYnfyJLaupJhr+DvGL293rVOKGiVa5ArAwZr0bA91Zamm
         LK7Zts76zmrF40Y8XdbaYrMXuYdd//mM8L8B9Ih+NKblceMjwDBIEVE+/2pbNKtXeoki
         LtluyOn1PhbNCwCYifRzOxDnUZ7sNQA2RCTeEWwiCTElBqe0AmQzMAY8nN7rU3VNdIvU
         2XeNxogrjLCx8HZ/4nSFiBXu3N5xQUHu2oji2nz/AqkGGjAVZ0RYrp0LQyO5SsmIFUka
         H1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=M5pm4/VJrTNRCgV/1Wc0seJfX5yLDcrWOklZuTfCCtY=;
        b=HoUOJP4AVBH4QCJEhc+ifClEjNGq4gds57huSMV84ZzcmO7B9JUEheaHBO9h2eOr54
         NZsMR73ZUtCYf/G+L+F6VjSouR4T2cRxfOFKrZJWMECw1SNHbYPP2cs7uYwwynxd3/Tz
         5FtCZsZR5L7yYmxWLzg4sfUdGX2iQRU+QlBOCOQu9F1g40V7hf2s+Q19kdaFfAB6XbOo
         GS/R3MPdIysRW4AA4zL7xkCzWVQOT66kGS7omWjc32el8DXI5Ow0HG8UHdHX3Fg8hT3x
         bSK78oSP5N3ncoW9NVdluHd/GycUMmTsmma7sfJDUTaNkqXwe+AZtRp8U/7xoqVjN12e
         4daA==
X-Gm-Message-State: ACgBeo0slDv3Q/g4EtUExHV5EN5T7r8rbhUIW7Vc9MZ/MxuuI2y5r0we
        R3Zx6P02JRbu96MZCRdUhW4=
X-Google-Smtp-Source: AA6agR6AKJbbncEdljYSR29LkZvk9rh/Ilz5/vWWK3pRLPjSRG84vapc9XlKp48gYeP57U0Da/y1Gw==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:524f:bfcc with SMTP id oo14-20020a17090b1c8e00b001f7524fbfccmr3025566pjb.132.1661256418503;
        Tue, 23 Aug 2022 05:06:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902e38100b0016bdf0032b9sm10206494ple.110.2022.08.23.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:06:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Aug 2022 05:06:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Message-ID: <20220823120656.GC203169@roeck-us.net>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-5-alice.guo@oss.nxp.com>
 <20220822140946.GC4087281@roeck-us.net>
 <AM6PR04MB60533A1ABDFA1DEDE59BB847E2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB60533A1ABDFA1DEDE59BB847E2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
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

On Tue, Aug 23, 2022 at 05:59:11AM +0000, Alice Guo (OSS) wrote:
> 
> 
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Monday, August 22, 2022 10:10 PM
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: wim@linux-watchdog.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; linux-watchdog@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
> > 
> > On Tue, Aug 16, 2022 at 12:36:40PM +0800, Alice Guo (OSS) wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
> > > about 3400us and 6700us respectively. So current 20us timeout is not
> > > enough. When reconfiguring is on-going, unlock and configure CS will
> > > lead to unknown result.
> > >
> > > Increase the wait timeout value to 10ms and check the return value of
> > > RCS wait to fix the issue
> > >
> > 
> > You'll have to find a better solution. An active (non-sleep) wait of
> > 10 ms is unacceptable.
> > 
> > Guenter
> 
> Hi Guenter,
> 
> Sorry. I think this patch should be merged with " watchdog: imx7ulp_wdt: Handle wdog reconfigure failure", but I didn't merge them. I will send v2.
> 

That doesn't change the fact that a 10 ms hot wait is unacceptable.

Thanks,
Guenter

> Best Regards,
> Alice Guo
> 
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > > Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> > > ---
> > >  drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/imx7ulp_wdt.c
> > > b/drivers/watchdog/imx7ulp_wdt.c index a0f6b8cea78f..12715c248688
> > > 100644
> > > --- a/drivers/watchdog/imx7ulp_wdt.c
> > > +++ b/drivers/watchdog/imx7ulp_wdt.c
> > > @@ -39,7 +39,7 @@
> > >  #define DEFAULT_TIMEOUT	60
> > >  #define MAX_TIMEOUT	128
> > >  #define WDOG_CLOCK_RATE	1000
> > > -#define WDOG_WAIT_TIMEOUT	20
> > > +#define WDOG_WAIT_TIMEOUT	10000
> > >
> > >  static bool nowayout = WATCHDOG_NOWAYOUT;
> > module_param(nowayout,
> > > bool, 0000); @@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct
> > > watchdog_device *wdog, bool enable)
> > >  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
> > >  	else
> > >  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> > > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > >
> > >  enable_out:
> > >  	local_irq_enable();
> > > @@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct
> > watchdog_device *wdog,
> > >  	if (ret)
> > >  		goto timeout_out;
> > >  	writel(val, wdt->base + WDOG_TOVAL);
> > > -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> > > +	if (ret)
> > > +		goto timeout_out;
> > >
> > >  	wdog->timeout = timeout;
> > >
> > > --
> > > 2.17.1
> > >
