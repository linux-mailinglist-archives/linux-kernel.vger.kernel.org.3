Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5BF477FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhLPWEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLPWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:04:30 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6EC061574;
        Thu, 16 Dec 2021 14:04:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z7so640715lfi.11;
        Thu, 16 Dec 2021 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTg6bT+BtI80nm3srF/7OYobTVkKIW4xhlRUkah0JXg=;
        b=q7WPqmW5TwQ+cC7KSbAHIvU4jSpl35285+gnvDwgh0++c7n8ejgpOt94TyQmk3Y06d
         GKqJ+HL1+WC/+KuSQWzJ+v5TvRVGndYU1tPnuruiIq67uTaaRNeTslgy7DDZSp6InEL8
         r5zZoGNi2/mR2Kb7meltKUPJUkSMVZ4w2EmAODzia0EZq26E71c8Irt+o6+MdpsT1GET
         X0C3cwzyjFjlAV21usnTG4n8HF6ma89D2RcdWLVAQDPygzg2QhBNeGFFVIG4Fm/KHCyo
         q4n4nXew+ch8yiLNVRWMt2EkiY8evq3KPVXA54KRscLnz+rdAMdjcGtiFd5ghy+p3pGR
         Lojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTg6bT+BtI80nm3srF/7OYobTVkKIW4xhlRUkah0JXg=;
        b=b47IuVKW2j1Ln5lA8cincVSht1qhZeiY/p1KHeesvYOLFmCh+aRE0SY8d45mj7pCyd
         LNN9DuD21+DSljQARAzCL+1/8vTBxp1uB3lvlsmkjZ2YVLxDSg4w406x7/hAjea4m/RO
         UH5FVnaM2M1Hy1jj6JRo80HCCSL+TwEln3+Z4ASXhooil+uxoMjtUbgr6/pglCwbpY8G
         14nRajIciYdBYuYTPMHKnCnaCZmec+5T9x/7o+tIfT9Ol+7fXzaOyOJ5uq7Q5V7luFRZ
         0NbvmBUbvVdaQSecHhqk9ogvzRFt+l+XvQ8as/w0rD3Qq4SzgHJ4pVBmuBAGkSj2x3Uj
         jNBA==
X-Gm-Message-State: AOAM5334CSbjkhyKqTtd2DJUpVGT6XFrqFxLiPFXeekQPG+ySo9sfTF8
        yezyTj5oTgvO8L7WK+776qI=
X-Google-Smtp-Source: ABdhPJxQS8KW2aRnYmuJ1HxngugOcHiliPvNzHLzvlK1bTIqr6niL47dVFzYRRLuTNmMNVAESmJv3w==
X-Received: by 2002:a05:6512:a92:: with SMTP id m18mr172616lfu.306.1639692268255;
        Thu, 16 Dec 2021 14:04:28 -0800 (PST)
Received: from netbook-debian (55-2-94-178.pool.ukrtel.net. [178.94.2.55])
        by smtp.gmail.com with ESMTPSA id e21sm1062892lfc.229.2021.12.16.14.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 14:04:28 -0800 (PST)
Date:   Fri, 17 Dec 2021 00:04:24 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Message-ID: <20211217000424.41da446e@netbook-debian>
In-Reply-To: <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
        <CAHp75VeERqjxrt7C4hrDnJpY1aCQPtF=CQ=MLY8e9Gik57P3DQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

Have you found some issues with idea of usage ACPI WMI methods as
failback solution, like in case when ASUS will release some BIOS with
different mutex path or different motherboard where will be same WMI
methods but fully different internal logic?
  =20
On Thu, 16 Dec 2021 23:27:52 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Dec 16, 2021 at 10:53 PM Eugene Shalygin
> <eugene.shalygin@gmail.com> wrote:
> >
> > This driver provides the same data as the asus_wmi_ec_sensors driver
> > (and gets it from the same source) but does not use WMI, polling
> > the ACPI EC directly.
> >
> > That provides two enhancements: sensor reading became quicker (on
> > some systems or kernel configuration it took almost a full second
> > to read all the sensors, that transfers less than 15 bytes of
> > data), the driver became more fexible. The driver now relies on
> > ACPI mutex to lock access =20
>=20
> flexible
>=20
> > to the EC, in the same way as the WMI DSDT code does. =20
>=20
> How do you know that this way there is no race with any of ACPI code?
>=20
> ...
>=20
> > +config SENSORS_ASUS_EC
> > +       tristate "ASUS EC Sensors" =20
>=20
> > +       depends on ACPI =20
>=20
> No need to duplicate. See (1) below.
>=20
> > +       help
> > +         If you say yes here you get support for the ACPI embedded
> > controller
> > +         hardware monitoring interface found in ASUS motherboards.
> > The driver
> > +         currently supports B550/X570 boards, although other ASUS
> > boards might
> > +         provide this monitoring interface as well.
> > +
> > +         This driver can also be built as a module. If so, the
> > module
> > +         will be called asus_ec_sensors.
> > +
> >  endif # ACPI =20
>=20
> (1)
>=20
> ...
>=20
> > +/*
> > + * HWMON driver for ASUS motherboards that publish some sensor
> > values
> > + * via the embedded controller registers =20
>=20
> Missed grammatical period.
>=20
> > + * =20
>=20
> > + */ =20
>=20
> ...
>=20
> > +#define ASUS_EC_BANK_REGISTER 0xff /* Writing to this EC register
> > switches EC bank */ =20
>=20
> Can you put comment before the definition?
>=20
> ...
>=20
> > +#define SENSOR_LABEL_LEN 0x10 =20
>=20
> Why in hex?
>=20
> Missed blank line here.
>=20
> > +/*
> > + * Arbitrary set max. allowed bank number. Required for sorting
> > banks and
> > + * currently is overkill with just 2 banks used at max, but for
> > the sake
> > + * of alignment let's set it to a higher value =20
>=20
> Check grammar everywhere, again missed period (at least).
>=20
> > + */ =20
>=20
> ...
>=20
> > +#define ACPI_DELAY_MSEC_LOCK   500     /* Wait for 0.5 s max. to
> > acquire the lock */ =20
>=20
> _LOCK_DELAY_MS and drop useless comment
>=20
> I think I gave the very same comments before. Maybe you can check the
> reviews of another driver?
>=20
> ...
>=20
>=20
> > +#define MAKE_SENSOR_ADDRESS(size, bank, index)
> >             \
> > +       {
> >            \
> > +               .value =3D (size << 16) + (bank << 8) + index
> >            \ =20
>=20
> Leave comma here and everywhere else in the structure entries.
>=20
> > +       } =20
>=20
> Besides that, would it be better to have it defined as a compound
> literal?
>=20
> ...
>=20
> > +enum known_ec_sensor {
> > +       SENSOR_TEMP_CHIPSET     =3D 1 <<  0, /* chipset temperature
> > [=E2=84=83] */
> > +       SENSOR_TEMP_CPU         =3D 1 <<  1, /* CPU temperature [=E2=84=
=83] */
> > +       SENSOR_TEMP_MB          =3D 1 <<  2, /* motherboard
> > temperature [=E2=84=83] */
> > +       SENSOR_TEMP_T_SENSOR    =3D 1 <<  3, /* "T_Sensor"
> > temperature sensor reading [=E2=84=83] */
> > +       SENSOR_TEMP_VRM         =3D 1 <<  4, /* VRM temperature [=E2=84=
=83] */
> > +       SENSOR_FAN_CPU_OPT      =3D 1 <<  5, /* CPU_Opt fan [RPM] */
> > +       SENSOR_FAN_VRM_HS       =3D 1 <<  6, /* VRM heat sink fan
> > [RPM] */
> > +       SENSOR_FAN_CHIPSET      =3D 1 <<  7, /* chipset fan [RPM] */
> > +       SENSOR_FAN_WATER_FLOW   =3D 1 <<  8, /* water flow sensor
> > reading [RPM] */
> > +       SENSOR_CURR_CPU         =3D 1 <<  9, /* CPU current [A] */
> > +       SENSOR_TEMP_WATER_IN    =3D 1 << 10, /* "Water_In"
> > temperature sensor reading [=E2=84=83] */
> > +       SENSOR_TEMP_WATER_OUT   =3D 1 << 11, /* "Water_Out"
> > temperature sensor reading [=E2=84=83] */ =20
>=20
> Perhaps kernel doc and use of BIT()?
>=20
> > +       SENSOR_END
> > +}; =20
>=20
> ...
>=20
> > +static const struct ec_sensor_info known_ec_sensors[] =3D {
> > +       EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a), /*
> > SENSOR_TEMP_CHIPSET */
> > +       EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b), /*
> > SENSOR_TEMP_CPU */
> > +       EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c), /*
> > SENSOR_TEMP_MB */
> > +       EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d), /*
> > SENSOR_TEMP_T_SENSOR */
> > +       EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e), /*
> > SENSOR_TEMP_VRM */
> > +       EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0), /*
> > SENSOR_FAN_CPU_OPT */
> > +       EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2), /*
> > SENSOR_FAN_VRM_HS */
> > +       EC_SENSOR("Chipset", hwmon_fan, 2, 0x00, 0xb4), /*
> > SENSOR_FAN_CHIPSET */
> > +       EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc), /*
> > SENSOR_FAN_WATER_FLOW */
> > +       EC_SENSOR("CPU", hwmon_curr, 1, 0x00, 0xf4), /*
> > SENSOR_CURR_CPU */
> > +       EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00), /*
> > SENSOR_TEMP_WATER_IN */
> > +       EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01), /*
> > SENSOR_TEMP_WATER_OUT */ =20
>=20
> Instead of comments, use form of
>=20
>   [FOO] =3D BAR(...),
>=20
> > +}; =20
>=20
> ...
>=20
> > +static struct asus_ec_board_info board_P_X570_P =3D {
> > +       .sensors =3D SENSOR_TEMP_CHIPSET | SENSOR_TEMP_CPU |
> > SENSOR_TEMP_MB | SENSOR_TEMP_VRM
> > +                | SENSOR_FAN_CHIPSET, =20
>=20
> It's a bit long and better to leave ' |' on the previous line(s).
>=20
> > +       .acpi_mutex_path =3D ASUS_HW_ACCESS_MUTEX_ASMX =20
>=20
> + Comma.
>=20
> > +}; =20
>=20
> Ditto for all other similar cases.
>=20
> ...
>=20
> > +#define DMI_EXACT_MATCH_BOARD(vendor, name, sensors) {
> >             \
> > +               .matches =3D {
> >            \
> > +                       DMI_EXACT_MATCH(DMI_BOARD_VENDOR, vendor),
> >            \
> > +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, name),
> >            \
> > +               },
> >            \
> > +               .driver_data =3D sensors
> >            \ =20
>=20
> + Comma.
>=20
> > +       } =20
>=20
> ...
>=20
> > +struct ec_sensors_data {
> > +       const struct asus_ec_board_info *board;
> > +       struct ec_sensor *sensors;
> > +       /* EC registers to read from */
> > +       u16 *registers;
> > +       u8 *read_buffer;
> > +       /* sorted list of unique register banks */
> > +       u8 banks[ASUS_EC_MAX_BANK];
> > +       unsigned long last_updated; /* in jiffies */
> > +       acpi_handle aml_mutex;
> > +       u8 nr_sensors; /* number of board EC sensors */
> > +       /* number of EC registers to read (sensor might span more
> > than 1 register) */
> > +       u8 nr_registers;
> > +       u8 nr_banks; /* number of unique register banks */
> > +}; =20
>=20
> Kernel doc?
>=20
> ...
>=20
> > +static u8 register_bank(u16 reg)
> > +{
> > +       return (reg & 0xff00) >> 8; =20
>=20
> ' & 0xff00' part is redundant.
>=20
> > +} =20
>=20
> ...
>=20
> > +static struct ec_sensors_data *get_sensor_data(struct device *pdev)
> > +{
> > +       return dev_get_drvdata(pdev);
> > +} =20
>=20
> Useless wrapper. It adds no value.
>=20
> ...
>=20
> > +       unsigned int i;
> > +
> > +       for (i =3D 0; i < ec->nr_sensors; ++i) {
> > +               if (get_sensor_info(ec, i)->type =3D=3D type) {
> > +                       if (channel =3D=3D 0)
> > +                               return i; =20
>=20
> > +                       --channel; =20
>=20
> What's wrong with post-decrement, and I think I already commented on
> this. So, I stopped here until you go and enforce all comments given
> against previous incarnation of this driver.
>=20
> > +               }
> > +       }
> > +       return -ENOENT;
> > +} =20
>=20
> ...
>=20
> > +       for (i =3D 1; i < SENSOR_END; i <<=3D 1) {
> > +               if ((i & ec->board->sensors) =3D=3D 0
> > +                       continue; =20
>=20
> Interesting way of NIH for_each_set_bit().
>=20
> ...
>=20
> > +               for (j =3D 0; j < si->addr.components.size; ++j,
> > ++register_idx) { =20
>=20
> Why pre-increments?
>=20
> > +                       ec->registers[register_idx] =3D
> > +                               (si->addr.components.bank << 8) +
> > +                               si->addr.components.index + j;
> > +               }
> > +       }
> > +} =20
>=20
> ...
>=20
> > +       acpi_handle res; =20
>=20
> > +       acpi_status status =3D acpi_get_handle(
> > +               NULL, (acpi_string)state->board->acpi_mutex_path,
> > &res); =20
>=20
> It looks awful (indentation), Have you run checkpatch?
>=20
> > +       if (ACPI_FAILURE(status)) {
> > +               dev_err(dev, "Could not get hardware access guard
> > mutex: error %d", status);
> > +               return NULL;
> > +       } =20
>=20
> ...
>=20
> > +static struct hwmon_chip_info asus_wmi_chip_info =3D {
> > +       .ops =3D &asus_ec_hwmon_ops, =20
>=20
> > +       .info =3D NULL, =20
>=20
> Redundant.
>=20
> > +}; =20
>=20



Best regards,
             Denis.
