Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A157C2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiGUDtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGUDs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:48:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2D45996;
        Wed, 20 Jul 2022 20:48:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so315673pjf.2;
        Wed, 20 Jul 2022 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XGwso/lizXZy9ShMNbcnuFhU18s9We3GIgTq5G+UrFQ=;
        b=d/+2P5KafqV9LDWgBGvSxTGW6StWm06WxHkcPVK8P7PdKtAvcoG8HK58aMTxojH9CJ
         mlRptRYfhZXEfYy31iaCYEX7GQdpGLYyjChIgDzvf4maPR4IG6/fJujRSGa738P7MRCI
         rjGa7gy1leFnXhggP3g/aMs008aTAVaaJUMVTkpuPiz5pyTL/rOvhqwHwc2bAkIltG+s
         IrNt6n5HvhPdZfqMwJ4rSZ9yjmTAtWAQtPuepCs8w/blHEs0sQLjYhIAxzcZBUAgPEHw
         zcs5pvEjsYC28hayQtZE/BgEFv7YjSBaQPgIjwbiv5+l8ao6xf68wtmjpgKJjM/1z3BY
         HIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XGwso/lizXZy9ShMNbcnuFhU18s9We3GIgTq5G+UrFQ=;
        b=u9HxecGKTQo1yhmkhqL0nAJ42Mc37T1uM3ZHe3THPp/eIgwJVj/2Hb8m2VTzYXqeHb
         lXy32e7r8D/1QU9Kh1mf5tMZ7HlURAg5lJJ3pnRZsrBEVj6RGe14hoC8lJJhPkXO+xmn
         rovizi2i+bc7FiIoJj5zqOHoXk/cRNECIPTdJlj7tivL7SiOrM9QQlFvU6WfuTrM/o5Y
         +LG6BXHKkLR2E4g/TZO2W2S5ANgRWVBa31MTeTro4N9o/lE3IgHzzWyclS+z6PGyhA9M
         5oc5uPcO/+Muo0/AxKYWx7ThKSgAygiwxXjXEtqew9MXj0py75GAeHTR2lIJ1E91mB99
         ZW1g==
X-Gm-Message-State: AJIora/pVLeojYQ1Cw8oLbGEQxGsENocvSD/Au7ZOaCL96hv37GhdN4A
        YIJYhOtaGIg8onp9opyB54Q=
X-Google-Smtp-Source: AGRyM1sQp9/b7IRWI21M8CBeFEXYFhqhLTNvjTcuz3YC5ZH8oZO3J4EELa1u9hVe1D9vHRHzUzHMgg==
X-Received: by 2002:a17:902:f705:b0:16b:9b6d:67a1 with SMTP id h5-20020a170902f70500b0016b9b6d67a1mr42828480plo.39.1658375336542;
        Wed, 20 Jul 2022 20:48:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b0016cdfcdcff2sm374836pla.19.2022.07.20.20.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:48:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 20 Jul 2022 20:48:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add D5 Next fan control
 support
Message-ID: <20220721034855.GA1643920@roeck-us.net>
References: <20220717171412.11142-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717171412.11142-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 07:14:12PM +0200, Aleksa Savic wrote:
> Define pump and fan speed register offsets in
> D5 Next control report, as well as its size, to expose PWM fan control.
> 
> Originally-from: Jack Doan <me@jackdoan.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - Clarified in the commit message that Jack Doan is the code author
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 0e56cc711a26..997d72ea6182 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -71,8 +71,12 @@ static u8 secondary_ctrl_report[] = {
>  #define D5NEXT_PUMP_OFFSET		0x6c
>  #define D5NEXT_FAN_OFFSET		0x5f
>  #define D5NEXT_5V_VOLTAGE		0x39
> +#define D5NEXT_CTRL_REPORT_SIZE		0x329
>  static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
>  
> +/* Pump and fan speed registers in D5 Next control report (from 0-100%) */
> +static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
> +
>  /* Register offsets for the Farbwerk RGB controller */
>  #define FARBWERK_NUM_SENSORS		4
>  #define FARBWERK_SENSOR_START		0x2f
> @@ -667,9 +671,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  		priv->num_fans = D5NEXT_NUM_FANS;
>  		priv->fan_sensor_offsets = d5next_sensor_fan_offsets;
> +		priv->fan_ctrl_offsets = d5next_ctrl_fan_offsets;
>  		priv->num_temp_sensors = D5NEXT_NUM_SENSORS;
>  		priv->temp_sensor_start_offset = D5NEXT_COOLANT_TEMP;
>  		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
> +		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
>  
>  		priv->temp_label = label_d5next_temp;
>  		priv->speed_label = label_d5next_speeds;
