Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3ED4C58B7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiBZXsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBZXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:48:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2DB871;
        Sat, 26 Feb 2022 15:47:45 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so6568498oti.5;
        Sat, 26 Feb 2022 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lklS8hWPQMBku0PWHRMXbokjyRLH7QCGBTWpr2u9luU=;
        b=K0271KQ9SxeofBRQWOOpVZoDMe7yd0zsp+CQfg/w1fS+eQHgjUiyFOYPpYyC2PAwNn
         N5LnbxQDXEXUnh3WjbKbMvdl+2DXQXpNOydABPGsjCjKHkk8pRuGtuB+QDTdjRpgbcIZ
         Jkm5gFVH/GUy2XkJw+cwktNRhNKPvBm2KzpIpgjptjXvkCPVvhe9Nc7zcbuxJWXMdlnh
         0VXMfTsFiKYnspFTx8WDjlgKSuPUW8EBtTViMsf3DKc5oL83ooNtHnQxLDH8mqf7q2g9
         K6hNog2zD99c/zkWfHCI8mRKHZt8OO2a4xoeSRQu40yip5Yt+odb+XzZeJOCGcrAGXuH
         +ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lklS8hWPQMBku0PWHRMXbokjyRLH7QCGBTWpr2u9luU=;
        b=L9y/QqYdWkrL8mLVU4wquVYIh7+DLu4DNIII8uSL8xTqRjpAU61cC2HWaJ+iABQQVh
         Ohczekvg6JDzszEBoITD6B07stIJEe2uuTPMEk1nN98dS1eq1/xW9JBOPb9klpTuDK9L
         S8dfv0mIgI0SPpYRbe51wa9BPYCtFOETIQOnV0iDGuLlZ9l044tVa9+hsIvcpkr9p8ei
         pl/wRox7u87zm9gZivix93RV3l1NQI2ox7rzlcenKoclvap61Ldp4VYvbAejyWRta5Tr
         KmdaHXgkbQ8JFr01QSlZuEkZ6/ZJZrdTMJYYty4SiWLZccfZ884o7oh6Mu8qzL29Mpyl
         /jIA==
X-Gm-Message-State: AOAM5336YEQb9iS7QXhbY/3Zu2mTs8ZrF9oqcMIAJeWVvydZvR2Ippf/
        eKpL61FH6iD3YyZi/iYMLig=
X-Google-Smtp-Source: ABdhPJxvSCM1F1JEeqrcKRBQbtiqxZ806zLrgk4TPi4KlRI6PCsHqDIpj834STxTXkqBMMwA/gqYLw==
X-Received: by 2002:a05:6830:2f1:b0:5af:494:1481 with SMTP id r17-20020a05683002f100b005af04941481mr6005479ote.83.1645919264372;
        Sat, 26 Feb 2022 15:47:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x60-20020a9d20c2000000b005acf97a030csm2908773ota.9.2022.02.26.15.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 15:47:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fcfe0d87-6755-a9e0-6237-fae889fbf2c7@roeck-us.net>
Date:   Sat, 26 Feb 2022 15:47:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] drivers/hwmon/pmbus: Add mutex to regulator ops
Content-Language: en-US
To:     Zev Weiss <zweiss@equinix.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <b991506bcbf665f7af185945f70bf9d5cf04637c.1645804976.git.sylv@sylv.io>
 <20220226234220.GV5754@packtop>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220226234220.GV5754@packtop>
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

On 2/26/22 15:42, Zev Weiss wrote:
> On Fri, Feb 25, 2022 at 08:06:09AM PST, Marcello Sylvester Bauer wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> On PMBUS devices with multiple pages, the regulator ops need to be
>> protected with the update mutex. This prevents accidentally changing
>> the page in a separate thread while operating on the PMBUS_OPERATION
>> register.
>>
>> Tested on Infineon xdpe11280 while a separate thread polls for sensor
>> data.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> ---
>> drivers/hwmon/pmbus/pmbus_core.c | 16 +++++++++++++---
>> 1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 776ee2237be2..f79930162256 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2386,10 +2386,14 @@ static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>> {
>> 	struct device *dev = rdev_get_dev(rdev);
>> 	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> 	u8 page = rdev_get_id(rdev);
>> 	int ret;
>>
>> +	mutex_lock(&data->update_lock);
>> 	ret = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
>> +	mutex_unlock(&data->update_lock);
>> +
>> 	if (ret < 0)
>> 		return ret;
>>
>> @@ -2400,11 +2404,17 @@ static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
>> {
>> 	struct device *dev = rdev_get_dev(rdev);
>> 	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	struct pmbus_data *data = i2c_get_clientdata(client);
>> 	u8 page = rdev_get_id(rdev);
>> +	int ret;
>>
>> -	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>> -				      PB_OPERATION_CONTROL_ON,
>> -				      enable ? PB_OPERATION_CONTROL_ON : 0);
>> +	mutex_lock(&data->update_lock);
>> +	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>> +				     PB_OPERATION_CONTROL_ON,
>> +				     enable ? PB_OPERATION_CONTROL_ON : 0);
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	return ret;
>> }
>>
>> static int pmbus_regulator_enable(struct regulator_dev *rdev)
>> -- 
>> 2.35.1
>>
>>
> 
> Looks like this doesn't cover pmbus_regulator_get_error_flags(), which
> was added recently -- perhaps rebase onto hwmon-next?
> 

This is a bug fix which needs to be applied to stable releases, or am I
missing something ?

Guenter
