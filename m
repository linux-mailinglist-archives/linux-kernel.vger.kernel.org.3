Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80034F0C9B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376492AbiDCVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 17:25:56 -0400
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com [192.185.144.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946B366AD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:24:00 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id DC07832B9D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:23:59 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id b7hXnIW62dx86b7hXnlvDm; Sun, 03 Apr 2022 16:23:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l94gkmhdFIeBvR1XcjMXTxmeKAsZIjPuc3bANEGaXH0=; b=38g9OeClcRZHqNz8qkUu1JPwvs
        GVdi/1i+FOFqjCdSHmFx/xgCCjPq6ATWk5WxXfHlLlYzfQBxpLipA8unlbTkFxfgHDxxijuAXMN/t
        +moOX/SK5AqXgzdjpJs9X3aej1pAgn7iOvDzNnMun8RbR7CwqNUurxWso6/UYWG/f3zlO1XHIUyR1
        +mBZ+lHFQ/Zzlq1tcYbtmP05zKY4NdjW+CEnyFjTZ0h+tWo7Zh+c65izNsWQ50i8JhsH52MVf+SAC
        pjLL7ElD+DxtPS6r3H0adfg5wv8MFdDBSakixR0bnMxKRpj2WjKMbKh8oDS/H2fPC2jesKOT0GDxs
        qdMkC0DA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54710)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nb7hX-0032yA-Gu; Sun, 03 Apr 2022 21:23:59 +0000
Message-ID: <71b929fd-2a4a-f2ce-8dbd-35e51235723e@roeck-us.net>
Date:   Sun, 3 Apr 2022 14:23:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220403193455.1363-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (asus_wmi_sensors) Fix CROSSHAIR VI HERO name
In-Reply-To: <20220403193455.1363-1-pauk.denis@gmail.com>
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
X-Exim-ID: 1nb7hX-0032yA-Gu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54710
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 12:34, Denis Pauk wrote:
> CROSSHAIR VI HERO motherboard is incorrectly named as
> ROG CROSSHAIR VI HERO. Issue is found by github user in [1].
> 
> [1]: https://github.com/electrified/asus-wmi-sensors/pull/79
> 

We have an official Reported-by: tag to give credit to reporters.
I don't see value in deviating from that. I can understand
if a reporter wants to remain anonymous, but then a link
to the anonymous report is pointless.

> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> 
> ---
> Changes in v2:
> - fix base commit.

That would not be a reason to send v2. Did this otherwise cause a conflict,
or is there some other problem with v1 ? If so, please provide such
information in the change log. I tried to apply v1 on top of mainline,
though, and it didn't report a conflict for me, so I am a bit confused.

Thanks,
Guenter

> ---
>   drivers/hwmon/asus_wmi_sensors.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> index c80eee874b6c..49784a6ea23a 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -71,7 +71,7 @@ static const struct dmi_system_id asus_wmi_dmi_table[] = {
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X399-A"),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X470-PRO"),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI EXTREME"),
> -	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO"),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("CROSSHAIR VI HERO"),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VI HERO (WI-FI AC)"),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO"),
>   	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VII HERO (WI-FI)"),
> 
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613

