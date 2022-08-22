Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316A59C180
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiHVOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiHVOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:08:27 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE82D6F;
        Mon, 22 Aug 2022 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=T5hG4CMiXiq0fNvlpK+kiyhe/gNT8UXeH30XEgn7uCo=; b=FFsskYAVPrQOAiPuFOPQMXOdJm
        OceTKwXIcedxp5Wn9izmEM3J0x6ZoLOZRs0oeKwLsxrGPG8BZEm1pIxBxNnnLmdWgdxOiB/Sb2XQi
        OPvLHK6LeE5iTxdE3TSD5WobzFhhWmYPSbm1jm65wsF0dwPZCG2e7dEHNqi7J0chngkq4PwKZJCOD
        2QQjCeCXGKWWOWLxbpPhEnzURMFL07mrNTBj3LPlhm9T4iXOB34xnguDIdn9C0FkTEqMnMs64rotm
        h7J0PK4+fINSGOR6fG47ZeUt7WrlA/Jq9t6YZE7J3J/W6TQQjUSdJE+lukpBDe+pof8zUE5ovzT8J
        f5vtLviQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oQ869-0001Zp-JO; Mon, 22 Aug 2022 16:08:13 +0200
Received: from [2001:a61:2a3c:f01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oQ869-0007l3-BV; Mon, 22 Aug 2022 16:08:13 +0200
Message-ID: <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
Date:   Mon, 22 Aug 2022 16:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Content-Language: en-US
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-4-ciprian.regus@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220822125106.1106798-4-ciprian.regus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26635/Mon Aug 22 09:54:02 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 14:51, Ciprian Regus wrote:
> Set the iio device's name based on the chip used.

While the change is correct it breaks the ABI. This needs a bit of a 
better explanation what is being done, why, what are the potential 
problems, why do we want to do it anyway.

>
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>   drivers/iio/adc/ltc2496.c      | 1 +
>   drivers/iio/adc/ltc2497-core.c | 2 +-
>   drivers/iio/adc/ltc2497.c      | 2 ++
>   drivers/iio/adc/ltc2497.h      | 1 +
>   4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> index 98338104c24a..86470f49e8ca 100644
> --- a/drivers/iio/adc/ltc2496.c
> +++ b/drivers/iio/adc/ltc2496.c
> @@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
>   
>   static struct chip_info ltc2496_info = {
>   	.resolution = 16,
> +	.name = "ltc2496"
>   };
>   
>   static const struct of_device_id ltc2496_of_match[] = {
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index b2752399402c..6dd9ab601904 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -169,7 +169,7 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>   	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
>   	int ret;
>   
> -	indio_dev->name = dev_name(dev);
> +	indio_dev->name = ddata->chip_info->name;
>   	indio_dev->info = &ltc2497core_info;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->channels = ltc2497core_channel;
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index bb5e0d4301e2..a0aad71c8130 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -99,9 +99,11 @@ static int ltc2497_remove(struct i2c_client *client)
>   static struct chip_info ltc2497_info[] = {
>   	[TYPE_LTC2497] = {
>   		.resolution = 16,
> +		.name = "ltc2497"
>   	},
>   	[TYPE_LTC2499] = {
>   		.resolution = 24,
> +		.name = "ltc2499"
>   	}
>   };
>   
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index f4d939cfd48b..0e86e38248ee 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -12,6 +12,7 @@ enum chip_type {
>   
>   struct chip_info {
>   	u32 resolution;
> +	char *name;
>   };
>   
>   struct ltc2497core_driverdata {


