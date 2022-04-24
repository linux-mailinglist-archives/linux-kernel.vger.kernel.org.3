Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E896E50CFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiDXFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDXFEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:04:52 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561322DA86;
        Sat, 23 Apr 2022 22:01:53 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 1-20020a4a0901000000b003296ea2104eso2197068ooa.13;
        Sat, 23 Apr 2022 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=aagCpZRQjALS74/VgsAt9RcVvW7HMgbl3yQXdfUVwBw=;
        b=bq7lPhRgoxlF07MggKywvD4rzsrg/6cDWK542Q8y3688SkYvW0VvNPDFO8cy4fGryT
         V+k//gaLBlxjhtlNp5vjYltUGYf/8chUoQeT2D/UVGI93mUc89PSoxPa2eAejCnWgDEt
         RGZLInBFVg4zqW4o+Ca1O6Qq3/6mPO6H9Q9T67dPpw+30ywTXmahGFIAVzFCDhHQA2Zv
         BKCUslb6d3WWIbyhiUXf8JiFY6ohl5n6NLbfW60koihXeQeIZ+TEuwK4uwAeTAwwZkfb
         Xfqv74AibTBqTSIQ2oKsn3h1MMG3ezI7HsCIJcyKyJ3NAow3fQVC+X+93lHkjYbp5D6F
         fF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=aagCpZRQjALS74/VgsAt9RcVvW7HMgbl3yQXdfUVwBw=;
        b=g+ItzTNZggaxvQNsEFD/IrGfRluhDDt5A4KIrETFM5I5mvBFC0EH3OafFJnt/SAwn2
         GU44IVec+Ce6bb5hys4+1EPIlseL2a2xyKDkXNTxZ4tmsv1al+oc+OY3pNPmuLkHuh+s
         JwJFrfoqp2kINHfjtV/n9NIrHLyOWDLjtKuvBFc1vghC0nMVZVD29bBR9gbaoz8vHK4E
         mHltPr5gsP6nXZCT6MumCzccV0D3KCIhAar5KC5V3Qp9Tkw3pXhjycYkDoZCNC8P4j7q
         5xIWcmJb84y1dtN9vbPMQAo0FQW44exUBPKEFbsV0Odz1q5TxSoVychReHDBMMIWlTSI
         2HMQ==
X-Gm-Message-State: AOAM530QZkPDxQw/sWeIGIg2PM3BubaXLKii4uLKI2+98gEo8lf6o1Yg
        CbxlRxEaLnvX3sTzrqVMCKoZSibZFGo=
X-Google-Smtp-Source: ABdhPJyj8PBp2Q2UjZ2H+Ik82mEHpuaULVTp4cn4oJ7FhE4FLd3liuV62NkCaV3jgSIaI09OW+f4jg==
X-Received: by 2002:a4a:df46:0:b0:33a:c5a:6d98 with SMTP id j6-20020a4adf46000000b0033a0c5a6d98mr4252486oou.5.1650776512639;
        Sat, 23 Apr 2022 22:01:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17-20020a544611000000b00325001eeb80sm1462518oip.27.2022.04.23.22.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 22:01:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56624756-a3e1-eca5-3bd9-4decd7d6e3d0@roeck-us.net>
Date:   Sat, 23 Apr 2022 22:01:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Jack Doan <me@jackdoan.com>, Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
 <20220424014206.GA3989097@roeck-us.net>
 <0bf6576c-c129-f8fb-19c3-e3fca797cfee@jackdoan.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer
 Farbwerk
In-Reply-To: <0bf6576c-c129-f8fb-19c3-e3fca797cfee@jackdoan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 20:47, Jack Doan wrote:
> On 4/23/22 20:42, Guenter Roeck wrote:
> 
>> On Thu, Apr 21, 2022 at 09:27:42AM +0200, Aleksa Savic wrote:
>>> Extend aquacomputer_d5next driver to expose hardware temperature sensors
>>> of the Aquacomputer Farbwerk RGB controller, which communicates through
>>> a proprietary USB HID protocol.
>>>
>>> Four temperature sensors are available. Additionally, serial number and
>>> firmware version are exposed through debugfs.
>>>
>>> Also, add Jack Doan to MAINTAINERS for this driver.
>>>
>>> Signed-off-by: Jack Doan<me@jackdoan.com>
>>> Signed-off-by: Aleksa Savic<savicaleksa83@gmail.com>
>>> ---
>> This patch doesn't apply. Please rebase to master and resend.
> Will do!
>> More comments inline.
>>
>>> If adding to MAINTAINERS requires a separate commit, I'll send it
>>> separately.
>>> ---
>>>   Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>>>   MAINTAINERS                                 |  1 +
>>>   drivers/hwmon/Kconfig                       |  5 +--
>>>   drivers/hwmon/aquacomputer_d5next.c         | 37 ++++++++++++++++++---
>>>   4 files changed, 38 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
>>> index e69f718caf5b..717e28226cde 100644
>>> --- a/Documentation/hwmon/aquacomputer_d5next.rst
>>> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
>>> @@ -6,6 +6,7 @@ Kernel driver aquacomputer-d5next
>>>   Supported devices:
>>>   
>>>   * Aquacomputer D5 Next watercooling pump
>>> +* Aquacomputer Farbwerk RGB controller
>>>   * Aquacomputer Farbwerk 360 RGB controller
>>>   * Aquacomputer Octo fan controller
>>>   
>>> @@ -32,7 +33,7 @@ better suited for userspace tools.
>>>   The Octo exposes four temperature sensors and eight PWM controllable fans, along
>>>   with their speed (in RPM), power, voltage and current.
>>>   
>>> -The Farbwerk 360 exposes four temperature sensors. Depending on the device,
>>> +The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
>>>   not all sysfs and debugfs entries will be available.
>>>   
>>>   Usage notes
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ea2cd656ee6c..d8e3ca0fbc3a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1389,6 +1389,7 @@ F:	drivers/media/i2c/aptina-pll.*
>>>   
>>>   AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
>>>   M:	Aleksa Savic<savicaleksa83@gmail.com>
>>> +M:	Jack Doan<me@jackdoan.com>
>>>   L:	linux-hwmon@vger.kernel.org
>>>   S:	Maintained
>>>   F:	Documentation/hwmon/aquacomputer_d5next.rst
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 5beadd8a0932..01d10c9b633a 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -256,12 +256,13 @@ config SENSORS_AHT10
>>>   	  will be called aht10.
>>>   
>>>   config SENSORS_AQUACOMPUTER_D5NEXT
>>> -	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
>>> +	tristate "Aquacomputer D5 Next, Octo, Farbwerk, Farbwerk 360"
>>>   	depends on USB_HID
>>>   	help
>>>   	  If you say yes here you get support for sensors and fans of
>>>   	  the Aquacomputer D5 Next watercooling pump, Octo fan
>>> -	  controller and Farbwerk 360 RGB controller, where available.
>>> +	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
>>> +	  available.
>>>   
>>>   	  This driver can also be built as a module. If so, the module
>>>   	  will be called aquacomputer_d5next.
>>> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
>>> index a464473bc981..7d2e7279abfb 100644
>>> --- a/drivers/hwmon/aquacomputer_d5next.c
>>> +++ b/drivers/hwmon/aquacomputer_d5next.c
>>> @@ -1,11 +1,12 @@
>>>   // SPDX-License-Identifier: GPL-2.0+
>>>   /*
>>> - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
>>> + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
>>>    *
>>>    * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>>>    * sensor values.
>>>    *
>>>    * Copyright 2021 Aleksa Savic<savicaleksa83@gmail.com>
>>> + * Copyright 2022 Jack Doan<me@jackdoan.com>
>> That is a bit aggressive for a few lines of code.
> Addressed below.
>>>    */
>>>   
>>>   #include <linux/crc16.h>
>>> @@ -19,14 +20,16 @@
>>>   #include <asm/unaligned.h>
>>>   
>>>   #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
>>> +#define USB_PRODUCT_ID_FARBWERK		0xf00a
>>>   #define USB_PRODUCT_ID_D5NEXT		0xf00e
>>>   #define USB_PRODUCT_ID_FARBWERK360	0xf010
>>>   #define USB_PRODUCT_ID_OCTO		0xf011
>>>   
>>> -enum kinds { d5next, farbwerk360, octo };
>>> +enum kinds { d5next, farbwerk, farbwerk360, octo };
>>>   
>>>   static const char *const aqc_device_names[] = {
>>>   	[d5next] = "d5next",
>>> +	[farbwerk] = "farbwerk",
>>>   	[farbwerk360] = "farbwerk360",
>>>   	[octo] = "octo"
>>>   };
>>> @@ -69,6 +72,12 @@ static u8 secondary_ctrl_report[] = {
>>>   #define D5NEXT_PUMP_CURRENT		112
>>>   #define D5NEXT_FAN_CURRENT		99
>>>   
>>> +/* Register offsets for the Farbwerk RGB controller */
>>> +#define FARBWERK_NUM_SENSORS		4
>>> +#define FARBWERK_SENSOR_START		0x2f
>>> +#define FARBWERK_SENSOR_SIZE		0x02
>>> +#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
>>> +
>>>   /* Register offsets for the Farbwerk 360 RGB controller */
>>>   #define FARBWERK360_NUM_SENSORS		4
>>>   #define FARBWERK360_SENSOR_START	0x32
>>> @@ -125,7 +134,7 @@ static const char *const label_d5next_current[] = {
>>>   	"Fan current"
>>>   };
>>>   
>>> -/* Labels for Farbwerk 360 and Octo temperature sensors */
>>> +/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
>>>   static const char *const label_temp_sensors[] = {
>>>   	"Sensor 1",
>>>   	"Sensor 2",
>>> @@ -319,6 +328,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>>>   			if (channel == 0)
>>>   				return 0444;
>>>   			break;
>>> +		case farbwerk:
>>>   		case farbwerk360:
>>>   		case octo:
>>>   			return 0444;
>>> @@ -551,8 +561,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
>>>   	.info = aqc_info,
>>>   };
>>>   
>>> -static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
>>> -			 int size)
>>> +static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
>>>   {
>>>   	int i, sensor_value;
>>>   	struct aqc_data *priv;
>>> @@ -587,6 +596,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>>>   		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
>>>   		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
>>>   		break;
>>> +	case farbwerk:
>>> +		/* Temperature sensor readings */
>>> +		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
>>> +			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
>>> +							  i * FARBWERK_SENSOR_SIZE);
>>> +			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
>>> +				priv->temp_input[i] = -ENODATA;
>> Can the sensor be connected dynamically ? If not, this should be handled
>> in an is_visible function.
> It's a somewhat unlikely use-case, but yes, they can be. The sensors are NTC thermistors that connect to pin-headers. Do we have a better way of representing "open circuit" than -ENODATA?

Seems to be a bit theoretic to assume that someone would play with
connecting and disconnecting cables while the system is running.
Have you tried to do that ? It would be interesting to know if
the controller handles that situation. But don't blame me
if you fry your system :-)

Anyway, there could be a tempX_fault attribute which would return 1
in that case. Not sure if that makes more sense, though.

>>> +			else
>>> +				priv->temp_input[i] = sensor_value * 10;
>>> +		}
>>> +		break;
>>>   	case farbwerk360:
>>>   		/* Temperature sensor readings */
>>>   		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
>>> @@ -733,6 +753,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>   		priv->voltage_label = label_d5next_voltages;
>>>   		priv->current_label = label_d5next_current;
>>>   		break;
>>> +	case USB_PRODUCT_ID_FARBWERK:
>>> +		priv->kind = farbwerk;
>>> +
>>> +		priv->temp_label = label_temp_sensors;
>>> +		break;
>>>   	case USB_PRODUCT_ID_FARBWERK360:
>>>   		priv->kind = farbwerk360;
>>>   
>>> @@ -795,6 +820,7 @@ static void aqc_remove(struct hid_device *hdev)
>>>   
>>>   static const struct hid_device_id aqc_table[] = {
>>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
>>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
>>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
>>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>>>   	{ }
>>> @@ -826,4 +852,5 @@ module_exit(aqc_exit);
>>>   
>>>   MODULE_LICENSE("GPL");
>>>   MODULE_AUTHOR("Aleksa Savic<savicaleksa83@gmail.com>");
>>> +MODULE_AUTHOR("Jack Doan<me@jackdoan.com>");
>> .... as is claiming authorship. I'd be the "author" of hundreds of kernel
>> files if I would do that. Aleksa signed off on it, so I'll accept it,
>> but I don't think it is appropriate.
> In the context of just this patch, yes, I agree. But, I felt it was warranted based on my previous contributions. I did a good bit of the reverse-engineering that made writing settings to these devices possible, and a lot of the previously submitted code for writing the setting changes is mine as well.
> 
> I didn't mean to make an inappropriate request though! If you'd like, I can submit a version of the patch without these lines.

No, I think that makes sense as long as Aleksa is ok with it.

Guenter

>>>   MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");

