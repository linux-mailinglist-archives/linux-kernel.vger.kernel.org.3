Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BE4D5D19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiCKIPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCKIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974E107D01
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:14:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 611C9B82A06
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BBEC340E9;
        Fri, 11 Mar 2022 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646986478;
        bh=J9I5epQPRqnFAwDewhY8bRUzY41Gx1w8t003TrP87Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7AL5uK0sBGbA5Vq8L9uWODqQ+xRb+GZnR4/1izwMCcdDWvlQ7y1tp66t/5DpWC67
         CKuIGLx22HjZVTgrYuGVskBjpHofBatHD6wJwyeaAGfv+2iWsU3ZIHZMV6jT0ETqG0
         aacHB1VhUWfUOF6MN8SLQ+bBR8wkpaqYT6RPHyEo=
Date:   Fri, 11 Mar 2022 09:14:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v7] drivers: ddcci: upstream DDCCI driver
Message-ID: <YisE6jjbzJyytqB8@kroah.com>
References: <20220311074413.14644-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311074413.14644-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:44:13PM -0800, Yusuf Khan wrote:
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>

This changelog text does not describe what this driver does, what it
supports, how it is talked to from userspace, or really anything at all.

For example, what is DDCCI?  Why does it have to be a kernel driver at
all?

> diff --git a/Documentation/ABI/testing/sysfs-driver-ddcci b/Documentation/ABI/testing/sysfs-driver-ddcci
> new file mode 100644
> index 000000000000..a46bc109a13f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-ddcci
> @@ -0,0 +1,37 @@
> +What:		/sys/bus/ddcci/ddcci<I�C bus number>i<hex address>
> +Date:		February 2022
> +KernelVersion:	5.17
> +Contact:	Christoph Grenz <webmaster@grenz-bonn.de>
> +Description:	This file is a internal dependent device on the I2C bus,
> +		it exports the same data that the main device exports.
> +
> +What:		/sys/bus/ddcci/ddcci<I�C bus number>e<hex address>
> +Date:		February 2022

It is no longer February :(

> +KernelVersion:	5.17

5.17 will not have these changes.

> +Contact:	Christoph Grenz <webmaster@grenz-bonn.de>

Why not contact you?  I need a signed-off-by from Christoph to agree to
have their name in here to be responsible.

> +Description:	This file is a external dependent device on the I2C bus,
> +		it exports the same data that the main device exports.

What bo you mean by "same data as the main device exports"?  What is a
"main device" here?

> +
> +What:		/sys/bus/ddcci/ddcci<I�C bus number>
> +Date:		February 2022
> +KernelVersion:	5.17
> +Contact:	Christoph Grenz <webmaster@grenz-bonn.de>
> +Description:	This file is the main device on the I2C bus, it exports
> +		the following peices of information about the device, capabilities
> +		which is a full ACCESS.bus capabilities string(see the ACCESS.bus
> +		specification for more info), idProt, which is a full ACCESS.bus
> +		protocol supported by the device(Usually "monitor"), idType,
> +		a ACCESS.buss device subtype(Usually "LCD" or "CRT"), idModel, a
> +		ACCESS.bus device model identifier(Usually a shortened form of the
> +		device model name), idVendor, a ACCESS.bus device vendor identifier
> +		(Empty if the Identification command is not supported), idModule,
> +		a ACCESS.bus device module identifier(Empty if the Identification
> +		command is not supported), idSerial, a 32 bit device number
> +		a fixed serial number if it's positive, a temporary serial number
> +		if negative and zero if the Identification command is not supported,
> +		and modalias, a combined identifier for driver selection,
> +		it has the form ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>,
> +		All non-alphanumeric characters (including whitespace) in the model,
> +		vendor or module parts are replaced by underscores to prevent issues
> +		with software like systemd-udevd. See Documentation/misc-devices/ddcci.rst
> +		for more information on DDC/CI.

You need to list the individual sysfs files, like the other entries in
this directory has.  This wall of text will not work, sorry.


> diff --git a/Documentation/driver-api/ddcci.rst b/Documentation/driver-api/ddcci.rst
> new file mode 100644
> index 000000000000..417bf3e216e5
> --- /dev/null
> +++ b/Documentation/driver-api/ddcci.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +DDC/CI
> +==============
> +
> +1. Introduction
> +===============
> +DDC/CI is a control protocol for monitor settings supported by most
> +monitors since about 2005. It is based on ACCESS.bus (an early USB predecessor).
> +
> +2. sysfs interface
> +==================
> +Each detected DDC/CI device gets a directory in /sys/bus/ddcci/devices.
> +The main device on a bus is named ddcci[I�C bus number].
> +Internal dependent devices are named ddcci[I�C bus number]i[hex address]
> +External dependent devices are named ddcci[I�C bus number]e[hex address]
> +There the following files export information about the device:
> +
> +capabilities
> +The full ACCESS.bus capabilities string. It contains the protocol,
> +type and model of the device, a list of all supported command
> +codes, etc. See the ACCESS.bus spec for more information.
> +
> +- idProt
> +ACCESS.bus protocol supported by the device. Usually "monitor".
> +
> +- idType
> +ACCESS.bus device subtype. Usually "LCD" or "CRT".
> +
> +- idModel
> +ACCESS.bus device model identifier. Usually a shortened form of the
> +device model name.
> +
> +- idVendor
> +ACCESS.bus device vendor identifier. Empty if the Identification command
> +is not supported.
> +
> +- idModule
> +ACCESS.bus device module identifier. Empty if the Identification command
> +is not supported.
> +
> +- idSerial
> +32 bit device number. A fixed serial number if it's positive, a temporary
> +serial number if negative and zero if the
> +Identification command is not supported.

All of these belong in the Documentation/ABI/ file, not here.

> +
> +- modalias
> +A combined identifier for driver selection. It has the form:
> +ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
> +All non-alphanumeric characters (including whitespace) in the model,
> +vendor or module parts are replaced by underscores to prevent issues
> +with software like systemd-udevd.
> +
> +3. Character device interface
> +=============================
> +For each DDC/CI device a character device in
> +/dev/bus/ddcci/[I�C bus number]/ is created.
> +
> +The main device on the bus is named display.
> +
> +Internal dependent devices are named i[hex address]
> +
> +External dependent devices are named e[hex address]

So how many characters devices are created?

Why do they have to be character devices?

> +
> +These character devices can be used to issue commands to a DDC/CI device
> +more easily than over i2c-dev devices. They should be opened unbuffered and
> +may be opened with O_EXCL if you want exclusive access. To send a command just
> +write the command byte and the arguments with a single write() operation.
> +The length byte and checksum are automatically calculated.
> +
> +To read a response use read() with a buffer big enough for the expected answer.
> +
> +NOTE: The maximum length of a DDC/CI message is 127 bytes.

What userspace code interacts through these character devices?  Do you
have a link to that code somewhere so we can be sure that the kernel is
doing it properly?

What is userspace going to do here?

> +
> +4. ddcci-backlight (monitor backlight driver)
> +=============================================
> +For each monitor that supports accessing the Backlight Level White
> +or the Luminance property, a backlight device of type "raw" named like the
> +corresponding ddcci device is created. You can find them in /sys/class/backlight/.
> +For convenience a symlink "ddcci_backlight" on the device associated with the
> +display connector in /sys/class/drm/ to the backlight device is created, as
> +long as the graphics driver allows to make this association.
> +

This shouldn't be a special ddcci thing, it's the same for all
backlights, right?



> +5. Limitations
> +==============
> +
> +-Dependent devices (sub devices using DDC/CI directly wired to the monitor,
> +like  Calibration devices, IR remotes, etc.) aren't automatically detected.
> +You can force detection of external dependent devices by writing
> +"ddcci-dependent [address]" into /sys/bus/i2c/i2c-?/new_device.
> +
> +There is no direct synchronization if you manually change the luminance
> +with the buttons on your monitor, as this can only be realized through polling
> +and some monitors close their OSD every time a DDC/CI command is received.
> +
> +Monitor hotplugging is not detected. You need to detach/reattach the I�C driver or reload the module.

Line length.


> +
> +6. Debugging
> +============
> +Both drivers use the dynamic debugging feature of the Linux kernel.
> +To get detailed debugging messages, set the dyndbg module parameter.
> +If you want to enable debugging permanently across reboots, create a file
> +/etc/modprobe.d/ddcci.conf containing lines like the following before loading the modules:
> +
> +options ddcci dyndbg
> +options ddcci-backlight dyndbg
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 740811893c57..2449c17e1080 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -451,4 +451,15 @@ config RANDOM_TRUST_BOOTLOADER
>  	pool. Otherwise, say N here so it will be regarded as device input that
>  	only mixes the entropy pool.
>  
> +config DDCCI
> +	tristate "DDCCI display protocol support"
> +	depends on I2C
> +	help
> +	  Display Data Channel Command Interface is an
> +	  interface that allows the kernel to "talk"
> +	  to most displays made after 2005. Check your
> +	  display's specification to see if it has
> +	  support for this. This depends on I2C to
> +	  compile.
> +
>  endmenu
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 264eb398fdd4..eaa2d58d50df 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel character device drivers.
>  #
>  
> +obj-$(CONFIG_DDCCI)				+= ddcci.o
>  obj-y				+= mem.o random.o
>  obj-$(CONFIG_TTY_PRINTK)	+= ttyprintk.o
>  obj-y				+= misc.o
> diff --git a/drivers/char/ddcci.c b/drivers/char/ddcci.c
> new file mode 100644
> index 000000000000..d3ec4160708f
> --- /dev/null
> +++ b/drivers/char/ddcci.c
> @@ -0,0 +1,1887 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  DDC/CI sub-bus driver
> + *
> + *  Copyright (c) 2015 Christoph Grenz
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.

This does not match the SPDX line.  Please fix up first before going any
further.


> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Should not be needed if this is a driver.  Only use dev_* calls.


> +#include <linux/fcntl.h>
> +#include <linux/cdev.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +#include <linux/sem.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/version.h>
> +
> +#include <linux/ddcci.h>
> +
> +#define DDCCI_RECV_BUFFER_SIZE 130
> +#define DEVICE_NAME "ddcci"
> +#define DDCCI_MAX_CAP_CHUNKS 200
> +
> +static unsigned int delay = 60;
> +static unsigned short autoprobe_addrs[127] = {0xF0, 0xF2, 0xF4, 0xF6, 0xF8};
> +static int autoprobe_addr_count = 5;

Shouldn't these be per-device?

> +
> +static dev_t ddcci_cdev_first;
> +static dev_t ddcci_cdev_next;
> +static dev_t ddcci_cdev_end;

Only 3 character devices no matter how many devices in the system?  This
feels wrong.

> +static DEFINE_MUTEX(core_lock);
> +
> +struct bus_type ddcci_bus_type;
> +EXPORT_SYMBOL_GPL(ddcci_bus_type);
> +
> +/* Assert neccessary string array sizes  */
> +#ifndef sizeof_field
> +# define sizeof_field(t, m) FIELD_SIZEOF(t, m)
> +#endif
> +static_assert(sizeof_field(struct ddcci_device, prot) > 8);
> +static_assert(sizeof_field(struct ddcci_device, type) > 8);
> +static_assert(sizeof_field(struct ddcci_device, model) > 8);
> +static_assert(sizeof_field(struct ddcci_device, vendor) > 8);
> +static_assert(sizeof_field(struct ddcci_device, module) > 8);
> +
> +/* Internal per-i2c-client driver data */
> +struct ddcci_bus_drv_data {
> +	unsigned long quirks;
> +	struct i2c_client *i2c_dev;
> +	struct mutex mut;
> +	unsigned char recv_buffer[DDCCI_RECV_BUFFER_SIZE];
> +};
> +
> +/* Replace non-alphanumeric characters in a string (used for modalias) */
> +static void ddcci_modalias_clean(char *string, size_t n, char replacement)
> +{
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		char c = string[i];
> +
> +		if (c == 0)
> +			return;
> +		else if (c < '0' || (c > '9' && c < 'A') || (c > 'Z' && c < 'a') || c > 'z')

isalpha()?


> +			string[i] = replacement;
> +	}
> +}
> +
> +/* Write a message to the DDC/CI bus using i2c_smbus_write_byte() */
> +static int __ddcci_write_bytewise(struct i2c_client *client, unsigned char addr,
> +				  bool p_flag, const unsigned char *__restrict buf,

What is __restrict here for?

> +				  unsigned char len)
> +{
> +	int ret = 0;
> +	unsigned char outer_addr = (unsigned char) (client->addr << 1);
> +	unsigned int xor = outer_addr; /* initial xor value */
> +
> +	/* Consistency checks */
> +	if (len > 127)
> +		return -EINVAL;

Why is 127 the limit?

> +
> +	/* Special case: reply to 0x6E is always 0x51 */
> +	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
> +		addr = DDCCI_HOST_ADDR_ODD;
> +	} else {
> +		/* When sending the odd address is used */
> +		addr = addr | 1;
> +	}
> +
> +	/* first byte: sender address */
> +	xor ^= addr;
> +	ret = i2c_smbus_write_byte(client, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* second byte: protocol flag and message size */
> +	xor ^= ((p_flag << 7) | len);
> +	ret = i2c_smbus_write_byte(client, (p_flag << 7) | len);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* send payload */
> +	while (len--) {
> +		xor ^= (*buf);
> +		ret = i2c_smbus_write_byte(client, (*buf));
> +		if (ret < 0)
> +			return ret;
> +		buf++;
> +	}
> +
> +	/* send checksum */
> +	ret = i2c_smbus_write_byte(client, xor);
> +	return ret;
> +}
> +
> +/* Write a message to the DDC/CI bus using i2c_master_send() */
> +static int __ddcci_write_block(struct i2c_client *client, unsigned char addr,
> +			       unsigned char *sendbuf, bool p_flag,
> +			       const unsigned char *data, unsigned char len)
> +{
> +	unsigned char outer_addr = (unsigned char) (client->addr << 1);
> +	unsigned int xor = outer_addr;	/* initial xor value */
> +	unsigned char *ptr = sendbuf;
> +
> +	/* Consistency checks */
> +	if (len > 127)
> +		return -EINVAL;
> +
> +	/* Special case: sender to 0x6E is always 0x51 */
> +	if (addr == DDCCI_DEFAULT_DEVICE_ADDR) {
> +		addr = DDCCI_HOST_ADDR_ODD;
> +	} else {
> +		/* When sending the odd address is used */
> +		addr = addr | 1;
> +	}
> +
> +	/* first byte: sender address */
> +	xor ^= addr;
> +	*(ptr++) = addr;
> +	/* second byte: protocol flag and message size */
> +	xor ^= ((p_flag << 7) | len);
> +	*(ptr++) = (p_flag << 7) | len;
> +	/* payload */
> +	while (len--) {
> +		xor ^= (*data);
> +		*(ptr++) = (*data);
> +		data++;
> +	}
> +	/* checksum */
> +	(*ptr) = xor;
> +
> +	/* Send it */
> +	return i2c_master_send(client, sendbuf, ptr - sendbuf + 1);
> +}
> +
> +/*
> + * Write a message to the DDC/CI bus.
> + *
> + * You must hold the bus mutex when calling this function.
> + */
> +static int ddcci_write(struct i2c_client *client, unsigned char addr,
> +		       bool p_flag, const unsigned char *data,
> +		       unsigned char len)
> +{
> +	struct ddcci_bus_drv_data *drv_data;
> +	unsigned char *sendbuf;
> +	int ret;
> +
> +	drv_data = i2c_get_clientdata(client);
> +
> +
> +	pr_debug("sending to %d:%02x:%02x: %*ph\n", client->adapter->nr,
> +		 client->addr << 1, addr, len, data);
> +	if (drv_data->quirks & DDCCI_QUIRK_WRITE_BYTEWISE) {
> +		ret = __ddcci_write_bytewise(client, addr, p_flag, data, len);
> +	} else {
> +		sendbuf = drv_data->recv_buffer;
> +		ret = __ddcci_write_block(client, addr, sendbuf, p_flag, data, len);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Read a response from the DDC/CI bus with headers directly into a buffer.
> + * Always check for DDCCI_QUIRK_SKIP_FIRST_BYTE when using this function.
> + * The returned length contains the whole unmodified response.
> + * If -EMSGSIZE is returned, the buffer contains the response up to `len`.
> + * If any other negative error code is returned, the buffer content is
> + * unspecified.
> + */
> +static int __ddcci_read(struct i2c_client *client, unsigned char addr,
> +			bool p_flag, unsigned long quirks, unsigned char *buf,
> +			unsigned char len)
> +{
> +	int i, payload_len, packet_length, ret;
> +	unsigned char xor = DDCCI_HOST_ADDR_EVEN;
> +
> +	/* Consistency checks */
> +	if (len < 3)
> +		return -EINVAL;
> +
> +	/* Read frame */
> +	ret = i2c_master_recv(client, buf, len);
> +	if (ret < 0)
> +		goto out_err;
> +	packet_length = ret;
> +
> +	/* Skip first byte if quirk active */
> +	if ((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE) && ret > 0 && len > 0) {
> +		ret--;
> +		len--;
> +		buf++;
> +	}
> +
> +	/* If answer too short (= incomplete) break out */
> +	if (ret < 3) {
> +		ret = -EIO;
> +		goto out_err;
> +	}
> +
> +	/* validate first byte */
> +	if (buf[0] != addr) {
> +		ret = (buf[0] == '\0') ? -EAGAIN : -EIO;
> +		goto out_err;
> +	}
> +
> +	/* validate second byte (protocol flag) */
> +	if ((buf[1] & 0x80) != (p_flag << 7)) {
> +		if (!p_flag || !(quirks & DDCCI_QUIRK_NO_PFLAG)) {
> +			ret = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* get and check payload length */
> +	payload_len = buf[1] & 0x7F;
> +	if (3 + payload_len > packet_length)
> +		return -EBADMSG;
> +	if (3 + payload_len > len)
> +		return -EMSGSIZE;
> +
> +	/* calculate checksum */
> +	for (i = 0; i < 3 + payload_len; i++)
> +		xor ^= buf[i];
> +
> +	/* verify checksum */
> +	if (xor != 0) {
> +		dev_err(&client->dev, "invalid DDC/CI response, corrupted data - xor is 0x%02x, length 0x%02x\n",
> +			xor, payload_len);
> +		ret = -EBADMSG;
> +		goto out_err;
> +	}
> +
> +	/* return result */
> +	ret = payload_len + 3 + ((quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE) ? 1:0);
> +
> +out_err:
> +	return ret;
> +}
> +
> +/*
> + * Read a response from the DDC/CI bus
> + *
> + * You must hold the bus mutex when calling this function.
> + */
> +static int ddcci_read(struct i2c_client *client, unsigned char addr,
> +		      bool p_flag, unsigned char *buf, unsigned char len)
> +{
> +	struct ddcci_bus_drv_data *drv_data;
> +	unsigned char *recvbuf;
> +	int ret;
> +
> +	drv_data = i2c_get_clientdata(client);
> +	recvbuf = drv_data->recv_buffer;
> +
> +	/* Read frame */
> +	ret = __ddcci_read(client, addr, p_flag,
> +		drv_data->quirks, recvbuf, DDCCI_RECV_BUFFER_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (drv_data->quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)
> +		recvbuf++;
> +
> +	/* return result */
> +	if (buf) {
> +		if (ret > 3) {
> +			ret = ret-3;
> +			/* copy to caller buffer */
> +			memcpy(buf, &recvbuf[2], (ret < len) ? ret : len);
> +
> +			if (ret > len) {
> +				/* if message was truncated, return -EMSGSIZE */
> +				pr_debug("received from %d:%02x:%02x: [%u/%u] %*ph ...\n",
> +					 client->adapter->nr, client->addr << 1,
> +					 addr, ret, len, len, buf);
> +				ret = -EMSGSIZE;
> +			} else {
> +				pr_debug("received from %d:%02x:%02x: [%u/%u] %*ph\n",
> +					 client->adapter->nr, client->addr << 1,
> +					 addr, ret, len, ret, buf);
> +			}
> +		}
> +	}
> +	if (!(drv_data->quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
> +		/* second read to clear buffers, needed on some devices */
> +		__ddcci_read(client, addr, true, drv_data->quirks, recvbuf, 1);
> +	}
> +	return ret;
> +}
> +
> +/* Request the capability string for a device and put it into buf */
> +static int ddcci_get_caps(struct i2c_client *client, unsigned char addr,
> +			  unsigned char *buf, unsigned int len)
> +{
> +	int result = 0, counter = 0, offset = 0;
> +	unsigned char cmd[3] = { DDCCI_COMMAND_CAPS, 0x00, 0x00 };
> +	unsigned char *chunkbuf = kzalloc(35, GFP_KERNEL);
> +
> +	if (!chunkbuf)
> +		return -ENOMEM;
> +
> +	do {
> +		/* Send command */
> +		result = ddcci_write(client, addr, true, cmd, sizeof(cmd));
> +		if (result < 0)
> +			goto err_free;
> +		msleep(delay);
> +		/* read result chunk */
> +		result = ddcci_read(client, addr, true, chunkbuf,
> +				    (len > 32) ? 35 : len + 3);
> +		if (result < 0)
> +			goto err_free;
> +
> +		if (result > 0) {
> +			/* check chunk header */
> +			if (chunkbuf[0] != DDCCI_REPLY_CAPS) {
> +				result = -EIO;
> +				goto err_free;
> +			}
> +			if (chunkbuf[1] != cmd[1] || chunkbuf[2] != cmd[2]) {
> +				result = -EIO;
> +				goto err_free;
> +			}
> +			if (result < 3) {
> +				result = -EIO;
> +				goto err_free;
> +			}
> +			memcpy(buf, chunkbuf + 3, min((unsigned int)result - 3, len));
> +
> +			counter++;
> +			/* adjust offset, etc. */
> +			offset += result-3;
> +			len -= result-3;
> +			buf += result-3;
> +			cmd[1] = offset >> 8;
> +			cmd[2] = offset & 0xFF;
> +			/* Another superfluous read to make some devices happy... */
> +			ddcci_read(client, addr, true, NULL, 2);
> +		}
> +	} while (result > 3 && counter < DDCCI_MAX_CAP_CHUNKS);
> +
> +	kfree(chunkbuf);
> +	return offset + result-3;
> +err_free:
> +	kfree(chunkbuf);
> +	return result;
> +}
> +
> +/*
> + * Request the device identification and put it into buf.
> + *
> + * Also detects all communication quirks and sets the corresponding flags
> + * in the ddcci_bus_drv_data structure associated with client.
> + *
> + * The identification command will fail on most DDC devices, as it is optional
> + * to support, but even the "failed" response suffices to detect quirks.
> + */
> +static int ddcci_identify_device(struct i2c_client *client, unsigned char addr,
> +				 unsigned char *buf, unsigned char len)
> +{
> +	int i, payload_len, ret = -ENODEV;
> +	unsigned long quirks;
> +	unsigned char cmd[1] = { DDCCI_COMMAND_ID };
> +	unsigned char *buffer;
> +	unsigned char xor = DDCCI_HOST_ADDR_EVEN;
> +	struct ddcci_bus_drv_data *bus_drv_data;
> +
> +	bus_drv_data = i2c_get_clientdata(client);
> +	quirks = bus_drv_data->quirks;
> +	buffer = bus_drv_data->recv_buffer;
> +
> +	/* Send Identification command */
> +	if (!(quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
> +		ret = __ddcci_write_block(client, addr, buffer, true, cmd, sizeof(cmd));
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] writing identification command in block mode: %d\n",
> +			client->addr << 1, addr, ret);
> +		if ((ret == -ENXIO)
> +		    && i2c_check_functionality(client->adapter,
> +					       I2C_FUNC_SMBUS_WRITE_BYTE)) {
> +			quirks |= DDCCI_QUIRK_WRITE_BYTEWISE;
> +			dev_info(&client->dev,
> +				"DDC/CI bus quirk detected: writes must be done bytewise\n");
> +			/* Some devices need writing twice after a failed blockwise write */
> +			__ddcci_write_bytewise(client, addr, true, cmd, sizeof(cmd));
> +			msleep(delay);
> +		}
> +	}
> +	if (ret < 0 && (quirks & DDCCI_QUIRK_WRITE_BYTEWISE)) {
> +		ret = __ddcci_write_bytewise(client, addr, true, cmd, sizeof(cmd));
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] writing identification command in bytewise mode: %d\n",
> +			client->addr << 1, addr, ret);
> +	}
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	/* Wait */
> +	msleep(delay);
> +
> +	/* Receive response */
> +	ret = i2c_master_recv(client, buffer, DDCCI_RECV_BUFFER_SIZE);
> +	if (ret < 0) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] receiving identification response resulted in errno %d\n",
> +			client->addr << 1, addr, ret);
> +		return ret;
> +	}
> +
> +	if (ret == 0) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] no identification response received\n",
> +			client->addr << 1, addr);
> +		return ret;
> +	}
> +
> +	/* Skip first byte if quirk already active */
> +	if (quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE && ret > 1) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] doubled first byte quirk in effect\n",
> +			client->addr << 1, addr);
> +		ret--;
> +		buffer++;
> +	}
> +
> +	/* If answer too short (= incomplete) break out */
> +	if (ret < 3) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] identification response is too short (%d bytes)\n",
> +			client->addr << 1, addr, ret);
> +		return -EIO;
> +	}
> +
> +	/* validate first byte */
> +	if (buffer[0] != addr) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] identification response: %*ph\n",
> +			client->addr << 1, addr, (ret > 32 ? 32 : ret), buffer);
> +
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] identification response invalid (expected first byte %02x, got %02x)\n",
> +			client->addr << 1, addr, addr, buffer[0]);
> +		return -ENODEV;
> +	}
> +
> +	/* Check if first byte is doubled (QUIRK_SKIP_FIRST_BYTE) */
> +	if (!(quirks & DDCCI_QUIRK_SKIP_FIRST_BYTE)) {
> +		if (buffer[0] == buffer[1]) {
> +			quirks |= DDCCI_QUIRK_SKIP_FIRST_BYTE;
> +			dev_info(&client->dev,
> +				"DDC/CI bus quirk detected: doubled first byte on read\n");
> +			ret--;
> +			buffer++;
> +			if (ret < 3)
> +				return -EIO;
> +		}
> +	}
> +
> +	/* validate second byte (protocol flag) */
> +	if ((buffer[1] & 0x80) != 0x80 && !(quirks & DDCCI_QUIRK_NO_PFLAG)) {
> +		dev_info(&client->dev,
> +			"DDC/CI bus quirk detected: device omits protocol flag on responses\n");
> +		quirks |= DDCCI_QUIRK_NO_PFLAG;
> +	}
> +
> +	/* get and check payload length */
> +	payload_len = buffer[1] & 0x7F;
> +	if (3 + payload_len > ret) {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] identification response: %*ph ...\n",
> +			client->addr << 1, addr, ret, buffer);
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] identification response was truncated (expected %d bytes, got %d)\n",
> +			client->addr << 1, addr, 3+payload_len, ret);
> +		return -EBADMSG;
> +	}
> +
> +	dev_dbg(&client->dev,
> +		"[%02x:%02x] identification response: %*ph\n",
> +		client->addr << 1, addr, 3+payload_len, buffer);
> +
> +	/* calculate checksum */
> +	for (i = 0; i < 3 + payload_len; i++)
> +		xor ^= buffer[i];
> +
> +	/* verify checksum */
> +	if (xor != 0) {
> +		dev_err(&client->dev,
> +			"[%02x:%02x] invalid DDC/CI response, corrupted data - xor is 0x%02x, length 0x%02x\n",
> +			client->addr << 1, addr, xor, payload_len);
> +		return -EBADMSG;
> +	}
> +
> +	/* save quirks */
> +	bus_drv_data->quirks = quirks;
> +
> +	/* return result */
> +	if (payload_len <= len) {
> +		ret = payload_len;
> +		memcpy(buf, &buffer[2], payload_len);
> +	} else {
> +		ret = -EMSGSIZE;
> +		memcpy(buf, &buffer[2], len);
> +	}
> +	return ret;
> +}
> +
> +/* Character device */
> +
> +/* Data structure for an open file handle */
> +struct ddcci_fp_data {
> +	struct ddcci_device *dev;
> +	bool exclusive;
> +	unsigned char buffer[129];
> +};
> +
> +/* Called when the character device is opened */
> +static int ddcci_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct ddcci_device *dev = container_of(inode->i_cdev,
> +						struct ddcci_device, cdev);
> +	struct ddcci_fp_data *fp_data = NULL;
> +
> +	fp_data = kzalloc(sizeof(struct ddcci_fp_data), GFP_KERNEL);
> +
> +	if (!fp_data)
> +		return -ENOMEM;
> +
> +	fp_data->exclusive = filp->f_flags & O_EXCL;
> +
> +	if (fp_data->exclusive) {
> +		if (down_write_trylock(&dev->cdev_sem) == 0) {
> +			kfree(fp_data);
> +			return -EBUSY;
> +		}
> +	} else {
> +		if (down_read_trylock(&dev->cdev_sem) == 0) {
> +			kfree(fp_data);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	fp_data->dev = dev;
> +	filp->private_data = fp_data;
> +
> +	return 0;
> +}
> +
> +/* Called when the character device is closed */
> +static int ddcci_cdev_close(struct inode *inode, struct file *filp)
> +{
> +	struct ddcci_fp_data *fp_data = filp->private_data;
> +	struct ddcci_device *dev = fp_data->dev;
> +
> +	if (fp_data->exclusive)
> +		up_write(&dev->cdev_sem);
> +	else
> +		up_read(&dev->cdev_sem);

So userspace can hold a lock with the open file descriptor?

That's not ok.


> +
> +	filp->private_data = NULL;
> +	kfree(fp_data);
> +	return 0;
> +}
> +
> +/* Called when reading from the character device */
> +static ssize_t ddcci_cdev_read(struct file *filp, char __user *buffer,
> +			       size_t length, loff_t *offset)
> +{
> +	struct ddcci_fp_data *fp_data = filp->private_data;
> +	struct ddcci_device *dev = fp_data->dev;
> +	unsigned char *buf = fp_data->buffer;
> +	const bool nonblocking = (filp->f_flags & O_NONBLOCK) != 0;
> +	int ret = 0;
> +
> +	if ((filp->f_mode & FMODE_READ) == 0)
> +		return -EBADF;
> +
> +	/* Lock mutex */
> +	if (nonblocking) {
> +		if (mutex_trylock(&dev->bus_drv_data->mut))
> +			return -EAGAIN;
> +	} else {
> +		if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
> +			return -ERESTARTSYS;
> +	}
> +
> +	/* Execute read */
> +	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, true, buf,
> +			 length);
> +
> +	if (ret > 0) {
> +		/* Copy data from user space */
> +		if (copy_to_user(buffer, buf, ret)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&dev->bus_drv_data->mut);
> +	return ret;
> +}
> +
> +/* Called when writing to the character device */
> +static ssize_t ddcci_cdev_write(struct file *filp, const char __user *buffer,
> +				size_t count, loff_t *offset)
> +{
> +	struct ddcci_fp_data *fp_data = filp->private_data;
> +	struct ddcci_device *dev = fp_data->dev;
> +	unsigned char *buf = fp_data->buffer;
> +	const bool nonblocking = (filp->f_flags & O_NONBLOCK) != 0;
> +	int ret = 0;
> +
> +	if ((filp->f_mode & FMODE_WRITE) == 0)
> +		return -EBADF;
> +
> +	if (count > 127)
> +		return -EINVAL;
> +
> +	/* Lock mutex */
> +	if (nonblocking) {
> +		if (mutex_trylock(&dev->bus_drv_data->mut))
> +			return -EAGAIN;
> +	} else {
> +		if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
> +			return -ERESTARTSYS;
> +	}
> +
> +	if (count > 0) {
> +		/* Copy data from user space */
> +		if (copy_from_user(buf, buffer, count)) {
> +			ret = -EFAULT;
> +			goto err_out;
> +		}
> +
> +		/* Execute write */
> +		ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr,
> +				  true, buf, count);
> +	}
> +
> +	if (ret >= 0) {
> +		msleep(delay);
> +		mutex_unlock(&dev->bus_drv_data->mut);
> +		return count;
> +	}
> +
> +err_out:
> +	mutex_unlock(&dev->bus_drv_data->mut);
> +	return ret;
> +}
> +
> +/* Called when seeking the character device */
> +static loff_t ddcci_cdev_seek(struct file *filp, loff_t offset, int anchor)
> +{
> +	return -EINVAL;

Not needed, just do not have it.

> +}
> +
> +static const struct file_operations ddcci_fops = {
> +	.owner = THIS_MODULE,
> +	.read = ddcci_cdev_read,
> +	.write = ddcci_cdev_write,
> +	.open = ddcci_cdev_open,
> +	.release = ddcci_cdev_close,
> +	.llseek = ddcci_cdev_seek
> +};
> +
> +/* Set up the character device for a DDC/CI device */
> +static int ddcci_setup_char_device(struct ddcci_device *device)
> +{
> +	int ret = -EINVAL;
> +
> +	/* Check if free minor exists */
> +	if (ddcci_cdev_next == ddcci_cdev_end) {
> +		dev_err(&device->dev, "no free major/minor\n");
> +		ret = -ENFILE;
> +		goto out;
> +	}
> +
> +	/* Initialize rwsem */
> +	init_rwsem(&device->cdev_sem);
> +
> +	/* Initialize character device node */
> +	cdev_init(&device->cdev, &ddcci_fops);
> +	device->cdev.owner = THIS_MODULE;
> +
> +	/* Publish char device */
> +	device->dev.devt = ddcci_cdev_next;
> +	ret = cdev_add(&device->cdev, ddcci_cdev_next, 1);
> +	if (ret) {
> +		device->dev.devt = 0;
> +		goto out;
> +	}
> +
> +	ddcci_cdev_next++;
> +out:
> +	return ret;
> +}
> +
> +/* sysfs attributes */
> +
> +static ssize_t ddcci_attr_capabilities_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {
> +		len = device->capabilities_len;
> +		if (len > PAGE_SIZE)
> +			len = PAGE_SIZE;
> +		if (len == 0) {
> +			ret = len;
> +		} else {
> +			memcpy(buf, device->capabilities, len);
> +			if (len < PAGE_SIZE) {
> +				buf[len] = '\n';
> +				ret = len + 1;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_prot_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {
> +		len = strnlen(device->prot, sizeof(device->prot));
> +		strncpy(buf, device->prot, PAGE_SIZE);
> +		if (len == 0) {
> +			ret = len;
> +		} else if (len < PAGE_SIZE) {
> +			buf[len] = '\n';
> +			ret = len + 1;
> +		} else {
> +			ret = PAGE_SIZE;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_type_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {
> +		len = strnlen(device->type, sizeof(device->type));
> +		strncpy(buf, device->type, PAGE_SIZE);
> +		if (len == 0) {
> +			ret = len;
> +		} else if (len < PAGE_SIZE) {
> +			buf[len] = '\n';
> +			ret = len + 1;
> +		} else {
> +			ret = PAGE_SIZE;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_model_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {
> +		len = strnlen(device->model, sizeof(device->model));
> +		strncpy(buf, device->model, PAGE_SIZE);
> +		if (len == 0) {
> +			ret = len;
> +		} else if (len < PAGE_SIZE) {
> +			buf[len] = '\n';
> +			ret = len + 1;
> +		} else {
> +			ret = PAGE_SIZE;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_vendor_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {
> +		len = strnlen(device->vendor, sizeof(device->vendor));
> +		strncpy(buf, device->vendor, PAGE_SIZE);
> +		if (len == 0) {
> +			ret = len;
> +		} else if (len < PAGE_SIZE) {
> +			buf[len] = '\n';
> +			ret = len+1;
> +		} else {
> +			ret = PAGE_SIZE;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_module_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	size_t len;
> +
> +	if (device != NULL) {

How can this ever fail?

> +		len = strnlen(device->module, sizeof(device->module));
> +		strncpy(buf, device->module, PAGE_SIZE);
> +		if (len == 0) {
> +			ret = len;
> +		} else if (len < PAGE_SIZE) {
> +			buf[len] = '\n';
> +			ret = len + 1;
> +		} else {
> +			ret = PAGE_SIZE;
> +		}
> +	}
> +	return ret;

Just use sysfs_emit() please.  Should make all of these much simpler.

> +}
> +
> +static ssize_t ddcci_attr_serial_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +
> +	if (device != NULL)
> +		ret = scnprintf(buf, PAGE_SIZE, "%d\n", device->device_number);
> +
> +	return ret;
> +}
> +
> +static ssize_t ddcci_attr_modalias_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct ddcci_device *device = ddcci_verify_device(dev);
> +	ssize_t ret = -ENOENT;
> +	char model[ARRAY_SIZE(device->model)];
> +	char vendor[ARRAY_SIZE(device->model)];
> +	char module[ARRAY_SIZE(device->model)];
> +
> +	if (device != NULL) {
> +		memcpy(model, device->model, sizeof(model));
> +		memcpy(vendor, device->vendor, sizeof(vendor));
> +		memcpy(module, device->module, sizeof(module));
> +		ddcci_modalias_clean(model, sizeof(model), '_');
> +		ddcci_modalias_clean(vendor, sizeof(vendor), '_');
> +		ddcci_modalias_clean(module, sizeof(module), '_');
> +
> +		ret = scnprintf(buf, PAGE_SIZE, "%s%s-%s-%s-%s-%s\n",
> +			DDCCI_MODULE_PREFIX,
> +			device->prot,
> +			device->type,
> +			model,
> +			vendor,
> +			module
> +		);
> +	}
> +	return ret;

This should not be needed in sysfs.  What tool wants this?

> +}
> +
> +static DEVICE_ATTR(capabilities, 0444, ddcci_attr_capabilities_show, NULL);
> +static DEVICE_ATTR(idProt, 0444, ddcci_attr_prot_show, NULL);
> +static DEVICE_ATTR(idType, 0444, ddcci_attr_type_show, NULL);
> +static DEVICE_ATTR(idModel, 0444, ddcci_attr_model_show, NULL);
> +static DEVICE_ATTR(idVendor, 0444, ddcci_attr_vendor_show, NULL);
> +static DEVICE_ATTR(idModule, 0444, ddcci_attr_module_show, NULL);
> +static DEVICE_ATTR(idSerial, 0444, ddcci_attr_serial_show, NULL);
> +static DEVICE_ATTR(modalias, 0444, ddcci_attr_modalias_show, NULL);

DEVICE_ATTR_RO()?

> +
> +static struct attribute *ddcci_char_device_attrs[] = {
> +	&dev_attr_capabilities.attr,
> +	&dev_attr_idProt.attr,
> +	&dev_attr_idType.attr,
> +	&dev_attr_idModel.attr,
> +	&dev_attr_idVendor.attr,
> +	&dev_attr_idModule.attr,
> +	&dev_attr_idSerial.attr,
> +	&dev_attr_modalias.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(ddcci_char_device);
> +
> +/* DDC/CI bus */
> +
> +static int ddcci_device_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct ddcci_device	*device = to_ddcci_device(dev);
> +	char model[ARRAY_SIZE(device->model)];
> +	char vendor[ARRAY_SIZE(device->vendor)];
> +	char module[ARRAY_SIZE(device->module)];
> +
> +	memcpy(model, device->model, sizeof(model));
> +	memcpy(vendor, device->vendor, sizeof(vendor));
> +	memcpy(module, device->module, sizeof(module));
> +	ddcci_modalias_clean(model, sizeof(model), '_');
> +	ddcci_modalias_clean(vendor, sizeof(vendor), '_');
> +	ddcci_modalias_clean(module, sizeof(module), '_');
> +
> +	if (add_uevent_var(env, "MODALIAS=%s%s-%s-%s-%s-%s",
> +			   DDCCI_MODULE_PREFIX,
> +			   device->prot,
> +			   device->type,
> +			   model,
> +			   vendor,
> +			   module
> +		))
> +		return -ENOMEM;
> +
> +	if (device->prot[0])
> +		if (add_uevent_var(env, "DDCCI_PROT=%s", device->prot))
> +			return -ENOMEM;
> +
> +	if (device->type[0])
> +		if (add_uevent_var(env, "DDCCI_TYPE=%s", device->type))
> +			return -ENOMEM;
> +
> +	if (device->model[0])
> +		if (add_uevent_var(env, "DDCCI_MODEL=%s", device->model))
> +			return -ENOMEM;
> +
> +	if (device->vendor[0]) {
> +		if (add_uevent_var(env, "DDCCI_VENDOR=%s", device->vendor))
> +			return -ENOMEM;
> +
> +		if (add_uevent_var(env, "DDCCI_MODULE=%s", device->module))
> +			return -ENOMEM;
> +
> +		if (add_uevent_var(env, "DDCCI_UNIQ=%d", device->device_number))
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ddcci_device_release(struct device *dev)
> +{
> +	struct ddcci_device *device = to_ddcci_device(dev);
> +	struct ddcci_driver *driver;
> +
> +	/* Notify driver */
> +	if (dev->driver) {
> +		driver = to_ddcci_driver(dev->driver);
> +		if (driver->remove)
> +			driver->remove(device);
> +	}
> +
> +	/* Teardown chardev */
> +	if (dev->devt) {
> +		mutex_lock(&core_lock);
> +		if (device->cdev.dev == ddcci_cdev_next-1)
> +			ddcci_cdev_next--;
> +		cdev_del(&device->cdev);
> +		mutex_unlock(&core_lock);
> +	}
> +
> +	/* Free capability string */
> +	if (device->capabilities) {
> +		device->capabilities_len = 0;
> +		kfree(device->capabilities);
> +	}
> +	/* Free device */
> +	kfree(device);
> +}
> +
> +static char *ddcci_devnode(struct device *dev,
> +			 umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	struct ddcci_device *device;
> +
> +	device = to_ddcci_device(dev);
> +	return kasprintf(GFP_KERNEL, "bus/ddcci/%d/display",
> +			 device->i2c_client->adapter->nr);
> +}
> +
> +static char *ddcci_dependent_devnode(struct device *dev,
> +			 umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	struct ddcci_device *device;
> +
> +	device = to_ddcci_device(dev);
> +	if (device->flags & DDCCI_FLAG_EXTERNAL) {
> +		if (device->outer_addr == device->inner_addr)
> +			return kasprintf(GFP_KERNEL, "bus/ddcci/%d/e%02x",
> +					 device->i2c_client->adapter->nr,
> +					 device->outer_addr);
> +		else
> +			return kasprintf(GFP_KERNEL, "bus/ddcci/%d/e%02x%02x",
> +					 device->i2c_client->adapter->nr,
> +					 device->outer_addr, device->inner_addr);
> +	} else {
> +		return kasprintf(GFP_KERNEL, "bus/ddcci/%d/i%02x",
> +				 device->i2c_client->adapter->nr,
> +				 device->inner_addr);
> +	}
> +}
> +
> +/* Device type for main DDC/CI devices*/
> +static struct device_type ddcci_device_type = {
> +	.name	= "ddcci-device",
> +	.uevent		= ddcci_device_uevent,
> +	.groups		= ddcci_char_device_groups,
> +	.release	= ddcci_device_release,
> +	.devnode	= ddcci_devnode
> +};
> +
> +/* Device type for dependent DDC/CI devices*/
> +static struct device_type ddcci_dependent_type = {
> +	.name	= "ddcci-dependent-device",
> +	.uevent		= ddcci_device_uevent,
> +	.groups		= ddcci_char_device_groups,
> +	.release	= ddcci_device_release,
> +	.devnode	= ddcci_dependent_devnode
> +};
> +
> +/**
> + * ddcci_verify_device - return parameter as ddcci_device, or NULL
> + * @dev: device, probably from some driver model iterator
> + */
> +struct ddcci_device *ddcci_verify_device(struct device *dev)
> +{
> +	if (!dev)
> +		return NULL;
> +	return (dev->type == &ddcci_device_type
> +		|| dev->type == &ddcci_dependent_type)
> +			? to_ddcci_device(dev)
> +			: NULL;
> +}
> +EXPORT_SYMBOL(ddcci_verify_device);
> +
> +/**
> + * ddcci_quirks - Get quirks for DDC/CI device
> + * @dev: Target DDC/CI device
> + */
> +unsigned long ddcci_quirks(struct ddcci_device *dev)
> +{
> +	if (WARN_ON(!dev))
> +		return ~0L;
> +	if (WARN_ON(!dev->bus_drv_data))
> +		return ~0L;
> +	return dev->bus_drv_data->quirks;
> +}
> +EXPORT_SYMBOL(ddcci_quirks);

Shouldn't all these exports be EXPORT_SYMBOL_GPL()?  I have to ask.


> +
> +/**
> + * ddcci_register_driver - register DDC/CI driver
> + * @owner: the owning module
> + * @driver: the driver to register
> + */
> +int ddcci_register_driver(struct module *owner, struct ddcci_driver *driver)
> +{
> +	int ret;
> +
> +	/* Can't register until after driver model init */
> +	if (WARN_ON(!ddcci_bus_type.p))

NEVER TOUCH .p in a type.  I should not have to rename it to
"do_not_think_of_looking_here", right?

This should not be needed.

> +		return -EAGAIN;
> +
> +	pr_debug("registering driver [%s]\n", driver->driver.name);
> +
> +	/* add the driver to the list of ddcci drivers in the driver core */
> +	driver->driver.owner = owner;
> +	driver->driver.bus = &ddcci_bus_type;
> +
> +	/* When registration returns, the driver core
> +	 * will have called probe() for all matching-but-unbound devices.
> +	 */
> +	ret = driver_register(&driver->driver);
> +	if (ret)
> +		return ret;
> +
> +	pr_debug("driver [%s] registered\n", driver->driver.name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ddcci_register_driver);
> +
> +/**
> + * ddcci_del_driver - unregister DDC/CI driver
> + * @driver: the driver being unregistered
> + */
> +void ddcci_del_driver(struct ddcci_driver *driver)
> +{
> +	driver_unregister(&driver->driver);
> +	pr_debug("driver [%s] unregistered\n", driver->driver.name);
> +}
> +EXPORT_SYMBOL(ddcci_del_driver);
> +
> +/**
> + * ddcci_device_write - Write a message to a DDC/CI device
> + * @dev: Target DDC/CI device
> + * @p_flag: Protocol flag, true for standard control messages
> + * @data: Data that will be written to the device
> + * @length: How many bytes to write
> + *
> + * Writes the message to the device and sleeps (see module parameter 'delay')
> + */
> +int ddcci_device_write(struct ddcci_device *dev, bool p_flag,
> +		       unsigned char *data, unsigned char length)
> +{
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
> +		return -EAGAIN;
> +
> +	ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, data, length);
> +	msleep(delay);
> +	mutex_unlock(&dev->bus_drv_data->mut);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ddcci_device_write);
> +
> +/**
> + * ddcci_device_read - Read a response from a DDC/CI device
> + * @dev: Target DDC/CI device
> + * @p_flag: Protocol flag, must match the corresponding write
> + * @buffer: Where to store data read from the device
> + * @length: Buffer size
> + */
> +int ddcci_device_read(struct ddcci_device *dev, bool p_flag,
> +		      unsigned char *buffer, unsigned char length)
> +{
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
> +		return -EAGAIN;
> +
> +	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, length);
> +	mutex_unlock(&dev->bus_drv_data->mut);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ddcci_device_read);
> +
> +/**
> + * ddcci_device_writeread - Write a message to a device and read the response
> + * @dev: Target DDC/CI device
> + * @p_flag: Protocol flag, true for standard control messages
> + * @buffer: Buffer used for write and read
> + * @length: How many bytes to write
> + * @maxlength: Buffer size on read
> + *
> + * Writing, sleeping and reading are done without releasing the DDC/CI bus.
> + * This provides atomicity in respect to other DDC/CI accesses on the same bus.
> + */
> +int ddcci_device_writeread(struct ddcci_device *dev, bool p_flag,
> +			   unsigned char *buffer, unsigned char length,
> +			   unsigned char maxlength)
> +{
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&dev->bus_drv_data->mut))
> +		return -EAGAIN;
> +
> +	ret = ddcci_write(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, length);
> +	if (ret < 0)
> +		goto err;
> +	msleep(delay);
> +	ret = ddcci_read(dev->bus_drv_data->i2c_dev, dev->inner_addr, p_flag, buffer, maxlength);
> +err:
> +	mutex_unlock(&dev->bus_drv_data->mut);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ddcci_device_writeread);
> +
> +#define IS_ANY_ID(x) (((x)[0] == -1) && ((x)[7] == -1))
> +
> +/* Check if any device id in the array matches the device and return the matching id */
> +static const struct ddcci_device_id *ddcci_match_id(const struct ddcci_device_id *id,
> +						    const struct ddcci_device *device)
> +{
> +	while (id->prot[0] || id->type[0] || id->model[0] || id->vendor[0] || id->module[0]) {
> +		if ((IS_ANY_ID(id->prot) || (strcmp(device->prot, id->prot) == 0))
> +		 && (IS_ANY_ID(id->type) || (strcmp(device->type, id->type) == 0))
> +		 && (IS_ANY_ID(id->model) || (strcmp(device->model, id->model) == 0))
> +		 && (IS_ANY_ID(id->vendor) || (strcmp(device->vendor, id->vendor) == 0))
> +		 && (IS_ANY_ID(id->module) || (strcmp(device->module, id->module) == 0))) {
> +			return id;
> +		}
> +		id++;
> +	}
> +	return NULL;
> +}
> +
> +static int ddcci_device_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct ddcci_device	*device = ddcci_verify_device(dev);
> +	struct ddcci_driver	*driver;
> +
> +	if (!device)
> +		return 0;
> +
> +	driver = to_ddcci_driver(drv);
> +	/* match on an id table if there is one */
> +	if (driver->id_table)
> +		return ddcci_match_id(driver->id_table, device) != NULL;
> +
> +	return 0;
> +}
> +
> +static int ddcci_device_probe(struct device *dev)
> +{
> +	struct ddcci_device	*device = ddcci_verify_device(dev);
> +	struct ddcci_driver	*driver;
> +	const struct ddcci_device_id *id;
> +	int ret = 0;
> +
> +	if (!device)
> +		return -EINVAL;
> +	driver = to_ddcci_driver(dev->driver);
> +
> +	id = ddcci_match_id(driver->id_table, device);
> +	if (!id)
> +		return -ENODEV;
> +
> +	if (driver->probe)
> +		ret = driver->probe(device, id);
> +
> +	return ret;
> +}
> +
> +static int ddcci_device_remove(struct device *dev)
> +{
> +	struct ddcci_device	*device = ddcci_verify_device(dev);
> +	struct ddcci_driver	*driver;
> +	int ret = 0;
> +
> +	if (!device)
> +		return -EINVAL;
> +	driver = to_ddcci_driver(dev->driver);
> +
> +	if (driver->remove)
> +		ret = driver->remove(device);
> +
> +	return ret;
> +}
> +
> +static void ddcci_device_remove_void(struct device *dev)
> +{
> +	ddcci_device_remove(dev);
> +}


So you have a bus with drivers.  But you have no drivers for this?  We
need those as well, right?

> +
> +/**
> + * DDCCI bus type structure
> + */
> +struct bus_type ddcci_bus_type = {
> +	.name		= "ddcci",
> +	.match		= ddcci_device_match,
> +	.probe		= ddcci_device_probe,
> +	.remove		= ddcci_device_remove_void

Why "_void"?

> +};
> +
> +/* Main I2C driver */
> +
> +/* Get a pointer to the closing parenthesis */
> +static char *ddcci_capstr_tok(const char *s, int depth)
> +{
> +	const char *ptr = s;
> +	char *end;
> +
> +	if (s == NULL || s[0] == '\0')
> +		return NULL;
> +
> +	while ((end = strpbrk(ptr, "()"))) {
> +		if (!end || depth == INT_MAX)
> +			return NULL;
> +		if (*end == '(')
> +			depth++;
> +		else if (depth > 0)
> +			depth--;
> +		else
> +			break;
> +		ptr = end + 1;
> +	}
> +	return end;
> +}
> +
> +/**
> + * ddcci_find_capstr_item - Search capability string for a tag
> + * @capabilities: Capability string to search
> + * @tag: Tag to find
> + * @length: Buffer for the length of the found tag value (optional)
> + *
> + * Return a pointer to the start of the tag value (directly after the '(') on
> + * success and write the length of the value (excluding the ')') into `length`.
> + *
> + * If the tag is not found or another error occurs, an ERR_PTR is returned
> + * and `length` stays untouched.
> + */
> +const char *ddcci_find_capstr_item(const char *capabilities,
> +				   const char *__restrict tag,
> +				   size_t *length)
> +{
> +	const char *src = capabilities, *ptr;
> +	ptrdiff_t len;
> +	int taglen = strnlen(tag, 1024);
> +
> +	/* Check length of requested tag */
> +	if (taglen <= 0 || taglen > 1023)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Find tag */
> +	while (src && (strncmp(src + 1, tag, taglen) != 0 || src[1 + taglen] != '('))
> +		src = ddcci_capstr_tok(src + 1, -1);
> +	if (!src || src[0] == '\0')
> +		return ERR_PTR(-ENOENT);
> +
> +	/* Locate end of value */
> +	src += taglen + 2;
> +	ptr = ddcci_capstr_tok(src, 0);
> +	if (!ptr)
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	/* Check length of tag data */
> +	len = ptr-src;
> +	if (len < 0 || len > 65535)
> +		return ERR_PTR(-EMSGSIZE);
> +
> +	/* Return pointer and length */
> +	if (length != NULL)
> +		*length = (size_t)len;
> +	return src;
> +}
> +EXPORT_SYMBOL(ddcci_find_capstr_item);
> +
> +/* Search the capability string for a tag and copy the value to dest */
> +static int ddcci_cpy_capstr_item(char *dest, const char *src,
> +				  const char *__restrict tag, size_t maxlen)
> +{
> +	const char *ptr;
> +	size_t len;
> +
> +	/* Find tag */
> +	ptr = ddcci_find_capstr_item(src, tag, &len);
> +	if (IS_ERR(ptr))
> +		return PTR_ERR(ptr);
> +
> +	/* Copy value */
> +	memcpy(dest, ptr, min(len, maxlen));
> +	return 0;
> +}
> +
> +/* Fill fields in device by parsing the capability string */
> +static int ddcci_parse_capstring(struct ddcci_device *device)
> +{
> +	const char *capstr = device->capabilities;
> +	int ret = 0;
> +
> +	if (!capstr)
> +		return -EINVAL;
> +
> +	/* capability string start with a paren */
> +	if (capstr[0] != '(')
> +		return -EINVAL;
> +
> +	/* get prot(...) */
> +	ret = ddcci_cpy_capstr_item(device->prot, capstr, "prot", sizeof(device->prot)-1);
> +	if (ret) {
> +		if (ret == -ENOENT) {
> +			dev_warn(&device->dev, "malformed capability string: no protocol tag");
> +			memset(device->prot, 0, sizeof(device->prot)-1);
> +		} else {
> +			return ret;
> +		}
> +	}
> +
> +	/* get type(...) */
> +	ret = ddcci_cpy_capstr_item(device->type, capstr, "type", sizeof(device->type)-1);
> +	if (ret) {
> +		if (ret == -ENOENT) {
> +			dev_warn(&device->dev, "malformed capability string: no type tag");
> +			memset(device->type, 0, sizeof(device->type)-1);
> +		} else {
> +			return ret;
> +		}
> +	}
> +
> +	/* and then model(...) */
> +	ret = ddcci_cpy_capstr_item(device->model, capstr, "model", sizeof(device->model)-1);
> +	if (ret) {
> +		if (ret == -ENOENT) {
> +			dev_warn(&device->dev, "malformed capability string: no model tag");
> +			memset(device->model, 0, sizeof(device->model)-1);
> +		} else {
> +			return ret;
> +		}
> +	}
> +
> +	/* if there is no protocol tag */
> +	if (!device->prot[0]) {
> +		/* and no type tag: give up. */
> +		if (!device->type[0])
> +			return -ENOENT;
> +
> +		/* Assume protocol "monitor" if type is "LCD" or "CRT" */
> +		if (strncasecmp(device->type, "LCD", sizeof(device->type)-1) == 0
> +		 || strncasecmp(device->type, "CRT", sizeof(device->type)-1) == 0) {
> +			memcpy(device->prot, "monitor", 7);
> +		}
> +	}
> +
> +	/* skip the rest for now */
> +
> +	return 0;
> +}
> +
> +/* Probe for a device on an inner address and create a ddcci_device for it */
> +static int ddcci_detect_device(struct i2c_client *client, unsigned char addr,
> +			       int dependent)
> +{
> +	int ret;
> +	unsigned char outer_addr = client->addr << 1;
> +	unsigned char *buffer = NULL;
> +	struct ddcci_bus_drv_data *drv_data = i2c_get_clientdata(client);
> +	struct ddcci_device *device = NULL;
> +
> +	mutex_lock(&drv_data->mut);
> +
> +	/* Allocate buffer big enough for any capability string */
> +	buffer = kmalloc(16384, GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto err_end;
> +	}
> +
> +	/* Allocate device struct */
> +	device = kzalloc(sizeof(struct ddcci_device), GFP_KERNEL);
> +	if (!device) {
> +		ret = -ENOMEM;
> +		goto err_end;
> +	}
> +
> +	/* Initialize device */
> +	device_initialize(&device->dev);
> +	device->dev.parent = &client->dev;
> +	device->dev.bus = &ddcci_bus_type;
> +	device->outer_addr = outer_addr;
> +	device->inner_addr = addr;
> +	device->bus_drv_data = drv_data;
> +	device->i2c_client = client;
> +
> +	if (!dependent) {
> +		device->dev.type = &ddcci_device_type;
> +		ret = dev_set_name(&device->dev, "ddcci%d", client->adapter->nr);
> +	} else if (outer_addr == dependent) {
> +		/* Internal dependent device */
> +		device->dev.type = &ddcci_dependent_type;
> +		device->flags = DDCCI_FLAG_DEPENDENT;
> +		ret = dev_set_name(&device->dev, "ddcci%di%02x", client->adapter->nr, addr);
> +	} else if (outer_addr == addr) {
> +		/* External dependent device */
> +		device->dev.type = &ddcci_dependent_type;
> +		device->flags = DDCCI_FLAG_DEPENDENT | DDCCI_FLAG_EXTERNAL;
> +		ret = dev_set_name(&device->dev, "ddcci%de%02x", client->adapter->nr, addr);
> +	} else {
> +		/* Dependent device of external dependent device Just in case something like this exists */
> +		device->dev.type = &ddcci_dependent_type;
> +		device->flags = DDCCI_FLAG_DEPENDENT | DDCCI_FLAG_EXTERNAL;
> +		ret = dev_set_name(&device->dev, "ddcci%de%02x%02x", client->adapter->nr, outer_addr, addr);
> +	}
> +
> +	if (ret)
> +		goto err_free;
> +
> +	/* Read identification and check for quirks */
> +	ret = ddcci_identify_device(client, addr, buffer, 29);
> +	if (ret < 0) {
> +		if (!dependent && (ret == -EBADMSG || ret == -EMSGSIZE))
> +			dev_warn(&device->dev, "DDC/CI main device sent broken response on identification. Trying to detect solely based on capability information.\n");
> +		else
> +			goto err_free;
> +	}
> +
> +	if (ret == 29 && buffer[0] == DDCCI_REPLY_ID) {
> +		memcpy(device->vendor, &buffer[7], 8);
> +		memcpy(device->module, &buffer[17], 8);
> +		device->device_number = be32_to_cpu(*(__force __be32 *)&buffer[18]);
> +	}
> +
> +	/* Read capabilities */
> +	ret = ddcci_get_caps(client, addr, buffer, 16384);
> +	if (ret > 0) {
> +		/*
> +		 *	Fixup unparenthesized capability strings, but only if the first
> +		 *	character is an ascii lower case letter.
> +		 *	This should still allow an early exit for completely garbled
> +		 *	data but helps detecting devices where only the parentheses are
> +		 *	missing, as the second char must be the first character of a
> +		 *	keyword.
> +		 */
> +		if (ret > 2 && buffer[0] >= 'a' && buffer[0] <= 'z') {
> +			dev_err(&device->dev, "DDC/CI device quirk detected: unparenthesized capability string\n");
> +			device->capabilities = kzalloc(ret + 3, GFP_KERNEL);
> +			if (!device->capabilities) {
> +				ret = -ENOMEM;
> +				goto err_free;
> +			}
> +			device->capabilities_len = ret + 2;
> +			memcpy(&(device->capabilities[1]), buffer, ret);
> +			device->capabilities[0] = '(';
> +			device->capabilities[ret + 1] = ')';
> +		} else {
> +			/* Standard case: simply copy the received string */
> +			device->capabilities = kzalloc(ret + 1, GFP_KERNEL);
> +			if (!device->capabilities) {
> +				ret = -ENOMEM;
> +				goto err_free;
> +			}
> +			device->capabilities_len = ret;
> +			memcpy(device->capabilities, buffer, ret);
> +		}
> +
> +		ret = ddcci_parse_capstring(device);
> +		if (ret) {
> +			dev_err(&device->dev, "malformed capability string: \"%s\" errno %d\n", device->capabilities, ret);
> +			ret = -EINVAL;
> +			goto err_free;
> +		}
> +	}
> +
> +	/* Found a device if either identification or capabilities succeeded */
> +	if (!device->capabilities && device->vendor[0] == '\0') {
> +		dev_dbg(&client->dev,
> +			"[%02x:%02x] got neither valid identification nor capability data\n",
> +			client->addr << 1, addr);
> +		ret = -ENODEV;
> +		goto err_free;
> +	}
> +
> +	/* Setup chardev */
> +	mutex_lock(&core_lock);
> +	ret = ddcci_setup_char_device(device);
> +	mutex_unlock(&core_lock);
> +	if (ret)
> +		goto err_free;
> +
> +	/* Release mutex and add device to the tree */
> +	mutex_unlock(&drv_data->mut);
> +	pr_debug("found device at %d:%02x:%02x\n", client->adapter->nr, outer_addr, addr);
> +	ret = device_add(&device->dev);
> +	if (ret)
> +		goto err_free;
> +
> +	goto end;
> +err_free:
> +	put_device(&device->dev);
> +err_end:
> +	mutex_unlock(&drv_data->mut);
> +end:
> +	kfree(buffer);
> +	return ret;
> +}
> +
> +/* I2C detect function: check if a main or external dependent device exists */
> +static int ddcci_detect(struct i2c_client *client, struct i2c_board_info *info)
> +{
> +	int ret;
> +	unsigned char outer_addr;
> +	unsigned char inner_addr;
> +	unsigned char buf[32];
> +	unsigned char cmd_id[1] = { DDCCI_COMMAND_ID };
> +	unsigned char cmd_caps[3] = { DDCCI_COMMAND_CAPS, 0x00, 0x00};
> +	unsigned char *cmd;
> +	unsigned int cmd_len;
> +
> +	/* Check for i2c_master_* functionality */
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		pr_debug("i2c adapter %d unsuitable: no i2c_master functionality\n", client->adapter->nr);
> +		return -ENODEV;
> +	}
> +
> +	/* send Capabilities Request (for main) or Identification Request command (for dependent devices) */
> +	outer_addr = client->addr << 1;
> +	inner_addr = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? DDCCI_HOST_ADDR_ODD : outer_addr | 1;
> +	cmd = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? cmd_caps : cmd_id;
> +	cmd_len = (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? sizeof(cmd_caps) : sizeof(cmd_id);
> +	pr_debug("detecting %d:%02x\n", client->adapter->nr, outer_addr);
> +
> +	ret = __ddcci_write_block(client, inner_addr, buf, true, cmd, cmd_len);
> +
> +	if (ret == -ENXIO || ret == -EIO) {
> +		if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE)) {
> +			pr_debug("i2c write failed with ENXIO or EIO but bytewise writing is not supported\n");
> +			return -ENODEV;
> +		}
> +		pr_debug("i2c write failed with ENXIO or EIO, trying bytewise writing\n");
> +		ret = __ddcci_write_bytewise(client, inner_addr, true, cmd, cmd_len);
> +		if (ret == 0) {
> +			msleep(delay);
> +			ret = __ddcci_write_bytewise(client, inner_addr, true, cmd, cmd_len);
> +		}
> +	}
> +
> +	if (ret < 0)
> +		return -ENODEV;
> +
> +	/* wait for device */
> +	msleep(delay);
> +	/* receive answer */
> +	ret = i2c_master_recv(client, buf, 32);
> +	if (ret < 3) {
> +		pr_debug("detection failed: no answer\n");
> +		return -ENODEV;
> +	}
> +
> +	/* check response starts with outer addr */
> +	if (buf[0] != outer_addr) {
> +		pr_debug("detection failed: invalid %s response (%02x != %02x)\n", (cmd == cmd_id) ? "identification" : "capabilities", buf[0], outer_addr);
> +		pr_debug("received message was %*ph \n", ret, buf);
> +		return -ENODEV;
> +	}
> +
> +	pr_debug("detected %d:%02x\n", client->adapter->nr, outer_addr);
> +
> +	/* set device type */
> +	strlcpy(info->type, (outer_addr == DDCCI_DEFAULT_DEVICE_ADDR) ? "ddcci" : "ddcci-dependent", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +/* I2C probe function */
> +static int ddcci_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int i, ret = -ENODEV, tmp;
> +	unsigned char main_addr, addr;
> +	struct ddcci_bus_drv_data *drv_data;
> +
> +	/* Initialize driver data structure */
> +	drv_data = devm_kzalloc(&client->dev, sizeof(struct ddcci_bus_drv_data), GFP_KERNEL);
> +	if (!drv_data)
> +		return -ENOMEM;
> +	drv_data->i2c_dev = client;
> +	mutex_init(&drv_data->mut);
> +
> +	/* Set i2c client data */
> +	i2c_set_clientdata(client, drv_data);
> +
> +	if (id->driver_data == 0) {
> +		/* Core device, probe at 0x6E */
> +		main_addr = DDCCI_DEFAULT_DEVICE_ADDR;
> +		dev_dbg(&client->dev, "probing core device [%02x]\n",
> +			client->addr << 1);
> +		ret = ddcci_detect_device(client, main_addr, 0);
> +		if (ret) {
> +			dev_info(&client->dev, "core device [%02x] probe failed: %d\n",
> +				 client->addr << 1, ret);
> +			if (ret == -EIO)
> +				ret = -ENODEV;
> +			goto err_free;
> +		}
> +
> +		/* Detect internal dependent devices */
> +		dev_dbg(&client->dev, "probing internal dependent devices\n");
> +		for (i = 0; i < autoprobe_addr_count; ++i) {
> +			addr = (unsigned short)autoprobe_addrs[i];
> +			if ((addr & 1) == 0 && addr != main_addr) {
> +				tmp = ddcci_detect_device(client, addr, main_addr);
> +				if (tmp < 0 && tmp != -ENODEV) {
> +					dev_info(&client->dev, "internal dependent device [%02x:%02x] probe failed: %d\n",
> +						 client->addr << 1, addr, ret);
> +				}
> +			}
> +		}
> +	} else if (id->driver_data == 1) {
> +		/* External dependent device */
> +		main_addr = client->addr << 1;
> +		dev_dbg(&client->dev, "probing external dependent device [%02x]\n", main_addr);
> +		ret = ddcci_detect_device(client, main_addr, -1);
> +		if (ret) {
> +			dev_info(&client->dev, "external dependent device [%02x] probe failed: %d\n",
> +				 main_addr, ret);
> +			if (ret == -EIO)
> +				ret = -ENODEV;
> +			goto err_free;
> +		}
> +	} else {
> +		dev_warn(&client->dev,
> +			 "probe() called with invalid i2c device id\n");
> +		ret = -EINVAL;
> +	}
> +
> +	goto end;
> +err_free:
> +	devm_kfree(&client->dev, drv_data);
> +end:
> +	return ret;
> +}
> +
> +/*
> + * Callback for bus_find_device() used in ddcci_remove()
> + *
> + * Find next device on i2c_client not flagged with
> + * DDCCI_FLAG_REMOVED and flag it.
> + */
> +static int ddcci_remove_helper(struct device *dev, const void *p)
> +{
> +	struct ddcci_device *device;
> +
> +	device = ddcci_verify_device(dev);
> +	if (!device || device->flags & DDCCI_FLAG_REMOVED)
> +		return 0;
> +
> +	if (!p || (dev->parent == p)) {
> +		device->flags |= DDCCI_FLAG_REMOVED;
> +		/* Memory Barrier */
> +		wmb();
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* I2C driver remove callback: unregister all subdevices */
> +static int ddcci_remove(struct i2c_client *client)
> +{
> +	struct ddcci_bus_drv_data *drv_data = i2c_get_clientdata(client);
> +	struct device *dev;
> +
> +	mutex_lock(&drv_data->mut);
> +	while (1) {
> +		dev = bus_find_device(&ddcci_bus_type, NULL, client,
> +				      ddcci_remove_helper);
> +		if (!dev)
> +			break;
> +		device_unregister(dev);
> +		put_device(dev);
> +	}
> +	mutex_unlock(&drv_data->mut);
> +	return 0;
> +}
> +
> +/*
> + * I2C driver device identification table.
> + */
> +static const struct i2c_device_id ddcci_idtable[] = {
> +	{ "ddcci", 0 },
> +	{ "ddcci-dependent", 1 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ddcci_idtable);
> +
> +/*
> + * I2C driver description structure
> + */
> +static struct i2c_driver ddcci_driver = {
> +	.driver = {
> +		.name	= "ddcci",
> +		.owner	= THIS_MODULE,
> +	},
> +
> +	.id_table	= ddcci_idtable,
> +	.probe		= ddcci_probe,
> +	.remove		= ddcci_remove,
> +	.class		= I2C_CLASS_DDC,
> +	.detect		= ddcci_detect,
> +	.address_list	= I2C_ADDRS(
> +		DDCCI_DEFAULT_DEVICE_ADDR>>1
> +	),
> +};
> +
> +/*
> + * Module initialization function. Called when the module is inserted or
> + * (if builtin) at boot time.
> + */
> +static int __init ddcci_module_init(void)
> +{
> +	int ret;
> +
> +	pr_debug("initializing ddcci driver\n");
> +	/* Allocate a device number region for the character devices */
> +	ret = alloc_chrdev_region(&ddcci_cdev_first, 0, 128, DEVICE_NAME);

Ah, now you allocate 128 devices?

Why not just use the misc device layer and allocate them individually as
you need them?  Much simpler and takes up less code and space overall.

> +	if (ret < 0) {
> +		pr_err("failed to register device region: error %d\n", ret);
> +		goto err_chrdevreg;
> +	}
> +	ddcci_cdev_next = ddcci_cdev_first;
> +	ddcci_cdev_end = MKDEV(MAJOR(ddcci_cdev_first), MINOR(ddcci_cdev_first) + 128);
> +
> +	/* Register bus */
> +	ret = bus_register(&ddcci_bus_type);
> +	if (ret) {
> +		pr_err("failed to register bus 'ddcci'\n");
> +		goto err_busreg;
> +	}
> +
> +	/* Register I2C driver */
> +	ret = i2c_add_driver(&ddcci_driver);
> +	if (ret) {
> +		pr_err("failed to register i2c driver\n");
> +		goto err_drvreg;
> +	}
> +
> +	pr_debug("ddcci driver initialized\n");
> +
> +	return 0;
> +
> +err_drvreg:
> +	bus_unregister(&ddcci_bus_type);
> +err_busreg:
> +	unregister_chrdev_region(ddcci_cdev_first, 128);
> +err_chrdevreg:
> +	return ret;
> +}
> +
> +/*
> + * Module clean-up function. Called when the module is removed.
> + */
> +static void __exit ddcci_module_exit(void)
> +{
> +	struct device *dev;
> +
> +	while (1) {
> +		dev = bus_find_device(&ddcci_bus_type, NULL, NULL, ddcci_remove_helper);
> +		if (!dev)
> +			break;
> +		device_unregister(dev);
> +		put_device(dev);
> +	}
> +
> +	i2c_del_driver(&ddcci_driver);
> +	bus_unregister(&ddcci_bus_type);
> +	unregister_chrdev_region(ddcci_cdev_first, 128);
> +}
> +
> +/* Let the kernel know the calls for module init and exit */
> +module_init(ddcci_module_init);
> +module_exit(ddcci_module_exit);
> +
> +/* Module parameter description */
> +module_param(delay, uint, 0644);
> +MODULE_PARM_DESC(delay, "default delay after bus writes (in ms, default 60)");
> +module_param_array(autoprobe_addrs, ushort, &autoprobe_addr_count, 0644);
> +MODULE_PARM_DESC(autoprobe_addrs, "internal dependent device addresses to autoprobe");

Please do not add module parameters.  They should not be needed at all
here.


> +
> +/* Module description */
> +MODULE_AUTHOR("Christoph Grenz <webmaster@grenz-bonn.de>");
> +MODULE_DESCRIPTION("DDC/CI bus driver");
> +MODULE_VERSION("0.4.2");

Driver versions do not make sense when the code is merged into the
kernel tree.


> +MODULE_LICENSE("GPL");
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index e32694c13da5..7a26088c3c3f 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -289,6 +289,17 @@ config BACKLIGHT_QCOM_WLED
>  	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>  	  WLED block. Currently it supports PM8941 and PMI8998.
>  
> +config BACKLIGHT_DDCCI
> +	tristate "DDCCI Backlight Driver"
> +	depends on DDCCI
> +	help
> +	  If you have a DDC/CI supporing monitor, say Y to enable a driver
> +	  to control its backlight using DDC/CI. This could be useful if
> +	  your monitor does not include a backlight driver. For this to be
> +	  useful you need to enable DDCCI support which can be found in
> +	  Device Drivers -> Character devices and that further depends on
> +	  I2C.

Ah, here's the driver.  This might be better as patch 2 of the series to
make it easier to review.

And you need a module name information here.

> +
>  config BACKLIGHT_RT4831
>  	tristate "Richtek RT4831 Backlight Driver"
>  	depends on MFD_RT4831
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index cae2c83422ae..7bfb6e506b35 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
>  obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
>  obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
>  obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
> +obj-$(CONFIG_BACKLIGHT_DDCCI)		+= ddcci-backlight.o
> diff --git a/drivers/video/backlight/ddcci-backlight.c b/drivers/video/backlight/ddcci-backlight.c
> new file mode 100644
> index 000000000000..9a86fee94d21
> --- /dev/null
> +++ b/drivers/video/backlight/ddcci-backlight.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  DDC/CI monitor backlight driver
> + *
> + *  Copyright (c) 2015 Christoph Grenz
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.

Again, your license text does not match.

thanks,

greg k-h
