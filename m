Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763865B263B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiIHSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIHSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:50:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3EFDBAA;
        Thu,  8 Sep 2022 11:50:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c24so17573562pgg.11;
        Thu, 08 Sep 2022 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Xon69veVFtPtTNhVyrOW/sb7ejnwEinq3kbT/mnBuNw=;
        b=kSV7ybkNXltcdl2PphJU4wafGX2Pf/oJpp7+gDhJ3ygzuFm5Ox23tVu+/DMcbq2nYf
         i4MxEuHSPd1K23Vb7BppLS0q9KT2TPm1Pnp53SfGEDyoIz7mbQLuGH1OyTqFr9hg/VT6
         QJneOxCsC/1gajIpbMjXdKvZQvg6vMLxTc7cnOepcfZb4QD9VxDjAnstSBISpxzBS3BD
         9FPe6NflCN6zVvEmBjKj6E69URESmH/i347qYsweTxkwNUe4ZFdJcqgUkNcY0+ppeHL9
         omljo7O3rQYFfOz2LIG49rPCQGsGDCeYPP6plaw6o4psuN83fIgEJgI2/RMjV1Qp6UAO
         Jl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Xon69veVFtPtTNhVyrOW/sb7ejnwEinq3kbT/mnBuNw=;
        b=67PwG54VO+MMqyllclRwXnp5BRht25JV7WHGbSn1o3bvXzr74I81h/uIR3jjevPg5v
         pvG0liX5NNmKlT5uVW3zpx8TPHyMCHxpjX11bi1dO1C0Z51RZ+hYsVVUwmJ6jGlnGzRd
         XgDVZjpKJb8ejKiPHytPPwsAjRYu7MlDZHZQ5cu6mcMUU2uRaq8nfJJ3KmQW5Y7Ds2aK
         0W/Ljaw7UbSDF6rxTUHKDKW1VLBTwcSTCQbYX13VuQtwTFPG3XgMRmhf3BSgbhEGby5a
         69i6canwcBG4ZURVnkurTVwnNbjhRxx9v8braNUn/7fs6+xDXbXSzUkd/xpc32kHwuvd
         jHOw==
X-Gm-Message-State: ACgBeo30O7XMs9fQNgfwXkb0XJFmfyQKrCM7ZeCg3qKLXRNYrbl7ob9c
        5dItoPpg7aCioQFr+y/b8/U=
X-Google-Smtp-Source: AA6agR6+PNI0swLH2s6eDo5p1pR8pp3YOFBZoSfQ/Y9cUuuiE3p5I3hKRrBNr3tei1dVQepKoNtEpA==
X-Received: by 2002:a63:5209:0:b0:434:9e1a:bdba with SMTP id g9-20020a635209000000b004349e1abdbamr9124561pgb.297.1662663051917;
        Thu, 08 Sep 2022 11:50:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0017681ccc0b1sm12656618pla.120.2022.09.08.11.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:50:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 11:50:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer High Flow Next
Message-ID: <20220908185050.GA3197459@roeck-us.net>
References: <20220907100739.806571-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907100739.806571-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:07:39PM +0200, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose various hardware
> sensors of the Aquacomputer High Flow Next flow sensor, which
> communicates through a proprietary USB HID protocol.
> 
> The High Flow Next exposes +5V voltages, water quality, conductivity
> and flow readings. A temperature sensor can be connected to it, in
> which case it provides its reading and an estimation of the
> dissipated/absorbed power in the liquid cooling loop.
> 
> Additionally, serial number and firmware version are exposed through
> debugfs.
> 
> Registry offsets were discovered and tested by users on Github [1] [2].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/8
> [2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/34
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v2:
> - Rebased code and docs properly
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |  5 ++
>  drivers/hwmon/Kconfig                       |  6 +-
>  drivers/hwmon/aquacomputer_d5next.c         | 91 ++++++++++++++++++++-
>  3 files changed, 96 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index b63a78d47624..e238533b5fe0 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -10,6 +10,7 @@ Supported devices:
>  * Aquacomputer Farbwerk 360 RGB controller
>  * Aquacomputer Octo fan controller
>  * Aquacomputer Quadro fan controller
> +* Aquacomputer High Flow Next sensor
>  
>  Author: Aleksa Savic
>  
> @@ -43,6 +44,10 @@ voltage and current.
>  The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
>  sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
>  
> +The High Flow Next exposes +5V voltages, water quality, conductivity and flow readings.
> +A temperature sensor can be connected to it, in which case it provides its reading
> +and an estimation of the dissipated/absorbed power in the liquid cooling loop.
> +
>  Depending on the device, not all sysfs and debugfs entries will be available.
>  Writing to virtual temperature sensors is not currently supported.
>  
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index d317aae183c1..18dc045d3fc5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -257,14 +257,14 @@ config SENSORS_AHT10
>  	  will be called aht10.
>  
>  config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, and Farbwerk 360"
> +	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 360, High Flow Next"
>  	depends on USB_HID
>  	select CRC16
>  	help
>  	  If you say yes here you get support for sensors and fans of
>  	  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
> -	  controllers, Farbwerk and Farbwerk 360 RGB controllers, where
> -	  available.
> +	  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flow
> +	  Next sensor, where available.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index b2b0c4fdfa84..3ea25edfc7a5 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
> - * Quadro)
> + * Quadro, High Flow Next)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values.
> @@ -26,15 +26,17 @@
>  #define USB_PRODUCT_ID_D5NEXT		0xf00e
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
>  #define USB_PRODUCT_ID_OCTO		0xf011
> +#define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
>  
> -enum kinds { d5next, farbwerk, farbwerk360, octo, quadro };
> +enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext };
>  
>  static const char *const aqc_device_names[] = {
>  	[d5next] = "d5next",
>  	[farbwerk] = "farbwerk",
>  	[farbwerk360] = "farbwerk360",
>  	[octo] = "octo",
> -	[quadro] = "quadro"
> +	[quadro] = "quadro",
> +	[highflownext] = "highflownext"
>  };
>  
>  #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -120,6 +122,16 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
>  /* Fan speed registers in Quadro control report (from 0-100%) */
>  static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 };
>  
> +/* Register offsets for the High Flow Next */
> +#define HIGHFLOWNEXT_NUM_SENSORS	2
> +#define HIGHFLOWNEXT_SENSOR_START	85
> +#define HIGHFLOWNEXT_FLOW		81
> +#define HIGHFLOWNEXT_WATER_QUALITY	89
> +#define HIGHFLOWNEXT_POWER		91
> +#define HIGHFLOWNEXT_CONDUCTIVITY	95
> +#define HIGHFLOWNEXT_5V_VOLTAGE		97
> +#define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
> +
>  /* Labels for D5 Next */
>  static const char *const label_d5next_temp[] = {
>  	"Coolant temp"
> @@ -228,6 +240,27 @@ static const char *const label_quadro_speeds[] = {
>  	"Flow speed [dL/h]"
>  };
>  
> +/* Labels for High Flow Next */
> +static const char *const label_highflownext_temp_sensors[] = {
> +	"Coolant temp",
> +	"External sensor"
> +};
> +
> +static const char *const label_highflownext_fan_speed[] = {
> +	"Flow [dL/h]",
> +	"Water quality [%]",
> +	"Conductivity [nS/cm]",
> +};
> +
> +static const char *const label_highflownext_power[] = {
> +	"Dissipated power",
> +};
> +
> +static const char *const label_highflownext_voltage[] = {
> +	"+5V voltage",
> +	"+5V USB voltage"
> +};
> +
>  struct aqc_data {
>  	struct hid_device *hdev;
>  	struct device *hwmon_dev;
> @@ -390,6 +423,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		break;
>  	case hwmon_fan:
>  		switch (priv->kind) {
> +		case highflownext:
> +			/* Special case to support flow sensor, water quality and conductivity */
> +			if (channel < 3)
> +				return 0444;
> +			break;
>  		case quadro:
>  			/* Special case to support flow sensor */
>  			if (channel < priv->num_fans + 1)
> @@ -402,6 +440,18 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  		}
>  		break;
>  	case hwmon_power:
> +		switch (priv->kind) {
> +		case highflownext:
> +			/* Special case to support one power sensor */
> +			if (channel == 0)
> +				return 0444;
> +			break;
> +		default:
> +			if (channel < priv->num_fans)
> +				return 0444;
> +			break;
> +		}
> +		break;
>  	case hwmon_curr:
>  		if (channel < priv->num_fans)
>  			return 0444;
> @@ -413,6 +463,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>  			if (channel < priv->num_fans + 2)
>  				return 0444;
>  			break;
> +		case highflownext:
> +			/* Special case to support two voltage sensors */
> +			if (channel < 2)
> +				return 0444;
> +			break;
>  		default:
>  			if (channel < priv->num_fans)
>  				return 0444;
> @@ -679,6 +734,22 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>  	case quadro:
>  		priv->speed_input[4] = get_unaligned_be16(data + priv->flow_sensor_offset);
>  		break;
> +	case highflownext:
> +		/* If external temp sensor is not connected, its power reading is also N/A */
> +		if (priv->temp_input[1] == -ENODATA)
> +			priv->power_input[0] = -ENODATA;
> +		else
> +			priv->power_input[0] =
> +			    get_unaligned_be16(data + HIGHFLOWNEXT_POWER) * 1000000;
> +
> +		priv->voltage_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE) * 10;
> +		priv->voltage_input[1] =
> +		    get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE_USB) * 10;
> +
> +		priv->speed_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_FLOW);
> +		priv->speed_input[1] = get_unaligned_be16(data + HIGHFLOWNEXT_WATER_QUALITY);
> +		priv->speed_input[2] = get_unaligned_be16(data + HIGHFLOWNEXT_CONDUCTIVITY);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -851,6 +922,19 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->voltage_label = label_fan_voltage;
>  		priv->current_label = label_fan_current;
>  		break;
> +	case USB_PRODUCT_ID_HIGHFLOWNEXT:
> +		priv->kind = highflownext;
> +
> +		priv->num_fans = 0;
> +		priv->num_temp_sensors = HIGHFLOWNEXT_NUM_SENSORS;
> +		priv->temp_sensor_start_offset = HIGHFLOWNEXT_SENSOR_START;
> +		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
> +
> +		priv->temp_label = label_highflownext_temp_sensors;
> +		priv->speed_label = label_highflownext_fan_speed;
> +		priv->power_label = label_highflownext_power;
> +		priv->voltage_label = label_highflownext_voltage;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -907,6 +991,7 @@ static const struct hid_device_id aqc_table[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
>  	{ }
>  };
>  
