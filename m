Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6E5089D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379225AbiDTN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354174AbiDTN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:56:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946BF40E42;
        Wed, 20 Apr 2022 06:53:40 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id z8so2111646oix.3;
        Wed, 20 Apr 2022 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=snwrcyB5dk/IDXf01z+/JfLp/Kk3Tv+Sf5yYHFawuEs=;
        b=FpeZ8sCLLzd35nfIMsEWMtv7FHuRXIz5OD7ozLV5X8UTT80+mGOjX9el5EWs6mrjBF
         Ma14BCFr/AWadx65FtKvKhCbW5mZaYftNnF/dKXGB+O/MP1lrh2BjFTbnuyzfXtJtFrQ
         G8G6VF9NsRA+3shI5zkDdpTje1eJM25Pw/qVIQWIt2D3dqlfwU2XHZ1njvPC2DRfCMpB
         RJg1r8Yr2X+0+F2ss2Oa7Dja2UqfjunTWwUqdDy8r4sYuvHOv51A33volIHIT3qCD26t
         DKZL1GnhV6sLcHC3y6J72FiCQDcO876w2IHmKqDdF6kd866lO6/E8NNaLWKeVePudoms
         eGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=snwrcyB5dk/IDXf01z+/JfLp/Kk3Tv+Sf5yYHFawuEs=;
        b=vgKsi+YPU9hc8qCcffP0IaSH8G6WKJUNs8eLDVArx9lpGeXTG++jqLdKrlhZaLDFBd
         v5X7qKP/jA/8p41sl2WC7yhlGRJmxTPXdmHv1jHZuPaeYDCBQbK9I02fYao/kKIWcLgj
         Gc2daJ+urcqONosRcHfgWYdoZizAh15TYWYLHqr2q93P9yRdXHQ1Ld7ugYk75BeUN/4H
         a9bfO1pTRU7i3mc68yp6wMUALNuRjGipExl9RANqKjXy2U9xOW6Jyd0cfKR5yu+R/LiK
         DQBmcR9zVF5eXT1h5I9RvG1m8PTsNgZWAYuZxohU+put/hmEcWreQca2HPa1irkVijlA
         Z5Og==
X-Gm-Message-State: AOAM531kdQJ9Rzl3acNk9tNNUsVzDJxVik50llTtul7WLi3XriD+ZuM5
        JXW1jrjc7mKc00ZM7WuDzlSfCQ7Eio0=
X-Google-Smtp-Source: ABdhPJxfllOmzrET/z5fFDJxh5RKC+OJeWrmG06X+aM8zEkrSCSQW2pd1GJcjpPXUVq6bBnjZJCVsg==
X-Received: by 2002:aca:3e55:0:b0:322:7604:8b13 with SMTP id l82-20020aca3e55000000b0032276048b13mr1747711oia.111.1650462819935;
        Wed, 20 Apr 2022 06:53:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3-20020aca4403000000b002ecf4d70c83sm6166993oia.27.2022.04.20.06.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 06:53:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f34ec7ac-7b34-6d98-25ad-31b13fe08c59@roeck-us.net>
Date:   Wed, 20 Apr 2022 06:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] hwmon: (pmbus) add MFR_* registers to debugfs
Content-Language: en-US
To:     Adam Wujek <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419215326.309991-1-dev_public@wujek.eu>
 <20220420122128.411757-1-dev_public@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220420122128.411757-1-dev_public@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 05:22, Adam Wujek wrote:
> Add registers to debugfs:
> PMBUS_MFR_ID
> PMBUS_MFR_MODEL
> PMBUS_MFR_REVISION
> PMBUS_MFR_LOCATION
> PMBUS_MFR_DATE
> PMBUS_MFR_SERIAL
> 
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>

Where is patch 1/2, and why did you resend this patch ?

Guenter

> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 0af7a3d74f47..1dc186780ccf 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2625,6 +2625,30 @@ static int pmbus_debugfs_get_status(void *data, u64 *val)
>   DEFINE_DEBUGFS_ATTRIBUTE(pmbus_debugfs_ops_status, pmbus_debugfs_get_status,
>   			 NULL, "0x%04llx\n");
> 
> +static ssize_t pmbus_debugfs_mfr_read(struct file *file, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	int rc;
> +	struct pmbus_debugfs_entry *entry = file->private_data;
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +
> +	rc = i2c_smbus_read_block_data(entry->client, entry->reg, data);
> +	if (rc < 0)
> +		return rc;
> +
> +	data[rc] = '\n';
> +	rc += 2;
> +
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static const struct file_operations pmbus_debugfs_ops_mfr = {
> +	.llseek = noop_llseek,
> +	.read = pmbus_debugfs_mfr_read,
> +	.write = NULL,
> +	.open = simple_open,
> +};
> +
>   static int pmbus_debugfs_get_pec(void *data, u64 *val)
>   {
>   	struct i2c_client *client = data;
> @@ -2801,6 +2825,66 @@ static int pmbus_init_debugfs(struct i2c_client *client,
>   					    &entries[idx++],
>   					    &pmbus_debugfs_ops);
>   		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_ID)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_ID;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_id", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_MODEL)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_MODEL;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_model", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_REVISION)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_REVISION;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_revision", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_LOCATION)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_LOCATION;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_location", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_DATE)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_DATE;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_date", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
> +
> +		if (pmbus_check_byte_register(client, i, PMBUS_MFR_SERIAL)) {
> +			entries[idx].client = client;
> +			entries[idx].page = i;
> +			entries[idx].reg = PMBUS_MFR_SERIAL;
> +			scnprintf(name, PMBUS_NAME_SIZE, "mfr%d_serial", i);
> +			debugfs_create_file(name, 0444, data->debugfs,
> +					    &entries[idx++],
> +					    &pmbus_debugfs_ops_mfr);
> +		}
>   	}
> 
>   	return devm_add_action_or_reset(data->dev,
> --
> 2.25.1
> 
> 

