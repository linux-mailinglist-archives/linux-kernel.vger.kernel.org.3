Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04754577742
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiGQQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:14:20 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CCBF55;
        Sun, 17 Jul 2022 09:14:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o15so9735976pjh.1;
        Sun, 17 Jul 2022 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uzmJq2JdSyiyV47Nf+Jr+oeguyxu9YLubRbJJqiEz7c=;
        b=k5uWOEIuBt0SDsYRu+EI6DbLOGw6EIpVRBtGNvamKfgcTrljgUgSmluaVhMDdkA81d
         d95b5BAsruKEmGRFng4pIlM97Zr+fxW57qtb9dPfQkP3DluTF3o+iAj80qG5IN5xD63L
         FCVSlBWHru7H5gHoF2MvjexZP1vl3Nvp+xlELjuM7m0f26/y6QbitnZHRPjbwg2yzJbd
         AYXacZl5G+D2l2hZDZYlvBcBtAw3JpgqAELeKA4RnoD8JInX/PO8ATq06PcC/t42bw/W
         jV4kfjg3Uu6adT+McmDjr33UFIMr6KAhCbUOr5VS08J9Hw1O+KoCRCIhJpRznpCeTVQ2
         hnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uzmJq2JdSyiyV47Nf+Jr+oeguyxu9YLubRbJJqiEz7c=;
        b=xL1jEdDfx2RZ+Y5pfka/stczdPRhT3UHhefD6hAF4U3p1oby+aOVe3zAXEDBfu3bf3
         yqsE9RMBFF6po3quBNFVUM3/C6g7S1LRadI7YiqiWb1kMNf6RUk0AIMIZgU4i6zZOrn3
         IzeSMca+0dGq/f0I0bucAc56zKzneywcxc2nw2Zktw1J8IdlTHFm8lnu2jviQa6UrRvm
         gR+ZC/hcF2/jdQxL78dSAE3At25wflH3iX4TUZhGten47I8u4K78e0lpDGxG+orejI7J
         /gmxmfZWjCoujRv8aluorYSj07ThxCB9bzRQLk6nF6NmEwuBK7Dx9fBSk/TadrPa+Ek4
         r82A==
X-Gm-Message-State: AJIora/4Fwpf2lIMv//AHjTKqtouEJ2N6QZxOgSPa27rn9UN2w4AKsR1
        ybuGf/WdNEYfZpABv1TkIiWn837H52QaXQ==
X-Google-Smtp-Source: AGRyM1vaMAtxif8fFZbLffWdwBs0Cp++VmGmzFMlmL6QsYlxT6SbHCUSwmUe8vmj9lJ5lm2ts+h7Tg==
X-Received: by 2002:a17:90b:3890:b0:1f0:2abb:e7d1 with SMTP id mu16-20020a17090b389000b001f02abbe7d1mr34256178pjb.158.1658074458885;
        Sun, 17 Jul 2022 09:14:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902710800b0015e8d4eb1d7sm7387265pll.33.2022.07.17.09.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 09:14:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4141c603-a153-adc1-ee08-f0ba0d99ade7@roeck-us.net>
Date:   Sun, 17 Jul 2022 09:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add D5 Next fan control
 support
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
References: <20220717154114.7545-1-savicaleksa83@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220717154114.7545-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 08:41, Aleksa Savic wrote:
> Define pump and fan speed register offsets in
> D5 Next control report, as well as its size, to expose PWM fan control.
> 
> Signed-off-by: Jack Doan <me@jackdoan.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

This suggests that Jack Doan was the author of this patch, not
Aleksa Savic. However, that is not reflected in the patch itself.
Please either use Originally-from: instead of Signed-off-by:
or make sure that the original author is listed correctly.

Thanks,
Guenter

> ---
>   drivers/hwmon/aquacomputer_d5next.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 0e56cc711a26..997d72ea6182 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -71,8 +71,12 @@ static u8 secondary_ctrl_report[] = {
>   #define D5NEXT_PUMP_OFFSET		0x6c
>   #define D5NEXT_FAN_OFFSET		0x5f
>   #define D5NEXT_5V_VOLTAGE		0x39
> +#define D5NEXT_CTRL_REPORT_SIZE		0x329
>   static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
>   
> +/* Pump and fan speed registers in D5 Next control report (from 0-100%) */
> +static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
> +
>   /* Register offsets for the Farbwerk RGB controller */
>   #define FARBWERK_NUM_SENSORS		4
>   #define FARBWERK_SENSOR_START		0x2f
> @@ -667,9 +671,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   
>   		priv->num_fans = D5NEXT_NUM_FANS;
>   		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
> +		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
>   		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
>   		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
>   		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
> +		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
>   
>   		priv->temp_label = label_d5next_temp;
>   		priv->speed_label = label_d5next_speeds;

