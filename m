Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C44929FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiARQCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiARQCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:02:08 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C5C061574;
        Tue, 18 Jan 2022 08:02:08 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id z25-20020a0568301db900b005946f536d85so15809795oti.9;
        Tue, 18 Jan 2022 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRWvJqJCJB2zDMiflQ0w0m6dxBHwwBYShSFfH7UqcLk=;
        b=peU65y+/8o9dTYfTioMQ4LSpvEhuJx6xNloR8e5IispZZSomPalSG3yTpB0b6b6MQT
         Nw0uGbiMW1uX8hP0gDkJMp+ZniJUpKFBIilMAusIbHdA00IIfHlWEoDmli7l9bdNzPsB
         cUBhndmqq8n1bSInmeMFGH6Uv4L5n3357ykRMYZewgoJMvhaKsBxi0PSrveeZlN4Nkh0
         So0ngNa5doNyZU+mJboiZ1wKZKPUmDOsM8dZgqjdNSmrYNhPYV7VOxjglgfjglKV2HSR
         tWpQDRN/j0A5LgB1uwCZ3ya45TAuliAzjULrhpBBYfflig0T+ebqMRaaTklND+pjO9sU
         3Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRWvJqJCJB2zDMiflQ0w0m6dxBHwwBYShSFfH7UqcLk=;
        b=wvUa9YIYJ77faQca5bsdj5TjdC3mLmX/+wIPupUCqWTJmORTbt/IhGtvn/Nvm/VT7z
         t6UzbNzhEHmL+t4Fs/r1U4ubTt3pP5mUWJi0i8YzsM8K8Rgrc4Iy1S70cqIKHb8ZyY78
         NUItpxUbZ/fjx5W6ht8Z/w1gvqIpBNKxcZsN/HZA+1MEa6z1U8LURfG1ss16SvCAFzq6
         8RI1eKgn2S0RZbCaJrG49+bRgAEVIm4Vkwt4atqaicCIUnA6DzVMM7860Tu9GV50vhI4
         XohHTUxtD4HN4qgTTJkeWBuwTi+dcpxebEmpoyVLlj9KkESTJLcudgWDXpbqPfqcBvan
         ELeQ==
X-Gm-Message-State: AOAM533YC1LGvraYvitFl+kZCLy3ERqDYoT3Rqw+oYawfCo0DayOW59t
        jHyzreXkk0jyHizuw0rDdG7aCJ2+piI=
X-Google-Smtp-Source: ABdhPJzy9v7kvJYI0+MuBDbD9FB49K/5OA24lyxf9WbKymoD40fCrr9UBa8MIMOc0pWZcCbLwUbGRg==
X-Received: by 2002:a9d:6242:: with SMTP id i2mr12390212otk.127.1642521727248;
        Tue, 18 Jan 2022 08:02:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12sm6972682otq.67.2022.01.18.08.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:02:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [ASUS EC Sensors V6 v6 3/3] hwmon: deprecate asis_wmi_ec_sensors
 driver
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
 <20220116201843.2301438-4-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <08d4e523-d4c2-f0a4-c681-179cd6051527@roeck-us.net>
Date:   Tue, 18 Jan 2022 08:02:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220116201843.2301438-4-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


No description, no Signed-off-by:. Sorry, you'll have to resend.

Guenter

On 1/16/22 12:18 PM, Eugene Shalygin wrote:
> ---
>   drivers/hwmon/Kconfig | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2c16b19d2c03..38094c702e4d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
>   
>   config SENSORS_ASUS_WMI_EC
>   	tristate "ASUS WMI B550/X570"
> -	depends on ACPI_WMI
> +	depends on ACPI_WMI && SENSORS_ASUS_EC=n
>   	help
>   	  If you say yes here you get support for the ACPI embedded controller
>   	  hardware monitoring interface found in B550/X570 ASUS motherboards.
>   	  This driver will provide readings of fans, voltages and temperatures
>   	  through the system firmware.
>   
> +	  This driver is deprecated in favor of the ASUS EC Sensors driver
> +	  which provides fully compatible output.
> +
>   	  This driver can also be built as a module. If so, the module
>   	  will be called asus_wmi_sensors_ec.
>   
> 

