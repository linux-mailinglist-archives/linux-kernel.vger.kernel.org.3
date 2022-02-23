Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8434C1990
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbiBWRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiBWRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:11:09 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD96B08A;
        Wed, 23 Feb 2022 09:10:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s5so19036087oic.10;
        Wed, 23 Feb 2022 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Ji03qACBAt40RAKIlAQ+jztbxgL4oP5r44AXEnLnuVY=;
        b=QJaDnb7OWdiHczdhEOpRvWhDQWEwJuHe8hBSeGn3bnnjIasdtQlYf1PYON0R2qOtRU
         TT4ZKnYmm+tEyryUOF0LpDR/2Id/GSZa7DQ44iOGQWXZ4jfceB0sJJAIAS16skoUpoyQ
         2f6JNAo1c1vB9ay+n5Azzf3UnKsrt3fZ7SJsG/foy3DbF7MHYwcz75tE9gGt/lKf7YzT
         n0W64YPzz4OjHvbjiXMfcxJU9mJns+FwrwK9SYjKHwscpAZKT5ZfMOJ7LMqQfhVKL9E+
         4ntNuuf18zyuVtVXM3Feuoau2nGGLrN76dAhwVdhMV9PfKi/+htSzQ0qMjVij7rwEOWh
         QSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Ji03qACBAt40RAKIlAQ+jztbxgL4oP5r44AXEnLnuVY=;
        b=WMtidH0Fq5Re7v4TxeQI1ixvs3cXZzND5YoGsW2w3s0SaZZGLZVFEkc056DhZ6cprl
         QkiO3riGgf2nmb051s7KMXEYw3rcu5Y6j2LBI3FVMlG1ZMUSsvG+HlnBu/MUkkHGqy89
         0CuJAXR6f/VLJLuBmJxEbBN/zahPeNqZMAyhzuu/fCjrAWXDqOl/jxhG79/A+eYaOGk5
         jYZObz+jYqoin0BQ2AzEnoizxCVXoIn7o+OwrcCRFFc75BhFS/axOwa9ZF/u5yM2SYBP
         +Cvz6EZepkKMhR/C8lvaa1DD/HuDM4S9WK5Va3C4P1myRQdygVsrwxA6XAws/UY1C0Rh
         o3VA==
X-Gm-Message-State: AOAM531Dz/be9PHdTcR2NHsSQJ0twOONSNZfArTNuXsJo12r6d8iEPR+
        a3XrCYxCnJDIhXQ8+uFQYQWbXrh8Yy4Ztg==
X-Google-Smtp-Source: ABdhPJyRnraa/SD8T+sL7qF2PNjOPfngCrRh2PbxOlGyhFbyoVTZw0iFoXD343ZLh9wHjmjPw5iWwA==
X-Received: by 2002:a05:6808:1b25:b0:2d7:b26:4bef with SMTP id bx37-20020a0568081b2500b002d70b264befmr320312oib.245.1645636240721;
        Wed, 23 Feb 2022 09:10:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t192sm19666oie.14.2022.02.23.09.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:10:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7cc6f708-9b9a-db6a-8048-8caa6ed57700@roeck-us.net>
Date:   Wed, 23 Feb 2022 09:10:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220223163817.30583-1-potin.lai@quantatw.com>
 <20220223163817.30583-2-potin.lai@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: (adm1275) Allow setting sample averaging
In-Reply-To: <20220223163817.30583-2-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/22 08:38, Potin Lai wrote:
> Current driver assume PWR_AVG and VI_AVG as 1 by default, and user needs to
> set sample averaging via sysfs manually.
> 
> This patch parses "pwr-avg" and "vi-avg" from device tree, and setting
> sample averaging during probe.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>   drivers/hwmon/pmbus/adm1275.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index d311e0557401..97faff4e3111 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client)
>   	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
>   	int tindex = -1;
>   	u32 shunt;
> +	u32 avg;
>   
>   	if (!i2c_check_functionality(client->adapter,
>   				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> @@ -756,6 +757,30 @@ static int adm1275_probe(struct i2c_client *client)
>   		return -ENODEV;
>   	}
>   
> +	if (data->have_power_sampling &&
> +	    of_property_read_u32(client->dev.of_node,
> +				"pwr-avg", &avg) == 0) {

Those properties will need a better name and will have to be prefixed
by the chip vendor.

> +		avg = clamp_val(avg, 1, ADM1275_SAMPLES_AVG_MAX);

clamp_val() is inappropriate for devicetree properties.
The property definition needs to include a valid range, and that range
needs to be validated and rejected if invalid.

> +		ret = adm1275_write_pmon_config(data, client,
> +						true, ilog2(avg));
> +		if (ret < 0) {
> +			dev_err(&client->dev, "set pwr-avg failed, ret = %d",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (of_property_read_u32(client->dev.of_node, "vi-avg", &avg) == 0) {
> +		avg = clamp_val(avg, 1, ADM1275_SAMPLES_AVG_MAX);
> +		ret = adm1275_write_pmon_config(data, client,
> +						false, ilog2(avg));
> +		if (ret < 0) {
> +			dev_err(&client->dev, "set vi-avg failed, ret = %d",

This needs to be more descriptive, eg "Setting voltage average failed, ...".
Same above.

> +				ret);
> +			return ret;
> +		}
> +	}
> +
>   	if (voindex < 0)
>   		voindex = vindex;
>   	if (vindex >= 0) {

