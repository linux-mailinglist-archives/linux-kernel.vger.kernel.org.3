Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4048B4E194A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbiCTBCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 21:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiCTBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 21:02:52 -0400
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774C13CDC
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 18:01:30 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 4FB0A3744E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 20:01:29 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id Vjwnn5F1WRnrrVjwnnV1pq; Sat, 19 Mar 2022 20:01:29 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=97ckXJWSbFWlyPLu7x4hQXrKqLD7BzyxnLplgIRpISY=; b=1dw2GQO5iXUJj8EQVLW1w3DzKj
        p9fs284lq4mq+zcqotJcYKnQCGUkb/GOYowvCHOPKKkiHxnLJ7WK9PSDhbl6sRLAlUptOwGwpUKJV
        0V2/ENKz0rHcxjfCpM6kYGyBKVaWTiwvQt8KHEHD3HoZf75Oy6XmaeRlsIBQcJaDDNyZzUOZEBI8F
        526qkrfHsUaAaCOW0QfJLCLJLM/EfGomYcfQlrLJH0vz1yI5q9ectpcdXLJ08EYzuLBjjOqDFdJGt
        8Ym/8TUg1dfGku6+F9xYYNx9+8uuXbOJEx25n0EKyYBzHTCC++1yr3XURlrff2sltuh9jMGtYU9My
        CF0P8G2Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54346)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nVjwm-004JcH-RX; Sun, 20 Mar 2022 01:01:28 +0000
Message-ID: <9cec7367-e6ec-5fe4-94ce-c908452c9385@roeck-us.net>
Date:   Sat, 19 Mar 2022 18:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drivers: hwmon: jc42: add HWMON_C_TZ_REGISTER
Content-Language: en-US
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <evalenti@kernel.org>
References: <20220318233011.13980-1-eduval@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220318233011.13980-1-eduval@amazon.com>
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
X-Exim-ID: 1nVjwm-004JcH-RX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54346
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/22 16:30, Eduardo Valentin wrote:
> Add a thermal zone interface to the devices added
> under jc42 driver. This way, thermal zones described
> in device tree can make use of the of nodes of these
> devices.
> 

Makes sense. I'll apply the patch, but it is a functional change
and a bit too risky to include in the upcoming commit window.
I'll apply it after the commit window closes.

Thanks,
Guenter

> Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:JC42.4 TEMPERATURE SENSOR DRIVER)
> Cc: Jean Delvare <jdelvare@suse.com> (maintainer:HARDWARE MONITORING)
> Cc: linux-hwmon@vger.kernel.org (open list:JC42.4 TEMPERATURE SENSOR DRIVER)
> Cc: linux-kernel@vger.kernel.org (open list)
> 
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
> ---
>   drivers/hwmon/jc42.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index cb347a6bd8d9..f40df2f29d41 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -443,6 +443,8 @@ static int jc42_detect(struct i2c_client *client, struct i2c_board_info *info)
>   }
>   
>   static const struct hwmon_channel_info *jc42_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
>   	HWMON_CHANNEL_INFO(temp,
>   			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
>   			   HWMON_T_CRIT | HWMON_T_MAX_HYST |

