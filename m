Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869F44EE604
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiDAC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbiDAC2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:28:46 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.4.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6674255A8A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:26:53 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id AB7CB400C5F43
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:26:52 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id a700nH5R2Hnota700n6PA0; Thu, 31 Mar 2022 21:26:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JL/R10AFXo3m+8yvx0Z1Ncw51gsFIrGlpCNnWHKID+k=; b=eDj6hmhodlrylz8YNuFxCUdKJ5
        Abq1JxKySetWQDsQJk++hoyiq3Ct5cK1h05ym8t13TCuAR417Xu05vHoG3tx/KDUjI7zdN3QVjSyX
        oV8CnCybZBETefM6shab9Pnp0YjimzYR2COrkXuRFZaAb2IM1/j1A4WAHDeNs2jN3EoaZ748hfdlV
        9oTxMJM8tadTAN2U/P0oazDZhYDIOsVSUEsCIAoda4QH4/ATJC5/5pnYMNSeVYBchgp7iDChzLsWN
        JY/8Lz1/ENJUG/LRjYktgVPipADWaT4d1XVjvdu3n6I1bnMCRDn58vTjsZOETKaKq4aVS764z3qVK
        fQA4Qzsw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54610)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1na700-0045Hw-7g; Fri, 01 Apr 2022 02:26:52 +0000
Message-ID: <a12c8a2a-1e8a-bfee-6812-969cccc6366e@roeck-us.net>
Date:   Thu, 31 Mar 2022 19:26:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     wim@linux-watchdog.org, geert+renesas@glider.be,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
References: <20220330100829.1000679-1-jjhiblot@traphandler.com>
 <20220330100829.1000679-3-jjhiblot@traphandler.com>
 <YkVFc6Q6/6rxSw89@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
In-Reply-To: <YkVFc6Q6/6rxSw89@google.com>
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
X-Exim-ID: 1na700-0045Hw-7g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54610
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 23:08, Tzung-Bi Shih wrote:
> On Wed, Mar 30, 2022 at 12:08:29PM +0200, Jean-Jacques Hiblot wrote:
>> diff --git a/drivers/watchdog/rzn1_wdt.c b/drivers/watchdog/rzn1_wdt.c
> [...]
>> +/*
>> + * Renesas RZ/N1 Watchdog timer.
>> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
>> + * cope with 2 seconds.
>> + *
>> + * Copyright 2018 Renesas Electronics Europe Ltd.
> 
> s/2018/2022/ ?
> 
>> +#define RZN1_WDT_RETRIGGER			0x0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL		0
>> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK	0xfff
>> +#define RZN1_WDT_RETRIGGER_PRESCALE		BIT(12)
>> +#define RZN1_WDT_RETRIGGER_ENABLE		BIT(13)
>> +#define RZN1_WDT_RETRIGGER_WDSI			(0x2 << 14)
> 
> Do RZN1_WDT_RETRIGGER_RELOAD_VAL and RZN1_WDT_RETRIGGER_WDSI get 1 more tab
> indent intentionally?
> 

That only looks like it due to the "+" at the beginning of the line.
If you look at the actual code the alignment is ok.

>> +static const struct watchdog_device rzn1_wdt = {
>> +	.info = &rzn1_wdt_info,
>> +	.ops = &rzn1_wdt_ops,
>> +	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
>> +};
> [...]
>> +static int rzn1_wdt_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	wdt->wdt = rzn1_wdt;
> 
> Does it really need to copy the memory?  For example,
> 
> 1. Use the memory in `wdt` directly and fill the `wdd`.
> 
> struct watchdog_device *wdd = &wdt->wdt;
> wdd->info = &rzn1_wdt_info;
> wdd->ops = &rzn1_wdt_ops;
> ...
> 
> 2. Use drvdata instead of container_of().
> 
> Use watchdog_set_drvdata() in _probe and watchdog_get_drvdata() in the
> watchdog ops to get struct rzn1_watchdog.
> 
That would indeed be preferred. The static data structure isn't really useful.

>> +static const struct of_device_id rzn1_wdt_match[] = {
>> +	{ .compatible = "renesas,rzn1-wdt" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);
> 
> Doesn't it need to guard by CONFIG_OF?
> 
Only if of_match_ptr() is used below, and then I'd prefer __maybe_unused

>> +static struct platform_driver rzn1_wdt_driver = {
>> +	.probe		= rzn1_wdt_probe,
>> +	.driver		= {
>> +		.name		= KBUILD_MODNAME,
>> +		.of_match_table	= rzn1_wdt_match,
> 
> Does it makes more sense to use of_match_ptr()?
> 

Usually we leave that up to driver authors.

>> +	},
>> +};
>> +
>> +module_platform_driver(rzn1_wdt_driver);
> 
> To make it look like a whole thing, I prefer to remove the extra blank line
> in between struct platform_driver and module_platform_driver().

We usually leave that up to driver authors. Many watchdog driver leave
an empty line, so it is ok (as long as there are no two empty lines).

Thanks,
Guenter
