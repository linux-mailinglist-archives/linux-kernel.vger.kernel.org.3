Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC84F1EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbiDDVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379197AbiDDQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:07 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.49.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871D35851
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:10 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 8356817B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:41:10 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bPlOniZjTXvvJbPlOnlmnL; Mon, 04 Apr 2022 11:41:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7WgjofAA6KFtyuYFlmhFU6JlXq3dpm5LRTI1JLbUZtg=; b=FMYEuEthHu16SlxBpkJ9Y62rkl
        ZAL8MaU5uy/Wxs3EZw1O32MFghfHwIujE26AM+k6K1Co2g9GpdujuFgRaJcPSLrhjUinomr+fdPwo
        yeHUee7zaDnix6gGkNCSt4JTaooROeu+QBVjeGOUJgyP7d015RpCzh6cMl+0xXxT3IOZnTWpHE831
        kqVoSgiwpS02FVQX4dJHY5lFaacAQdcfOPDJdGZj9GdAjOnogzqG62lBShqTkvCS2zUTRX+oZ+GSS
        GZNilg36MeKDFofhJXMTnQi7inTusG7VUfqpGU2dsSQSsFafMipHssDQDMiUJ88S9mu1UOzTLrdPb
        65MAOlMg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54720)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbPlO-002RIp-5r; Mon, 04 Apr 2022 16:41:10 +0000
Message-ID: <817c20de-3ebc-e444-a14e-b18773da9f19@roeck-us.net>
Date:   Mon, 4 Apr 2022 09:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-3-nick.hawkins@hpe.com>
 <20220404142830.GA3289074@roeck-us.net>
 <PH0PR84MB171847EBCFEF79A06434CE8488E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <PH0PR84MB171847EBCFEF79A06434CE8488E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbPlO-002RIp-5r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54720
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 09:25, Hawkins, Nick wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Monday, April 4, 2022 9:29 AM
> To: Hawkins, Nick <nick.hawkins@hpe.com>
> Cc: Verdun, Jean-Marie <verdun@hpe.com>; Wim Van Sebroeck <wim@linux-watchdog.org>; linux-kernel@vger.kernel.org; linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH v3 03/10] drivers: wdt: Introduce HPE GXP SoC Watchdog
> 
> On Thu, Mar 10, 2022 at 01:52:22PM -0600, nick.hawkins@hpe.com wrote:
>>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>>
>>> Adding support for the HPE GXP Watchdog. It is new to the linux
>>> community and this along with several other patches is the first
>>> support for it. The GXP asic contains a full compliment of timers one
>>> of which is the watchdog timer. The watchdog timer is 16 bit and has
>>> 10ms resolution.
>>>
>>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>>> ---
>>>   drivers/watchdog/Kconfig   |   8 ++
>>>   drivers/watchdog/Makefile  |   1 +
>>>   drivers/watchdog/gxp-wdt.c | 191
>>> +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 200 insertions(+)
>>>   create mode 100644 drivers/watchdog/gxp-wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> c8fa79da23b3..cb210d2978d2 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -1820,6 +1820,14 @@ config RALINK_WDT
>>>   	help
>>>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>>>   
>>> +config GXP_WATCHDOG
>>> +	tristate "HPE GXP watchdog support"
>>> +	depends on ARCH_HPE_GXP
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  Say Y here to include support for the watchdog timer
>>> +	  in HPE GXP SoCs.
>>> +
>>>   config MT7621_WDT
>>>   	tristate "Mediatek SoC watchdog"
>>>   	select WATCHDOG_CORE
>>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>>> index f7da867e8782..e2acf3a0d0fc 100644
>>> --- a/drivers/watchdog/Makefile
>>> +++ b/drivers/watchdog/Makefile
>>> @@ -92,6 +92,7 @@ obj-$(CONFIG_RTD119X_WATCHDOG) += rtd119x_wdt.o
>>>   obj-$(CONFIG_SPRD_WATCHDOG) += sprd_wdt.o
>>>   obj-$(CONFIG_PM8916_WATCHDOG) += pm8916_wdt.o
>>>   obj-$(CONFIG_ARM_SMC_WATCHDOG) += arm_smc_wdt.o
>>> +obj-$(CONFIG_GXP_WATCHDOG) += gxp-wdt.o
>>>   obj-$(CONFIG_VISCONTI_WATCHDOG) += visconti_wdt.o
>>>   obj-$(CONFIG_MSC313E_WATCHDOG) += msc313e_wdt.o
>>>   obj-$(CONFIG_APPLE_WATCHDOG) += apple_wdt.o diff --git
>>> a/drivers/watchdog/gxp-wdt.c b/drivers/watchdog/gxp-wdt.c new file
>>> mode 100644 index 000000000000..d2b489cb4774
>>> --- /dev/null
>>> +++ b/drivers/watchdog/gxp-wdt.c
>>> @@ -0,0 +1,191 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P.
>>> + *
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> +modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/types.h>
>>> +#include <linux/watchdog.h>
>>> +
>>> +#define MASK_WDGCS_ENABLE	0x01
>>> +#define MASK_WDGCS_RELOAD	0x04
>>> +#define MASK_WDGCS_NMIEN	0x08
>>> +#define MASK_WDGCS_WARN		0x80
>>> +
>>> +#define WDT_MAX_TIMEOUT_MS	655000
>>> +#define WDT_DEFAULT_TIMEOUT	30
>>> +#define SECS_TO_WDOG_TICKS(x) ((x) * 100) #define
>>> +WDOG_TICKS_TO_SECS(x) ((x) / 100)
>>> +
>>> +struct gxp_wdt {
>>> +	void __iomem	*counter;
>>> +	void __iomem	*control;
>>> +	struct watchdog_device	wdd;
> 
>> Odd variable alignment. Might as well just use spaces before the variable names.
> 
> Fixed
> 
>>> +};
>>> +
>>> +static void gxp_wdt_enable_reload(struct gxp_wdt *drvdata) {
>>> +	uint8_t val;
>>> +
>>> +	val = readb(drvdata->control);
>>> +	val |= (MASK_WDGCS_ENABLE | MASK_WDGCS_RELOAD);
>>> +	writeb(val, drvdata->control);
>>> +}
>>> +
>>> +static int gxp_wdt_start(struct watchdog_device *wdd) {
>>> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
>>> +
>>> +	writew((SECS_TO_WDOG_TICKS(wdd->timeout)), drvdata->counter);
> 
>> Unnecessary iand confusing () around SECS_TO_WDOG_TICKS().
> 
> Fixed
> 
>>> +	gxp_wdt_enable_reload(drvdata);
>>> +	return 0;
>>> +}
>>> +
>>> +static int gxp_wdt_stop(struct watchdog_device *wdd) {
>>> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
>>> +	uint8_t val;
>>> +
>>> +	val = readb_relaxed(drvdata->control);
>>> +	val &= ~MASK_WDGCS_ENABLE;
>>> +	writeb(val, drvdata->control);
>>> +	return 0;
>>> +}
>>> +
>>> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
>>> +			       unsigned int timeout)
>>> +{
>>> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
>>> +	uint32_t actual;
> 
>> Please use u32 as suggested by checkpatch. Same everywhere.
> 
> Fixed, checkpatch did not flag this, is there an option I should be using with checkpatch.pl?

--strict

Guenter
