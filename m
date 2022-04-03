Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF964F0CA6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376505AbiDCVnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 17:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDCVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 17:43:40 -0400
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.46.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99133370
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:41:44 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7E1EF400C77D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:41:44 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id b7yinIkq3dx86b7yinm96K; Sun, 03 Apr 2022 16:41:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cgUDi4lsP3k/s/nNK1ITpQoP3n/z3XxmUfhvd+epdT8=; b=Ph6UD+UKkKug8ArLPUFMMWxppt
        mjyi8NVJjxoyoSIUXhNGGax2773brZPcx2mP6ZCSqItTDEHw+aT05HdhKqXr3/Ppehzylq4yipXxe
        DUWrdQphp49zFnN+iUG3/FAtxATJ3eGxBOblq2ueRE8COCcyp8FU9l+Ub+8OmBdtOftOTPsBjJbq/
        5Nwyi2vDpLWFjZbxbPbzaJDhm195X0oZCJF0jGrrIFvhTRFqaCn8Z0t9tHa0JsBmTAAeURq3zx7W0
        JnbtpytO/0bHmySjTaKSHGwzpfMn5UkOWU7PFHIDMoJf+JjOPR6s1L7QrtG4nKpTKMCiU1HZH2ntY
        RqYQNCXw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57830 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nb7yi-003CoT-06; Sun, 03 Apr 2022 21:41:44 +0000
Date:   Sun, 3 Apr 2022 14:41:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Octo
Message-ID: <20220403214142.GA2965233@roeck-us.net>
References: <20220327070446.8151-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327070446.8151-1-savicaleksa83@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nb7yi-003CoT-06
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57830
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 17
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 09:04:46AM +0200, Aleksa Savic wrote:
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
> Changes in v3:
> - Added break; statements where needed
> - aqc_set_ctrl_val() now only sets values with a length of 2
> - Replace goto with return in aqc_send_ctrl_data()
> 
> Changes in v2:
> - Fixed formatting
> - HID report values from device are now being converted sooner
> - aqc_pwm_to_percent() is now range checked
> - Put pointers to labels in aqc_data
> - Simplified checksum calculation call
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |   4 +
>  drivers/hwmon/Kconfig                       |   7 +-
>  drivers/hwmon/aquacomputer_d5next.c         | 431 +++++++++++++++++---
>  3 files changed, 390 insertions(+), 52 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 3373e27b707d..e69f718caf5b 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -7,6 +7,7 @@ Supported devices:
>  
>  * Aquacomputer D5 Next watercooling pump
>  * Aquacomputer Farbwerk 360 RGB controller
> +* Aquacomputer Octo fan controller
>  
>  Author: Aleksa Savic
>  
> @@ -28,6 +29,9 @@ seems to require sending it a complete configuration. That includes addressable
>  RGB LEDs, for which there is no standard sysfs interface. Thus, that task is
>  better suited for userspace tools.
>  
> +The Octo exposes four temperature sensors and eight PWM controllable fans, along
> +with their speed (in RPM), power, voltage and current.
> +
>  The Farbwerk 360 exposes four temperature sensors. Depending on the device,
>  not all sysfs and debugfs entries will be available.
>  
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index db8bc55e5f50..5beadd8a0932 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -256,11 +256,12 @@ config SENSORS_AHT10
>  	  will be called aht10.
>  
>  config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next watercooling pump"
> +	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
>  	depends on USB_HID
>  	help
> -	  If you say yes here you get support for the Aquacomputer D5 Next
> -	  watercooling pump sensors.
> +	  If you say yes here you get support for sensors and fans of
> +	  the Aquacomputer D5 Next watercooling pump, Octo fan
> +	  controller and Farbwerk 360 RGB controller, where available.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 525809cf7c95..cd008bfa03be 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360)
> + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values.
> @@ -8,23 +8,27 @@
>   * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
>   */
>  
> +#include <linux/crc16.h>
>  #include <linux/debugfs.h>
>  #include <linux/hid.h>
>  #include <linux/hwmon.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/seq_file.h>
>  #include <asm/unaligned.h>
>  
>  #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
>  #define USB_PRODUCT_ID_D5NEXT		0xf00e
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
> +#define USB_PRODUCT_ID_OCTO		0xf011
>  
> -enum kinds { d5next, farbwerk360 };
> +enum kinds { d5next, farbwerk360, octo };
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
> -	[farbwerk360] = "farbwerk360"
> +	[farbwerk360] = "farbwerk360",
> +	[octo] = "octo"
>  };
>  
>  #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -35,6 +39,18 @@ static const char *const aqc_device_names[] = {
>  #define SERIAL_SECOND_PART		5
>  #define FIRMWARE_VERSION		13
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
>  /* Register offsets for the D5 Next pump */
>  #define D5NEXT_POWER_CYCLES		24
>  
> @@ -55,12 +71,38 @@ static const char *const aqc_device_names[] = {
>  
>  /* Register offsets for the Farbwerk 360 RGB controller */
>  #define FARBWERK360_NUM_SENSORS		4
> -#define FARBWERK360_SENSOR_START		0x32
> +#define FARBWERK360_SENSOR_START	0x32
>  #define FARBWERK360_SENSOR_SIZE		0x02
>  #define FARBWERK360_SENSOR_DISCONNECTED	0x7FFF
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
>  /* Labels for D5 Next */
> -#define L_D5NEXT_COOLANT_TEMP		"Coolant temp"
> +static const char *const label_d5next_temp[] = {
> +	"Coolant temp"
> +};
>  
>  static const char *const label_d5next_speeds[] = {
>  	"Pump speed",
> @@ -83,7 +125,7 @@ static const char *const label_d5next_current[] = {
>  	"Fan current"
>  };
>  
> -/* Labels for Farbwerk 360 temperature sensors */
> +/* Labels for Farbwerk 360 and Octo temperature sensors */
>  static const char *const label_temp_sensors[] = {
>  	"Sensor 1",
>  	"Sensor 2",
> @@ -91,32 +133,180 @@ static const char *const label_temp_sensors[] = {
>  	"Sensor 4"
>  };
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
>  struct aqc_data {
>  	struct hid_device *hdev;
>  	struct device *hwmon_dev;
>  	struct dentry *debugfs;
> +	struct mutex mutex;	/* Used for locking access when reading and writing PWM values */
>  	enum kinds kind;
>  	const char *name;
>  
> +	int buffer_size;
> +	u8 *buffer;
> +	int checksum_start;
> +	int checksum_length;
> +	int checksum_offset;
> +
>  	/* General info, same across all devices */
>  	u32 serial_number[2];
>  	u16 firmware_version;
>  
> -	/* D5 Next specific - how many times the device was powered on */
> +	/* How many times the device was powered on */
>  	u32 power_cycles;
>  
>  	/* Sensor values */
>  	s32 temp_input[4];
> -	u16 speed_input[2];
> -	u32 power_input[2];
> -	u16 voltage_input[3];
> -	u16 current_input[2];
> +	u16 speed_input[8];
> +	u32 power_input[8];
> +	u16 voltage_input[8];
> +	u16 current_input[8];
> +
> +	/* Label values */
> +	const char *const *temp_label;
> +	const char *const *speed_label;
> +	const char *const *power_label;
> +	const char *const *voltage_label;
> +	const char *const *current_label;
>  
>  	unsigned long updated;
>  };
>  
> -static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> -			      int channel)
> +static int aqc_percent_to_pwm(u16 val)

I am sure I asked this before. The calculation looks like a conversion
from centi-percent to pwm, not from percent to pwm. Please either reflect
that in the function name or add a comment.

Thanks,
Guenter
