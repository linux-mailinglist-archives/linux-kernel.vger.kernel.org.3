Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6628517067
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358997AbiEBNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiEBNiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:38:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62FA1B0;
        Mon,  2 May 2022 06:34:47 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id e189so15187418oia.8;
        Mon, 02 May 2022 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gQMyKlyvtn7NB43AhDDTs9JaSXDF/dP/VHiUOIz/tGw=;
        b=IK6Ow2IsupUWDqHvAII0diazA3Gzsqsa1KTofXUFt6QVttbkPonEO/F1weiWjqEUeK
         GD5lsOFTw+VEPqzbxtY9G3pGx4gOJErdmHEhk2pEkqOqeBUo7d9gOxmRZ7EOLvYGt+Zm
         Xa0wZG1aYIvaqMlYcwCl5y5TFbS81abNJTZ/6DR0vL9wD+aHKjasiIzbanIWXiW2oh9h
         eyXB2Z/ntblf03cQc5zMRsoxh6l7k8bDcpoWFnnY6ygtWddbRkZ1pzAV2Y/tshM7fii6
         OmnGifOSSMjzn/YI+wNXQCz+izQVoejUXDd1Rv0DJdcAGD3bnDQZ+tj8U0+i3hOKufY6
         aEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gQMyKlyvtn7NB43AhDDTs9JaSXDF/dP/VHiUOIz/tGw=;
        b=0a0drz2my6sfjBKIJln3EnsCDakEOgQUd5pm07AKcXfhh90TcvROirz879jEAtwcgK
         JmnyOKPvLd/GIV2tZF94iXccKRpZkRaj8ufoP1n5OpUAlCmiIo+otEpTyFP3mWBkxspt
         ffuq1iNycUo7aVQoeFi62aFZDPKCFY1V/MPWo4Bw82gQ8v2tlpsSLFhM5u9a2SxiZsLr
         ECvNt1RnPro1Aqgk6SMvRt3yX8Z8vdjmrVC86IcBedIxmugitAU31iyKzQrcqdH2r64T
         TknkU+OlzsHC4dcmTuV1Upt7lKeKAxPr/1wMvv2asQ1jMJbfl3zp6S5VbrHukboNKWhs
         wyEQ==
X-Gm-Message-State: AOAM531Cb2oQE10/BXYBTlDG5qqQbyNyrD9V5Sziam4oRALbZ1PvV0Ns
        vF8LSbgJIILPiNFq7V6jy38=
X-Google-Smtp-Source: ABdhPJzprsnADVm1kafKkZtd/+x/LieJhbzhXSesIBDddxmYoPlY5Awod2ChCHmDpzgs8WxCpRp2Pg==
X-Received: by 2002:a05:6808:180b:b0:325:e888:da1b with SMTP id bh11-20020a056808180b00b00325e888da1bmr3341801oib.247.1651498486830;
        Mon, 02 May 2022 06:34:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r17-20020a9d7511000000b0060603221272sm2835923otk.66.2022.05.02.06.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:34:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net>
Date:   Mon, 2 May 2022 06:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220502124249.682058-2-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 05:42, Corentin Labbe wrote:
> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> So let's convert the driver to use hwmon_device_register_with_info().
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   drivers/hwmon/acpi_power_meter.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index d2545a1be9fc..98293727f980 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
>   	if (res)
>   		goto exit_free_capability;
>   
> -	resource->hwmon_dev = hwmon_device_register(&device->dev);
> +	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
> +							      ACPI_POWER_METER_DEVICE_NAME,
> +							      NULL, NULL,
> +							      NULL);

NACK. That isn't a conversion to the new API, it just abuses the fact
that the new API has to accept a NULL info pointer for historic reasons.

Guenter
