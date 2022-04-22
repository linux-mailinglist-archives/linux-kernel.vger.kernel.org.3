Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE250C072
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiDVTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiDVTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:32:09 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2F3203DEE;
        Fri, 22 Apr 2022 12:10:12 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5ca5c580fso9594097fac.3;
        Fri, 22 Apr 2022 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ZpPUttmc20QG0u/9OaOcqx66/SOjLOHHpGATXJAi5E=;
        b=P/GZW6RWKvQIEdTW74KnS4pN8dz9XrgYU4wGsqTbqjKJ1gDm8tiLuIQmwRqBDHq1qt
         dPPDq8vPU4nhBPyH59GSYzkniEyd+cZKGvdsNM2y7+acHqOAZ83l4YxJwGR6BczvilFX
         JNgx1asymvoZDNZ+K0EXgy2RzR/kE8F+hxb3wqbRJ2znvHFGeFYKsVRbmMl9nsmeTUxs
         whNafn19MbqU4Wr5U8m1KceQoKnTuR4ygdZZCLOvNTXVCSppajCNJNWDFaO0iI66YnzL
         343Irt2bWdX8UT3tGB7OAasS96CneQTyi9Wlp/UEQl5w9IW3jlqc0joOGXXm/HbyWeuO
         a8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/ZpPUttmc20QG0u/9OaOcqx66/SOjLOHHpGATXJAi5E=;
        b=M9DKm+xAhzc7XwaHfi63jP36+EOrnxdhYHD3DDknsnSYd0Ng8r96S6OlDYp0Y7evkz
         vmKxUH0Fp/emOAu/r/84P667RrvrVVUKEtP8kFQo8oFOuLeA1FNN1XS7jZkz3igE41vR
         XYToMdxd/RmqNobibbKvn9mVaQONPsjrsh34YNQDS/oEtM0ygClDRCFBd87tiKfvWsoR
         YKyk5XbsJj+tRB5XwodlprpAp5lc+X/b/5CIA/U9iqqripJEB8IAA2ivgV3KWOeh/rhp
         Qs6RZ/9j7WKLDe2m2PfCHQ4xm22du82umSu6o7DhyBgrFVOp6e6yXn9hcCfpKqXBf4RB
         Utaw==
X-Gm-Message-State: AOAM532r8v6agNZ07OKEUQbsNb1Dg1BLM2EwLGRhCtMBZPUrGhLf9MWp
        rZmllITeVBULaNaSCPKlW7YsMz1Kk2k=
X-Google-Smtp-Source: ABdhPJwwrT59Ouq94XcBA5qrbDMLYWridfEb3FHdAX9HknVegA9s3CQZ9YMVLyFA/NbVF+HxZKy1wQ==
X-Received: by 2002:aca:d1a:0:b0:322:35db:2c0 with SMTP id 26-20020aca0d1a000000b0032235db02c0mr3017629oin.82.1650652306864;
        Fri, 22 Apr 2022 11:31:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a05683004c200b0060558c5c2dbsm992578otd.7.2022.04.22.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:31:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 22 Apr 2022 11:31:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <20220422183144.GA2637654@roeck-us.net>
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421072743.5058-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:27:42AM +0200, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose hardware temperature sensors
> of the Aquacomputer Farbwerk RGB controller, which communicates through
> a proprietary USB HID protocol.
> 
> Four temperature sensors are available. Additionally, serial number and
> firmware version are exposed through debugfs.
> 
> Also, add Jack Doan to MAINTAINERS for this driver.
> 
> Signed-off-by: Jack Doan <me@jackdoan.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> If adding to MAINTAINERS requires a separate commit, I'll send it
> separately.
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
>  MAINTAINERS                                 |  1 +
>  drivers/hwmon/Kconfig                       |  5 +--
>  drivers/hwmon/aquacomputer_d5next.c         | 37 ++++++++++++++++++---
>  4 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index e69f718caf5b..717e28226cde 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -6,6 +6,7 @@ Kernel driver aquacomputer-d5next
>  Supported devices:
>  
>  * Aquacomputer D5 Next watercooling pump
> +* Aquacomputer Farbwerk RGB controller
>  * Aquacomputer Farbwerk 360 RGB controller
>  * Aquacomputer Octo fan controller
>  
> @@ -32,7 +33,7 @@ better suited for userspace tools.
>  The Octo exposes four temperature sensors and eight PWM controllable fans, along
>  with their speed (in RPM), power, voltage and current.
>  
> -The Farbwerk 360 exposes four temperature sensors. Depending on the device,
> +The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
>  not all sysfs and debugfs entries will be available.
>  
>  Usage notes
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea2cd656ee6c..d8e3ca0fbc3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1389,6 +1389,7 @@ F:	drivers/media/i2c/aptina-pll.*
>  
>  AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
>  M:	Aleksa Savic <savicaleksa83@gmail.com>
> +M:	Jack Doan <me@jackdoan.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/hwmon/aquacomputer_d5next.rst
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5beadd8a0932..01d10c9b633a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -256,12 +256,13 @@ config SENSORS_AHT10
>  	  will be called aht10.
>  
>  config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
> +	tristate "Aquacomputer D5 Next, Octo, Farbwerk, Farbwerk 360"
>  	depends on USB_HID
>  	help
>  	  If you say yes here you get support for sensors and fans of
>  	  the Aquacomputer D5 Next watercooling pump, Octo fan
> -	  controller and Farbwerk 360 RGB controller, where available.
> +	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
> +	  available.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a464473bc981..7d2e7279abfb 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,11 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
> + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values.
>   *
>   * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
> + * Copyright 2022 Jack Doan <me@jackdoan.com>
>   */
>  
>  #include <linux/crc16.h>
> @@ -19,14 +20,16 @@
>  #include <asm/unaligned.h>
>  
>  #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
> +#define USB_PRODUCT_ID_FARBWERK		0xf00a
>  #define USB_PRODUCT_ID_D5NEXT		0xf00e
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
>  #define USB_PRODUCT_ID_OCTO		0xf011
>  
> -enum kinds { d5next, farbwerk360, octo };
> +enum kinds { d5next, farbwerk, farbwerk360, octo };
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
> +	[farbwerk] = "farbwerk",
>  	[farbwerk360] = "farbwerk360",
>  	[octo] = "octo"
>  };
> @@ -69,6 +72,12 @@ static u8 secondary_ctrl_report[] = {
>  #define D5NEXT_PUMP_CURRENT		112
>  #define D5NEXT_FAN_CURRENT		99
>  
> +/* Register offsets for the Farbwerk RGB controller */
> +#define FARBWERK_NUM_SENSORS		4
> +#define FARBWERK_SENSOR_START		0x2f
> +#define FARBWERK_SENSOR_SIZE		0x02
> +#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
> +
>  /* Register offsets for the Farbwerk 360 RGB controller */
>  #define FARBWERK360_NUM_SENSORS		4
>  #define FARBWERK360_SENSOR_START	0x32
> @@ -125,7 +134,7 @@ static const char *const label_d5next_current[] = {
>  	"Fan current"
>  };
>  
> -/* Labels for Farbwerk 360 and Octo temperature sensors */
> +/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
>  static const char *const label_temp_sensors[] = {
>  	"Sensor 1",
>  	"Sensor 2",
> @@ -319,6 +328,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  			if (channel == 0)
>  				return 0444;
>  			break;
> +		case farbwerk:
>  		case farbwerk360:
>  		case octo:
>  			return 0444;
> @@ -551,8 +561,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
>  	.info = aqc_info,
>  };
>  
> -static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> -			 int size)
> +static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
>  {
>  	int i, sensor_value;
>  	struct aqc_data *priv;
> @@ -587,6 +596,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
>  		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
>  		break;
> +	case farbwerk:
> +		/* Temperature sensor readings */
> +		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
> +			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
> +							  i * FARBWERK_SENSOR_SIZE);
> +			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
> +				priv->temp_input[i] = -ENODATA;
> +			else
> +				priv->temp_input[i] = sensor_value * 10;
> +		}
> +		break;
>  	case farbwerk360:
>  		/* Temperature sensor readings */
>  		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
> @@ -733,6 +753,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->voltage_label = label_d5next_voltages;
>  		priv->current_label = label_d5next_current;
>  		break;
> +	case USB_PRODUCT_ID_FARBWERK:
> +		priv->kind = farbwerk;
> +


Any special reason for this empty line ? It seems kind of random.

Guenter

> +		priv->temp_label = label_temp_sensors;
> +		break;
>  	case USB_PRODUCT_ID_FARBWERK360:
>  		priv->kind = farbwerk360;
>  
> @@ -795,6 +820,7 @@ static void aqc_remove(struct hid_device *hdev)
>  
>  static const struct hid_device_id aqc_table[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>  	{ }
> @@ -826,4 +852,5 @@ module_exit(aqc_exit);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> +MODULE_AUTHOR("Jack Doan <me@jackdoan.com>");
>  MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
> -- 
> 2.35.1
> 
