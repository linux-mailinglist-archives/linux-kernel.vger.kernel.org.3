Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC764C5695
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiBZPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiBZPKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:10:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FED1E745A;
        Sat, 26 Feb 2022 07:09:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p14so16345350ejf.11;
        Sat, 26 Feb 2022 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WERqwgAI1c6yxhUZIK/70ILU+adYDpKfBP9VVE29yWE=;
        b=Fhzl14vfEVuuJL3VHw1a3pBv/1R4bK/iEdfKxIKUehFQreZ2Ao2mT5hLc8s0tZc8Wc
         iimL6KFjlZpboDClrEQH3ZLijPp/kkPUHRL9rSFRR92Mg05BamHNt399Wu11m+42o9uz
         de8/TT/ahk2Rkk9FYc5VbTDvQvIw9qGTZ/YEuE2FuPR+z34suO4Xyfhb9UgJnHC7/xG5
         R1hw9fiHNbIB7q1HJ1sUoGy5zfO3iqip+RInjxTzeCUfxvnBLW9JjKjADLDoCIzVvuDL
         qz3rjA9dNEY8TO7gb9dn+NMfiMxHJoCfxVAuMJqI2pO4ElM+pxTw+Dk/dKQnLx2K8/kZ
         f8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WERqwgAI1c6yxhUZIK/70ILU+adYDpKfBP9VVE29yWE=;
        b=UxKJowbq/OXswcPGSKGO3YvuFsTgDLHjjYSgUS5qcNL92ESyQO62bB290edJOWulMG
         pDd92PrTxQWW/PxHGBHgzavQfPfbawPrIMrd3eUnjP66HVmAcmhxpbvrZxS8CdZEbSaV
         lYf7EvgUvGCirVFxMMK9XCKi+K/EO3VblGSnz0jHFgH9QAhbnlulGBwRWx6ZKzdV5iIw
         7/TW8+fXGzh4zxcWnLSa6/I+3F7eibLwQZ6sNPbL5mphp0rO44egNY8csYXWlYDaTWDI
         bDZtV7X7gQHuqFWHL4fDod/atPm2j7QwICwV8LyZ5D53foXJZsfk0W0wKSTZ1LUQAo6V
         TJUQ==
X-Gm-Message-State: AOAM530HOzZS8LuApsJLxaBQvcyRt179Acs2UPvdHkTMBjyenTv5twuf
        oug0+QjeDqc7cHHHJAcPsag=
X-Google-Smtp-Source: ABdhPJzWdZRw2BI/NDmi80Bd+RWNxrXYk4Z9te3MLfLVqsXC1qy0bwjcRqujYdOpK0GldRVWP5q/Iw==
X-Received: by 2002:a17:906:7e52:b0:6b6:bc81:eae9 with SMTP id z18-20020a1709067e5200b006b6bc81eae9mr9857872ejr.273.1645888174983;
        Sat, 26 Feb 2022 07:09:34 -0800 (PST)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm2992270edb.73.2022.02.26.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:09:34 -0800 (PST)
Date:   Sat, 26 Feb 2022 16:09:32 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: add driver for Aquacomputer Farbwerk 360
Message-ID: <YhpCrNhjfb0E8rLn@fedora>
References: <20220221102157.13574-1-savicaleksa83@gmail.com>
 <5fa0a22c-5f55-bd38-8d76-a4ea31898bca@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa0a22c-5f55-bd38-8d76-a4ea31898bca@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 24, 2022 at 11:57:47AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On 2/21/22 02:21, Aleksa Savic wrote:
> > This driver exposes hardware temperature sensors of the Aquacomputer
> > Farbwerk 360 RGB controller, which communicates through a proprietary
> > USB HID protocol.
> > 
> > Four temperature sensors are available. If a sensor is not connected,
> > it will report zeroes. Additionally, serial number and firmware version
> > are exposed through debugfs.
> > 
> > This driver has been tested on x86_64.
> > 
> > Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> 
> Unless I amm missing something, this driver is quite similar to the
> d5next driver (drivers/hwmon/aquacomputer_d5next.c), except that there
> are 4 instead of 1 temperature sensor, the sensor data is in a different place,
> and there is _only_ temperature data. It should be quite straightforward
> to merge the two drivers into one, so please  do that.
> 
> Additional comment inline.
> 
> Thanks,
> Guenter

Yes, it's very similar, I based this one on that. I'll send a patch for
the original driver. I also have code ready for Aquacomputer Octo (8 fans, 4
temperature sensors, very similar to all this as well) with PWM write control
support for the fans. And there is also WIP code for PWM and curve support for
the D5 Next from contributors on my github repo, though we're working on that.

Considering that the driver would then contain support for more devices (the D5
Next and the Farbwerk 360 for now), can it be renamed to just aquacomputer or
something similar?

For the inline comments, understood, I'll resolve them in the next patch.

Thanks,
Aleksa
 
> > ---
> >   .../hwmon/aquacomputer_farbwerk360.rst        |  40 +++
> >   Documentation/hwmon/index.rst                 |   1 +
> >   MAINTAINERS                                   |   7 +
> >   drivers/hwmon/Kconfig                         |  10 +
> >   drivers/hwmon/Makefile                        |   1 +
> >   drivers/hwmon/aquacomputer_farbwerk360.c      | 261 ++++++++++++++++++
> >   6 files changed, 320 insertions(+)
> >   create mode 100644 Documentation/hwmon/aquacomputer_farbwerk360.rst
> >   create mode 100644 drivers/hwmon/aquacomputer_farbwerk360.c
> > 
> > diff --git a/Documentation/hwmon/aquacomputer_farbwerk360.rst b/Documentation/hwmon/aquacomputer_farbwerk360.rst
> > new file mode 100644
> > index 000000000000..cebaffccd818
> > --- /dev/null
> > +++ b/Documentation/hwmon/aquacomputer_farbwerk360.rst
> > @@ -0,0 +1,40 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver aquacomputer_farbwerk360
> > +======================================
> > +
> > +Supported devices:
> > +
> > +* Aquacomputer Farbwerk 360 RGB controller
> > +
> > +Author: Aleksa Savic
> > +
> > +Description
> > +-----------
> > +
> > +This driver exposes hardware temperature sensors of the Aquacomputer Farbwerk 360
> > +RGB controller, which communicates through a proprietary USB HID protocol.
> > +
> > +Four temperature sensors are available. If a sensor is not connected, it will report
> > +zeroes. Additionally, serial number and firmware version are exposed through debugfs.
> > +
> > +Usage notes
> > +-----------
> > +
> > +Farbwerk 360 communicates via HID reports. The driver is loaded automatically by
> > +the kernel and supports hotswapping.
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +=============== ==============================================
> > +temp[1-4]_input Measured temperature (in millidegrees Celsius)
> > +=============== ==============================================
> > +
> > +Debugfs entries
> > +---------------
> > +
> > +================ ===============================================
> > +serial_number    Serial number of the pump
> > +firmware_version Version of installed firmware
> > +================ ===============================================
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index df20022c741f..42b7369340ba 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -40,6 +40,7 @@ Hardware Monitoring Kernel Drivers
> >      aht10
> >      amc6821
> >      aquacomputer_d5next
> > +   aquacomputer_farbwerk360
> >      asb100
> >      asc7621
> >      aspeed-pwm-tacho
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bd86ed9fbc79..fb8b8d7aebbc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1386,6 +1386,13 @@ S:	Maintained
> >   F:	Documentation/hwmon/aquacomputer_d5next.rst
> >   F:	drivers/hwmon/aquacomputer_d5next.c
> > +AQUACOMPUTER FARBWERK 360 RGB CONTROLLER SENSOR DRIVER
> > +M:	Aleksa Savic <savicaleksa83@gmail.com>
> > +L:	linux-hwmon@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/hwmon/aquacomputer_farbwerk360.rst
> > +F:	drivers/hwmon/aquacomputer_farbwerk360.c
> > +
> >   AQUANTIA ETHERNET DRIVER (atlantic)
> >   M:	Igor Russkikh <irusskikh@marvell.com>
> >   L:	netdev@vger.kernel.org
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 8df25f1079ba..e1ca5e1e6ab0 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -264,6 +264,16 @@ config SENSORS_AQUACOMPUTER_D5NEXT
> >   	  This driver can also be built as a module. If so, the module
> >   	  will be called aquacomputer_d5next.
> > +config SENSORS_AQUACOMPUTER_FARBWERK360
> > +	tristate "Aquacomputer Farbwerk 360 RGB controller"
> > +	depends on USB_HID
> > +	help
> > +	  If you say yes here you get support for temperature sensors provided by
> > +	  the Aquacomputer Farbwerk 360 RGB controller.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called aquacomputer_farbwerk360.
> > +
> >   config SENSORS_AS370
> >   	tristate "Synaptics AS370 SoC hardware monitoring driver"
> >   	help
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 185f946d698b..1c1556a53f6d 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -49,6 +49,7 @@ obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
> >   obj-$(CONFIG_SENSORS_AHT10)	+= aht10.o
> >   obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
> >   obj-$(CONFIG_SENSORS_AQUACOMPUTER_D5NEXT) += aquacomputer_d5next.o
> > +obj-$(CONFIG_SENSORS_AQUACOMPUTER_FARBWERK360) += aquacomputer_farbwerk360.o
> >   obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
> >   obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
> >   obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
> > diff --git a/drivers/hwmon/aquacomputer_farbwerk360.c b/drivers/hwmon/aquacomputer_farbwerk360.c
> > new file mode 100644
> > index 000000000000..14b760a2c8a8
> > --- /dev/null
> > +++ b/drivers/hwmon/aquacomputer_farbwerk360.c
> > @@ -0,0 +1,261 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * hwmon driver for Aquacomputer Farbwerk 360 (RGB controller)
> > + *
> > + * The Farbwerk 360 sends HID reports (with ID 0x01) every second to report sensor values
> > + * of up to four connected temperature sensors.
> > + *
> > + * Copyright 2022 Aleksa Savic <savicaleksa83@gmail.com>
> > + */
> > +
> > +#include <asm/unaligned.h>
> 
> asm includes should be last (ah, my bad, this is from the d5 driver.
> but still, just for the future).
> 
> > +#include <linux/debugfs.h>
> > +#include <linux/hid.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/seq_file.h>
> > +
> > +#define DRIVER_NAME		"aquacomputer_farbwerk360"
> > +
> > +#define STATUS_REPORT_ID	0x01
> > +#define STATUS_UPDATE_INTERVAL	(2 * HZ) /* In seconds */
> > +
> > +/* Register offsets */
> > +#define SERIAL_FIRST_PART	0x03
> > +#define SERIAL_SECOND_PART	0x05
> > +#define FIRMWARE_VERSION	0x0D
> > +
> > +#define NUM_SENSORS		4
> > +#define SENSOR_START		0x32
> > +#define SENSOR_SIZE		0x02
> > +#define SENSOR_DISCONNECTED	0x7FFF
> > +
> > +static const char *const label_temps[] = { "Sensor 1", "Sensor 2", "Sensor 3", "Sensor 4" };
> > +
> > +struct farbwerk360_data {
> > +	struct hid_device *hdev;
> > +	struct device *hwmon_dev;
> > +	struct dentry *debugfs;
> > +	s32 temp_input[4];
> > +	u32 serial_number[2];
> > +	u16 firmware_version;
> > +	unsigned long updated;
> > +};
> > +
> > +static umode_t farbwerk360_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> > +				      int channel)
> > +{
> > +	return 0444;
> > +}
> > +
> > +static int farbwerk360_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> > +			    long *val)
> > +{
> > +	struct farbwerk360_data *priv = dev_get_drvdata(dev);
> > +
> > +	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL))
> > +		return -ENODATA;
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		*val = priv->temp_input[channel];
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int farbwerk360_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> > +				   int channel, const char **str)
> > +{
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		*str = label_temps[channel];
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops farbwerk360_hwmon_ops = {
> > +	.is_visible = farbwerk360_is_visible,
> > +	.read = farbwerk360_read,
> > +	.read_string = farbwerk360_read_string,
> > +};
> > +
> > +static const struct hwmon_channel_info *farbwerk360_info[] = {
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> > +			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info farbwerk360_chip_info = {
> > +	.ops = &farbwerk360_hwmon_ops,
> > +	.info = farbwerk360_info,
> > +};
> > +
> > +static int farbwerk360_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data,
> > +				 int size)
> > +{
> > +	int i, sensor_value;
> > +	struct farbwerk360_data *priv;
> > +
> > +	if (report->id != STATUS_REPORT_ID)
> > +		return 0;
> > +
> > +	priv = hid_get_drvdata(hdev);
> > +
> > +	/* Info provided with every report */
> > +	priv->serial_number[0] = get_unaligned_be16(data + SERIAL_FIRST_PART);
> > +	priv->serial_number[1] = get_unaligned_be16(data + SERIAL_SECOND_PART);
> > +
> > +	priv->firmware_version = get_unaligned_be16(data + FIRMWARE_VERSION);
> > +
> > +	/* Temperature sensor readings */
> > +	for (i = 0; i < NUM_SENSORS; i++) {
> > +		sensor_value = get_unaligned_be16(data + SENSOR_START + i * SENSOR_SIZE);
> > +		if (sensor_value == SENSOR_DISCONNECTED)
> > +			sensor_value = 0;
> 
> If it is known that a sensor is disconnected, it would make
> more sense to report -ENODATA when it is read instead of a
> temperature of 0 degrees.
> 
> > +
> > +		priv->temp_input[i] = sensor_value * 10;
> > +	}
> > +
> > +	priv->updated = jiffies;
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +
> > +static int serial_number_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct farbwerk360_data *priv = seqf->private;
> > +
> > +	seq_printf(seqf, "%05u-%05u\n", priv->serial_number[0], priv->serial_number[1]);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(serial_number);
> > +
> > +static int firmware_version_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct farbwerk360_data *priv = seqf->private;
> > +
> > +	seq_printf(seqf, "%u\n", priv->firmware_version);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> > +
> > +static void farbwerk360_debugfs_init(struct farbwerk360_data *priv)
> > +{
> > +	char name[32];
> > +
> > +	scnprintf(name, sizeof(name), "%s-%s", DRIVER_NAME, dev_name(&priv->hdev->dev));
> > +
> > +	priv->debugfs = debugfs_create_dir(name, NULL);
> > +	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
> > +	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
> > +}
> > +
> > +#else
> > +
> > +static void farbwerk360_debugfs_init(struct farbwerk360_data *priv)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +static int farbwerk360_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > +{
> > +	int ret;
> > +	struct farbwerk360_data *priv;
> > +
> > +	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->hdev = hdev;
> > +	hid_set_drvdata(hdev, priv);
> > +
> > +	priv->updated = jiffies - STATUS_UPDATE_INTERVAL;
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hid_hw_open(hdev);
> > +	if (ret)
> > +		goto fail_and_stop;
> > +
> > +	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "farbwerk360", priv,
> > +							  &farbwerk360_chip_info, NULL);
> > +
> > +	if (IS_ERR(priv->hwmon_dev)) {
> > +		ret = PTR_ERR(priv->hwmon_dev);
> > +		goto fail_and_close;
> > +	}
> > +
> > +	farbwerk360_debugfs_init(priv);
> > +
> > +	return 0;
> > +
> > +fail_and_close:
> > +	hid_hw_close(hdev);
> > +fail_and_stop:
> > +	hid_hw_stop(hdev);
> > +	return ret;
> > +}
> > +
> > +static void farbwerk360_remove(struct hid_device *hdev)
> > +{
> > +	struct farbwerk360_data *priv = hid_get_drvdata(hdev);
> > +
> > +	debugfs_remove_recursive(priv->debugfs);
> > +	hwmon_device_unregister(priv->hwmon_dev);
> > +
> > +	hid_hw_close(hdev);
> > +	hid_hw_stop(hdev);
> > +}
> > +
> > +static const struct hid_device_id farbwerk360_table[] = {
> > +	{ HID_USB_DEVICE(0x0c70, 0xf010) }, /* Aquacomputer Farbwerk 360 */
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(hid, farbwerk360_table);
> > +
> > +static struct hid_driver farbwerk360_driver = {
> > +	.name = DRIVER_NAME,
> > +	.id_table = farbwerk360_table,
> > +	.probe = farbwerk360_probe,
> > +	.remove = farbwerk360_remove,
> > +	.raw_event = farbwerk360_raw_event,
> > +};
> > +
> > +static int __init farbwerk360_init(void)
> > +{
> > +	return hid_register_driver(&farbwerk360_driver);
> > +}
> > +
> > +static void __exit farbwerk360_exit(void)
> > +{
> > +	hid_unregister_driver(&farbwerk360_driver);
> > +}
> > +
> > +/* Request to initialize after the HID bus to ensure it's not being loaded before */
> > +late_initcall(farbwerk360_init);
> > +module_exit(farbwerk360_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
> > +MODULE_DESCRIPTION("Hwmon driver for Aquacomputer Farbwerk 360");
> 
