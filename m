Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFE4C5D98
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiB0Qx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiB0Qx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:53:56 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D664161D;
        Sun, 27 Feb 2022 08:53:17 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l25so11429115oic.13;
        Sun, 27 Feb 2022 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DLB+KjA+36FGogaPpx9tIXiVFKHZ9ogYrk3Bus4BHP0=;
        b=qWGBB4hiNQqW8gdR7/0UwngjJT+6gqYg7TB4J+LXyigNwiSQ6G4KwvMrGUDi8bbtAZ
         +30xHBPqF4ou2ZrvZWe2uEPQEgRPmYMbzugy0iJhb3PvEKbOVx6O/1ZdJLYQAmvgiNu+
         fDwI/bxBN1inANF8wj3VM+51fkDm6m+tdegOyUbXqO/bhOep8ETiEgyTYWb2JHdFh5C3
         Pki5V5teVw0LZP+b+k5BZgUekFEBpeuSvGgq2JxyisL/37FiM3Naumpup5pagvUnYQDA
         IqWwJQTT+MTOsYhAXSuLBCZNTShqGjc5OA1EAY2RzKI/SCteimOmfKMYzchW9bfUELXF
         XHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DLB+KjA+36FGogaPpx9tIXiVFKHZ9ogYrk3Bus4BHP0=;
        b=eGrrDcJ6DaV8zkgDw20LOuiHBL4AklsQLYqEYJ8TT598YXsAuCvwDD4G+bBN0k8KSA
         VmxtXoa+NUfAZp1JQKQR9X8thwl/MpNtXhk/IzppIdpTwN5DgCwBcgixLHaXe+nbAs+q
         0p1L2hg17vcwA4juyLeK1+Ys0aUYhbFLo1iCGRsUVaKJlW1X465OVy4jrClycozoyEuE
         dKdf0ToG7YKu1ZdUvV8FpK/QsuRI/o4PviCmTHZvIIupJjuDz8/pAK5iZi8KtkBXtJLt
         n1JNMcrnxm1DUM7Km0igGLDgX6jlzcEiau/Ai8kYvRYUJrhdQn9Ph75APyib4LR+S9G8
         lbyA==
X-Gm-Message-State: AOAM531A7t3Whg2YIafHQ6iUWzuZVxQZMNfkYkwnjExxJDGuNojbhEFV
        kFeCQEgWwTn113QT/mWW6LE=
X-Google-Smtp-Source: ABdhPJx9tE9vO89tCY1gqpvCC0eLKudt/2Yql6y4vG1v5SvmDtWMY1I+odPma2cbzqLN+JuXZ29jAQ==
X-Received: by 2002:a05:6808:1718:b0:2d7:416e:d9d9 with SMTP id bc24-20020a056808171800b002d7416ed9d9mr7845154oib.76.1645980796337;
        Sun, 27 Feb 2022 08:53:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4-20020a9d5cc4000000b005af6f4ff5e2sm3973316oti.61.2022.02.27.08.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 08:53:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a45f4294-8f2d-e0ac-abf5-b48f13c3d49e@roeck-us.net>
Date:   Sun, 27 Feb 2022 08:53:14 -0800
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

I applied the patch and made the necessary changes in
pmbus_regulator_get_error_flags(), so no need to send a patch for it.

Guenter
