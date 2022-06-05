Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE653DB35
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiFEKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiFEKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:10:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5B4664D;
        Sun,  5 Jun 2022 03:10:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b8so15200731edf.11;
        Sun, 05 Jun 2022 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QmfLcAbHryy1IIAetYAoGcOfIXsKgWBW6y02L6ugeGg=;
        b=qrflZFjk4SIwu4KFvRYQar/ZyKEsx6E+7C2J5p1wMoRQPvNGd6QaWt25q6izabVts6
         eGnPM8+4keZhThLhHLV1vBs07tbXASxT0aOkhaFtbSobiaubZ4scWrotz71v3YCNnnGL
         DA1NUE6QUTDDE2AGBFDYEsK4K5rgGREFtfc+o040TINXpgqG/7H/eiVgmsLEwg+HVu6G
         AM1pMokTHyJibw/W/VYDJNHjPID0P1HBRjECCwu0K1Te8Uv6eEGMD81ZkU01JeC6/ZHu
         ExGXQ+Xjh2EsM+yOFypCbYRjNGaKQjK7KsOq8VywvGDRZxTLDAdGGJlNB3rCSfFeQd/J
         oZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QmfLcAbHryy1IIAetYAoGcOfIXsKgWBW6y02L6ugeGg=;
        b=AK/dHDEkNmUZxu6Wmh5Wavk560PcWbxZJMSgV57Zj2wKs+8BC+7Mb+UTHorBrF6gPq
         OOKhJLaoITOPbOM/28fh5LM/jkgS/QTAjJVVmgfpMNxAB2rqrIFz56UOVhxUELFCM8XF
         2q4MbYpX47qg8BR1GIHxh2Y7brs66uE1VO0P77o20Bqz8y/mF2B0zs8xdtdIssPyqfVX
         8ss9NmDuZ06RuPSKo+RsakUnlkpK8oSglL5ihRPsIKg6nf5TjZJo8KHiRCbDjTREK1IY
         i81U+jqTV+5oCIDiv+0/OjyH8dGHarBDvXNflD/KmKDmlDEbjdpbXyLD0UPQC6M4hCkO
         OjIg==
X-Gm-Message-State: AOAM533C5mhS6Ifh+UEj448AvFIFQNANFZmWBzeNZS2B32hv3Rk/r8/E
        OWCnDZtGHcB9m46agnZfRXCX/2kROXU=
X-Google-Smtp-Source: ABdhPJx4TyNHg+Dg3Z8vekoPEFjbwiNqG+9BWbHG9O4PBvtmEpiQDBoXvNAzJcm3Ofuon0iEnHjFMg==
X-Received: by 2002:a05:6402:1f8c:b0:42d:c3a9:5beb with SMTP id c12-20020a0564021f8c00b0042dc3a95bebmr20396106edc.160.1654423818984;
        Sun, 05 Jun 2022 03:10:18 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f6ffe.dip0.t-ipconnect.de. [91.63.111.254])
        by smtp.gmail.com with ESMTPSA id b23-20020a17090630d700b0070e1adff390sm2958588ejb.34.2022.06.05.03.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 03:10:18 -0700 (PDT)
Message-ID: <afbec770-437d-0304-1ea8-637b613bc053@gmail.com>
Date:   Sun, 5 Jun 2022 12:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] regulator: mp5416: use OF match data
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220604145816.47576-1-robimarko@gmail.com>
 <20220604145816.47576-3-robimarko@gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20220604145816.47576-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/22 16:58, Robert Marko wrote:
> In preparation for adding support for MP5496 which slightly differs from
> MP5416 convert the driver to use OF match data instead of always using the
> MP5416 regulator_desc for regulator registration.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/regulator/mp5416.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
> index d8245080df03..011a825570ea 100644
> --- a/drivers/regulator/mp5416.c
> +++ b/drivers/regulator/mp5416.c
> @@ -11,6 +11,7 @@
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/driver.h>
> @@ -178,6 +179,7 @@ static int mp5416_i2c_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct regulator_config config = { NULL, };
> +	static const struct regulator_desc *desc;
>   	struct regulator_dev *rdev;
>   	struct regmap *regmap;
>   	int i;
> @@ -188,12 +190,16 @@ static int mp5416_i2c_probe(struct i2c_client *client)
>   		return PTR_ERR(regmap);
>   	}
>   
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -ENODEV;
> +
>   	config.dev = dev;
>   	config.regmap = regmap;
>   
>   	for (i = 0; i < MP5416_MAX_REGULATORS; i++) {
>   		rdev = devm_regulator_register(dev,
> -					       &mp5416_regulators_desc[i],
> +					       &desc[i],
>   					       &config);
>   		if (IS_ERR(rdev)) {
>   			dev_err(dev, "Failed to register regulator!\n");
> @@ -205,7 +211,7 @@ static int mp5416_i2c_probe(struct i2c_client *client)
>   }
>   
>   static const struct of_device_id mp5416_of_match[] = {
> -	{ .compatible = "mps,mp5416" },
> +	{ .compatible = "mps,mp5416", .data = &mp5416_regulators_desc },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mp5416_of_match);

Acked-by: Saravanan Sekar <sravanhome@gmail.com>
