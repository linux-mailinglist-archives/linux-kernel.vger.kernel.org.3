Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7887850D33C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiDXQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiDXQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:22:53 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFF1606AB;
        Sun, 24 Apr 2022 09:19:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v65so9929156oig.10;
        Sun, 24 Apr 2022 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4tNCsdnlVnPEJ7/xhc5Cq22tippVdust1ZNiw0N7EtA=;
        b=Jd1/eSljZ1f2OryQk8wmUVQZbEffQoMUhrL8PFGn1II4+G604oiaQSCWK46EHa9HEi
         dFCZZKpkd0XjKaUBBgYfpj+kQz8CoEErL6uOC9fo3tc6sx4XtDYoNyqqvLJW6/zSJVat
         q/64W2dCQK4HoRO5K9teE3c1rbGAGn/e/OlYH/Eqn41+iuKg6FOZrV5563TmXby6FQqW
         iwvKpGkO5wJ7GqLlEZzhiTbX4bAVElj3/8mwpSTLSvrFxkg8Mohdk9I154arU0sUC5Gt
         hhkgYyiSkIqRjQtibdB6ggsQtBCWFfbOZmALGKHKvCBTKrSd3z64xBkdCghdAtlI7YLI
         jxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4tNCsdnlVnPEJ7/xhc5Cq22tippVdust1ZNiw0N7EtA=;
        b=zRjhcTZPyPGbgbrnR15/gDtp4mwEM4L02Gt3gDTpUjKIJDZHuggY7zUVieO7fDfHug
         ATXccZDhUR52qID34WJI6RL5dnJVGdGEBNjir8aDRGecZ2OiATp59Fz/UGVfWcQCaRVT
         QSXVfOH0bDbHmYhY9kzpQDpqn/zTYCqOHk2O7OxdPg7Ocjs4wSvnDDp/35GHjq+MU+d7
         DuWYRcZ55D9w0YSqXNKSMXdlDbDP+UY3bMJOo6lbx/Imv/fayqExjq78epqbL5bQ3krY
         irgsCRKrpsFZpNDfN/8zUrTyHdsQQgvB8V+y7jAnRthaWkZas0z80I3fbLm2ajIxhYKa
         H2Dw==
X-Gm-Message-State: AOAM530HwyQ59ea5GeExbGMoe9u7J7v2bx5mgZfq2W/O0j4t+9GvSAm8
        /e8XABXNw23pxpqPRt5VBnE=
X-Google-Smtp-Source: ABdhPJzp5UJS8K9KqriWBEetcOKWxWj90jUPJ370wZJnUrNCtpB65v5aAKHrP6qpIHK5OsSXsIfRzw==
X-Received: by 2002:aca:f389:0:b0:322:3753:bf51 with SMTP id r131-20020acaf389000000b003223753bf51mr10155645oih.44.1650817191970;
        Sun, 24 Apr 2022 09:19:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a4a85c7000000b0035c12c8be73sm3317675ooh.29.2022.04.24.09.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 09:19:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <665df671-23bb-475d-5148-8613cb6cf16c@roeck-us.net>
Date:   Sun, 24 Apr 2022 09:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (pmbus/max16601) Add MAX16602 support
Content-Language: en-US
To:     "Ofluoglu, Atif" <Atif.Ofluoglu@analog.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
References: <BYAPR03MB40063CFD52C6D8831A8740AD8AEE9@BYAPR03MB4006.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <BYAPR03MB40063CFD52C6D8831A8740AD8AEE9@BYAPR03MB4006.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 07:06, Ofluoglu, Atif wrote:
>>From e2a1f7d1a836188a9b284fc473af9118aa160ddb Mon Sep 17 00:00:00 2001
> From: Atif Ofluoglu <mailto:atif.ofluoglu@maximintegrated.com>
> Date: Fri, 15 Apr 2022 16:34:29 +0300
> Subject: [PATCH] hwmon: (pmbus/max16601) Add MAX16602 support
> 
> Adding another MAX16602 chip support to MAX16601 driver
> Tested with MAX16602 works as expected.
> 
> Signed-off-by: Atif Ofluoglu <mailto:atif.ofluoglu@maximintegrated.com>

Never mind, applied. The problem was that your e-mail system adds
"mailto:" to all e-mail addresses. See above and in the patch.
Also, the actual patch was embedded in another e-mail frame which
confused git. After fixing that up, that the patch applied cleanly.
In the future, please make sure that your e-mail system leaves
any patches you send alone.

Thanks,
Guenter

> ---
>   Documentation/hwmon/max16601.rst |  8 ++++++++
>   drivers/hwmon/pmbus/Kconfig      |  4 ++--
>   drivers/hwmon/pmbus/max16601.c   | 13 ++++++++-----
>   3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/hwmon/max16601.rst b/Documentation/hwmon/max16601.rst
> index 92c0a7d7808c..6a4eef8efbaf 100644
> --- a/Documentation/hwmon/max16601.rst
> +++ b/Documentation/hwmon/max16601.rst
> @@ -21,6 +21,14 @@ Supported chips:
>   
>       Datasheet: Not published
>   
> +  * Maxim MAX16602
> +
> +    Prefix: 'max16602'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX16602.pdf
> +
>   Author: Guenter Roeck <mailto:linux@roeck-us.net>
>   
>   
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index a2ea1d5a8765..53683d2d0fb2 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -228,10 +228,10 @@ config SENSORS_MAX16064
>   	  be called max16064.
>   
>   config SENSORS_MAX16601
> -	tristate "Maxim MAX16508, MAX16601"
> +	tristate "Maxim MAX16508, MAX16601, MAX16602"
>   	help
>   	  If you say yes here you get hardware monitoring support for Maxim
> -	  MAX16508 and MAX16601.
> +	  MAX16508, MAX16601 and MAX16602.
>   
>   	  This driver can also be built as a module. If so, the module will
>   	  be called max16601.
> diff --git a/drivers/hwmon/pmbus/max16601.c b/drivers/hwmon/pmbus/max16601.c
> index 5a226a564776..b628405e6586 100644
> --- a/drivers/hwmon/pmbus/max16601.c
> +++ b/drivers/hwmon/pmbus/max16601.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Hardware monitoring driver for Maxim MAX16508 and MAX16601.
> + * Hardware monitoring driver for Maxim MAX16508, MAX16601 and MAX16602.
>    *
>    * Implementation notes:
>    *
> @@ -31,7 +31,7 @@
>   
>   #include "pmbus.h"
>   
> -enum chips { max16508, max16601 };
> +enum chips { max16508, max16601, max16602 };
>   
>   #define REG_DEFAULT_NUM_POP	0xc4
>   #define REG_SETPT_DVID		0xd1
> @@ -202,7 +202,7 @@ static int max16601_identify(struct i2c_client *client,
>   	else
>   		info->vrm_version[0] = vr12;
>   
> -	if (data->id != max16601)
> +	if (data->id != max16601 && data->id != max16602)
>   		return 0;
>   
>   	reg = i2c_smbus_read_byte_data(client, REG_DEFAULT_NUM_POP);
> @@ -264,6 +264,7 @@ static void max16601_remove(void *_data)
>   static const struct i2c_device_id max16601_id[] = {
>   	{"max16508", max16508},
>   	{"max16601", max16601},
> +	{"max16602", max16602},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(i2c, max16601_id);
> @@ -280,13 +281,15 @@ static int max16601_get_id(struct i2c_client *client)
>   		return -ENODEV;
>   
>   	/*
> -	 * PMBUS_IC_DEVICE_ID is expected to return "MAX16601y.xx"
> -	 * or "MAX16500y.xx".
> +	 * PMBUS_IC_DEVICE_ID is expected to return "MAX16601y.xx" or
> +	 * MAX16602y.xx or "MAX16500y.xx".cdxxcccccccccc
>   	 */
>   	if (!strncmp(buf, "MAX16500", 8)) {
>   		id = max16508;
>   	} else if (!strncmp(buf, "MAX16601", 8)) {
>   		id = max16601;
> +	} else if (!strncmp(buf, "MAX16602", 8)) {
> +		id = max16602;
>   	} else {
>   		buf[ret] = '\0';
>   		dev_err(dev, "Unsupported chip '%s'\n", buf);

