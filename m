Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF314BA82D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiBQS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:27:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbiBQS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:27:00 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B890FD0B;
        Thu, 17 Feb 2022 10:26:45 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o5so9976879qvm.3;
        Thu, 17 Feb 2022 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=MMOEkIqPd1GFJyB2Iu2RQtVB2AJeO/QpJFoJ7mGMrXA=;
        b=lylzI3Jz7qhGeRMG6kHWouq6A9rI6JMcfy8RRpNKlJ6iqMiTrHWImTIw7Tl2OkJNAL
         FnXv4khs6J7dlM2ENloaTxYg+qZoK7RgJZnpz8kdYRfxyzYMa+7bobgEhNHAaxwvK0FS
         rA1sTiMy03cII0lGyHRvtqtmfVzvKWOMIWC9sOP+SeZ7rY0DKTUKlGzaSaxDCrcMkSU1
         jGmZtm3QErNogH3Dbg9hf1F+3J46J+1rOMX/b4QpRlULs6xpMyAUyPh29BJz+4Km9gxy
         NDRgaRLyOHbOWBNLhJbwgZUtQoYg1jORZK4E6io+w5NClKliVIzdv9oxA/DT38HilmpL
         HD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=MMOEkIqPd1GFJyB2Iu2RQtVB2AJeO/QpJFoJ7mGMrXA=;
        b=EaooKzVzcjRsxaSwyIKoUGlftC4ZlvTDh+XoAeuUmZTF4HlTz2SyfW+REVcX4HLkVu
         WZmq8w3xD5FzPRWLig3U9XHLM6Zqz3lVM2Xaf4TyI0RGkHqBPW9niSH+RFLUEvAgToiY
         PccvwhR80ICBgOKU3wIc/Oh8dLNJW7pw5/UpmuRU0Pn6Fnwa9n/IxGSnFX9G8X9YkImA
         67mZhO/vxdf92ujHD+j6TUPiNSO0BaUUwNhi8kid6dBUt6GRHglH4B9cXW+R3irKC38N
         3HciVqdfZguy6wX+9hihIMnP8G94v8Udrw8k6iNpa2c6Nj1HsnXjx12YkrWxoDiiyQ9C
         polg==
X-Gm-Message-State: AOAM532+Ia95CGl4LnDT3yoLhbPbIXKQBgJ3j2Wmy7D69d/kHpszPDpF
        qNZ0jk4urYI+aP/xv04o9Kc=
X-Google-Smtp-Source: ABdhPJyKX7TgIu3p4sKaHKL9k0lsYrXDoCyiEEFlrq6MGLGg7g6x1FBr/xl+JpiUjvRG3sUT9/C4WA==
X-Received: by 2002:a05:6214:c82:b0:42c:c5f3:b162 with SMTP id r2-20020a0562140c8200b0042cc5f3b162mr3226713qvr.116.1645122404767;
        Thu, 17 Feb 2022 10:26:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13sm21686688qko.114.2022.02.17.10.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:26:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net>
Date:   Thu, 17 Feb 2022 10:26:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) do not print from .probe()
In-Reply-To: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
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

On 2/16/22 23:23, Eugene Shalygin wrote:
> Remove the call to dev_info() from the board detection function, which
> is called from probe(), not only to be in line with hwmon driver rules, but
> also because the message duplicates the error code returned from probe()
> for that case (ENODEV).
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>   drivers/hwmon/asus-ec-sensors.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 0701ade16227..cbe1b987144a 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -597,18 +597,11 @@ static struct hwmon_chip_info asus_ec_chip_info = {
>   	.ops = &asus_ec_hwmon_ops,
>   };
>   
> -static unsigned long __init
> -get_board_sensors(const struct device *dev)
> +static unsigned long __init get_board_sensors(void)
>   {
> -	const struct dmi_system_id *dmi_entry;
> -
> -	dmi_entry = dmi_first_match(asus_ec_dmi_table);
> -	if (!dmi_entry) {
> -		dev_info(dev, "Unsupported board");
> -		return 0;
> -	}
> -
> -	return (unsigned long)dmi_entry->driver_data;
> +	const struct dmi_system_id *dmi_entry =
> +		dmi_first_match(asus_ec_dmi_table);
> +	return dmi_entry ? (unsigned long)dmi_entry->driver_data : 0;

Looks like you did not run checkpatch.

Either case, I think you should just drop this function In probe:

	const struct dmi_system_id *dmi_entry = dmi_first_match(asus_ec_dmi_table);

	...
	if (!dmi_entry)
		return -ENODEV;
	...
	ec_data->board_sensors = (unsigned long)dmi_entry->driver_data;

Guenter

>   }
>   
>   static int __init asus_ec_probe(struct platform_device *pdev)
> @@ -625,7 +618,7 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>   	struct device *hwdev;
>   	unsigned int i;
>   
> -	board_sensors = get_board_sensors(dev);
> +	board_sensors = get_board_sensors();
>   	if (!board_sensors)
>   		return -ENODEV;
>   

