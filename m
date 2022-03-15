Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC24DA5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352450AbiCOXBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343986AbiCOXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:01:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D95D64E;
        Tue, 15 Mar 2022 16:00:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so562307wrh.11;
        Tue, 15 Mar 2022 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hXQ+F8C3tNuXEKUAVGAOF2ZBmymUXm4wxo2Tm197Al4=;
        b=Pf0/0dDbZEgm2sMgS6UYLQeiAX+t3B9PA6NGVxtpPQPqCPyyiGaYGbhuE3BtTF7GCH
         5KBzpJerrXGxOR07Ss5wMjOlzQW4HMX1T76Oi1f70Z//abtMEo1zD6u/bXDlSEO7HXuu
         vkDDnW3nDGcx6ZnDrVJe0S+d3pokRBVw84is3H5rVdDMK2YT41hs4wZfZDdUulf6ffau
         8KGP7N9BacF1THivrCHPQGKMbLvQH+exsaj+aYOHHZMgPnPGloVphs/s1k20Apuk+4F5
         MIlNhgzxrwHHvTUTEn8RDU1x+TiFd6TbFKRjtjzv6F2J5pHNiJ9dKWXii3TNO7kN7o+V
         N+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hXQ+F8C3tNuXEKUAVGAOF2ZBmymUXm4wxo2Tm197Al4=;
        b=uIdkCw4EGIs+czibQtx9jyxrjeqA0wex85JtbnQ6oH6bMhduHR4GSH+ZGXrSOmkeF3
         co0arunfbFAkNhAKrBlq0fsAtXS5OK3JUK23edszmgyCB/bcZKD4Ew/pq1iE5HEUWOnG
         DLeJCeMk3iMLrpudCvJyawROdWdSLRo+unrQBIMX7poMEScD1LAC+/44kvWMddWl8ORw
         Db9yf1xjgdY90ojMoTEZLEQ2PjtingS0GRPuEknvzhTRTjhk4Z4ghQ+mdZabApiXzzv9
         MZrX5slsBzjM12SK67or2wxvsYm0nmbBNbnwPRBZlHUFovSH3ycSOREcSl4oiF9WbFrS
         4ycA==
X-Gm-Message-State: AOAM531n9ls80Bn9s7fcjPq3sihC4/42BzgQJvECXJrs2HUxVDvIBkLq
        CtMqMB05QNsk12DuFBbK7d8gurMNsVjRYQ==
X-Google-Smtp-Source: ABdhPJyGiJUjNwWcBJMHvTUlju1YCEutt2csJsCEM7FlpcXtsSYSvcUWFLbb0PWay9YsrTKo93+tvw==
X-Received: by 2002:a5d:55c7:0:b0:1f0:48cf:9568 with SMTP id i7-20020a5d55c7000000b001f048cf9568mr22472526wrw.379.1647385215664;
        Tue, 15 Mar 2022 16:00:15 -0700 (PDT)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm3463642wmj.5.2022.03.15.16.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 16:00:15 -0700 (PDT)
Message-ID: <5ea0e154-e06e-32b4-be86-f38ce07b8bec@gmail.com>
Date:   Tue, 15 Mar 2022 23:00:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: bq2415x: Fix spelling mistake "vender" ->
 "vendor"
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220315223700.2961660-1-colin.i.king@gmail.com>
 <20220315224645.ytcf7y7awc3q2y6j@pali>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20220315224645.ytcf7y7awc3q2y6j@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2022 22:46, Pali Rohár wrote:
> On Tuesday 15 March 2022 22:37:00 Colin Ian King wrote:
>> There are several spelling mistakes in comments, function names
>> and literal strings. Fix these.
> 
> I do not think that there are mistakes.
> 
> Please look at page 29 of the official bq24150 datasheet:
> https://www.ti.com/lit/ds/symlink/bq24150.pdf

Looks like TI are redefining the spelling in the language :-)


> 
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/power/supply/bq2415x_charger.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
>> index 5724001e66b9..b35700071966 100644
>> --- a/drivers/power/supply/bq2415x_charger.c
>> +++ b/drivers/power/supply/bq2415x_charger.c
>> @@ -71,7 +71,7 @@
>>   #define BQ2415X_BIT_OTG_PL		1
>>   #define BQ2415X_BIT_OTG_EN		0
>>   
>> -/* vender register */
>> +/* vendor register */
>>   #define BQ2415X_MASK_VENDER		(BIT(5)|BIT(6)|BIT(7))
>>   #define BQ2415X_SHIFT_VENDER		5
>>   #define BQ2415X_MASK_PN			(BIT(3)|BIT(4))
>> @@ -491,8 +491,8 @@ static int bq2415x_detect_revision(struct bq2415x_device *bq)
>>   	return -1;
>>   }
>>   
>> -/* return chip vender code */
>> -static int bq2415x_get_vender_code(struct bq2415x_device *bq)
>> +/* return chip vendor code */
>> +static int bq2415x_get_vendor_code(struct bq2415x_device *bq)
>>   {
>>   	int ret;
>>   
>> @@ -1501,9 +1501,9 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
>>   		sprintf(revstr, "1.%d", ret);
>>   
>>   	bq->model = kasprintf(GFP_KERNEL,
>> -				"chip %s, revision %s, vender code %.3d",
>> +				"chip %s, revision %s, vendor code %.3d",
>>   				bq2415x_chip_name[chip], revstr,
>> -				bq2415x_get_vender_code(bq));
>> +				bq2415x_get_vendor_code(bq));
>>   	if (!bq->model) {
>>   		dev_err(bq->dev, "failed to allocate model name\n");
>>   		return -ENOMEM;
>> -- 
>> 2.35.1
>>

