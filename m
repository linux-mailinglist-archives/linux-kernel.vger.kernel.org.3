Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA185237EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344164AbiEKP7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiEKP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:59:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF81505CF;
        Wed, 11 May 2022 08:59:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id F0E6E1F41720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652284760;
        bh=JQ6HdYH9HaMCjw2/dzr/tOM16K501dak4z60cc1ZykY=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=KNGvZVnG5pMiE8Utp5gcEaS8cUQTgJ9S8uF7Hli0BhK/lKJPjNXFvBRxIjG+ZoLHb
         rhc2GromAoJx2M9tCfKJvyJp5uGE5rhlqLmbYTEpUqhXfnZA/SuelhrPq7PxXZZ2fE
         1y62AIMulgwoeS3cKUdjYmreBBaK3WCHaWLvkgOJoPkbJgOhZzJyzurGWHIZBjjahe
         gwj20WjmXJPjAc8Q5BGoGCDnCYSlZ0foEq0rioYpu2JdKDRJNk0wcAQyeW3qGY+Osx
         fFkQ31tZTqjjdD1TV6uCgcZKe94uF3kVRxVtJdndKhA+woeXmd8egj+txOJaHirB8j
         nk1E7XqdyvT4Q==
Message-ID: <8bd83f45-5278-e817-3f65-88fafd0ad3f4@collabora.com>
Date:   Wed, 11 May 2022 20:59:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH RESEND v11] platform/chrome: Add ChromeOS ACPI device
 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     usama.anjum@collabora.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
References: <YnoJ0k6eIUiwjXSZ@debian-BULLSEYE-live-builder-AMD64>
 <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75Vd574LCnEq-KX=WHnnDyrjZgGu6W9wNEbnw79FBpyx=Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for reviewing.

On 5/10/22 2:33 PM, Andy Shevchenko wrote:
> On Tue, May 10, 2022 at 8:44 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
>> to the ChromeOS ACPI device and exports the values reported by ACPI in a
>> sysfs directory. This data isn't present in ACPI tables when read
>> through ACPI tools, hence a driver is needed to do it. The driver gets
>> data from firmware using the ACPI component of the kernel. The ACPI values
>> are presented in string form (numbers as decimal values) or binary
>> blobs, and can be accessed as the contents of the appropriate read only
>> files in the standard ACPI device's sysfs directory tree. This data is
>> consumed by the ChromeOS user space.
> 
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
> 
> You can use --cc parameter to `git send-email` instead of putting
> these lines in the commit message.
> 
> ...
> 
>> +#define DEV_ATTR(_var, _name)                                  \
>> +       static struct device_attribute dev_attr_##_var =        \
>> +               __ATTR(_name, 0444, chromeos_first_level_attr_show, NULL);
>> +
> 
> Why not ATTR_RO()?
It'll not work as attribute name has . in it.

> 
> ...
> 
>> +#define GPIO_ATTR_GROUP(_group, _name, _num)                                           \
>> +       static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,                \
>> +                                                  struct attribute *attr, int n)       \
>> +       {                                                                               \
>> +               if (_num < chromeos_acpi_gpio_groups)                                   \
>> +                       return attr->mode;                                              \
> 
>> +               else                                                                    \
> 
> Redundant.
We are deciding on run time that how many GPIO attribute groups need to
be shown. chromeos_acpi_gpio_groups is set at run time. I don't see why
`else` can be redundant here.

> 
>> +                       return 0;                                                       \
>> +       }                                                                               \
>> +       static ssize_t chromeos_attr_show_gpio_##_num(struct device *dev,               \
>> +                                                     struct device_attribute *attr,    \
>> +                                                     char *buf)                        \
>> +       {                                                                               \
>> +               char name[ACPI_ATTR_NAME_LEN + 1];                                      \
>> +               int ret, num;                                                           \
>> +                                                                                       \
>> +               ret = parse_attr_name(attr->attr.name, name, &num);                     \
>> +               if (ret)                                                                \
>> +                       return ret;                                                     \
> 
>> +               ret = chromeos_acpi_evaluate_method(dev, _num, num, name, buf);         \
>> +               if (ret < 0)                                                            \
>> +                       ret = 0;                                                        \
> 
> Below I saw the same code, why is the error ignored?
> 
I'll return the error in both places.

>> +               return ret;                                                             \
>> +       }                                                                               \
>> +       static struct device_attribute dev_attr_0_##_group =                            \
>> +               __ATTR(GPIO.0, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
>> +       static struct device_attribute dev_attr_1_##_group =                            \
>> +               __ATTR(GPIO.1, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
>> +       static struct device_attribute dev_attr_2_##_group =                            \
>> +               __ATTR(GPIO.2, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
>> +       static struct device_attribute dev_attr_3_##_group =                            \
>> +               __ATTR(GPIO.3, 0444, chromeos_attr_show_gpio_##_num, NULL);             \
>> +                                                                                       \
>> +       static struct attribute *attrs_##_group[] = {                                   \
>> +               &dev_attr_0_##_group.attr,                                              \
>> +               &dev_attr_1_##_group.attr,                                              \
>> +               &dev_attr_2_##_group.attr,                                              \
>> +               &dev_attr_3_##_group.attr,                                              \
>> +               NULL                                                                    \
>> +       };                                                                              \
>> +       static const struct attribute_group attr_group_##_group = {                     \
>> +               .name = _name,                                                          \
>> +               .is_visible = attr_is_visible_gpio_##_num,                              \
> 
>> +               .attrs = attrs_##_group                                                 \
> 
> Keep a comma here.
Is there any particular reason for it? If there is, I'll add commas to
all the structures.
...
> 
> ...
> 
>> +static int parse_attr_name(const char *name, char *attr_name, int *attr_num)
>> +{
>> +       int ret = 0;
>> +
>> +       strscpy(attr_name, name, ACPI_ATTR_NAME_LEN + 1);
>> +
>> +       if (strlen(name) > ACPI_ATTR_NAME_LEN)
> 
> This seems strange, esp. taking into account that strscpy() returns that.
> 
> int ret;
> 
> ret = strscpy(...);
> if (ret == -E2BIG)
>   return kstrtoint(...);
> 
> return 0;
This is very nice way to do it. I'll update.
...

-- 
Muhammad Usama Anjum
