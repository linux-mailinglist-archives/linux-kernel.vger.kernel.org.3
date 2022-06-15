Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8A54D088
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbiFOR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357888AbiFOR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:58:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9F2A413;
        Wed, 15 Jun 2022 10:57:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2823618pjl.5;
        Wed, 15 Jun 2022 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Pdm0v/eHuTn8EFkDzG/jFCh8QYUQn580u0Hjxv+TmSs=;
        b=O6gq5i4RqzsvkWTYJsuMFS8kKcm670FI0T+LsWRMSujkkRhttepRtBbCuuV3sdBHxN
         ZkKf9wTiZH+763xUbde92AiQDVe8Rkf4d/gLKDxvlYd0Uxi68FfSA5rHgmyJJSX26up8
         uuQk//BHaJJJULhr8k+0pnWJTy4DAA4b66GUVVCAC9kbEJwzyBj/XsDcbRnZzy49agjI
         mPKoDUTSTjacxo8afX8af66SfRrc1La9rhayTXyDofnCPzDCKIVLxFcjN1QeOImSTLAS
         4d5otv6SXN9r5HnnYp1EzNpnAe4fM4/Ii7YdbbN8xeOr7bA2HBIJwf8meWNLqGce+jDS
         VO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Pdm0v/eHuTn8EFkDzG/jFCh8QYUQn580u0Hjxv+TmSs=;
        b=ykaqRWSSoTdhkDT7EdKVELiP917YlABZkdL3jnOraWJftSXye39adoHRO89okbhA4p
         7ff8oFsEm8lH930X+jmRNvJ8HW9igVl3VaUn3B2H1L0KA3RSH2dACH0iVf0sw9FCgrCk
         +iivZiIMmTw4k+loe45N+DJHjApBX5W+1Mn40ZtTkjwSyQe8kudkH9z+U5Zy1WRiW+Nr
         thiX9Dl0apza57FiB3OuEuQGB93itnW48VbuFs+craSfAjAZfHIFBZ4xWf8sqoW/QlCh
         caZXbGihq2I+9nrCa7FxRR4OoBws0J/gwib/XT73ofkq5IS9eoOr6j4FwmygY3hSejmT
         p79Q==
X-Gm-Message-State: AJIora9IytRHVlA8PDUGaYX6cTq6J4drYovVzMpuoTYlixGfsXFEdPId
        QS680cu5MjGutd1ZiWzF9XI=
X-Google-Smtp-Source: AGRyM1tYNZ3eEVpA869lUoIGayFw5Kmo3S5lbWkKwlKXn5LAschra1zSpqfs75aKZ+F5PiYuACDC8Q==
X-Received: by 2002:a17:90b:4f4a:b0:1e3:49c9:aab0 with SMTP id pj10-20020a17090b4f4a00b001e349c9aab0mr11518167pjb.223.1655315871910;
        Wed, 15 Jun 2022 10:57:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p5-20020a170903248500b0015e8d4eb1c8sm5961816plw.18.2022.06.15.10.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:57:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <01243e3e-f4d2-c1ba-98f5-db7bc0c62adc@roeck-us.net>
Date:   Wed, 15 Jun 2022 10:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Liang He <windhl@126.com>, tharvey@gateworks.com,
        rjones@gateworks.com, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615151856.3970186-1-windhl@126.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] drivers: hwmon: Add missing of_node_put() in gsc-hwmon.c
In-Reply-To: <20220615151856.3970186-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 08:18, Liang He wrote:
> In gsc_hwmon_get_devtree_pdata(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_node_put() in
> fail path or when it is not used anymore.
>  > Signed-off-by: Liang He <windhl@126.com>
> ---

Please use proper subject lines. Here it should have been

hwmon: (gsc-hwmon) Add missing of_node_put()

>   drivers/hwmon/gsc-hwmon.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 1fe37418ff46..34c20d13627a 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -268,10 +268,14 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
>   
>   	/* fan controller base address */
>   	fan = of_find_compatible_node(dev->parent->of_node, NULL, "gw,gsc-fan");

A single of_node_put(fan) here would have been be sufficient.

> -	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {
> +	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {		
> +		of_node_put(fan);
>   		dev_err(dev, "fan node without base\n");
>   		return ERR_PTR(-EINVAL);
>   	}
> +	
> +	/* if fan&&!of_property_read_u32 fail */

This comment only adds confusion and does not add any value.

Guenter

> +	of_node_put(fan);
>   
>   	/* allocate structures for channels and count instances of each type */
>   	device_for_each_child_node(dev, child) {

