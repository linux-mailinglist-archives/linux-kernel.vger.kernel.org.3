Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4E516A07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383215AbiEBEgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357574AbiEBEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:36:47 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1F37001;
        Sun,  1 May 2022 21:33:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y63so14253513oia.7;
        Sun, 01 May 2022 21:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dusRhvjndPsSe9YalLMuSlnyDmLuZcGjS7vRF5kpALI=;
        b=B0f9lNM+NrcXu7s9eDw3uoN8MjVfk92UF6XMKGigDV8y8S7NdmpUAMMk3kn6I9o86W
         Ku+Qy8YbU2aJDUZG/fNtYo45UGfQOl860LLr2vJ03BgErUXx/e6Mw0ExeBTc4LPGKdVr
         gK+HmfO6lIgaUyxUDpQNzDdG6czFvRo+I8HuJYb+PlX90pG6RmUpNkaKBYDA/ODIp28N
         T8W5nNPgq97v6iK2Ab5NM930DqG7zWGPNH201kcwscnkahLAbCNGR/FjEjmI68cZavWx
         WTVhMG30TYKeK2vUFXWKSN0oC6N7RFkKTeuEM712V/MxcmEB3L2hI4S+slCwC+UGQD5/
         bwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dusRhvjndPsSe9YalLMuSlnyDmLuZcGjS7vRF5kpALI=;
        b=29fvm8q+9O76sww8UWI/CqN49aePoX00dhUAn91Iwi9FQ3KCWXOair/6CB9Q8Qh80D
         zvI2GgzO64lX6p45t1HqQPsYJ6s7JYkm6VbxLFTkOpixjHyqvNruhilQ326IEuqnGqcL
         TVMG9f6CcuJuQOdD8Heg27AP+IMUQlcWZmLpBDY7oByTkugVGV89wbmGPhCVwC+Fkjzm
         ijYKbdR+BUgyERuL7rfm89ih6X1x2mbJoDaPFu6fqU4s7k1I0XMrSmcpozjPcjNDlml0
         xF+Y8oAhs38N2ZploQh/OYmo4enmbC7xxvZL5ZyHQwh7BGfMaM+4Rgry1SJLTBD9kyRx
         6HnA==
X-Gm-Message-State: AOAM532zDHNsQ7TY5OEZz8tksRjNMw1KaYvXV/rwoPL60TziEBzd+ahB
        ATz1fDZPjWEbRqjd00dtFiI=
X-Google-Smtp-Source: ABdhPJzfuWC0yZu9FejBYmSODAPywlHkJUjRZk6FO5t+fVaYqlxYgdcgnh7Sdi5hWFy7BMpYnfUKEg==
X-Received: by 2002:a05:6808:180a:b0:322:bcd3:ddaf with SMTP id bh10-20020a056808180a00b00322bcd3ddafmr4805796oib.35.1651465997630;
        Sun, 01 May 2022 21:33:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10-20020a05683013ca00b0060603221259sm2564542otq.41.2022.05.01.21.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 21:33:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 May 2022 21:33:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Walle <michael@walle.cc>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] hwmon: (bt1-pvt) use generic polynomial functions
Message-ID: <20220502043314.GA1718794@roeck-us.net>
References: <20220401214032.3738095-1-michael@walle.cc>
 <20220401214032.3738095-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401214032.3738095-3-michael@walle.cc>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:40:30PM +0200, Michael Walle wrote:
> The polynomial calculation function was moved into lib/ to be able to
> reuse it. Move over to this one.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig   |  1 +
>  drivers/hwmon/bt1-pvt.c | 50 +++++++++++------------------------------
>  2 files changed, 14 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b7..be9773270e53 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -415,6 +415,7 @@ config SENSORS_ATXP1
>  config SENSORS_BT1_PVT
>  	tristate "Baikal-T1 Process, Voltage, Temperature sensor driver"
>  	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> +	select POLYNOMIAL
>  	help
>  	  If you say yes here you get support for Baikal-T1 PVT sensor
>  	  embedded into the SoC.
> diff --git a/drivers/hwmon/bt1-pvt.c b/drivers/hwmon/bt1-pvt.c
> index 74ce5211eb75..21ab172774ec 100644
> --- a/drivers/hwmon/bt1-pvt.c
> +++ b/drivers/hwmon/bt1-pvt.c
> @@ -26,6 +26,7 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/polynomial.h>
>  #include <linux/seqlock.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> @@ -65,7 +66,7 @@ static const struct pvt_sensor_info pvt_info[] = {
>   *     48380,
>   * where T = [-48380, 147438] mC and N = [0, 1023].
>   */
> -static const struct pvt_poly __maybe_unused poly_temp_to_N = {
> +static const struct polynomial __maybe_unused poly_temp_to_N = {
>  	.total_divider = 10000,
>  	.terms = {
>  		{4, 18322, 10000, 10000},
> @@ -76,7 +77,7 @@ static const struct pvt_poly __maybe_unused poly_temp_to_N = {
>  	}
>  };
>  
> -static const struct pvt_poly poly_N_to_temp = {
> +static const struct polynomial poly_N_to_temp = {
>  	.total_divider = 1,
>  	.terms = {
>  		{4, -16743, 1000, 1},
> @@ -97,7 +98,7 @@ static const struct pvt_poly poly_N_to_temp = {
>   * N = (18658e-3*V - 11572) / 10,
>   * V = N * 10^5 / 18658 + 11572 * 10^4 / 18658.
>   */
> -static const struct pvt_poly __maybe_unused poly_volt_to_N = {
> +static const struct polynomial __maybe_unused poly_volt_to_N = {
>  	.total_divider = 10,
>  	.terms = {
>  		{1, 18658, 1000, 1},
> @@ -105,7 +106,7 @@ static const struct pvt_poly __maybe_unused poly_volt_to_N = {
>  	}
>  };
>  
> -static const struct pvt_poly poly_N_to_volt = {
> +static const struct polynomial poly_N_to_volt = {
>  	.total_divider = 10,
>  	.terms = {
>  		{1, 100000, 18658, 1},
> @@ -113,31 +114,6 @@ static const struct pvt_poly poly_N_to_volt = {
>  	}
>  };
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
>  static inline u32 pvt_update(void __iomem *reg, u32 mask, u32 data)
>  {
>  	u32 old;
> @@ -324,9 +300,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>  	} while (read_seqretry(&cache->data_seqlock, seq));
>  
>  	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>  	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>  
>  	return 0;
>  }
> @@ -345,9 +321,9 @@ static int pvt_read_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>  		data = FIELD_GET(PVT_THRES_HI_MASK, data);
>  
>  	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>  	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>  
>  	return 0;
>  }
> @@ -360,10 +336,10 @@ static int pvt_write_limit(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>  
>  	if (type == PVT_TEMP) {
>  		val = clamp(val, PVT_TEMP_MIN, PVT_TEMP_MAX);
> -		data = pvt_calc_poly(&poly_temp_to_N, val);
> +		data = polynomial_calc(&poly_temp_to_N, val);
>  	} else {
>  		val = clamp(val, PVT_VOLT_MIN, PVT_VOLT_MAX);
> -		data = pvt_calc_poly(&poly_volt_to_N, val);
> +		data = polynomial_calc(&poly_volt_to_N, val);
>  	}
>  
>  	/* Serialize limit update, since a part of the register is changed. */
> @@ -522,9 +498,9 @@ static int pvt_read_data(struct pvt_hwmon *pvt, enum pvt_sensor_type type,
>  		return -ETIMEDOUT;
>  
>  	if (type == PVT_TEMP)
> -		*val = pvt_calc_poly(&poly_N_to_temp, data);
> +		*val = polynomial_calc(&poly_N_to_temp, data);
>  	else
> -		*val = pvt_calc_poly(&poly_N_to_volt, data);
> +		*val = polynomial_calc(&poly_N_to_volt, data);
>  
>  	return 0;
>  }
