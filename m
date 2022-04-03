Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0722B4F07FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbiDCGDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiDCGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 02:03:39 -0400
X-Greylist: delayed 1223 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 23:01:46 PDT
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.48.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630F2A257
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 23:01:46 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 01DC0988F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:41:23 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id aszKnEVlhRnrraszKnJNLA; Sun, 03 Apr 2022 00:41:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B8Vpt4j0VXhi1wOCizFRse/0RAuRJNIB4Y5M9/3tKP0=; b=mYp6TGq8N59uC1v2h6Vf7jj7D+
        M7FdSC6XFvbA79UA4yr2Qtaq6P9zBM2v/0MW/DlR8EWROyUKNOl0V8Z1G8xV96As7/C7yxoQTRjQv
        GseHfzQgw1uJL9fReeiyvq5hvaEmlGMf92Z0JDxk3Td/Qadktbgh1kjlBIfGov8IsP8bHmzsKhj/i
        6a/aB1TnmEIPHF5b5LNnVhqfheEzvGyB/b2pyrg4Q1IH2y5gjM609sClhSTPufzLoZ50wWULkV/KW
        DLIyepDWAPkKr13c/+8GHgwTmgZa4m/EFXeWpL8N89kTg5jUxAL+m/Ko4AGdoZR9nJ8qAy5QHYsts
        Wh6YZk2Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54670)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1naszK-001qPy-D2; Sun, 03 Apr 2022 05:41:22 +0000
Message-ID: <1009cf3a-587b-307a-d1c9-efe71cd0a104@roeck-us.net>
Date:   Sat, 2 Apr 2022 22:41:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] watchdog: sp805: disable watchdog on remove
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ronenk@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, dwmw@amazon.co.uk
References: <20220403052249.48784-1-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220403052249.48784-1-farbere@amazon.com>
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
X-Exim-ID: 1naszK-001qPy-D2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54670
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 9
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 22:22, Eliav Farber wrote:
> Disable the watchdog if it is active while removing the module.
> It is necessary in order to prevent a reset in case watchdog
> hw was running before the removal.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/watchdog/sp805_wdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index d8876fba686d..d7dc0f3f16ec 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -311,6 +311,9 @@ static int sp805_wdt_remove(struct amba_device *adev)
>   {
>   	struct sp805_wdt *wdt = amba_get_drvdata(adev);
>   
> +	if (watchdog_active(&wdt->wdd))
> +		wdt_disable(&wdt->wdd);
> +

Why not use watchdog_stop_on_unregister() ?

Guenter

>   	watchdog_unregister_device(&wdt->wdd);
>   	watchdog_set_drvdata(&wdt->wdd, NULL);
>   

