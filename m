Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC950CC47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiDWQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDWQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:27:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E01CDEE6;
        Sat, 23 Apr 2022 09:24:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a1so8192310edt.3;
        Sat, 23 Apr 2022 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ppVcIeAAOmwed352sGxya3BOJYGtZNlR1farH+4bFU=;
        b=dOlySR7580WffaBWqz8gjNUEbOMG+kudDCF/52sKG5IK0LENEIDD60WJpFGYUgvEi+
         HLsUxtBXgQBWOwu/Nj+CmWk9EYPYOW3YBSLJr3K3FtPKYN41ktnIR/88mlgA5ndk6fGt
         RJcz5CZrr7UAMjJdhyG5eVECHwi+s3ZsoGJcNQNzXFQYQyetKc/qwvXWXSDvGdEwKCQr
         jHNBObFvpHnIQDFg5xk92D1rZ1gpvLOSjoRqP4TUqKIStYAMZ9Xczp8SJxNsy1etcDRu
         74Bv3oYkSY8vERwXC6XY5S75DXHEw/ZpsEQfFE0o5lXzVh6rPpwO72G3UTHSapBlRY4w
         O/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ppVcIeAAOmwed352sGxya3BOJYGtZNlR1farH+4bFU=;
        b=P899MhSkNyOABuFwSIW1ZQD5jkM8fhAp0kWMJQlKJ4DMCmK/LpF1GArIKL7siGMvh0
         nrzYL2M28v3599aM/ccM6gZtrlr2kNeAv7aBgLgNojDYQElnsJEJlerimmjTyjxl3gXo
         ttYLVPW0Qd4m2HO/m9nJbTYwdX8umOYgRPgvet33zQfhtjnasizuWJIKGAKX1i8aedmV
         F4GIihgXULEgYA/zD3x4FBdDTxXCyagufcoBxT+DGHyk4Jl/MkvDziU994J2KXmyrwy6
         oM0taDscf6+5wWHVnN5Tcox5CZTXFHhShdW7P3TOSUm9frg1hpeN449nDOKR7EtAQ6FQ
         3UKg==
X-Gm-Message-State: AOAM533zfsyBkav2cr28MMOouBwTIvwRHgj48J68lwEXsj0uB5F8qnic
        I2rsCcp44qvT44qnyhjbRi0=
X-Google-Smtp-Source: ABdhPJyVE0CNMZrfPGfxJenMu6rNOWh0m8pHA0B5Nlt/cm+nTJ8sq/MSqB5dTV69I1x8g2UtMheV5w==
X-Received: by 2002:a05:6402:22c4:b0:41d:78b1:349 with SMTP id dm4-20020a05640222c400b0041d78b10349mr10777700edb.365.1650731028923;
        Sat, 23 Apr 2022 09:23:48 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id bl20-20020a170906c25400b006efeef97b1esm1797616ejb.206.2022.04.23.09.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 09:23:48 -0700 (PDT)
Date:   Sat, 23 Apr 2022 18:23:46 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <YmQoEoU1UJ+KPhQ9@fedora>
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
 <20220422183144.GA2637654@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422183144.GA2637654@roeck-us.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:31:44AM -0700, Guenter Roeck wrote:
> On Thu, Apr 21, 2022 at 09:27:42AM +0200, Aleksa Savic wrote:
> > Extend aquacomputer_d5next driver to expose hardware temperature sensors
> > of the Aquacomputer Farbwerk RGB controller, which communicates through
> > a proprietary USB HID protocol.
> > 
> > Four temperature sensors are available. Additionally, serial number and
> > firmware version are exposed through debugfs.
> > 
> > Also, add Jack Doan to MAINTAINERS for this driver.
> > 
> > Signed-off-by: Jack Doan <me@jackdoan.com>
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> > ---
> > If adding to MAINTAINERS requires a separate commit, I'll send it
> > separately.
> > ---
> >  Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
> >  MAINTAINERS                                 |  1 +
> >  drivers/hwmon/Kconfig                       |  5 +--
> >  drivers/hwmon/aquacomputer_d5next.c         | 37 ++++++++++++++++++---
> >  4 files changed, 38 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> > index e69f718caf5b..717e28226cde 100644
> > --- a/Documentation/hwmon/aquacomputer_d5next.rst
> > +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> > @@ -6,6 +6,7 @@ Kernel driver aquacomputer-d5next
> >  Supported devices:
> >  
> >  * Aquacomputer D5 Next watercooling pump
> > +* Aquacomputer Farbwerk RGB controller
> >  * Aquacomputer Farbwerk 360 RGB controller
> >  * Aquacomputer Octo fan controller
> >  
> > @@ -32,7 +33,7 @@ better suited for userspace tools.
> >  The Octo exposes four temperature sensors and eight PWM controllable fans, along
> >  with their speed (in RPM), power, voltage and current.
> >  
> > -The Farbwerk 360 exposes four temperature sensors. Depending on the device,
> > +The Farbwerk and Farbwerk 360 expose four temperature sensors. Depending on the device,
> >  not all sysfs and debugfs entries will be available.
> >  
> >  Usage notes
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea2cd656ee6c..d8e3ca0fbc3a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1389,6 +1389,7 @@ F:	drivers/media/i2c/aptina-pll.*
> >  
> >  AQUACOMPUTER D5 NEXT PUMP SENSOR DRIVER
> >  M:	Aleksa Savic <savicaleksa83@gmail.com>
> > +M:	Jack Doan <me@jackdoan.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/hwmon/aquacomputer_d5next.rst
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 5beadd8a0932..01d10c9b633a 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -256,12 +256,13 @@ config SENSORS_AHT10
> >  	  will be called aht10.
> >  
> >  config SENSORS_AQUACOMPUTER_D5NEXT
> > -	tristate "Aquacomputer D5 Next, Octo and Farbwerk 360"
> > +	tristate "Aquacomputer D5 Next, Octo, Farbwerk, Farbwerk 360"
> >  	depends on USB_HID
> >  	help
> >  	  If you say yes here you get support for sensors and fans of
> >  	  the Aquacomputer D5 Next watercooling pump, Octo fan
> > -	  controller and Farbwerk 360 RGB controller, where available.
> > +	  controller, Farbwerk and Farbwerk 360 RGB controllers, where
> > +	  available.
> >  
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called aquacomputer_d5next.
> > diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> > index a464473bc981..7d2e7279abfb 100644
> > --- a/drivers/hwmon/aquacomputer_d5next.c
> > +++ b/drivers/hwmon/aquacomputer_d5next.c
> > @@ -1,11 +1,12 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk 360, Octo)
> > + * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo)
> >   *
> >   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
> >   * sensor values.
> >   *
> >   * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
> > + * Copyright 2022 Jack Doan <me@jackdoan.com>
> >   */
> >  
> >  #include <linux/crc16.h>
> > @@ -19,14 +20,16 @@
> >  #include <asm/unaligned.h>
> >  
> >  #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
> > +#define USB_PRODUCT_ID_FARBWERK		0xf00a
> >  #define USB_PRODUCT_ID_D5NEXT		0xf00e
> >  #define USB_PRODUCT_ID_FARBWERK360	0xf010
> >  #define USB_PRODUCT_ID_OCTO		0xf011
> >  
> > -enum kinds { d5next, farbwerk360, octo };
> > +enum kinds { d5next, farbwerk, farbwerk360, octo };
> >  
> >  static const char *const aqc_device_names[] = {
> >  	[d5next] = "d5next",
> > +	[farbwerk] = "farbwerk",
> >  	[farbwerk360] = "farbwerk360",
> >  	[octo] = "octo"
> >  };
> > @@ -69,6 +72,12 @@ static u8 secondary_ctrl_report[] = {
> >  #define D5NEXT_PUMP_CURRENT		112
> >  #define D5NEXT_FAN_CURRENT		99
> >  
> > +/* Register offsets for the Farbwerk RGB controller */
> > +#define FARBWERK_NUM_SENSORS		4
> > +#define FARBWERK_SENSOR_START		0x2f
> > +#define FARBWERK_SENSOR_SIZE		0x02
> > +#define FARBWERK_SENSOR_DISCONNECTED	0x7FFF
> > +
> >  /* Register offsets for the Farbwerk 360 RGB controller */
> >  #define FARBWERK360_NUM_SENSORS		4
> >  #define FARBWERK360_SENSOR_START	0x32
> > @@ -125,7 +134,7 @@ static const char *const label_d5next_current[] = {
> >  	"Fan current"
> >  };
> >  
> > -/* Labels for Farbwerk 360 and Octo temperature sensors */
> > +/* Labels for Farbwerk, Farbwerk 360 and Octo temperature sensors */
> >  static const char *const label_temp_sensors[] = {
> >  	"Sensor 1",
> >  	"Sensor 2",
> > @@ -319,6 +328,7 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
> >  			if (channel == 0)
> >  				return 0444;
> >  			break;
> > +		case farbwerk:
> >  		case farbwerk360:
> >  		case octo:
> >  			return 0444;
> > @@ -551,8 +561,7 @@ static const struct hwmon_chip_info aqc_chip_info = {
> >  	.info = aqc_info,
> >  };
> >  
> > -static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> > -			 int size)
> > +static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
> >  {
> >  	int i, sensor_value;
> >  	struct aqc_data *priv;
> > @@ -587,6 +596,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
> >  		priv->current_input[0] = get_unaligned_be16(data + D5NEXT_PUMP_CURRENT);
> >  		priv->current_input[1] = get_unaligned_be16(data + D5NEXT_FAN_CURRENT);
> >  		break;
> > +	case farbwerk:
> > +		/* Temperature sensor readings */
> > +		for (i = 0; i < FARBWERK_NUM_SENSORS; i++) {
> > +			sensor_value = get_unaligned_be16(data + FARBWERK_SENSOR_START +
> > +							  i * FARBWERK_SENSOR_SIZE);
> > +			if (sensor_value == FARBWERK_SENSOR_DISCONNECTED)
> > +				priv->temp_input[i] = -ENODATA;
> > +			else
> > +				priv->temp_input[i] = sensor_value * 10;
> > +		}
> > +		break;
> >  	case farbwerk360:
> >  		/* Temperature sensor readings */
> >  		for (i = 0; i < FARBWERK360_NUM_SENSORS; i++) {
> > @@ -733,6 +753,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		priv->voltage_label = label_d5next_voltages;
> >  		priv->current_label = label_d5next_current;
> >  		break;
> > +	case USB_PRODUCT_ID_FARBWERK:
> > +		priv->kind = farbwerk;
> > +
> 
> 
> Any special reason for this empty line ? It seems kind of random.
> 
> Guenter
> 

That's how code in other cases of that switch is formatted (not visible
from this patch directly), setting priv->kind and then the appropriate
labels.

Thanks,
Aleksa

> > +		priv->temp_label = label_temp_sensors;
> > +		break;
> >  	case USB_PRODUCT_ID_FARBWERK360:
> >  		priv->kind = farbwerk360;
> >  
> > @@ -795,6 +820,7 @@ static void aqc_remove(struct hid_device *hdev)
> >  
> >  static const struct hid_device_id aqc_table[] = {
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_D5NEXT) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_FARBWERK360) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
> >  	{ }
> > @@ -826,4 +852,5 @@ module_exit(aqc_exit);
> >  
> >  MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> > +MODULE_AUTHOR("Jack Doan <me@jackdoan.com>");
> >  MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
> > -- 
> > 2.35.1
> > 
