Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F6A5A2DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbiHZSHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHZSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:07:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302F192BB;
        Fri, 26 Aug 2022 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661537246;
        bh=hRvarPt/vDEjfDmjGnhrdNuhWBISD4yTkXxXIrBjPH8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cRFzDJrMMCjBHSp1zbo9hLGg72uMaDYQW0UQL1A7pXJXvEZsl5F8n34U060qQoMJ8
         a3E9wpIM1XPqIvY4FypzMp9kKQ7/IaslgXhrLDC5lsopwOf0yhVtpLLeOI2OI1Yyy9
         zeEXTbjeIiWxkMzTESMAbliNeezsFlawTFquUF2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1ohvX91VO9-00LHX7; Fri, 26
 Aug 2022 20:07:26 +0200
Subject: Re: [PATCH 1/2] hwmon: Add include stubs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220825214341.2743-1-W_Armin@gmx.de>
 <20220825214341.2743-2-W_Armin@gmx.de>
 <20220826124742.GD2897306@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <2127da59-c8aa-301e-4648-2abf48ea7d61@gmx.de>
Date:   Fri, 26 Aug 2022 20:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220826124742.GD2897306@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:JRX2b73jr3GBB6kJTSCx+kfTwnxbMr2JBDz/M9uA2E5ks1tqc0+
 mlN7JimZNQBXFdEVVThFO1gfN9ciCMRRe3nrgUA7Si8uEoiFCVLql3Q+1wDiDSLu/QxmZjy
 y17Otnu9CNACzrpJVPCfTsM8ZQxl8tYQI9YHW6bFcOmaceICcOGViYiKvDBTo4Blh+CAJ7C
 4Ax54RiCPIEVNm4QKuJ4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5EPKsk3ZGKs=:X1soPrpPdhiYRzW0i8GXJd
 Aj82lLDcrOXncI84u3h97EAOWjFVTQDxHN//nojQNjHngOqnu5y1zq2LDs/I5xKnZZsJI4BNs
 XRWxVszOjXPKRsc0LzJLTMsXVE0qKvD9wI3HDTs0eiVz3V1U72UcD2hTs3QmQf9IYbiS8Rn9g
 lgxcIKy/Gwl+5o4hmnyKN1/XlElmvnCXcYqg19wzvJGIGwPx9b+qGpxWMVYizl8SWtQy9yMbR
 Np0UlDLUXDmSXUeeJ3yI/S8cbuUgG1urmAXQxPOathTSSeEEJaj47nrUnKD0EjuoBtidXi1NO
 lZWYg20bEaaAoGBcQsa9VmF03yoipr9hvUNYslOlareuchb964LN7AcHgb9CYeXOsHCXc6Ju4
 Tmiq+eaQXci6AokHaa9+3eWpticRPG6yR3vLk8Dgiy1pFHkcaxwAQt/KURkSMO60kREQbuiRZ
 OKjqEYz8iWgP6m0sowAWUNDXtx1PZLWpxFtQgS50jmWFDoMhlcZUD2yI4klsJya+8kI1pGbXN
 1NKGtllkMnocAQrjYgMun05Qj+wu++UQdgQtlnJopg4Qr0gy9ovplnL38UAtC4vzSCeNmF4BB
 +5Iof9iy5xmKzbr1qM7HghywYWnJGNfpyHlbOc6O03+6Cc43GsA0JGPaFbWzxS9b8UzXahZiq
 cLThSkO0RJFqUslfQdq4stEJAmHURjIlz5pV9MKofFC3pPbOoFpsBNCcNnPpgVVHmfW3jLV2v
 MvSch6uaTf3gzvpgaMpJgCJm/OLtOrQki6F5RHVTJ77fbYx7qS/fYWuVWWtjHitjvdCWXVoAt
 5zs94SuL4z759o3wG7MtotxIliPLUTb+VjNJHVfjPrQRKDcto/D6enhn4KDPnQWvOSyoQR2Ii
 127t8saR66UgmP+dn6iC4dHvwFVPVIsH9sEc2dF/jL5orGoDjtKlc1yI7DomI8a8LsNIZYEEM
 VZ8WJy9PCJhhhQuqJnF6NkixxPpDBqwloJipxVaiQBVHyn1Ol6Mw50e2SlkfnekL+dKrc8d2V
 agb3lzGfgIG857Kdziaijup6rGYL1vHYx1iz9Ur+XjhHyeh2zArEHm6X9x30yEBDsx3qGL8yb
 umoLcM2iRk/1CEnGRb/3acqepUkGatFdCyrIaWKJrQWYirfSOT2XoTF7A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.08.22 um 14:47 schrieb Guenter Roeck:

> On Thu, Aug 25, 2022 at 11:43:40PM +0200, Armin Wolf wrote:
>> If CONFIG_HWMON/CONFIG_HWMON_VID was disabled during compile
>> time, driver using the hwmon subsystem might fail to compile.
> That would be a bug in driver dependencies and is not a problem
> to be solved in the hwmon subsystem. Dummies are not provided on
> purpose so far because we _want_ driver developers to think about
> usage and for them to understand what happens if HWMON is not enabled.

My wording might have been incorrect, i meant that currently, code who uses
the hwmon subsystem must either select CONFIG_HWMON or provide #ifdef guards.

> The benefit is that it would reduce the need for conditional code
> in drivers registering with hwmon from outside the hwmon subsystem.
>
>> Provide stubs for such cases.
>>
> HWMON_VID is not user selectable, it is only needed by hwmon drivers,
> it is mandatory for the drivers needing it, those drivers _must_ select
> it, and there must be no dummies.
>
> I am not really sure about the benefits of dummies for HWMON either,
> but I am open to discussion. Either case that must be accompanied
> by matching driver patches to show its usage, to make sure that there
> is no negative impact, to show the benefits, and to get a wider audience.
>
Understandable, i will include such patches in the next revision.

>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   include/linux/hwmon-vid.h | 18 ++++++++++
>>   include/linux/hwmon.h     | 76 ++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 93 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
>> index 9409e1d207ef..329151416c47 100644
>> --- a/include/linux/hwmon-vid.h
>> +++ b/include/linux/hwmon-vid.h
>> @@ -11,9 +11,27 @@
>>   #ifndef _LINUX_HWMON_VID_H
>>   #define _LINUX_HWMON_VID_H
>>
>> +#include <linux/kconfig.h>
>> +
>> +#if IS_ENABLED(CONFIG_HWMON_VID)
>> +
>>   int vid_from_reg(int val, u8 vrm);
>>   u8 vid_which_vrm(void);
>>
>> +#else
>> +
>> +static inline int vid_from_reg(int val, u8 vrm)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline u8 vid_which_vrm(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif /* CONFIG_HWMON_VID */
>> +
>>   /* vrm is the VRM/VRD document version multiplied by 10.
>>      val is in mV to avoid floating point in the kernel.
>>      Returned value is the 4-, 5- or 6-bit VID code.
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index 14325f93c6b2..281387ee03bc 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -13,6 +13,9 @@
>>   #define _HWMON_H_
>>
>>   #include <linux/bitops.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kconfig.h>
>>
>>   struct device;
>>   struct attribute_group;
>> @@ -433,6 +436,8 @@ struct hwmon_chip_info {
>>   	const struct hwmon_channel_info **info;
>>   };
>>
>> +#if IS_ENABLED(CONFIG_HWMON)
> This should be IS_REACHABLE(). It doesn't help if HWMON is built as
> module and called from an in-kernel driver. Otherwise drivers using it
> would still need "depends on HWMON || HWMON=n" and it would still require
> conditional code to catch "HWMON enabled but not reachable".
>
>> +
>>   /* hwmon_device_register() is deprecated */
>>   struct device *hwmon_device_register(struct device *dev);
>>
>> @@ -467,6 +472,75 @@ int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type,
>>   char *hwmon_sanitize_name(const char *name);
>>   char *devm_hwmon_sanitize_name(struct device *dev, const char *name);
>>
>> +#else
>> +
>> +static inline struct device *hwmon_device_register(struct device *dev)
>> +{
>> +	return ERR_PTR(-ENODEV);
> -ENOTSUPP would probably be a more suitable error code.

The stubs found in other header files do return -ENODEV, so i though
that this should also be done inside hwmon.h

Armin Wolf

>> +}
>> +
>> +static inline struct device
>> +*hwmon_device_register_with_groups(struct device *dev, const char *name, void *drvdata,
>> +				   const struct attribute_group **groups)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline struct device
>> +*devm_hwmon_device_register_with_groups(struct device *dev, const char *name, void *drvdata,
>> +					const struct attribute_group **groups)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline struct device
>> +*hwmon_device_register_with_info(struct device *dev, const char *name, void *drvdata,
>> +				 const struct hwmon_chip_info *info,
>> +				 const struct attribute_group **extra_groups)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline struct device *hwmon_device_register_for_thermal(struct device *dev, const char *name,
>> +							       void *drvdata)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline struct device
>> +*devm_hwmon_device_register_with_info(struct device *dev, const char *name, void *drvdata,
>> +				      const struct hwmon_chip_info *info,
>> +				      const struct attribute_group **extra_groups)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline void hwmon_device_unregister(struct device *dev)
>> +{
>> +}
>> +
>> +static inline void devm_hwmon_device_unregister(struct device *dev)
>> +{
>> +}
>> +
>> +static inline int hwmon_notify_event(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>> +				     int channel)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline char *hwmon_sanitize_name(const char *name)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline char *devm_hwmon_sanitize_name(struct device *dev, const char *name)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +#endif /* CONFIG_HWMON */
>> +
>>   /**
>>    * hwmon_is_bad_char - Is the char invalid in a hwmon name
>>    * @ch: the char to be considered
>> @@ -490,4 +564,4 @@ static inline bool hwmon_is_bad_char(const char ch)
>>   	}
>>   }
>>
>> -#endif
>> +#endif /* _HWMON_H_ */
>> --
>> 2.30.2
>>
