Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787CD507DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiDTBD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348181AbiDTBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:03:26 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89251275CC;
        Tue, 19 Apr 2022 18:00:41 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-deb9295679so421944fac.6;
        Tue, 19 Apr 2022 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9jqaNc5GS93TqmOq2Cq3d6a6vz0jEdB9F8+DagCs+Co=;
        b=h8epfsKDDQhn9rNEqVXlRvWdOyABHN1ZbHL/SpuTNNPtHIrikHxXUOWCErWTnFONvX
         SlUhfrcbJg6m/raBZAEtQcM8ePyH13DkirRtX5k6Zbf3sHs1UGHzHsUGuDHacn6nJ2Jf
         fY0Xdfla0BXMaGIr5JjjKw5aqvBz+4yQca7hiuDls6LVlnyKIucmogdTH2yNKeWagszR
         jpzPI3XwdMR0WLj8hijz+kQYs38OpuUrZTlAlby0harTRJ6m/KZxAAe7rvuYSQoo2X4j
         B2XBhlNQ2ovTwfp3Tp7aWR6/Hg2OIksju+xuHihX3oa4/gdtPN00xm8JZ23CpViEiPeB
         9MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9jqaNc5GS93TqmOq2Cq3d6a6vz0jEdB9F8+DagCs+Co=;
        b=8N5vDBbdIjUFE2S26pu4wpx2sk6odiewqsEMAlO20yLaL0ZjGCK5hchg5Vy1zKFLzh
         rkxkGumjjNoiRPVNciaVEYE1dbO4XZ3JLgjPNj6StU4LHY/DtyayAxJ7djU/Y8aifweH
         /ySktLbwOZGF1eFd89B2jwI2zeXKb6oe6hYEb5wRiX4SzYKsUCdPojf5nUp7BIBJZbO2
         UHbBk8h0lu9IpxOpTrxatXYXgwMOCXGSMt2svVo4208rDCfLcFcL1R1zZnjfuYj9UJUg
         5FfzLbQut6EQsL9HdjwouIMcHAToGqTKrhhckUrUtNK2lZKQkvVsdUTnlkRdITfnkR+K
         riQA==
X-Gm-Message-State: AOAM532UZ5jDOTUJI11KbQtoJVYf5d+lg7THzPmyE4egGAcRacLtyb4J
        K+1/72Hvzk0oclNBQmSZ0RfCN4EOl9Y=
X-Google-Smtp-Source: ABdhPJzq/wMmB0JIONSUhoRlRLpkCwI5rH7guTD9k3y5UejmwncJ3nD46HwNX5PJe8t/qOkSUENZfA==
X-Received: by 2002:a05:6871:b22:b0:e6:49ed:4af0 with SMTP id fq34-20020a0568710b2200b000e649ed4af0mr93723oab.102.1650416440828;
        Tue, 19 Apr 2022 18:00:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a7505000000b0033a47bb6a74sm1332178ooc.47.2022.04.19.18.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 18:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2d09fe1-dada-e844-cafa-da48424855a4@roeck-us.net>
Date:   Tue, 19 Apr 2022 18:00:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Content-Language: en-US
To:     Adam Wujek <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419205228.303952-1-dev_public@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220419205228.303952-1-dev_public@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 13:53, Adam Wujek wrote:
> Explicitly disable PEC when the client does not support it.
> Without the explicit disable, when the device with the PEC support is removed
> later when a device without PEC support is inserted into the same address,
> the driver uses the old value of client->flags which contains the I2C_CLIENT_PEC
> flag. As a consequence the PEC is used when it should not.
> 
> Signed-off-by: Adam Wujek <dev_public@wujek.eu>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 82c3754e21e3..f8ca36759b0a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2014,6 +2014,8 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
>   	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>   		client->flags |= I2C_CLIENT_PEC;
> +	else
> +		client->flags &= ~I2C_CLIENT_PEC;
> 

I just realized that this patch is not based on the latest
kernel version. Please rebase.

Guenter
