Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F74E84E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiC0BYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 21:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiC0BYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 21:24:14 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.46.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442BF00
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 18:22:37 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id BCFE7400C57EE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 20:22:36 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id YHc4n59Z8dx86YHc4njTSz; Sat, 26 Mar 2022 20:22:36 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j/1YmtB4FKiKjWrDJnr3R0JdU+uyqopV85T8JxNaT7o=; b=tMBOXK9ViWc6x6KVGwWFwTpf3x
        RTmcF+fp9hyRINl/0E4uK9Pew/UaUbssRI49fymn3D8dUfkhoxxJinff5q69Nuy2gm8a9qgrCd02S
        anpULi9PkvwLGimBZ3D2VTR+nlYRkJIQ0e+jB1NMiM4aK2IOMCyIfNT0HSmn9KbOzRDDSp9fZZnKe
        xtFNAqv70P5kkS/Du64Lx/FIbsqU5mgww5SZw4gPm/xLstShKxoCuluTheXVK5AulB8bjl/YaD2zS
        /TXCnYV46BICzWr7nsBpb/sv9abYIeTEuiDgIoAiRIjQItXUjkIee6UiFSd7qpBe6EFQW3fryQKx+
        0SM0ddag==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54492)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nYHc4-001a6G-9a; Sun, 27 Mar 2022 01:22:36 +0000
Message-ID: <ede18e3e-0e9f-91ef-05fb-6465e72a3838@roeck-us.net>
Date:   Sat, 26 Mar 2022 18:22:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/4] hwmon: (bt1-pvt) use generic polynomial functions
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220326192347.2940747-1-michael@walle.cc>
 <20220326192347.2940747-3-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220326192347.2940747-3-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nYHc4-001a6G-9a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54492
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 8
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/22 12:23, Michael Walle wrote:
> The polynomial calculation function was moved into lib/ to be able to
> reuse it. Move over to this one.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

select POLYNOMIAL missing in Kconfig

>   drivers/hwmon/bt1-pvt.c | 50 +++++++++++------------------------------
>   1 file changed, 13 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> index 74ce5211eb75..21ab172774ec 100644
> --- a/drivers/hwmon/bt1-pvt.c
> +++ b/drivers/hwmon/bt1-pvt.c
> @@ -26,6 +26,7 @@
>   #include <linux/mutex.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/polynomial.h>
>   #include <linux/seqlock.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
> @@ -65,7 +66,7 @@ static const struct pvt_sensor_info pvt_info[] = {
>    *     48380,
>    * where T = [-48380, 147438] mC and N = [0, 1023].
>    */
> -static const struct pvt_poly __maybe_unused poly_temp_to_N = {
> +static const struct polynomial __maybe_unused poly_temp_to_N = {
>   	.total_divider = 10000,
>   	.terms = {
>   		{4, 18322, 10000, 10000},
> @@ -76,7 +77,7 @@ static const struct pvt_poly __maybe_unused poly_temp_to_N = {
>   	}
>   };
>   
> -static const struct pvt_poly poly_N_to_temp = {
> +static const struct polynomial poly_N_to_temp = {
>   	.total_divider = 1,
>   	.terms = {
>   		{4, -16743, 1000, 1},
> @@ -97,7 +98,7 @@ static const struct pvt_poly poly_N_to_temp = {
>    * N = (18658e-3*V - 11572) / 10,
>    * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
>    */
> -static const struct pvt_poly __maybe_unused poly_volt_to_N = {
> +static const struct polynomial __maybe_unused poly_volt_to_N = {
>   	.total_divider = 10,
>   	.terms = {
>   		{1, 18658, 1000, 1},
> @@ -105,7 +106,7 @@ static const struct pvt_poly __maybe_unused poly_volt_to_N = {
>   	}
>   };
>   
> -static const struct pvt_poly poly_N_to_volt = {
> +static const struct polynomial poly_N_to_volt = {
>   	.total_divider = 10,
>   	.terms = {
>   		{1, 100000, 18658, 1},
> @@ -113,31 +114,6 @@ static const struct pvt_poly poly_N_to_volt = {
>   	}
>   };
>   
> -/*
> - * Here is the polynomial calculation function, which performs the
> - * redistributed terms calculations. It's pretty straightforward. We walk
> - * over each degree term up to the free one, and perform the redistributed
> - * multiplication of the term coefficient, its divider (as for the rationale
> - * fraction representation), data power and the rational fraction divider
> - * leftover. Then all of this is collected in a total sum variable, which
> - * value is normalized by the total divider before being returned.
> - */
> -static long pvt_calc_poly(const struct pvt_poly *poly, long data)
> -{
> -	const struct pvt_poly_term *term = poly->terms;
> -	long tmp, ret = 0;
> -	int deg;
> -
> -	do {
> -		tmp = term->coef;
> -		for (deg = 0; deg < term->deg; ++deg)
> -			tmp = mult_frac(tmp, data, term->divider);
> -		ret += tmp / term->divider_leftover;
> -	} while ((term++)->deg);
> -
> -	return ret / poly->total_divider;
> -}
> -
>   static inline u32 pvt_update(void __iomem *reg, u32 mask, u32 data)
>   {
>   	u32 old;
> @@ -324,9 +300,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>   	} while (read_seqretry(&cache->data_seqlock, seq));
>   
>   	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>   	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>   
>   	return 0;
>   }
> @@ -345,9 +321,9 @@ static int pvt_read_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>   		data = FIELD_GET(PVT_THRES_HI_MASK, data);
>   
>   	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>   	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>   
>   	return 0;
>   }
> @@ -360,10 +336,10 @@ static int pvt_write_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>   
>   	if (type == PVT_TEMP) {
>   		val = clamp(val, PVT_TEMP_MIN, PVT_TEMP_MAX);
> -		data = pvt_calc_poly(&poly_temp_to_N, val);
> +		data = polynomial_calc(&poly_temp_to_N, val);
>   	} else {
>   		val = clamp(val, PVT_VOLT_MIN, PVT_VOLT_MAX);
> -		data = pvt_calc_poly(&poly_volt_to_N, val);
> +		data = polynomial_calc(&poly_volt_to_N, val);
>   	}
>   
>   	/* Serialize limit update, since a part of the register is changed. */
> @@ -522,9 +498,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>   		return -ETIMEDOUT;
>   
>   	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>   	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>   
>   	return 0;
>   }

