Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2F53DB36
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiFEKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbiFEKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:10:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722846662;
        Sun,  5 Jun 2022 03:10:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o10so15233687edi.1;
        Sun, 05 Jun 2022 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vVCp23L5FQ++D23bNToFr9/vJxz+m61H5hSSQD2iE7s=;
        b=FAAGQQ0tOasCnIeAOw3CgvqS+UK4Fo6Xgn+UCUnnMHScBbJGIze2+66j7R5U/t9c/W
         TSWPH6lqn06AMhvri9+U/HjBu+MwPFeRpzSxli4Uy7HanXmpAaMjB5DedPD5fRYMUDk1
         X3oysloDYRvaAf9JITxmwPKKvkF8KqW/J+Uoe4yrXZEZLEAS7tCXVJn3TQBfjgN5QZ7k
         +kk02kw4AUDFAbujtJXtxGEzlYI5qbyp+qx0aMAmNRekcp5cjGuNl6Ck/Q0iNTswDtf0
         tlG9Jf9oX9C1OZhYPCtPLrJ/h53Ij/JYK7A1ALk8HvrNLXUt8sF8xyQ8eUfuaiS0F9mS
         1wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vVCp23L5FQ++D23bNToFr9/vJxz+m61H5hSSQD2iE7s=;
        b=EMHpNXMQNz2mwRWEYEiuH274mxMDUqsatRUmXMhgeX36j6ZAlLIXkFmfC9tuv0emKv
         HSeG8Af8wLyasRQzfaozAUuYNKt5LDMrj0J/D/Fw3BNZP91xSL+od6YEgHU9EjJ+JpTD
         5a5yIXAFOHrXADKxzPu/lX6RQgQmEdN/VaP4Q4ykFQn/k4Rpc4reiSwwNfavH53pq+8A
         whNCL3RJmQaFJZeqx307Cq9yl0jNvegMwnzNlD7u0h9JjL4tLFJH7jr+7Bq1X0iTn+nn
         fr+b5kGUS2cA4QnIoMKZrZxnq1gqY8OW0XaVcLDkLOVXwnE2E3r9inDfond+h4rCxBA2
         VQ8g==
X-Gm-Message-State: AOAM530yuiJURXj+r1JBnMkPq6A5uraiuH39leDoZ156x+9PTlDFlmUx
        qU3+3tlRZcncP3xgb6IzhQE=
X-Google-Smtp-Source: ABdhPJzQ7uhWSDjvawxpldyb/l71x0CtDEJk3kK4HZUXSE8R/d8c9aiOxIvamFUwdhqDxD/xkJZmcg==
X-Received: by 2002:a05:6402:2926:b0:42e:1f3c:d041 with SMTP id ee38-20020a056402292600b0042e1f3cd041mr16295707edb.240.1654423829557;
        Sun, 05 Jun 2022 03:10:29 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f6ffe.dip0.t-ipconnect.de. [91.63.111.254])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b006fee961b9e0sm5004863ejf.195.2022.06.05.03.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 03:10:29 -0700 (PDT)
Message-ID: <326b83b5-65f8-7cd7-4732-157b978026af@gmail.com>
Date:   Sun, 5 Jun 2022 12:10:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/4] regulator: mp5416: add support for MP5496
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220604145816.47576-1-robimarko@gmail.com>
 <20220604145816.47576-4-robimarko@gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20220604145816.47576-4-robimarko@gmail.com>
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
> MP5496 is the updated version of MP5416 with the only difference being
> that now all Buck regulators have the same 0.6-2.1875V range with a 12.5mV
> step.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/regulator/mp5416.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
> index 011a825570ea..71e20e8d78ac 100644
> --- a/drivers/regulator/mp5416.c
> +++ b/drivers/regulator/mp5416.c
> @@ -175,6 +175,17 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
>   	MP5416LDO("ldo4", 4, BIT(1)),
>   };
>   
> +static struct regulator_desc mp5496_regulators_desc[MP5416_MAX_REGULATORS] = {
> +	MP5416BUCK("buck1", 1, mp5416_I_limits1, MP5416_REG_CTL1, BIT(0), 1),
> +	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 1),
> +	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
> +	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 1),
> +	MP5416LDO("ldo1", 1, BIT(4)),
> +	MP5416LDO("ldo2", 2, BIT(3)),
> +	MP5416LDO("ldo3", 3, BIT(2)),
> +	MP5416LDO("ldo4", 4, BIT(1)),
> +};
> +
>   static int mp5416_i2c_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> @@ -212,12 +223,14 @@ static int mp5416_i2c_probe(struct i2c_client *client)
>   
>   static const struct of_device_id mp5416_of_match[] = {
>   	{ .compatible = "mps,mp5416", .data = &mp5416_regulators_desc },
> +	{ .compatible = "mps,mp5496", .data = &mp5496_regulators_desc },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mp5416_of_match);
>   
>   static const struct i2c_device_id mp5416_id[] = {
>   	{ "mp5416", },
> +	{ "mp5496", },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(i2c, mp5416_id);

Acked-by: Saravanan Sekar <sravanhome@gmail.com>
