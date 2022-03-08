Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82264D1F76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbiCHRyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiCHRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:54:03 -0500
X-Greylist: delayed 38783 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 09:53:05 PST
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.149.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD424085
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:53:04 -0800 (PST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 327611AFD4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:53:03 -0600 (CST)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id Re19nozyx22u3Re19naoBo; Tue, 08 Mar 2022 11:53:03 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ix/jkr3K7cxxpWdk41c8XSTlc95k2HiwB0Mzjg4Lwgg=; b=op5iSJ6H072CQ9i424nosmaBWK
        6CJEMr1J53wAcMxT0HtPTpykcHhNH+yIrpLw+9F/iCCQQ6REJS3SHfiKqnAPnogLFhv9GlcICRUE1
        GpFKb/+1qyxCdE6cJ48nW1iAZY0nETv6vnFXuXLd8x1Kz6EaqGCpVkCB+i600qf9r1cPRl8KIBG9K
        xqtERNZDWgAk+JjmWPPSO3YdAAhpDm13kMKbYilhxs9/CyjCOqMJbsGAD1gXKrzpItaLf1IWnfrMk
        cosas2mu6X+bI8YGfC7C+FAUuo9pgwNwHBZED957jTkPimcihmObYeMzspwStz75+jC9DnbpDdSqd
        IbQovOQg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38104)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nRe18-000NFW-KD; Tue, 08 Mar 2022 17:53:02 +0000
Message-ID: <f13f68eb-d208-9df2-80ea-6aedd686cbc1@roeck-us.net>
Date:   Tue, 8 Mar 2022 09:52:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308105225.24178-1-savicaleksa83@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer
 Octo
In-Reply-To: <20220308105225.24178-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nRe18-000NFW-KD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:38104
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 14
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 02:52, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose hardware temperature sensors
> and fans of the Aquacomputer Octo fan controller, which communicates
> through a proprietary USB HID protocol.
> 
> Four temperature sensors and eight PWM controllable fans are available.
> Additionally, serial number, firmware version and power-on count are
> exposed through debugfs.
> 
> This driver has been tested on x86_64.
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> Lindent works much better than VS Code, so there should be some
> formatting fixes. Also, update Kbuild to reflect new features of
> the driver.

If you _really_ think you need to improve formatting, do that in a
separate patch. FWIW, the formatting changes I noticed do not make
checkpatch more or less happy and are therefore just completely
unnecessary. Please refrain from doing that; I am quite overwhelmed
with reviews, and I really don't have time to review (and get
distracted by) unnecessary formatting changes.

I partially reviewed this patch, but I gave up after getting stuck
on the formatting. Please undo all formatting changes and resubmit.

> ---
>   Documentation/hwmon/aquacomputer_d5next.rst |   4 +
>   drivers/hwmon/Kconfig                       |   7 +-
>   drivers/hwmon/aquacomputer_d5next.c         | 402 +++++++++++++++++++-
>   3 files changed, 396 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 3373e27b707d..e69f718caf5b 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -7,6 +7,7 @@ Supported devices:
>   
>   * Aquacomputer D5 Next watercooling pump
>   * Aquacomputer Farbwerk 360 RGB controller
> +* Aquacomputer Octo fan controller
>   
>   Author: Aleksa Savic
>   
> @@ -28,6 +29,9 @@ seems to require sending it a complete configuration. That includes addressable
>   RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
>   better suited for userspace tools.
>   
> +The Octo exposes four temperature sensors and eight PWM controllable fans, along
> +with their speed (in RPM), power, voltage and current.
> +
>   The Farbwerk 360 exposes four temperature sensors. Depending on the device,
>   not all sysfs and debugfs entries will be available.
>   
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d3986310ec21..0b6a84af1353 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -256,11 +256,12 @@ config SENSORS_AHT10
>   	  will be called aht10.
>   
>   config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next watercooling pump"
> +	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
>   	depends on USB_HID
>   	help
> -	  If you say yes here you get support for the Aquacomputer D5 Next
> -	  watercooling pump sensors.
> +	  If you say yes here you get support for sensors and fans of
> +	  the Aquacomputer D5 Next watercooling pump, Octo fan
> +	  controller and Farbwerk 360 RGB controller, where available.
>   
>   	  This driver can also be built as a module. If so, the module
>   	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 525809cf7c95..f45f8afc2b15 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360)
> + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
>    *
>    * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>    * sensor values.
> @@ -8,23 +8,27 @@
>    * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
>    */
>   
> +#include <linux/crc16.h>
>   #include <linux/debugfs.h>
>   #include <linux/hid.h>
>   #include <linux/hwmon.h>
>   #include <linux/jiffies.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/seq_file.h>
>   #include <asm/unaligned.h>
>   
>   #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
>   #define USB_PRODUCT_ID_D5NEXT		0xf00e
>   #define USB_PRODUCT_ID_FARBWERK360	0xf010
> +#define USB_PRODUCT_ID_OCTO		0xf011
>   
> -enum kinds { d5next, farbwerk360 };
> +enum kinds { d5next, farbwerk360, octo };
>   
>   static const char *const aqc_device_names[] = {
>   	[d5next] = "d5next",
> -	[farbwerk360] = "farbwerk360"
> +	[farbwerk360] = "farbwerk360",
> +	[octo] = "octo"
>   };
>   
>   #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -35,6 +39,18 @@ static const char *const aqc_device_names[] = {
>   #define SERIAL_SECOND_PART		5
>   #define FIRMWARE_VERSION		13
>   
> +#define CTRL_REPORT_ID			0x03
> +
> +/* The HID report that the official software always sends
> + * after writing values, currently same for all devices
> + */
> +#define SECONDARY_CTRL_REPORT_ID	0x02
> +#define SECONDARY_CTRL_REPORT_SIZE	0x0B
> +
> +static u8 secondary_ctrl_report[] = {
> +	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
> +};
> +
>   /* Register offsets for the D5 Next pump */
>   #define D5NEXT_POWER_CYCLES		24
>   
> @@ -55,10 +71,34 @@ static const char *const aqc_device_names[] = {
>   
>   /* Register offsets for the Farbwerk 360 RGB controller */
>   #define FARBWERK360_NUM_SENSORS		4
> -#define FARBWERK360_SENSOR_START		0x32
> +#define FARBWERK360_SENSOR_START	0x32
>   #define FARBWERK360_SENSOR_SIZE		0x02
>   #define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
>   
> +/* Register offsets for the Octo fan controller */
> +#define OCTO_POWER_CYCLES		0x18
> +#define OCTO_NUM_FANS			8
> +#define OCTO_FAN_PERCENT_OFFSET		0x00
> +#define OCTO_FAN_VOLTAGE_OFFSET		0x02
> +#define OCTO_FAN_CURRENT_OFFSET		0x04
> +#define OCTO_FAN_POWER_OFFSET		0x06
> +#define OCTO_FAN_SPEED_OFFSET		0x08
> +
> +static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
> +
> +#define OCTO_NUM_SENSORS		4
> +#define OCTO_SENSOR_START		0x3D
> +#define OCTO_SENSOR_SIZE		0x02
> +#define OCTO_SENSOR_DISCONNECTED	0x7FFF
> +
> +#define OCTO_CTRL_REPORT_SIZE			0x65F
> +#define OCTO_CTRL_REPORT_CHECKSUM_OFFSET	0x65D
> +#define OCTO_CTRL_REPORT_CHECKSUM_START		0x01
> +#define OCTO_CTRL_REPORT_CHECKSUM_LENGTH	0x65C
> +
> +/* Fan speed registers in Octo control report (from 0-100%) */
> +static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0x259, 0x2AE };
> +
>   /* Labels for D5 Next */
>   #define L_D5NEXT_COOLANT_TEMP		"Coolant temp"
>   
> @@ -83,7 +123,7 @@ static const char *const label_d5next_current[] = {
>   	"Fan current"
>   };
>   
> -/* Labels for Farbwerk 360 temperature sensors */
> +/* Labels for Farbwerk 360 and Octo temperature sensors */
>   static const char *const label_temp_sensors[] = {
>   	"Sensor 1",
>   	"Sensor 2",
> @@ -91,30 +131,192 @@ static const char *const label_temp_sensors[] = {
>   	"Sensor 4"
>   };
>   
> +/* Labels for Octo */
> +static const char *const label_fan_speed[] = {
> +	"Fan 1 speed",
> +	"Fan 2 speed",
> +	"Fan 3 speed",
> +	"Fan 4 speed",
> +	"Fan 5 speed",
> +	"Fan 6 speed",
> +	"Fan 7 speed",
> +	"Fan 8 speed"
> +};
> +
> +static const char *const label_fan_power[] = {
> +	"Fan 1 power",
> +	"Fan 2 power",
> +	"Fan 3 power",
> +	"Fan 4 power",
> +	"Fan 5 power",
> +	"Fan 6 power",
> +	"Fan 7 power",
> +	"Fan 8 power"
> +};
> +
> +static const char *const label_fan_voltage[] = {
> +	"Fan 1 voltage",
> +	"Fan 2 voltage",
> +	"Fan 3 voltage",
> +	"Fan 4 voltage",
> +	"Fan 5 voltage",
> +	"Fan 6 voltage",
> +	"Fan 7 voltage",
> +	"Fan 8 voltage"
> +};
> +
> +static const char *const label_fan_current[] = {
> +	"Fan 1 current",
> +	"Fan 2 current",
> +	"Fan 3 current",
> +	"Fan 4 current",
> +	"Fan 5 current",
> +	"Fan 6 current",
> +	"Fan 7 current",
> +	"Fan 8 current"
> +};
> +
>   struct aqc_data {
>   	struct hid_device *hdev;
>   	struct device *hwmon_dev;
>   	struct dentry *debugfs;
> +	struct mutex mutex; /* Used for locking access when reading and writing PWM values */
>   	enum kinds kind;
>   	const char *name;
>   
> +	int buffer_size;
> +	u8 *buffer; /* Stores the control report */
> +	int checksum_start; /* Where the checksummed region starts */
> +	int checksum_length; /* And where it ends */
> +	int checksum_offset; /* Position of checksum, usually at the very end */
> +
>   	/* General info, same across all devices */
>   	u32 serial_number[2];
>   	u16 firmware_version;
>   
> -	/* D5 Next specific - how many times the device was powered on */
> +	/* How many times the device was powered on, if available */
>   	u32 power_cycles;
>   
>   	/* Sensor values */
>   	s32 temp_input[4];
> -	u16 speed_input[2];
> -	u32 power_input[2];
> -	u16 voltage_input[3];
> -	u16 current_input[2];
> +	u16 speed_input[8];
> +	u32 power_input[8];
> +	u16 voltage_input[8];
> +	u16 current_input[8];
>   
>   	unsigned long updated;
>   };
>   
> +static int aqc_be_percent_to_pwm(u16 val)
> +{
> +	return DIV_ROUND_CLOSEST(ntohs(val) * 255, 100 * 100);
> +}
> +
> +static u16 aqc_pwm_to_percent(u8 val)
> +{
> +	return DIV_ROUND_CLOSEST(val * 100 * 100, 255);
> +}
> +
> +/* Expects the mutex to be locked */
> +static int aqc_get_ctrl_data(struct aqc_data *priv)
> +{
> +	int ret;
> +
> +	memset(priv->buffer, 0x00, priv->buffer_size);
> +	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer,
> +				 priv->buffer_size, HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret < 0)
> +		ret = -ENODATA;
> +
> +	return ret;
> +}
> +
> +/* Expects the mutex to be locked */
> +static int aqc_send_ctrl_data(struct aqc_data *priv)
> +{
> +	int ret;
> +	u16 checksum = 0xffff;	/* Init value for CRC-16/USB */
> +
> +	checksum = crc16(checksum, priv->buffer + priv->checksum_start, priv->checksum_length);
> +	checksum ^= 0xffff;	/* Xorout value for CRC-16/USB */

Why not just the following ?

	u16 checksum;

	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);


> +
> +	/* Place the new checksum at the end of the report */
> +	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
> +
> +	/* Send the patched up report back to the device - all other settings stay the same */
> +	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		goto exit;
> +
> +	/* The official software sends this report after every change, so do it here as well */
> +	ret =
> +	    hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
> +			       SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
> +			       HID_REQ_SET_REPORT);
> +exit:
> +	return ret;
> +}
> +
> +/* Refreshes the control buffer and returns value at offset in big endian */
> +static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, void *val, size_t size)
> +{
> +	int ret;
> +
> +	mutex_lock(&priv->mutex);
> +
> +	if (size < 1 || size > 4) {

A runtime size check for a parameter of a static function, where the parameter
is always a constant ? And, on top of that, check it inside a mutex ?
That is completely unacceptable. Why pass the size anyway ? It is always 2.

> +		ret = -EINVAL;
> +		goto unlock_and_return;
> +	}
> +
> +	ret = aqc_get_ctrl_data(priv);
> +	if (ret < 0)
> +		goto unlock_and_return;
> +
> +	memcpy(val, priv->buffer + offset, size);
> +
> +unlock_and_return:
> +	mutex_unlock(&priv->mutex);
> +	return ret;
> +}
> +
> +static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, size_t size)
> +{
> +	int ret;
> +
> +	mutex_lock(&priv->mutex);
> +
> +	if (size < 1 || size > 4) {
> +		ret = -EINVAL;
> +		goto unlock_and_return;
> +	}
> +
> +	ret = aqc_get_ctrl_data(priv);
> +	if (ret < 0)
> +		goto unlock_and_return;
> +
> +	switch (size) {
> +	case 4:
> +		put_unaligned_be32(val, priv->buffer + offset);
> +		break;
> +	case 2:
> +		put_unaligned_be16((u16)val, priv->buffer + offset);
> +		break;
> +	case 1:
> +		priv->buffer[offset] = val;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = aqc_send_ctrl_data(priv);
> +
> +unlock_and_return:
> +	mutex_unlock(&priv->mutex);
> +	return ret;
> +}
> +
>   static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>   			      int channel)
>   {
> @@ -128,17 +330,47 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   				return 0444;
>   			break;
>   		case farbwerk360:
> +		case octo:
>   			return 0444;
>   		default:
>   			break;
>   		}
>   		break;
> +	case hwmon_pwm:
> +		switch (priv->kind) {
> +		case octo:
> +			switch (attr) {
> +			case hwmon_pwm_input:
> +				return 0644;
> +			default:
> +				break;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>   	case hwmon_fan:
>   	case hwmon_power:
> -	case hwmon_in:
>   	case hwmon_curr:
>   		switch (priv->kind) {
>   		case d5next:
> +			if (channel < 2)
> +				return 0444;
> +			break;
> +		case octo:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (priv->kind) {
> +		case d5next:
> +			if (channel < 3)
> +				return 0444;
> +			break;
> +		case octo:
>   			return 0444;
>   		default:
>   			break;
> @@ -154,6 +386,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   		    int channel, long *val)
>   {
> +	int ret;
>   	struct aqc_data *priv = dev_get_drvdata(dev);
>   
>   	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL))
> @@ -172,6 +405,19 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>   	case hwmon_power:
>   		*val = priv->power_input[channel];
>   		break;
> +	case hwmon_pwm:
> +		switch (priv->kind) {
> +		case octo:
> +			ret = aqc_get_ctrl_val(priv, octo_ctrl_fan_offsets[channel], val, 2);

'val' is a pointer to long, aqc_get_ctrl_val() writes a two-byte u16 in big endian form into it,

> +			if (ret < 0)
> +				return ret;
> +
> +			*val = aqc_be_percent_to_pwm(*val);

... and then aqc_be_percent_to_pwm converts the result to an int, converting it from
two-byte network byte order to int. Uuh... no. That just happens to work on a little
endian system, but that is just accidentally so. Convert in aqc_get_ctrl_val(), and
don't use the pointer to the return data (which is a pointer to a long) as interim
storage. Since the returned value is an unsigned short, and always so, you might as
well use the function return value for both the returned value and the error
instead of returning a value in a pointer.

> +			break;
> +		default:
> +			break;
> +		}
> +		break;
>   	case hwmon_in:
>   		*val = priv->voltage_input[channel];
>   		break;
> @@ -197,6 +443,7 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   			*str = L_D5NEXT_COOLANT_TEMP;
>   			break;
>   		case farbwerk360:
> +		case octo:
>   			*str = label_temp_sensors[channel];
>   			break;
>   		default:
> @@ -208,6 +455,9 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   		case d5next:
>   			*str = label_d5next_speeds[channel];
>   			break;
> +		case octo:
> +			*str = label_fan_speed[channel];
> +			break;

It might be time to store the pointers to the labels in priv.

>   		default:
>   			break;
>   		}
> @@ -217,6 +467,9 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   		case d5next:
>   			*str = label_d5next_power[channel];
>   			break;
> +		case octo:
> +			*str = label_fan_power[channel];
> +			break;
>   		default:
>   			break;
>   		}
> @@ -226,6 +479,9 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   		case d5next:
>   			*str = label_d5next_voltages[channel];
>   			break;
> +		case octo:
> +			*str = label_fan_voltage[channel];
> +			break;
>   		default:
>   			break;
>   		}
> @@ -235,6 +491,41 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
>   		case d5next:
>   			*str = label_d5next_current[channel];
>   			break;
> +		case octo:
> +			*str = label_fan_current[channel];
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +		     int channel, long val)
> +{
> +	int ret;
> +	struct aqc_data *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			switch (priv->kind) {
> +			case octo:
> +				ret =
> +				    aqc_set_ctrl_val(priv, octo_ctrl_fan_offsets[channel],

Drop that first continuation line; we can go up to 100 columns now.

Also, the parameter to aqc_pwm_to_percent() needs to be range checked
to avoid overflows.

> +						     aqc_pwm_to_percent(val), 2);
> +				if (ret < 0)
> +					return ret;
> +				break;
> +			default:
> +				break;
> +			}
>   		default:
>   			break;
>   		}
> @@ -250,6 +541,7 @@ static const struct hwmon_ops aqc_hwmon_ops = {
>   	.is_visible = aqc_is_visible,
>   	.read = aqc_read,
>   	.read_string = aqc_read_string,
> +	.write = aqc_write
>   };
>   
>   static const struct hwmon_channel_info *aqc_info[] = {
> @@ -259,16 +551,48 @@ static const struct hwmon_channel_info *aqc_info[] = {
>   			   HWMON_T_INPUT | HWMON_T_LABEL,
>   			   HWMON_T_INPUT | HWMON_T_LABEL),
>   	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL,
>   			   HWMON_F_INPUT | HWMON_F_LABEL),
>   	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
>   			   HWMON_P_INPUT | HWMON_P_LABEL,
>   			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT),
>   	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>   			   HWMON_I_INPUT | HWMON_I_LABEL,
>   			   HWMON_I_INPUT | HWMON_I_LABEL,
>   			   HWMON_I_INPUT | HWMON_I_LABEL),
>   	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>   			   HWMON_C_INPUT | HWMON_C_LABEL,
>   			   HWMON_C_INPUT | HWMON_C_LABEL),
>   	NULL
> @@ -326,6 +650,35 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>   				priv->temp_input[i] = sensor_value * 10;
>   		}
>   		break;
> +	case octo:
> +		priv->power_cycles = get_unaligned_be32(data + OCTO_POWER_CYCLES);
> +
> +		/* Fan speed and related readings */
> +		for (i = 0; i < OCTO_NUM_FANS; i++) {
> +			priv->speed_input[i] =
> +			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
> +					       OCTO_FAN_SPEED_OFFSET);
> +			priv->power_input[i] =
> +			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
> +					       OCTO_FAN_POWER_OFFSET) * 10000;
> +			priv->voltage_input[i] =
> +			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
> +					       OCTO_FAN_VOLTAGE_OFFSET) * 10;
> +			priv->current_input[i] =
> +			    get_unaligned_be16(data + octo_sensor_fan_offsets[i] +
> +					       OCTO_FAN_CURRENT_OFFSET);
> +		}
> +
> +		/* Temperature sensor readings */
> +		for (i = 0; i < OCTO_NUM_SENSORS; i++) {
> +			sensor_value = get_unaligned_be16(data + OCTO_SENSOR_START +
> +							  i * OCTO_SENSOR_SIZE);
> +			if (sensor_value == OCTO_SENSOR_DISCONNECTED)
> +				priv->temp_input[i] = -ENODATA;
> +			else
> +				priv->temp_input[i] = sensor_value * 10;
> +		}
> +		break;
>   	default:
>   		break;
>   	}
> @@ -376,10 +729,17 @@ static void aqc_debugfs_init(struct aqc_data *priv)
>   
>   	priv->debugfs = debugfs_create_dir(name, NULL);
>   	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
> -	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
> +	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv,
> +			    &firmware_version_fops);

Sigh :-(. Please refrain from such cosmetic changes. You are just making my life harder.

>   
> -	if (priv->kind == d5next)
> -		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
> +	switch (priv->kind) {
> +	case d5next:
> +	case octo:
> +		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv,
> +				    &power_cycles_fops);
> +	default:
> +		break;
> +	}
>   }
>   
>   #else
> @@ -423,12 +783,25 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	case USB_PRODUCT_ID_FARBWERK360:
>   		priv->kind = farbwerk360;
>   		break;
> +	case USB_PRODUCT_ID_OCTO:
> +		priv->kind = octo;
> +		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
> +		priv->checksum_start = OCTO_CTRL_REPORT_CHECKSUM_START;
> +		priv->checksum_length = OCTO_CTRL_REPORT_CHECKSUM_LENGTH;
> +		priv->checksum_offset = OCTO_CTRL_REPORT_CHECKSUM_OFFSET;
> +		break;
>   	default:
>   		break;
>   	}
>   
>   	priv->name = aqc_device_names[priv->kind];
>   
> +	priv->buffer = devm_kzalloc(&hdev->dev, priv->buffer_size, GFP_KERNEL);
> +	if (!priv->buffer)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->mutex);
> +
>   	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, priv->name, priv,
>   							  &aqc_chip_info, NULL);
>   
> @@ -462,6 +835,7 @@ static void aqc_remove(struct hid_device *hdev)
>   static const struct hid_device_id aqc_table[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>   	{ }
>   };
>   

