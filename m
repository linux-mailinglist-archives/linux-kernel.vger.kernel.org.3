Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25F149DF8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiA0Kf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:35:57 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48121 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232813AbiA0Kf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:35:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 16F5E58038C;
        Thu, 27 Jan 2022 05:35:55 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute3.internal (MEProxy); Thu, 27 Jan 2022 05:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; bh=dxzJ5fUeSjprnyTxgK84tca3YXNVyE
        W4kzNdT3N7XRs=; b=WYSm6JGlUapjy+ROB6Osl2/uNm93ldLYQEGkzRKfQWetv1
        yB5AECNMo7sjYvVH3Y6Ng2RYZ9vq/sHX7NnAC5lkoQrfc+yVRZFn7F80Squ1/jct
        xpLA7x6NFzCCUQAA5QbIdd1le2HIop9xy/cW7HICJ54Vww21Iw3N3NKamYwvUcEJ
        ZHVc7mqpwiXxFbplCmLcRTgWWpjV14pdicfS4y685c3glP78TAyiyVqM08DxmVfU
        n1XiTYPLSl3DXyDtMMrkIj2HNAqlNlNSuLI9IQGD+GDMlxu2tI21e3+7bODoUEU0
        fosjq5PJLKLUOs9zJEQB6xZVOLtzyTsAagsop/GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dxzJ5fUeSjprnyTxg
        K84tca3YXNVyEW4kzNdT3N7XRs=; b=BBQ9Y1HO5N9/5XJkaJt1E+0HhrJEx4Rwu
        TlH7DnO0dJ47/B9tfRFEE46LHEUXH8f9QG481w4CxX6uuAUvtRgor9efAN9Fxma7
        mm84XSfro5yYAawYC8+6XtC0rte/zPAiEfPJiWzBcNkyhAxN5hocZm14ZBKueOLf
        YTMPmddhG1ETE+oUTuBn2+a9NPEzD1kPec/AFvcnYzSNvjCPgaUI2IAKk0M4yk6+
        NkrWqtWy5LIafYrjevrSy+d8UlG+rlHf6mtwRp86plkdYM1Od09PSGjI7KndCKWK
        eDhJ2VzEYMXGhj8WJ9qsRXH6aBcGj+eUMxH1rvVwQVrSKXx+pRD5Q==
X-ME-Sender: <xms:inXyYRtKBFnbtkyc_ZSUk0s4UvK4WQ3pSBz7WPE04VzYpqd3i2nEog>
    <xme:inXyYafrQcT3kLlk2v7mA8QcRFzllOQIkGDZWsb8eI9UUTTKHOTlNwpxBE1HF0gix
    8TnEl54api8Dz43CR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeefgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpeetlhhishht
    rghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrth
    htvghrnhepueffkeevheejledtueevieekleekjefhjeehudfhtdfgtdfgjeejkedvveej
    veeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:inXyYUy4HdHQrsbzB6HyGapnUWk5HaayeuNjd-IxvfuGj2PlzrSwCQ>
    <xmx:inXyYYMsL9BtTAkTNwQhJCucFLjecZz3lmuCLsKAlJcbEkHPtf1eTg>
    <xmx:inXyYR9qG-UjMiwpg9a-cUVvt4rbgOmMTf5KjUMJXYQKwEcytFYtEw>
    <xmx:i3XyYQZ0xKJ2_6Yw09xuAijegF6L1nSO5_Vl6x0HnkyQtY_ZbvOfGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 74C71AC0E99; Thu, 27 Jan 2022 05:35:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <6b0d3b85-a3a3-4f06-a6c1-88fa0a4113f0@www.fastmail.com>
In-Reply-To: <1a8ee480-b066-8da9-cd63-079e07b7d88a@roeck-us.net>
References: <20220124120027.106754-1-alistair@alistair23.me>
 <1a8ee480-b066-8da9-cd63-079e07b7d88a@roeck-us.net>
Date:   Thu, 27 Jan 2022 20:35:33 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        s.hauer@pengutronix.de, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        "Rob Herring" <robh+dt@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2] watchdog: imx2_wdg: Alow ping on suspend
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022, at 2:21 AM, Guenter Roeck wrote:
> On 1/24/22 04:00, Alistair Francis wrote:
> > The i.MX watchdog cannot be disabled by softwrae once it has been
> 
> s/softwrae/software/
> 
> > enabled. This means that it can't be stopped before suspend.
> > 
> > For systems that enter low power mode this is fine, as the watchdog will
> > be automatically stopped by hardwrae in low power mode. Not all i.MX
> 
> s/hardwrae/hardware/
> 
> > platforms support low power mode in the mainline kernel. For example the
> > i.MX7D does not enter low power mode and so will be rebooted 2 minutes
> > after entering freeze or mem sleep states.
> 
> I don't think "mem" adds any value here. Just make it sleep states.
> 
> > 
> > This patch introduces a device tree property "fsl,ping-during-suspend"
> > that can be used to enable ping on suspend support for these systems.
> > 
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> 
> Change log goes here.
> 
> >   drivers/watchdog/imx2_wdt.c | 27 ++++++++++++++++++++-------
> >   1 file changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> > index 51bfb796898b..d0c5d47ddede 100644
> > --- a/drivers/watchdog/imx2_wdt.c
> > +++ b/drivers/watchdog/imx2_wdt.c
> > @@ -66,6 +66,7 @@ struct imx2_wdt_device {
> >   struct watchdog_device wdog;   
> >   bool ext_reset;
> >   bool clk_is_on;
> 
> I don't see the purpose of this variable. Unless I am missing something is is set
> but never used.

clk_is_on is used in imx2_wdt_ping(), it disables the access if
the clock isn't running.

> 
> > + bool no_ping;
> >   };
> >   
> >   static bool nowayout = WATCHDOG_NOWAYOUT;
> > @@ -312,12 +313,18 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
> >   
> >   wdev->ext_reset = of_property_read_bool(dev->of_node,
> >   "fsl,ext-reset-output");
> > + /*
> > + * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
> > + * during suspend.
> > + */
> > + wdev->no_ping = !of_device_is_compatible(dev->of_node, "fsl,imx7d-wdt");
> 
> This is ok as long as there is only a single chip requiring this change.
> If there are more, the 'data' field in struct of_device_id should be used
> instead.

I only know of one now, so this should be fine then.

Alistair

> 
> >   platform_set_drvdata(pdev, wdog);
> >   watchdog_set_drvdata(wdog, wdev);
> >   watchdog_set_nowayout(wdog, nowayout);
> >   watchdog_set_restart_priority(wdog, 128);
> >   watchdog_init_timeout(wdog, timeout, dev);
> > - watchdog_stop_ping_on_suspend(wdog);
> > + if (wdev->no_ping)
> > + watchdog_stop_ping_on_suspend(wdog);
> >   
> >   if (imx2_wdt_is_running(wdev)) {
> >   imx2_wdt_set_timeout(wdog, wdog->timeout);
> > @@ -366,9 +373,11 @@ static int __maybe_unused imx2_wdt_suspend(struct device *dev)
> >   imx2_wdt_ping(wdog);
> >   }
> >   
> > - clk_disable_unprepare(wdev->clk);
> > + if (wdev->no_ping) {
> > + clk_disable_unprepare(wdev->clk);
> >   
> > - wdev->clk_is_on = false;
> > + wdev->clk_is_on = false;
> > + }
> >   
> >   return 0;
> >   }
> > @@ -380,11 +389,14 @@ static int __maybe_unused imx2_wdt_resume(struct device *dev)
> >   struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> >   int ret;
> >   
> > - ret = clk_prepare_enable(wdev->clk);
> > - if (ret)
> > - return ret;
> > + if (wdev->no_ping) {
> > + ret = clk_prepare_enable(wdev->clk);
> >   
> > - wdev->clk_is_on = true;
> > + if (ret)
> > + return ret;
> > +
> > + wdev->clk_is_on = true;
> > + }
> >   
> >   if (watchdog_active(wdog) && !imx2_wdt_is_running(wdev)) {
> >   /*
> > @@ -407,6 +419,7 @@ static SIMPLE_DEV_PM_OPS(imx2_wdt_pm_ops, imx2_wdt_suspend,
> >   
> >   static const struct of_device_id imx2_wdt_dt_ids[] = {
> >   { .compatible = "fsl,imx21-wdt", },
> > + { .compatible = "fsl,imx7d-wdt", },
> >   { /* sentinel */ }
> >   };
> >   MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
> 
> 
