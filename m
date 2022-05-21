Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE2E52FEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbiEUTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiEUTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:16:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3AE5007E
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:16:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h14so15550609wrc.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2uC/3RyXqWOkH/0zlLOXjt5Wvw0qvh3OxTW3crUSw00=;
        b=gcFXVhQJZ9/m7nbyz+zYDubXBPq4LCEchM7SrfzkKTKOvhjhuixvmD+KWtuzql4TpE
         AX9/OnR5XAs3hSSZsKC/Tmk6fS6zAGGRE4/7MTiBcgcPE5elbbJ9QLkoRz0QQEAxDMHe
         ciYUqjWY+dktD3Y+EHHAhqXw/Kst6BhQv3E8AQnejM8snBk5jCtYhSgvYFriRx6yDI6d
         I19P6fzdRcFhJWypa72lYNHkNNGFB2VsrXBi+ZulZZrnMjmznVJe89cv2nZnXFOqMYVx
         KukRfVBz6vxfuhRcz/3PPNt/yFDM0ny/xm8b4qxAWDwzmxB1Ppg2Mcwm6A+sj37dYci7
         FXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2uC/3RyXqWOkH/0zlLOXjt5Wvw0qvh3OxTW3crUSw00=;
        b=guXwxV9K+RyxlKGHKTP8Mggj/kPcikng8dCoUIO31QX2tT1prpTeZ/J4aOKW40NuXW
         IYx+fU6IteAJa3yBzsV89Yii/BM/6bVEVP3ACCBBK3jvkZyf29uZ3SIc8Loy1I8nFlac
         ZITL5No5mZvuSYiEJG5hYgPMRzsVOhQIBkaYsaRx5przbzZ3TWheAFB1I8RbZvsAPLEv
         hoXFkWry7o9aVP/33ZljeJZIf9jY7guHqx9X3R9jxdR3hk2/uNzN2hGBvl2WUhj6vQ3l
         B3y1MRZCiOU1AzIQkAmfe5aZCG31yKyQJp+U9Qmq5IHThwTWHS+TgdA8K+m2g8dZC+T/
         f+Aw==
X-Gm-Message-State: AOAM531JMOhVtgA+bPH1dbkPqobwXWT2WGiVqwtatAMwaxqQXR4PW2yx
        MnaeHt/4lTrgJHJd4ZuXihVAMA==
X-Google-Smtp-Source: ABdhPJzKD1foyF38YEmBuxxo7uUx5Gk0i/Lv6O6YfNNWKpScwkJVu6S07OdvNaMP2UaCK0c5Rfs2gg==
X-Received: by 2002:a5d:4a10:0:b0:20d:5f7:253 with SMTP id m16-20020a5d4a10000000b0020d05f70253mr13087415wrq.681.1653160590324;
        Sat, 21 May 2022 12:16:30 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id l8-20020a7bc448000000b003942a244f2esm4992901wmi.7.2022.05.21.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:16:29 -0700 (PDT)
Date:   Sat, 21 May 2022 21:16:26 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Message-ID: <Yok6iuNUGerryFkO@Red>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net>
 <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net>
 <YoHtg30ZrhxjVedA@Red>
 <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
 <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b038aa19-9cba-d16a-15c5-e02fc749ab96@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, May 21, 2022 at 06:52:15AM -0700, Guenter Roeck a écrit :
> On 5/16/22 05:21, Guenter Roeck wrote:
> > On 5/15/22 23:21, LABBE Corentin wrote:
> >> Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
> >>> On 5/15/22 12:36, LABBE Corentin wrote:
> >>>> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
> >>>>> Corentin,
> >>>>>
> >>>>> On 5/8/22 23:30, Corentin Labbe wrote:
> >>>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> >>>>>> So let's convert the driver to use hwmon_device_register_with_info().
> >>>>>>
> >>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >>>>>> ---
> >>>>> [ ... ]
> >>>>>
> >>>>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>>>>>             if (res)
> >>>>>>                 break;
> >>>>>> -        remove_attrs(resource);
> >>>>>> +        remove_domain_devices(resource);
> >>>>>>             setup_attrs(resource);
> >>>>>
> >>>>> Zhang Rui found an interesting problem with this code:
> >>>>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
> >>>>> to update sysfs attribute visibility, probably between
> >>>>> remove_domain_devices() and setup_attrs().
> >>>>>
> >>>>>>             break;
> >>>>>>         case METER_NOTIFY_TRIP:
> >>>>>> -        sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> >>>>>> +        hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
> >>>>>
> >>>>> ... which makes realize: The notification device should be the hwmon device.
> >>>>> That would be resource->hwmon_dev, not the acpi device.
> >>>>>
> >>>>
> >>>> Hello
> >>>>
> >>>> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
> >>>> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
> >>>>
> >>>> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
> >>>>
> >>>> For testing config change I have tried lot of way:
> >>>>                   res = read_capabilities(resource);
> >>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>>>                   remove_domain_devices(resource);
> >>>>                   setup_attrs(resource);
> >>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
> >>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
> >>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> >>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
> >>>
> >>> Did you add a debug log here ?
> >>
> >> Yes I added debug log to check what is called.
> >>
> >>>
> >>> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
> >>> It would have to be resource->hwmon_dev->groups.
> >>>
> >>
> >> Even with that, no call to is_visible:
> >> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
> >>                  remove_domain_devices(resource);
> >>                  setup_attrs(resource);
> >> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
> >> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
> >> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> >> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
> >>                  break;
> >>
> >> I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
> >> So perhaps it explain why it is never called.
> > 
> > Ah yes, you are correct. Sorry, it has been too long ago that I wrote that code.
> > Effectively that means we'll have to rework the hwmon core to generate attributes
> > anyway and leave it up to the driver core to call the is_visible function.
> > 
> 
> Attached is an outline of what would be needed in the hwmon core.
> Completely untested. I wonder if it may be easier to always
> create all attributes and have them return -ENODATA if not
> supported.
> 

With your patch, the notify config change lead to new attributes to be displayed.

Your patch just needs:
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -315,7 +315,7 @@ static void hwmon_thermal_notify(struct device *dev, int index)
 }
 
 #else
-static int hwmon_thermal_register_sensors(struct device *dev)
+static int hwmon_thermal_register_sensors(struct device *dev, bool update)
 {
        return 0;
 }

Tested with:
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -40,7 +40,7 @@
 #define METER_NOTIFY_INTERVAL  0x84
 
 static int cap_in_hardware;
-static bool force_cap_on;
+static bool force_cap_on = 1;
 
 static int can_cap_in_hardware(void)
 {
@@ -337,6 +337,16 @@ static ssize_t power1_is_battery_show(struct device *dev,
 {
        struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
        int val;
+       unsigned long long data;
+       acpi_status status;
+
+       status = acpi_evaluate_integer(resource->acpi_dev->handle, "_DBX",
+                                      NULL, &data);
+       if (ACPI_FAILURE(status)) {
+               acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_DBX",
+                                            status);
+       }
+       pr_info("DBX give %llu\n", data);
 
        if (resource->caps.flags & POWER_METER_IS_BATTERY)
                val = 1;
@@ -570,6 +580,8 @@ static umode_t acpi_power_is_visible(const void *data,
 {
        const struct acpi_power_meter_resource *resource = data;
 
+       pr_info("%s\n", __func__);
+
        switch (attr) {
        case hwmon_power_average_min:
        case hwmon_power_average_max:
@@ -741,7 +753,7 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 
                remove_domain_devices(resource);
                setup_attrs(resource);
-               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
+               res = hwmon_update_groups(resource->hwmon_dev);
                break;
        case METER_NOTIFY_TRIP:
On a microvm qemu with my ACPI power meter emulation:
/ # ls /sys/class/hwmon/hwmon0/
device		 power1_average		  power1_is_battery	subsystem
name		 power1_average_interval  power1_model_number	uevent
power		 power1_interval_max	  power1_oem_info
power1_accuracy  power1_interval_min	  power1_serial_number
/ # cat /sys/class/hwmon/hwmon0/
device/                  power1_average_interval  power1_oem_info
name                     power1_interval_max      power1_serial_number
power/                   power1_interval_min      subsystem/
power1_accuracy          power1_is_battery        uevent
power1_average           power1_model_number
/ # cat /sys/class/hwmon/hwmon0/power1_is_battery 
[   14.969697] power_meter ACPI000D:00: Found ACPI power meter.
[   14.970114] acpi_power_is_visible
[   14.970133] acpi_power_is_visible
[   14.970141] acpi_power_is_visible
[   14.970147] acpi_power_is_visible
[   14.970153] acpi_power_is_visible
[   14.970158] acpi_power_is_visible
[   14.970164] acpi_power_is_visible
[   14.970169] acpi_power_is_visible
[   14.970187] acpi_power_is_visible
[   14.970193] acpi_power_is_visible
[   14.970202] acpi_power_is_visible
[   14.970346] DBX give 40
[   14.975185] power_meter ACPI000D:00: Capping in progress.
0
cat: /sys/class/hwmon/hwmon0/power1_is_battery: No such device
/ # ls /sys/class/hwmon/hwmon0/
device			 power1_average_min   power1_is_battery
name			 power1_cap	      power1_model_number
power			 power1_cap_hyst      power1_oem_info
power1_accuracy		 power1_cap_max       power1_serial_number
power1_average		 power1_cap_min       subsystem
power1_average_interval  power1_interval_max  uevent
power1_average_max	 power1_interval_min

Thanks
