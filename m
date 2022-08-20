Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23359AE78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347157AbiHTN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiHTN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:26:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB85D0C0;
        Sat, 20 Aug 2022 06:26:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w23so1671358ljj.7;
        Sat, 20 Aug 2022 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=NcFDh4UDcPbq9UdI2AkFMxI9zTEsc2ylz8q0khcgSEs=;
        b=aoz8iZB37JcZnfbbvy1muasJ5P1lkuMB0btREoNJ2+HnH3vptywQt8c29Egdg83wNr
         AR7OW9hv32gY7CxmL7OCZM6iu9e8oOJnxFR54E/0M2nFd5VJ+9XwADTcGSE64mMNmId9
         RgLFRI9ve1NIek5bNLP+6JwPE9oWx7Z4CZ98f8pI1kZAKJHxWI8xm+vtUFTmOjUxgFYp
         eUqncH2npEn4GKhY47OrneUgR6k9smbX0IoGLMQuoYKl3Si2rpNmh7ioqMy4Z25zA6mO
         fVNC+DPnA69PasWh6nPmBgT6eis31mgYBzdciKyS4nzRjvlTitQY9YjoD9KXpDuINOMw
         A6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=NcFDh4UDcPbq9UdI2AkFMxI9zTEsc2ylz8q0khcgSEs=;
        b=NkV9fycRr6xY6u3GUO+sfADGh9vGQrgwZPwErtXlBFXOTIMfbpIXUFzEtYOBL0IB2o
         ElzEb5orDNhZVEUD0bnkJMbgsC90ch+zl2xIjhEaJGajK0AHTEORhuikimC33t8hM6Nn
         cgTLe5pCM2rE22jgiZfYUGkeBY0ADMDvlNZzTaUWUM/0JNjUar631E0hRmuPK5B1S6Al
         Pdw5dzb8FjainCO+YRUNbjnsjpNgESRE0BtoDAXWLXi9E9JznsZcJ6Lqpj90/HmuzfBF
         IIR4+rH024aG8+LNjvcYPXVnZm9ZhgEcn7NxxDVQQPJUGJOKyXu8HXrtikr+xwtxFhwa
         vPxQ==
X-Gm-Message-State: ACgBeo0mIG3LnRynTCgOc72fkjl+sF/09LmO5pRHTAXvIWEWHSxvr50V
        6yQs/nTv6uN5sHbY1q9cDqE=
X-Google-Smtp-Source: AA6agR4o3Q02ankag8Bpawi3Qd66pAIZyx6yUxCeTas4uyiwqA9SIClaqlVe66Y0P+bnChOyONRrKA==
X-Received: by 2002:a2e:9212:0:b0:261:c864:5429 with SMTP id k18-20020a2e9212000000b00261c8645429mr403246ljg.530.1661002000627;
        Sat, 20 Aug 2022 06:26:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 18-20020a2e0912000000b0025e08d58e75sm1054409ljj.133.2022.08.20.06.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:26:40 -0700 (PDT)
Message-ID: <0fad815c-e6aa-06a6-4280-bc4ebad33107@gmail.com>
Date:   Sat, 20 Aug 2022 16:26:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <20220820122226.7f7d1b1a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220820122226.7f7d1b1a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 14:22, Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 22:19:31 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
>> bulk-enable, add-action-to-disable-at-detach - pattern.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> v2 => v3
>> Split to own patch.
>> ---
>>   drivers/iio/gyro/bmg160_core.c | 24 +++---------------------
>>   1 file changed, 3 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
>> index cedd9f02ea21..baa80980c99f 100644
>> --- a/drivers/iio/gyro/bmg160_core.c
>> +++ b/drivers/iio/gyro/bmg160_core.c
>> @@ -93,7 +93,6 @@
>>   
>>   struct bmg160_data {
>>   	struct regmap *regmap;
>> -	struct regulator_bulk_data regulators[2];
>>   	struct iio_trigger *dready_trig;
>>   	struct iio_trigger *motion_trig;
>>   	struct iio_mount_matrix orientation;
>> @@ -1067,19 +1066,13 @@ static const char *bmg160_match_acpi_device(struct device *dev)
>>   	return dev_name(dev);
>>   }
>>   
>> -static void bmg160_disable_regulators(void *d)
>> -{
>> -	struct bmg160_data *data = d;
>> -
>> -	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>> -}
>> -
>>   int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>>   		      const char *name)
>>   {
>>   	struct bmg160_data *data;
>>   	struct iio_dev *indio_dev;
>>   	int ret;
>> +	static const char * const regulators[] = {"vdd", "vddio"};
> 
> As in previous, small preference for spaces after { and before }

Thanks. I'll fix it when I respin.


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
