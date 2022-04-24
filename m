Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6027050CF0E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiDXD7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiDXD7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:59:34 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69FDF18
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:56:34 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z8so13564220oix.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jackdoan-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SI6k7b10AiK1hM0eXBJEIUwBjMbKHQkO/wRH+36ynPU=;
        b=RDCF2ZXRJuQ4Z4pZpBX4+JmOm1jb1rQNPgvxOoRIFpNG4CZvcvCQIJL7vF2fcDWXL3
         FYcal0I9FM+zkmks80GEKtbYl/Pkv50vIW4GyS0cz3FKIUWfKEpwN/Zup3ldltW99mZ1
         Br2BtE86RQnqYYzyECw92ttelf+fxzQkUKKJEqfGTpD0FniAj++lpEKT5Plbx/sSUFl7
         FrbJUHQSDEyRw9AU0TL95tKnYnAHLn+FMrxtpNGJYApNeycFtBARh+UQwK43SLmvc8a9
         8Di8CsNqbO1CUjJ0bz+i63hQsoHEv1L6Q3l5ocsrbS6xYU0o/z76PXFSorljzvSqGf9m
         RwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SI6k7b10AiK1hM0eXBJEIUwBjMbKHQkO/wRH+36ynPU=;
        b=SJ+5lw5rdwVKp2yfBe5kkQeV36ryJxkoZB/hxWDyRsKK+5b/Zc8Tz0NL/vrL60DS0g
         uOuQnSbIH1mjBXznKXXzL58WyQ5NJ/wpz4j+pcAh7nRaEzraYQVAoUOQWJiTvM5qja2D
         DVwdcec19tl2M/2VkcDY97PGcdGj9YjhD/dtse0P5tipvdQbJ+Iw+vc+tkLBRtwV0mOc
         DT/O+ypqpHNFuIDQMk6Vz5VVdYWIytbBCOjYxyJfrZaQS62iXmGKuwzUbgvZOZnS/NQv
         pjDiKO8chJ4axu10K0BrdjPKhnJeP7Vh/Z1U5GuETElGXiw9qUiyorRGVuUpK4lIvv/M
         SQfg==
X-Gm-Message-State: AOAM530qMu0I37i4x4Xk2EIE/+VIFV//+dYOC8A+AIjGnShyNA5KRWdQ
        qDQ8KsZO6akeSnbr/LFQMTMLIg==
X-Google-Smtp-Source: ABdhPJzuAj7ScYB1mYxjUtPsv4e0+tztFjNprqIols0hwsoy9aYTxZG6YpwuXDw6RJBknTznE2NfGg==
X-Received: by 2002:a05:6808:23d4:b0:323:c21:71fb with SMTP id bq20-20020a05680823d400b003230c2171fbmr5510709oib.261.1650772594221;
        Sat, 23 Apr 2022 20:56:34 -0700 (PDT)
Received: from jackdesk ([2600:1700:24d0:1e2f:386a:dfff:fe72:8e55])
        by smtp.gmail.com with ESMTPSA id x20-20020a4ac594000000b00329a02f2f34sm2671037oop.16.2022.04.23.20.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:56:33 -0700 (PDT)
Date:   Sat, 23 Apr 2022 22:56:25 -0500
From:   Jack Doan <me@jackdoan.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk
Message-ID: <YmTKaZwxTRZRnFkq@jackdesk>
References: <20220421072743.5058-1-savicaleksa83@gmail.com>
 <20220424014206.GA3989097@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424014206.GA3989097@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 06:42:06PM -0700, Guenter Roeck wrote:
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
> 
> This patch doesn't apply. Please rebase to master and resend.
> 
Will do! 

> More comments inline.
> 
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
> 
> That is a bit aggressive for a few lines of code.
Addressed below.

> 
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
> 
> Can the sensor be connected dynamically ? If not, this should be handled
> in an is_visible function.
> 
It's a somewhat unlikely use-case, but yes, they can be. The sensors are NTC thermistors that connect to pin-headers. Do we have a better way of representing "open circuit" than -ENODATA?

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
> 
> .... as is claiming authorship. I'd be the "author" of hundreds of kernel
> files if I would do that. Aleksa signed off on it, so I'll accept it,
> but I don't think it is appropriate.

In the context of just this patch, yes, I agree. But, I felt it was warranted based on my previous contributions. I did a good bit of the reverse-engineering that made writing settings to these devices possible, and a lot of the previously submitted code for writing the setting changes is mine as well.

I didn't mean to make an inappropriate request though! If you'd like, I can submit a version of the patch without these lines.

Also I'm really sorry if you get this email twice. Thunderbird seems to have snuck HTML into my emails and the mailinglist rejected my first reply. I've switched to mutt to prevent this.

> 
> >  MODULE_DESCRIPTION("Hwmon driver for Aquacomputer devices");
