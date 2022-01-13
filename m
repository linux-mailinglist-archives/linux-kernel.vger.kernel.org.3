Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86D48D08D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiAMCvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiAMCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:51:51 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED0C06173F;
        Wed, 12 Jan 2022 18:51:50 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id i9so5970627oih.4;
        Wed, 12 Jan 2022 18:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5FspLJRD1mfTtVmG8jofxIl0TqdWH9PjoPfFz13cPbY=;
        b=bMTVHbnmenwmjEpx9DAXoNej8qPqk/ly5dOLsu4w0cQBnhvLKcDGPyESIm06BaF/8e
         LkfSzfIpZvCH0FnkT3u+y3OlvP0Bu6DdcQQrhI9H50ESuEYuzDW+WGe4BoLWPwU9hS+d
         rWofWWTSSZXYRcBQdn8uXCysp/HOfNjGuEAIijB6O1fHdW0l6SwcEvCZGmkOCvNGL33A
         koXayCxl3Z8BDLBS4lNBZ5bbEztT5HWTfJNnJz6Ld3dpHuQaVws3XWs5+Kh4IWA8RVtG
         WRKfq9qI/8DAgZleZeL84caxKKPcjQRBBG5zTJhducLNlf1qEVQAG5JKsO+Fh7KvEt7Z
         g3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5FspLJRD1mfTtVmG8jofxIl0TqdWH9PjoPfFz13cPbY=;
        b=iE/YudLr84ElVN0TlNwV6KmHZ1GBCBnDCB/prME1NhxYUGiX8nIaW28ReHrewA3dPt
         OZdZ+uRmdNq/z2J2D2+OfWoof5pt64zT1ziJyv2pjlWQdiXYbtwxPGv06dvul7inJS6u
         bKj4B/J/f9EJTvInmosEWgqOE8CDKCIIxPEh8zSAIoMvFWgc9ZVx8R+0hOrd/ZXEck5t
         IPx1F7SP8KQpT3IxaPOIJTcrXqkFgzoay8sFrIcEFgrMEtoH7uWSimlQtZYG9aux9DIz
         bWWiaVqhF5fXSQVbEVgo1lq3mYr6Q/iLSaT/oyL+sFX2+DDun1LU4CeUeAgsDcejH1RY
         +FqQ==
X-Gm-Message-State: AOAM5302aBE4hkMNphpzf+kJ1/RpnHubG5iAWkIxJoSUiS+ufxa5AHgQ
        F+qFPlvVQSb/tThrseglNkD3X3L4fxU=
X-Google-Smtp-Source: ABdhPJyfuKmp30/9hMSNIJDjRDN2Q2GXHpOZoNENUHbo8yamhaGDueRih+aUQwpJj7oudpzShoBHhQ==
X-Received: by 2002:a05:6808:1119:: with SMTP id e25mr1790235oih.30.1642042310046;
        Wed, 12 Jan 2022 18:51:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm298923otl.26.2022.01.12.18.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 18:51:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220111180347.1245774-1-eugene.shalygin@gmail.com>
 <20220111180347.1245774-4-eugene.shalygin@gmail.com>
 <2224186.ElGaqSPkdT@natalenko.name>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 3/3] hwmon: deprecate asis_wmi_ec_sensors driver
Message-ID: <a95919c0-6a89-18bc-e8ba-2165414e096b@roeck-us.net>
Date:   Wed, 12 Jan 2022 18:51:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2224186.ElGaqSPkdT@natalenko.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 1:51 PM, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 11. ledna 2022 19:03:46 CET Eugene Shalygin wrote:
>> ---
>>   drivers/hwmon/Kconfig | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 2c16b19d2c03..5e693c93d43a 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -2243,13 +2243,16 @@ config SENSORS_ASUS_WMI
>>   
>>   config SENSORS_ASUS_WMI_EC
>>   	tristate "ASUS WMI B550/X570"
>> -	depends on ACPI_WMI
>> +	depends on ACPI_WMI && !SENSORS_ASUS_EC
> 
> Not sure how it handles `SENSORS_ASUS_EC=m`. Probably, it should be:
> 
> ```
> depends on ACPI_WMI && SENSORS_ASUS_EC=n
> ```
> 

Odd language, and good catch. If I understand correctly, the result
of !SENSORS_ASUS_EC is 'm' if SENSORS_ASUS_EC=m. So, yes, it looks
like this needs to be "ACPI_WMI && SENSORS_ASUS_EC=n".

Guenter

> ?
> 
>>   	help
>>   	  If you say yes here you get support for the ACPI embedded controller
>>   	  hardware monitoring interface found in B550/X570 ASUS motherboards.
>>   	  This driver will provide readings of fans, voltages and temperatures
>>   	  through the system firmware.
>>   
>> +	  This driver is deprecated in favor of the ASUS EC Sensors driver
>> +	  which provides fully compatible output.
>> +
>>   	  This driver can also be built as a module. If so, the module
>>   	  will be called asus_wmi_sensors_ec.
> 
> Thanks.
> 

