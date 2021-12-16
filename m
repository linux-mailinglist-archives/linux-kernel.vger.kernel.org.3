Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D974E477ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLPV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhLPV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:28:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A8C061574;
        Thu, 16 Dec 2021 13:28:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so376043edd.9;
        Thu, 16 Dec 2021 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5txe/FQxXJno5fOHUNCBLSvcA9lIj01jhYSg9QRu7ek=;
        b=Dim7tjWc40ze1DdreQNBI2YDZJLE+uibntHCMEaYRIV2IadT/0OFJJUAdePFBoXw43
         f4H64anHFVg0V3RCaPIRMUvX0PelmqchCDSE8i/P2LF0wtrnkIy4HenPS4OWGmh96SsI
         ++R3F1vZYJ7+3A1kPcedMdSUNVKZbDJ2ZTqyUL5cNUumu23k+hZLrp4QEdKmpka/4y/P
         gNQ8mVqrRQ/KBYb2ePpnzAJp8h+6tA7aySIbiuvOsUpm9Xxg7A4FmccwUbh3Kq3nuf2G
         0z1Yic8t2fqvsDrNDDZSj715t1NN2chP3g6AiANVQSZiy407HyMEPWUqQ9u0vg6fsOJB
         Qgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5txe/FQxXJno5fOHUNCBLSvcA9lIj01jhYSg9QRu7ek=;
        b=bSoM+fuYAO8swtu4GJHU6YJUmswWN8+LA7x6WUCh9yfau8ttKJsALcTayT9o1nUruO
         Vp2RdFk63auy2ybBFpGsGUdUhwxKgD3DwyUYg+V2KE1+NFjte8DshVTBCx/IVksurozi
         ERpbTm/GljTCtozw2rq8Iw04xrhnclI2yoyUkeY6TyRUzryy6vw8LMMLO7wdU2pwwmyY
         5v9R0VRDTotPIbK0ZCp6Yzi4LUB7K76W3EOklGEIvCBqo+iO5818joGrawepfdP6ZVbt
         XQUodGilx7/VOBJoxEihhuJWvbM45A32Ovi8CuxWAxQZlLAqC+8LEAXGYpsUSB4SE1bA
         AoCg==
X-Gm-Message-State: AOAM532EZ3MqJa76+Zx5IkpFkxwnlyI/LjpEHaVZoXD5DFSqaxJtf8Ry
        b2AMCXAJDc02oPBLZpsbz+rmkhct9BGHtkPjwa8=
X-Google-Smtp-Source: ABdhPJwgLOMxgTZ0C3EdEIVmBdZiAARWRiVsOweJvVbfxIaZH1GKloZW/PshXapPIfChIpA/A4vScWGW2gv8PbUHu6o=
X-Received: by 2002:aa7:cd75:: with SMTP id ca21mr5826204edb.242.1639690109633;
 Thu, 16 Dec 2021 13:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
In-Reply-To: <20211216205303.768991-1-eugene.shalygin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Dec 2021 23:27:52 +0200
Message-ID: <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:53 PM Eugene Shalygin
<eugene.shalygin@gmail.com> wrote:
>
> This driver provides the same data as the asus_wmi_ec_sensors driver
> (and gets it from the same source) but does not use WMI, polling
> the ACPI EC directly.
>
> That provides two enhancements: sensor reading became quicker (on some
> systems or kernel configuration it took almost a full second to read
> all the sensors, that transfers less than 15 bytes of data), the driver
> became more fexible. The driver now relies on ACPI mutex to lock access

flexible

> to the EC, in the same way as the WMI DSDT code does.

How do you know that this way there is no race with any of ACPI code?

...

> +config SENSORS_ASUS_EC
> +       tristate "ASUS EC Sensors"

> +       depends on ACPI

No need to duplicate. See (1) below.

> +       help
> +         If you say yes here you get support for the ACPI embedded contr=
oller
> +         hardware monitoring interface found in ASUS motherboards. The d=
river
> +         currently supports B550/X570 boards, although other ASUS boards=
 might
> +         provide this monitoring interface as well.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called asus_ec_sensors.
> +
>  endif # ACPI

(1)

...

> +/*
> + * HWMON driver for ASUS motherboards that publish some sensor values
> + * via the embedded controller registers

Missed grammatical period.

> + *

> + */

...

> +#define ASUS_EC_BANK_REGISTER 0xff /* Writing to this EC register switch=
es EC bank */

Can you put comment before the definition?

...

> +#define SENSOR_LABEL_LEN 0x10

Why in hex?

Missed blank line here.

> +/*
> + * Arbitrary set max. allowed bank number. Required for sorting banks an=
d
> + * currently is overkill with just 2 banks used at max, but for the sake
> + * of alignment let's set it to a higher value

Check grammar everywhere, again missed period (at least).

> + */

...

> +#define ACPI_DELAY_MSEC_LOCK   500     /* Wait for 0.5 s max. to acquire=
 the lock */

_LOCK_DELAY_MS and drop useless comment

I think I gave the very same comments before. Maybe you can check the
reviews of another driver?

...


> +#define MAKE_SENSOR_ADDRESS(size, bank, index)                          =
       \
> +       {                                                                =
      \
> +               .value =3D (size << 16) + (bank << 8) + index            =
        \

Leave comma here and everywhere else in the structure entries.

> +       }

Besides that, would it be better to have it defined as a compound literal?

...

> +enum known_ec_sensor {
> +       SENSOR_TEMP_CHIPSET     =3D 1 <<  0, /* chipset temperature [=E2=
=84=83] */
> +       SENSOR_TEMP_CPU         =3D 1 <<  1, /* CPU temperature [=E2=84=
=83] */
> +       SENSOR_TEMP_MB          =3D 1 <<  2, /* motherboard temperature [=
=E2=84=83] */
> +       SENSOR_TEMP_T_SENSOR    =3D 1 <<  3, /* "T_Sensor" temperature se=
nsor reading [=E2=84=83] */
> +       SENSOR_TEMP_VRM         =3D 1 <<  4, /* VRM temperature [=E2=84=
=83] */
> +       SENSOR_FAN_CPU_OPT      =3D 1 <<  5, /* CPU_Opt fan [RPM] */
> +       SENSOR_FAN_VRM_HS       =3D 1 <<  6, /* VRM heat sink fan [RPM] *=
/
> +       SENSOR_FAN_CHIPSET      =3D 1 <<  7, /* chipset fan [RPM] */
> +       SENSOR_FAN_WATER_FLOW   =3D 1 <<  8, /* water flow sensor reading=
 [RPM] */
> +       SENSOR_CURR_CPU         =3D 1 <<  9, /* CPU current [A] */
> +       SENSOR_TEMP_WATER_IN    =3D 1 << 10, /* "Water_In" temperature se=
nsor reading [=E2=84=83] */
> +       SENSOR_TEMP_WATER_OUT   =3D 1 << 11, /* "Water_Out" temperature s=
ensor reading [=E2=84=83] */

Perhaps kernel doc and use of BIT()?

> +       SENSOR_END
> +};

...

> +static const struct ec_sensor_info known_ec_sensors[] =3D {
> +       EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a), /* SENSOR_TEMP_C=
HIPSET */
> +       EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b), /* SENSOR_TEMP_CPU *=
/
> +       EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c), /* SENSOR_TE=
MP_MB */
> +       EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d), /* SENSOR_TEMP_=
T_SENSOR */
> +       EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e), /* SENSOR_TEMP_VRM *=
/
> +       EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0), /* SENSOR_FAN_CPU=
_OPT */
> +       EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2), /* SENSOR_FAN_VRM_=
HS */
> +       EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4), /* SENSOR_FAN_CHI=
PSET */
> +       EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc), /* SENSOR_FAN_=
WATER_FLOW */
> +       EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4), /* SENSOR_CURR_CPU *=
/
> +       EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00), /* SENSOR_TEMP_=
WATER_IN */
> +       EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01), /* SENSOR_TEMP=
_WATER_OUT */

Instead of comments, use form of

  [FOO] =3D BAR(...),

> +};

...

> +static struct asus_ec_board_info board_P_X570_P =3D {
> +       .sensors =3D SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU | SENSOR_TEMP_=
MB | SENSOR_TEMP_VRM
> +                | SENSOR_FAN_CHIPSET,

It's a bit long and better to leave ' |' on the previous line(s).

> +       .acpi_mutex_path =3D ASUS_HW_ACCESS_MUTEX_ASMX

+ Comma.

> +};

Ditto for all other similar cases.

...

> +#define DMI_EXACT_MATCH_BOARD(vendor, name, sensors) {                  =
       \
> +               .matches =3D {                                           =
        \
> +                       DMI_EXACT_MATCH(DMI_BOARD_VENDOR, vendor),       =
      \
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, name),           =
      \
> +               },                                                       =
      \
> +               .driver_data =3D sensors                                 =
        \

+ Comma.

> +       }

...

> +struct ec_sensors_data {
> +       const struct asus_ec_board_info *board;
> +       struct ec_sensor *sensors;
> +       /* EC registers to read from */
> +       u16 *registers;
> +       u8 *read_buffer;
> +       /* sorted list of unique register banks */
> +       u8 banks[ASUS_EC_MAX_BANK];
> +       unsigned long last_updated; /* in jiffies */
> +       acpi_handle aml_mutex;
> +       u8 nr_sensors; /* number of board EC sensors */
> +       /* number of EC registers to read (sensor might span more than 1 =
register) */
> +       u8 nr_registers;
> +       u8 nr_banks; /* number of unique register banks */
> +};

Kernel doc?

...

> +static u8 register_bank(u16 reg)
> +{
> +       return (reg & 0xff00) >> 8;

' & 0xff00' part is redundant.

> +}

...

> +static struct ec_sensors_data *get_sensor_data(struct device *pdev)
> +{
> +       return dev_get_drvdata(pdev);
> +}

Useless wrapper. It adds no value.

...

> +       unsigned int i;
> +
> +       for (i =3D 0; i < ec->nr_sensors; ++i) {
> +               if (get_sensor_info(ec, i)->type =3D=3D type) {
> +                       if (channel =3D=3D 0)
> +                               return i;

> +                       --channel;

What's wrong with post-decrement, and I think I already commented on this.
So, I stopped here until you go and enforce all comments given against
previous incarnation of this driver.

> +               }
> +       }
> +       return -ENOENT;
> +}

...

> +       for (i =3D 1; i < SENSOR_END; i <<=3D 1) {
> +               if ((i & ec->board->sensors) =3D=3D 0
> +                       continue;

Interesting way of NIH for_each_set_bit().

...

> +               for (j =3D 0; j < si->addr.components.size; ++j, ++regist=
er_idx) {

Why pre-increments?

> +                       ec->registers[register_idx] =3D
> +                               (si->addr.components.bank << 8) +
> +                               si->addr.components.index + j;
> +               }
> +       }
> +}

...

> +       acpi_handle res;

> +       acpi_status status =3D acpi_get_handle(
> +               NULL, (acpi_string)state->board->acpi_mutex_path, &res);

It looks awful (indentation), Have you run checkpatch?

> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "Could not get hardware access guard mutex: =
error %d", status);
> +               return NULL;
> +       }

...

> +static struct hwmon_chip_info asus_wmi_chip_info =3D {
> +       .ops =3D &asus_ec_hwmon_ops,

> +       .info =3D NULL,

Redundant.

> +};

--=20
With Best Regards,
Andy Shevchenko
