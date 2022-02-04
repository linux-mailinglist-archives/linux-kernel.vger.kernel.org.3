Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173234A9349
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiBDFR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiBDFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:17:55 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BEC061714;
        Thu,  3 Feb 2022 21:17:54 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y23so7239582oia.13;
        Thu, 03 Feb 2022 21:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l3ZQirJN7kR1FPeuRUvVpgAJYVeQULZAuLFjO0OCycA=;
        b=p9CcdUqxpIyYuG16ViVgRkY2pinhNxSRidZAQdBCd2ImtK0pUMMqpgd0OA0PumJ49n
         EE2dtVrJUO+aFBJh7FwCEQpRjp+UrauZsf4pfsK/PxoocyYW277OhdmCiP+JfEo1fKZ3
         LemBe1DMkB9FR3jkrBhVYux7D0KQofgXPsfDq7VsbOLNvX8b7wyDso32Fut0qkTA7T+I
         Wunk/lVTgteV4eTlZt1kK89SqtnaYyQsq90HpBCU5/jtmvFxcR/qVCnV83QAlFG+IPQ/
         SmZhMh8V0sU5Bgx+h9Np9BIIPEI/8N03TDJvbBM10M5XlgxVkNQoFR2pJ4einmrHwOFQ
         VkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=l3ZQirJN7kR1FPeuRUvVpgAJYVeQULZAuLFjO0OCycA=;
        b=APNyyeGqXXe+3jnYR4qyv5G1P5DHKIbfVOcvzGj77EMbKFuoDO3Upgiuw4oRTjF04N
         Q0YITOpHWLu5zVre6/0DYZfiJEbKHEVAIRP//3XXVDbBw2uItCPOoKNlTNzYoCObjH1z
         6uy/ue6ZZYo3eT14qmE2aZqIU10cBSmeEFofICQYNMrm51jHEkYRYOls5dzc5Qlq+oj8
         eDnGbX1PbxMxLi6RZJfqfGQ8797bPrwX4WC6cDRc5JiZAWH5jExUbzPpvtHIZ6Evrew/
         2hlNsjgsrdUWOanUfxXgdnkMht0czQ3c+T4yMmt7cX+urpqImpVKo1JIjVtZIqrEqewh
         rxLw==
X-Gm-Message-State: AOAM531Mzf3szUMbhHGNE5mf9JHFLFwc9w1YnwavEXOBKcX6+YH1J04P
        PiuYZVIPnXNC5qN3ctGED5G7Ib5X19c/GQ==
X-Google-Smtp-Source: ABdhPJzBOKwXT7CULH5WA5xwsMig5QVBxphnuMvPPGbQp4EqTPdLOL9RTfZewHZwT40Sb/VjnOct4Q==
X-Received: by 2002:a05:6808:212a:: with SMTP id r42mr597383oiw.94.1643951874102;
        Thu, 03 Feb 2022 21:17:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l14sm352739ooq.12.2022.02.03.21.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:17:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Feb 2022 21:17:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: hwmon: (asus-ec-sensors) Add Crosshair VIII Hero WiFi
Message-ID: <20220204051751.GA345469@roeck-us.net>
References: <20220203203052.441712-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203203052.441712-1-eugene.shalygin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:30:52PM +0100, Eugene Shalygin wrote:
> The Wi-Fi variant of Crosshair VIII Hero provides the same sensors,
> which was tested by a Libre Hardware Monitor user [1].
> 
> [1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/453#issuecomment-1028398487
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst | 1 +
>  drivers/hwmon/asus-ec-sensors.c         | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index b12ac7ebeb1a..22de1b037cfb 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -7,6 +7,7 @@ Supported boards:
>   * PRIME X570-PRO,
>   * Pro WS X570-ACE,
>   * ROG CROSSHAIR VIII DARK HERO,
> + * ROG CROSSHAIR VIII HERO (WI-FI)
>   * ROG CROSSHAIR VIII FORMULA,
>   * ROG CROSSHAIR VIII HERO,
>   * ROG CROSSHAIR VIII IMPACT,
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 7285334c7d80..05244209c0c6 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -188,6 +188,12 @@ static const struct dmi_system_id asus_ec_dmi_table[] __initconst = {
>  		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
>  		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
>  		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
> +	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
> +			      "ROG CROSSHAIR VIII HERO (WI-FI)",
> +		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
> +		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> +		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
> +		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU),
>  	DMI_EXACT_MATCH_BOARD(VENDOR_ASUS_UPPER_CASE,
>  			      "ROG CROSSHAIR VIII IMPACT",
>  		SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
