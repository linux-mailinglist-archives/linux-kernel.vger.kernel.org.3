Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57673480B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhL1Qvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhL1Qvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:51:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557DC061574;
        Tue, 28 Dec 2021 08:51:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so76197564edv.1;
        Tue, 28 Dec 2021 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WRR+trVFG3aUmhcouCmMcrvl/yDBJw9FWlNG8ndvbJc=;
        b=T+/NB3GhwMNkQNE4m4n4Mv5dYI+XlZBWoFtEtiNudoWPVFOvWNwJxal3TypO6wdtow
         9ACBl5tEWHUS6+oo+mbIwSvUTBUDvm7v9925r0K8nz+QlnPXTbAA1N8Gb1MJx74jHwop
         TYIrJCckD+rloo/p0J7tSZzNwnBW6WlJaPjHmfPzqVGcq4C5nmNii0WLkdXwNMeptMfT
         7NiUF71PThw6/0cgYdjElRxCcfsYTj0l6E1+AtvmzMiKS1dT1121kIlPcbRHBjklFjwv
         Jt3lulc6XAqwIt0IDOygihjf2L3xbcZe8jgFcnxGyAoa8DQ+Mu3OjZ0yKkAhV//kxO+B
         LGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WRR+trVFG3aUmhcouCmMcrvl/yDBJw9FWlNG8ndvbJc=;
        b=LY6cnCGAtGoRrmA9bLY+JWaFjeuQaUdYt75esvbWU8ovkWdF3UOdBWRy2IejpYoTo7
         UMJGXMXEDxFH4+LcivSGHbhwYCjVm3yp118k1x29GzaTj1mC1bBYkHbd4m32pcpBeQnE
         RecaU6abDzdI/oedSf9EDzLzCg1UnkSCOpiAacBvAAgW4yPCNd60PxhhUO7Pm7x+gidf
         mH77kB9btjheL3gWV5Wm35QmQM4afTVLC8ktQYr086OwsicC4kbcsCcHyqiOM46K36YN
         lC0HaP9gJNT1aTmuUoKmVevi+SyHDTbrs6ApaL3aR44GWkcDcldyFSAWAaejpg+Jb6q2
         AKHw==
X-Gm-Message-State: AOAM5333bRzS3fJqmgzGSxjxkZt2pfqezNb1W6uhWXflObA4znSBLMW5
        OWn/G7uXinonlnz5b5ehlD1MqcrSgxo=
X-Google-Smtp-Source: ABdhPJxXJLgB/LeBzjNxbKlA5g7VtJBxjXK2hNz0tBughCWlVvJThR5gJbRIIjaVVfUFXObUX0d+kw==
X-Received: by 2002:a17:907:6ea2:: with SMTP id sh34mr18518407ejc.509.1640710302718;
        Tue, 28 Dec 2021 08:51:42 -0800 (PST)
Received: from [192.168.1.13] ([79.112.215.103])
        by smtp.gmail.com with ESMTPSA id cr17sm6238779ejc.107.2021.12.28.08.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 08:51:42 -0800 (PST)
Message-ID: <9b82bdf9-25a0-46cd-cfed-b86f114dc303@gmail.com>
Date:   Tue, 28 Dec 2021 18:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/1] hwmon: Add debugfs register access
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211227224201.508331-1-demonsingur@gmail.com>
 <20211227224201.508331-2-demonsingur@gmail.com>
 <b8dbcf50-8478-02c0-7a94-ff5b2b04aa2e@roeck-us.net>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <b8dbcf50-8478-02c0-7a94-ff5b2b04aa2e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/21 18:13, Guenter Roeck wrote:
> On 12/27/21 2:42 PM, Cosmin Tanislav wrote:
>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>
>> Similar to IIO, create a device directory inside debugfs
>> mount point, and create a direct_reg_access file inside
>> that directory, if debugfs_reg_access callback is defined
>> inside hwmon_ops.
>>
> 
> Patch looks good afaics. I don't want to apply it now (ie for 5.17),
> though, because it is getting close and we don't have a use case.
> If you have one in mind, I'd suggest to submit it together with
> this patch, or we'll have to wait until there is a user.
> 
> Guenter

As I mentioned previously I have a local patch on top of the ADT7X10
refactor that uses this. I tested your modifications to my patchset on
the ADT7420 part and it seems to work just fine. I can push it on top of
either this patch or that patchset, your choice.

> 
>> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
>> ---
>>   Documentation/hwmon/hwmon-kernel-api.rst |  9 +++
>>   drivers/hwmon/hwmon.c                    | 97 ++++++++++++++++++++++++
>>   include/linux/hwmon.h                    | 12 +++
>>   3 files changed, 118 insertions(+)
>>
>> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst 
>> b/Documentation/hwmon/hwmon-kernel-api.rst
>> index c41eb6108103..d568a0bfa5fb 100644
>> --- a/Documentation/hwmon/hwmon-kernel-api.rst
>> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
>> @@ -136,6 +136,8 @@ The list of hwmon operations is defined as::
>>               u32 attr, int, long *);
>>       int (*write)(struct device *, enum hwmon_sensor_types type,
>>                u32 attr, int, long);
>> +    int (*reg_access)(struct device *dev, unsigned int reg,
>> +              unsigned int writeval, unsigned int *readval);
>>     };
>>   It defines the following operations.
>> @@ -152,6 +154,13 @@ It defines the following operations.
>>       Pointer to a function for writing a value to the chip. This 
>> function is
>>       optional, but must be provided if any writeable attributes exist.
>> +* reg_access:
>> +    Pointer to a function for writing or reading a register to the chip.
>> +    This function is optional.
>> +    WARNING: Drivers implementing this function must block any access 
>> that
>> +    may cause issues such as power loss, board resets, flash 
>> corruption or
>> +    bricking.
>> +
>>   Each sensor channel is described with struct hwmon_channel_info, 
>> which is
>>   defined as follows::
>> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
>> index 3501a3ead4ba..027e5fc33114 100644
>> --- a/drivers/hwmon/hwmon.c
>> +++ b/drivers/hwmon/hwmon.c
>> @@ -10,6 +10,7 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   #include <linux/bitops.h>
>> +#include <linux/debugfs.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/gfp.h>
>> @@ -35,6 +36,9 @@ struct hwmon_device {
>>       struct list_head tzdata;
>>       struct attribute_group group;
>>       const struct attribute_group **groups;
>> +    unsigned int cached_reg_addr;
>> +    char read_buf[20];
>> +    unsigned int read_buf_len;
>>   };
>>   #define to_hwmon_device(d) container_of(d, struct hwmon_device, dev)
>> @@ -64,6 +68,90 @@ struct hwmon_thermal_data {
>>       struct thermal_zone_device *tzd;/* thermal zone device */
>>   };
>> +static struct dentry *hwmon_debugfs_dentry;
>> +
>> +static ssize_t hwmon_debugfs_read_reg(struct file *file,
>> +                      char __user *userbuf,
>> +                      size_t count, loff_t *ppos)
>> +{
>> +    struct hwmon_device *hwdev = file->private_data;
>> +    unsigned int val;
>> +    int ret;
>> +
>> +    if (*ppos > 0)
>> +        return simple_read_from_buffer(userbuf, count, ppos,
>> +                           hwdev->read_buf,
>> +                           hwdev->read_buf_len);
>> +
>> +    ret = hwdev->chip->ops->reg_access(&hwdev->dev, 
>> hwdev->cached_reg_addr,
>> +                       0, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    hwdev->read_buf_len = snprintf(hwdev->read_buf, 
>> sizeof(hwdev->read_buf),
>> +                       "0x%X\n", val);
>> +
>> +    return simple_read_from_buffer(userbuf, count, ppos, 
>> hwdev->read_buf,
>> +                       hwdev->read_buf_len);
>> +}
>> +
>> +static ssize_t hwmon_debugfs_write_reg(struct file *file,
>> +                       const char __user *userbuf,
>> +                       size_t count, loff_t *ppos)
>> +{
>> +    struct hwmon_device *hwdev = file->private_data;
>> +    unsigned int reg, val;
>> +    char buf[80];
>> +    int ret;
>> +
>> +    count = min_t(size_t, count, sizeof(buf) - 1);
>> +    if (copy_from_user(buf, userbuf, count))
>> +        return -EFAULT;
>> +
>> +    buf[count] = 0;
>> +
>> +    ret = sscanf(buf, "%i %i", &reg, &val);
>> +
>> +    switch (ret) {
>> +    case 1:
>> +        hwdev->cached_reg_addr = reg;
>> +        break;
>> +    case 2:
>> +        hwdev->cached_reg_addr = reg;
>> +        ret = hwdev->chip->ops->reg_access(&hwdev->dev, reg, val, NULL);
>> +        if (ret)
>> +            return ret;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +static const struct file_operations hwmon_debugfs_reg_fops = {
>> +    .open = simple_open,
>> +    .read = hwmon_debugfs_read_reg,
>> +    .write = hwmon_debugfs_write_reg,
>> +};
>> +
>> +static void hwmon_device_register_debugfs(struct hwmon_device *hwdev)
>> +{
>> +    struct dentry *dir = debugfs_create_dir(dev_name(&hwdev->dev),
>> +                        hwmon_debugfs_dentry);
>> +
>> +    debugfs_create_file("direct_reg_access", 0644, dir, hwdev,
>> +                &hwmon_debugfs_reg_fops);
>> +}
>> +
>> +static void hwmon_device_unregister_debugfs(struct hwmon_device *hwdev)
>> +{
>> +    struct dentry *dir = debugfs_lookup(dev_name(&hwdev->dev),
>> +                        hwmon_debugfs_dentry);
>> +
>> +    debugfs_remove_recursive(dir);
>> +}
>> +
>>   static ssize_t
>>   name_show(struct device *dev, struct device_attribute *attr, char *buf)
>>   {
>> @@ -114,6 +202,8 @@ static void hwmon_dev_release(struct device *dev)
>>   {
>>       struct hwmon_device *hwdev = to_hwmon_device(dev);
>> +    hwmon_device_unregister_debugfs(hwdev);
>> +
>>       if (hwdev->group.attrs)
>>           hwmon_free_attrs(hwdev->group.attrs);
>>       kfree(hwdev->groups);
>> @@ -817,6 +907,9 @@ __hwmon_device_register(struct device *dev, const 
>> char *name, void *drvdata,
>>           }
>>       }
>> +    if (chip && chip->ops->reg_access)
>> +        hwmon_device_register_debugfs(hwdev);
>> +
>>       return hdev;
>>   free_hwmon:
>> @@ -1062,12 +1155,16 @@ static int __init hwmon_init(void)
>>           pr_err("couldn't register hwmon sysfs class\n");
>>           return err;
>>       }
>> +
>> +    hwmon_debugfs_dentry = debugfs_create_dir("hwmon", NULL);
>> +
>>       return 0;
>>   }
>>   static void __exit hwmon_exit(void)
>>   {
>>       class_unregister(&hwmon_class);
>> +    debugfs_remove(hwmon_debugfs_dentry);
>>   }
>>   subsys_initcall(hwmon_init);
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index fad1f1df26df..587fb2931ac1 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -390,6 +390,16 @@ enum hwmon_intrusion_attributes {
>>    *            Channel number
>>    *        @val:    Value to write
>>    *        The function returns 0 on success or a negative error number.
>> + * @reg_access:
>> + *        Callback to read or write register values.
>> + *        Parameters are:
>> + *        @dev:    Pointer to hardware monitoring device
>> + *        @reg:    Register address to read or write
>> + *        @writeval:
>> + *            Value to write to register. 0 when reading.
>> + *        @readval:
>> + *            Pointer to value read from register. NULL when writing.
>> + *        The function returns 0 on success or a negative error number.
>>    */
>>   struct hwmon_ops {
>>       umode_t (*is_visible)(const void *drvdata, enum 
>> hwmon_sensor_types type,
>> @@ -400,6 +410,8 @@ struct hwmon_ops {
>>               u32 attr, int channel, const char **str);
>>       int (*write)(struct device *dev, enum hwmon_sensor_types type,
>>                u32 attr, int channel, long val);
>> +    int (*reg_access)(struct device *dev, unsigned int reg,
>> +              unsigned int writeval, unsigned int *readval);
>>   };
>>   /**
>>
> 
