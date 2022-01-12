Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F648BFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbiALIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349361AbiALIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:30:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8FC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:30:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so1055047wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeGkS/AWYnZy47we+qF8wCuwX52GEkI6vQJfLEPaRTM=;
        b=tisGOzLAWxSxmmGKxIOeVzPciTEN9rH2KFH9Do55+GiVOO50bmLiwt3AEhdYYG42Po
         aHDhJq32SXbrFH40QHtpSfox94sDcOJmebPmt6VYf/FyAX0hBz7bTx6V74ZUzJjHRMFT
         NKSsDLag8uUI6DX2OlfLhMw0Uq8aelMqibO86f+oellRFdSU2Z8vznyCpT41Rht/TsZ9
         YpBcCMh0AvGURo15h6GZxdcGoThQggQuIh5Z3s6o1GH0vq9YzD8nbLoP91RvGeCWRp0Y
         2ZqA5XuNDZqJqYXWj/T1Vy+yGyMQ9v+MqHS713torJ8+XxAnkLqfNorHiSEHmJpiuObF
         6ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zeGkS/AWYnZy47we+qF8wCuwX52GEkI6vQJfLEPaRTM=;
        b=FigZmTnkUs9rsneugIGEaBXmpllmtMZsl7BqjNacoCvSjVOckN2shFQn02CAlS00hA
         PwXtXtAQ69/jkpUz3+AqQoEvPUo2rpzI3tYrzNbnX52/dDiKss3yA1YEjYUM74TlnV+n
         N1hTfjdap9R0rSNSxLROvgXiQC6AbyUItCryyrYOC43osv97bKdAzcCl1yEUjpNy/lAa
         YM46hm5lxOWsFdh/3+iw6/pZP60xT09e+L96uDEo10AWRabgTU1GSxGWuQtCennJsbUM
         k32gzf86QVWj422vtvwrZOchSZWFeQXNThxkuu5jOysO0ongOB51fJDW2Km2m3MyZVON
         ZIAw==
X-Gm-Message-State: AOAM533Zcy4Rl9sZFNX3zcnFbl+hl3vdCwmxRi5MWPAigQtTqsaemcug
        s3XDOf+D4rJ4ZpPb9ngsDljCQjBdXbB9Rg==
X-Google-Smtp-Source: ABdhPJyXFR6mrywvto4d9XMnjLkxRHK9EpZKHxrQ7Z64/zyNjYP4o9flE665UZPXnZvUNqaJuhAqFQ==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr5869719wmg.62.1641976239060;
        Wed, 12 Jan 2022 00:30:39 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id b6sm11730973wri.56.2022.01.12.00.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:30:38 -0800 (PST)
Subject: Re: [PATCH 1/3] pinctrl: meson-g12a: add more pwm_f options
To:     Gary Bisson <gary.bisson@boundarydevices.com>,
        linux-amlogic@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220103154616.308376-2-gary.bisson@boundarydevices.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <cd92df54-caa1-deed-3a93-929ba43adba8@baylibre.com>
Date:   Wed, 12 Jan 2022 09:30:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103154616.308376-2-gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 16:46, Gary Bisson wrote:
> Add missing PWM_F pin muxing for GPIOA_11 and GPIOZ_12.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> index cd9656b13836..d182a575981e 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> @@ -283,6 +283,8 @@ static const unsigned int pwm_d_x6_pins[]		= { GPIOX_6 };
>  static const unsigned int pwm_e_pins[]			= { GPIOX_16 };
>  
>  /* pwm_f */
> +static const unsigned int pwm_f_z_pins[]		= { GPIOZ_12 };
> +static const unsigned int pwm_f_a_pins[]		= { GPIOA_11 };
>  static const unsigned int pwm_f_x_pins[]		= { GPIOX_7 };
>  static const unsigned int pwm_f_h_pins[]		= { GPIOH_5 };
>  
> @@ -618,6 +620,7 @@ static struct meson_pmx_group meson_g12a_periphs_groups[] = {
>  	GROUP(tdm_c_dout2_z,		4),
>  	GROUP(tdm_c_dout3_z,		4),
>  	GROUP(mclk1_z,			4),
> +	GROUP(pwm_f_z,			5),
>  
>  	/* bank GPIOX */
>  	GROUP(sdio_d0,			1),
> @@ -768,6 +771,7 @@ static struct meson_pmx_group meson_g12a_periphs_groups[] = {
>  	GROUP(tdm_c_dout3_a,		2),
>  	GROUP(mclk0_a,			1),
>  	GROUP(mclk1_a,			2),
> +	GROUP(pwm_f_a,			3),
>  };
>  
>  /* uart_ao_a */
> @@ -1069,7 +1073,7 @@ static const char * const pwm_e_groups[] = {
>  };
>  
>  static const char * const pwm_f_groups[] = {
> -	"pwm_f_x", "pwm_f_h",
> +	"pwm_f_z", "pwm_f_a", "pwm_f_x", "pwm_f_h",
>  };
>  
>  static const char * const cec_ao_a_h_groups[] = {
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
