Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9808E520A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiEJAha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEJAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:37:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F50D2AC6FD;
        Mon,  9 May 2022 17:33:30 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e656032735so16609871fac.0;
        Mon, 09 May 2022 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=64L3c9mM134nU08ZcOwqqRtvzxpfpmFyW/XcEdewfog=;
        b=DklkJSJQIzB9odhVCeZcEpjwt8ipi0M/j47TWaWuwQ1NSDqsgXr0nc5RwNyYKoJpkR
         t4R9OhUL4HLE7gIwTV9NR7GxF9XRYzWJdVJfBTNz+UyraFdyZB+65/45NcMi59WaalUP
         qRBKZg9naJYYv7ZdCQK3b8rE0rPv/l43QRv48LlOHAe8A7KH+cNSDb/UcEVuoYwEOCJT
         VrwekoorWPINytaUhsfre6QB0BtQSEnowO/Pvv7q+5bUa6iCG40KKC9jUrR3/JMT/4WJ
         USekykU4qZJ2vVI4/UDQTuH9I312O2juYGU8T+us5kwKusfZA3KLnFR5fWngeaVPlBJ4
         olNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=64L3c9mM134nU08ZcOwqqRtvzxpfpmFyW/XcEdewfog=;
        b=yebfwbKt3Bkxnw8sNdAvEjj7/LTQ8TN0l0Y+Aa/zOrqjRRMg/F9aNmboORurXwp4AO
         Fh+amaMS6i9xy8Ur0BepMFqba3dfW5OfLdW4waX8wHOlY4zj6r80vWE3BIPdExZ3vjBx
         FIS9Ia3Rdu+IAtTKuFzHnX06wUP7T+jx8O6+AxBw2a5SiC8pgUB3s4aFOXej1lT5f8nM
         /gIADRKhIVs6JmmXcMxus5rblVNBKKFcgZc3OCvg7k4JX2LVWxr3P/qRGOuNnUFQ4lW+
         i6L6CWNNdauYil5GVtpMAseShWe01NWusjG2/pNKuOX7kuQJOOr6AXB7j5mP+qBNP8Wq
         bSfg==
X-Gm-Message-State: AOAM533sNlIR41Ld99n/7syRnRaHNnBMPgMwAn6ECgUtM05UPdnxuPVW
        NtxY8zS0bfsDF3Za+T7RxDRLZzyayFaMqw==
X-Google-Smtp-Source: ABdhPJy377jdrFVTBfRZFBojoqd9vuoahvNrUz3dtMSIRseHPXi1/86DGlMNcjz9ZrL/wiToNlkPwA==
X-Received: by 2002:a05:6870:1807:b0:d7:2a4c:14b8 with SMTP id t7-20020a056870180700b000d72a4c14b8mr11295005oaf.97.1652142809351;
        Mon, 09 May 2022 17:33:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568080a0800b00325cda1ff8csm4980517oij.11.2022.05.09.17.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 17:33:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 9 May 2022 17:33:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Debabrata Banerjee <dbavatar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X570-E GAMING
 WIFI II
Message-ID: <20220510003327.GA1561946@roeck-us.net>
References: <20220505073351.123753-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505073351.123753-1-eugene.shalygin@gmail.com>
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

On Thu, May 05, 2022 at 09:33:51AM +0200, Eugene Shalygin wrote:
> From: Debabrata Banerjee <dbavatar@gmail.com>
> 
> Adds support for the ROG STRIX X570-E GAMING WIFI II board and
> simplifies formatting for the list of supported models.
> 
> Signed-off-by: Debabrata Banerjee <dbavatar@gmail.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst | 23 ++++++++++++-----------
>  drivers/hwmon/asus-ec-sensors.c         |  8 ++++++++
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index 1700fe619597..78ca69eda877 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -4,19 +4,20 @@ Kernel driver asus_ec_sensors
>  =================================
>  
>  Supported boards:
> - * PRIME X470-PRO,
> - * PRIME X570-PRO,
> - * Pro WS X570-ACE,
> + * PRIME X470-PRO
> + * PRIME X570-PRO
> + * Pro WS X570-ACE
>   * ProArt X570-CREATOR WIFI
> - * ROG CROSSHAIR VIII DARK HERO,
> + * ROG CROSSHAIR VIII DARK HERO
>   * ROG CROSSHAIR VIII HERO (WI-FI)
> - * ROG CROSSHAIR VIII FORMULA,
> - * ROG CROSSHAIR VIII HERO,
> - * ROG CROSSHAIR VIII IMPACT,
> - * ROG STRIX B550-E GAMING,
> - * ROG STRIX B550-I GAMING,
> - * ROG STRIX X570-E GAMING,
> - * ROG STRIX X570-F GAMING,
> + * ROG CROSSHAIR VIII FORMULA
> + * ROG CROSSHAIR VIII HERO
> + * ROG CROSSHAIR VIII IMPACT
> + * ROG STRIX B550-E GAMING
> + * ROG STRIX B550-I GAMING
> + * ROG STRIX X570-E GAMING
> + * ROG STRIX X570-E GAMING WIFI II
> + * ROG STRIX X570-F GAMING
>   * ROG STRIX X570-I GAMING
>  
>  Authors:
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 998d49d6b799..611e897429b1 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -315,6 +315,14 @@ static const struct ec_board_info board_info[] = {
>  		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  		.family = family_amd_500_series,
>  	},
> +	{
> +		.board_names = {"ROG STRIX X570-E GAMING WIFI II"},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR | SENSOR_CURR_CPU |
> +			SENSOR_IN_CPU_CORE,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
> +		.family = family_amd_500_series,
> +	},
>  	{
>  		.board_names = {"ROG STRIX X570-F GAMING"},
>  		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
