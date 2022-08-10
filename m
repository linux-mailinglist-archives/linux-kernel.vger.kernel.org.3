Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654C58EC57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiHJMxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiHJMxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:53:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FBA7E827;
        Wed, 10 Aug 2022 05:52:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f11so14257419pgj.7;
        Wed, 10 Aug 2022 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=AntC5mRDzJTqMnizzXcGjI604N3lWRDUOH1hw5226rg=;
        b=TcyZu08ifEO7Hr7qHyiXZk8WMISO4ddMtJ5adxJwMfnAuUQnwDuae34T81/9W3cvwL
         1cLkZI/UzxKWf4H6H9vQd3Up8pAjNxegzJvnH9+LRdP9jLKLLYY7ZpNg9PMFIrR3OVOu
         eOGj8ahdQkneouAzrgUC2I/PBaEgegz4aeVWuIwjf5SRRACkSv2TFzK/dkfSV/Acnjtv
         i9UjUjUFwAIOQaFZOgHF59kxmngugqkzpDd3IXtbk5egT/8FMO6GMJ++d5/mCJscs0WP
         QwcQ/hjYBZ8X02wvV+NWkl/TZ0dYV4DfdeggDJv0oEdj6KVGLbyyaiHoQGdvCZE4z+IO
         kwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=AntC5mRDzJTqMnizzXcGjI604N3lWRDUOH1hw5226rg=;
        b=Ynsfv32UGEp01Y4EQzizwVs1dxo3UwRZFmruVOl9HrA/UWBPAYPkyenj/zks4ujt0n
         ft7CDwYGmrEf0lGE8+mj6Y5W3zOAEB8iE4RTwmwvtru8PCOnECQgXI3lqxMgj7aUy/q0
         Rq5Wdy9nlOoeJp1mHzEAF6bJqDAmWyslcxaAgvOAYRuHdheudUm98qKkPgws5JpNhrCW
         9gGnIO9gGJx8pSuhnezBad2UH/J9iX3ZzhQJ/MtcolR1nsd8HHOIj1fHigS5sRA2HkLA
         ShqcgMwVr6M7WXjFIp6u9tr8m1Dq//FfBsQh2hrlfcZ7/t+EVC7HKwNVDRwoqy9cXyWU
         yzbg==
X-Gm-Message-State: ACgBeo0zN3WZxSLa2I2s3eUTZdbcB6IbbZ/XOJKYbqawhPVe+H5rfr1+
        AmxuBynFIbqducOm2dqWTEVq6QcLemQ=
X-Google-Smtp-Source: AA6agR7y4+2XTKx0yON0/9igDgzYahoYSfO3zhsgie6o7dVjVyRYiHlaZUk786YDWzEQ+M/L7UFakA==
X-Received: by 2002:a05:6a00:3408:b0:52f:9dd0:4b21 with SMTP id cn8-20020a056a00340800b0052f9dd04b21mr8758660pfb.39.1660135979503;
        Wed, 10 Aug 2022 05:52:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902cad100b0016d9d6d05f7sm12543100pld.273.2022.08.10.05.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:52:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2c78b4e7-f481-e29d-1196-a1b73d232635@roeck-us.net>
Date:   Wed, 10 Aug 2022 05:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        matti.vaittinen@fi.rohmeurope.com
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1660127865.git.mazziesaccount@gmail.com>
 <4565950ddca2f78209dad49e169d4af7517db27e.1660127865.git.mazziesaccount@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 6/7] hwmon: lm90: simplify using
 devm_regulator_get_enable()
In-Reply-To: <4565950ddca2f78209dad49e169d4af7517db27e.1660127865.git.mazziesaccount@gmail.com>
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

On 8/10/22 04:32, Matti Vaittinen wrote:
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable().
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/lm90.c | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 3820f0e61510..2ab561ec367c 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -1848,12 +1848,6 @@ static void lm90_remove_pec(void *dev)
>   	device_remove_file(dev, &dev_attr_pec);
>   }
>   
> -static void lm90_regulator_disable(void *regulator)
> -{
> -	regulator_disable(regulator);
> -}
> -
> -
>   static const struct hwmon_ops lm90_ops = {
>   	.is_visible = lm90_is_visible,
>   	.read = lm90_read,
> @@ -1865,24 +1859,13 @@ static int lm90_probe(struct i2c_client *client)
>   	struct device *dev = &client->dev;
>   	struct i2c_adapter *adapter = client->adapter;
>   	struct hwmon_channel_info *info;
> -	struct regulator *regulator;
>   	struct device *hwmon_dev;
>   	struct lm90_data *data;
>   	int err;
>   
> -	regulator = devm_regulator_get(dev, "vcc");
> -	if (IS_ERR(regulator))
> -		return PTR_ERR(regulator);
> -
> -	err = regulator_enable(regulator);
> -	if (err < 0) {
> -		dev_err(dev, "Failed to enable regulator: %d\n", err);
> -		return err;
> -	}
> -
> -	err = devm_add_action_or_reset(dev, lm90_regulator_disable, regulator);
> +	err = devm_regulator_get_enable(dev, "vcc");
>   	if (err)
> -		return err;
> +		return dev_err_probe(dev, err, "Failed to enable regulator\n");
>   
>   	data = devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
>   	if (!data)

