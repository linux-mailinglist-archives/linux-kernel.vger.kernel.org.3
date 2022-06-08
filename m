Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A8543177
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiFHNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbiFHNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:35:13 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242479812;
        Wed,  8 Jun 2022 06:35:12 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a21-20020a9d4715000000b0060bfaac6899so6331304otf.12;
        Wed, 08 Jun 2022 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=reeEQFh3LC+qo5qJsG50K2d+1BfirPZvoFmPWWCV21k=;
        b=FLMoALnyTnERra43UvuFn2V/33O7N6SPVyl0xbbN4Qt/ktoRjNyQtlYdHXiJZiCZDf
         AhRMW7BtKSwvZlopqe8y421EvWO7rEwLdirgBQM91pHVeppLRawN6WFt01vL/tSVRL6K
         Q+LQIeLzOp/nhj3xasZOPAmtg54Q6HDzw7aTtxlhWzpHHcwwP9YEJBYh0TFU94GYfRka
         WUrdlnil8DqcUHBYycfVGdkF1xtHE5kOF2Fpt206v/9I11QlXOmLfsTn5nuao1VSIg+e
         rxO+h7AynTqKOiK77KYO3A+oShOrxjRtby/ug1XHjXrK3GHqlHAl31bYcVxJf8EK4lIY
         OJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=reeEQFh3LC+qo5qJsG50K2d+1BfirPZvoFmPWWCV21k=;
        b=hulCknG6HrbMcGOIsMe8AE6R593otXq91CHiSRezZ1JG5E5o1tkD415a4G5lA6W4aB
         do1G6GBUoUzPIyn3pRTHnruFHDrNiZLDiUvdY+QCEAzlli75p8VKEK/VKiEPpT1TZifr
         2AuEBDiAGblVyZXpaeT99SxLfUZJIKuLY6NxuTq/RzPR0mTrQvWym3CBqGwt5MvLaOdG
         VaugfYwhJ4ABrQc90Hn2OjiMsqUFf0yIwjEpi9W7XgBUoHvZrQv06DSjmUBt+tTWSPhE
         IiYbY6fatCz2wCAlCG+drxYH2lG9JYupheAI5YX0K2JSGrJCXdaVSDxWg+PfztMpjZIZ
         ZfbA==
X-Gm-Message-State: AOAM533TRRPc/gfjpzHA1utIT/qIPcT4xtRp9ck45wXsi0uoqRB8oEfR
        8m3//F+mA6HRDYyXPRrZ9wP2Z9IHBEY=
X-Google-Smtp-Source: ABdhPJzvc/FWIfgIz7FsKylJBgpgQCFULzxPsWjlIYAw/LqW/aQ25YEZ8KWpGjhBp9jv7AWpx5zzMg==
X-Received: by 2002:a9d:63ce:0:b0:60b:fc2f:88c2 with SMTP id e14-20020a9d63ce000000b0060bfc2f88c2mr6146675otl.103.1654695312004;
        Wed, 08 Jun 2022 06:35:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l8-20020a4ae388000000b0041b87a7a654sm3549935oov.37.2022.06.08.06.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 06:35:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76e05a85-b8c3-eaa5-727e-d8dc8f1c0672@roeck-us.net>
Date:   Wed, 8 Jun 2022 06:35:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] hwmon: (pmbus) fix build error unused-function
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, jdelvare@suse.com,
        dev_public@wujek.eu
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608084938.173071-1-renzhijie2@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220608084938.173071-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/8/22 01:49, Ren Zhijie wrote:
> If CONFIG_PMBUS is y and CONFIG_DEBUG_FS is not set.
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
> drivers/hwmon/pmbus/pmbus_core.c:593:13: error: ‘pmbus_check_block_register’ defined but not used [-Werror=unused-function]
>   static bool pmbus_check_block_register(struct i2c_client *client, int page,
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [drivers/hwmon/pmbus/pmbus_core.o] Error 1
> make[2]: *** [drivers/hwmon/pmbus] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers/hwmon] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> To fix building warning, wrap all related code with CONFIG_DEBUG_F.

Please use __maybe_unused for the affected functions instead.

Thanks,
Guenter

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c3ffc3a1ff83("hwmon: (pmbus) add a function to check the presence of a block register")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 56 ++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 809e666cb52b..2c68ab1fe697 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -441,18 +441,6 @@ int pmbus_update_byte_data(struct i2c_client *client, int page, u8 reg,
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_update_byte_data, PMBUS);
>   
> -static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
> -				 char *data_buf)
> -{
> -	int rv;
> -
> -	rv = pmbus_set_page(client, page, 0xff);
> -	if (rv < 0)
> -		return rv;
> -
> -	return i2c_smbus_read_block_data(client, reg, data_buf);
> -}
> -
>   static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, int page,
>   					      int reg)
>   {
> @@ -590,22 +578,6 @@ bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
>   }
>   EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);
>   
> -static bool pmbus_check_block_register(struct i2c_client *client, int page,
> -				       int reg)
> -{
> -	int rv;
> -	struct pmbus_data *data = i2c_get_clientdata(client);
> -	char data_buf[I2C_SMBUS_BLOCK_MAX + 2];
> -
> -	rv = pmbus_read_block_data(client, page, reg, data_buf);
> -	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
> -		rv = pmbus_check_status_cml(client);
> -	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
> -		data->read_status(client, -1);
> -	pmbus_clear_fault_page(client, -1);
> -	return rv >= 0;
> -}
> -
>   const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
>   {
>   	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2961,6 +2933,34 @@ static int pmbus_regulator_register(struct pmbus_data *data)
>   static struct dentry *pmbus_debugfs_dir;	/* pmbus debugfs directory */
>   
>   #if IS_ENABLED(CONFIG_DEBUG_FS)
> +static int pmbus_read_block_data(struct i2c_client *client, int page, u8 reg,
> +				 char *data_buf)
> +{
> +	int rv;
> +
> +	rv = pmbus_set_page(client, page, 0xff);
> +	if (rv < 0)
> +		return rv;
> +
> +	return i2c_smbus_read_block_data(client, reg, data_buf);
> +}
> +
> +static bool pmbus_check_block_register(struct i2c_client *client, int page,
> +				       int reg)
> +{
> +	int rv;
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	char data_buf[I2C_SMBUS_BLOCK_MAX + 2];
> +
> +	rv = pmbus_read_block_data(client, page, reg, data_buf);
> +	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
> +		rv = pmbus_check_status_cml(client);
> +	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
> +		data->read_status(client, -1);
> +	pmbus_clear_fault_page(client, -1);
> +	return rv >= 0;
> +}
> +
>   static int pmbus_debugfs_get(void *data, u64 *val)
>   {
>   	int rc;

