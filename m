Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8928A4B38A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiBLXaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiBLXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:30:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB715FF19;
        Sat, 12 Feb 2022 15:30:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so21036701wrc.6;
        Sat, 12 Feb 2022 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=knIxBqUqromJULOxfs7G6seW/nlxQ4mODcvICUF58uk=;
        b=S4Re7CkS10XVZjgluFziPr7iaAPdCmntAscxAEmYFxos9TydFtGWMyDkw3/x7xCi4c
         WaTobfU6HjvNHMt/l+B9/xkVC5BUf6CmdBgVI4dT+aPtLDimmFLuNRp1240B5P7H4TsA
         r03VQsHqypu21avnzglgCS3+sVB8247N7UIkYKsKnBL8JQ+4+0TdcNSj7V01cjfXFDlD
         ec5sgooO40edVlauTWyq2ySzrD9uuje3xBGosRcWpXwVC6MlVEGywCyBVgwf8xdeMGcB
         hKnsK5jlZcPVjAEkpPp+nQqpOfd5qeaCO/RzrVc6xHyIekehNQCWEFCzKwHirVbR9Ats
         ir4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=knIxBqUqromJULOxfs7G6seW/nlxQ4mODcvICUF58uk=;
        b=C9oQ8upRfU4CA56hW0MgXIaCsi6dKbLNxq1FpFwiAeHkuNh4ejoyaGbQpKXC5Rqcyp
         XH23bBOvpdZNiAkKYnRa5gzlysEb3V7bffmbY4TDHoVEC+AdTmovuT+/zEE6L0bqjQpD
         P397i8TT44DIZO6OnCyb1T6BbjkkdxZbTEgUCMhAITrK84Km8GFXfPtiEwWJVMwWPUVv
         xyeh4ag892umZJ/YnMO80AtQLR0x8fkT0QMBKXs7k3HWPj+BAPhGg4D6Ii2gLznsbIEG
         98XyQzb4jqQWPFsxHrZLfGJKyjt+Q/fzfbipM78qh/28Yq1k/YOZhZ7BDCIBQslEqqMf
         VBqA==
X-Gm-Message-State: AOAM530jHqFV0BjYepyfHIZp/3IOybYnlxhTBPOOk4X6nfQKlWg1X+a4
        D78T0yMGHhZWemVSFPgzA30Bo2C770U/yBxKZRo=
X-Google-Smtp-Source: ABdhPJy7Z4FbioyHJ4XDhYhUSE5i/yKJ/lg6MFaa4ws92n8KQ6fQ0/8PtHfSu2GLN/Z2E/VbCCeJtBuRPOdtm1fPm6g=
X-Received: by 2002:a05:6000:1c11:: with SMTP id ba17mr6054345wrb.97.1644708613601;
 Sat, 12 Feb 2022 15:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20220206022023.376142-1-andrew.smirnov@gmail.com> <gfQUxZHzyr7uH4TwqJwXGsxCIYa-VvrN955036G3kKr6ligJYTAI3dqhf-FJddyHVBomp3JUUBNFMmmR8rwm7WzSxprlclT9Cbkrr2dknP0=@protonmail.com>
In-Reply-To: <gfQUxZHzyr7uH4TwqJwXGsxCIYa-VvrN955036G3kKr6ligJYTAI3dqhf-FJddyHVBomp3JUUBNFMmmR8rwm7WzSxprlclT9Cbkrr2dknP0=@protonmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 12 Feb 2022 15:30:01 -0800
Message-ID: <CAHQ1cqF5HCJVsmyMHMxU85Uwv_Yd8qoAUVMz7R_zo0S9_pFZfg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 7:19 AM Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.c=
om> wrote:
>
> Hi
>
>
> 2022. febru=C3=A1r 6., vas=C3=A1rnap 3:20 keltez=C3=A9ssel, Andrey Smirno=
v =C3=ADrta:
> > Add a driver exposing various bits and pieces of functionality
> > provided by Steam Deck specific VLV0100 device presented by EC
> > firmware. This includes but not limited to:
> >
> >     - CPU/device's fan control
> >     - Read-only access to DDIC registers
> >     - Battery tempreature measurements
> >     - Various display related control knobs
> >     - USB Type-C connector event notification
> >
>
> I think some kind of documentation is missing as to
> how the various attributes are supposed to work.
>
>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Mark Gross <markgross@kernel.org>
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-kernel@vger.kernel.org (open list)
> > Cc: platform-driver-x86@vger.kernel.org
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >
> > This driver is really a kitchen sink of various small bits. Maybe it
> > is worth splitting into an MFD + child drivers/devices?
>
> Or maybe using the auxiliary bus?
>

Hmm, I wasn't familiar with that one before. Looks like a decent fit
as well. I'm looking at intel_soc_pmic_mrfld.c as a example to emulate
since it seems to be implementing something that is _kind of_ similar
and I'm still leaning to do an MFD for a couple of simple reasons:

- I'd be able to assign ID-less name to my extcon device which would
be helpful for glueing it to USB block
- MFD seems to already have nice devm helpers which would simplify
more core driver code

>
> >
> >  drivers/platform/x86/Kconfig     |  15 +
> >  drivers/platform/x86/Makefile    |   2 +
> >  drivers/platform/x86/steamdeck.c | 523 +++++++++++++++++++++++++++++++
> >  3 files changed, 540 insertions(+)
> >  create mode 100644 drivers/platform/x86/steamdeck.c
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index c23612d98126..86f014e78a6e 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1136,6 +1136,21 @@ config SIEMENS_SIMATIC_IPC
> >         To compile this driver as a module, choose M here: the module
> >         will be called simatic-ipc.
> >
> > +config STEAMDECK
> > +       tristate "Valve Steam Deck platform driver"
> > +       depends on X86_64
>
> Should ACPI, EXTCON, HWMON, etc. be also listed here?
> E.g. if EXTCON is not available, then `devm_extcon_dev_allocate()` will f=
ail
> with ENOSYS and the driver cannot be loaded.
>

Yeah, my bad, will fix.

>
> > +       help
> > +         Driver exposing various bits and pieces of functionality
> > +      provided by Steam Deck specific VLV0100 device presented by
> > +      EC firmware. This includes but not limited to:
> > +          - CPU/device's fan control
> > +          - Read-only access to DDIC registers
> > +          - Battery tempreature measurements
> > +          - Various display related control knobs
> > +          - USB Type-C connector event notification
> > +
> > +      Say N unless you are running on a Steam Deck.
> > +
> >  endif # X86_PLATFORM_DEVICES
> >
> >  config PMC_ATOM
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index c12a9b044fd8..2eb965e14ced 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -129,3 +129,5 @@ obj-$(CONFIG_PMC_ATOM)                    +=3D pmc_=
atom.o
> >
> >  # Siemens Simatic Industrial PCs
> >  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)    +=3D simatic-ipc.o
> > +
> > +obj-$(CONFIG_STEAMDECK)                      +=3D steamdeck.o
> > diff --git a/drivers/platform/x86/steamdeck.c b/drivers/platform/x86/st=
eamdeck.c
> > new file mode 100644
> > index 000000000000..77a6677ec19e
> > --- /dev/null
> > +++ b/drivers/platform/x86/steamdeck.c
> > @@ -0,0 +1,523 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/*
> > + * Steam Deck ACPI platform driver
> > + *
> > + * Copyright (C) 2021-2022 Valve Corporation
> > + *
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/extcon-provider.h>
> > +
> > +#define ACPI_STEAMDECK_NOTIFY_STATUS 0x80
> > +
> > +/* 0 - port connected, 1 -port disconnected */
> > +#define ACPI_STEAMDECK_PORT_CONNECT  BIT(0)
> > +/* 0 - Upstream Facing Port, 1 - Downdstream Facing Port */
> > +#define ACPI_STEAMDECK_CUR_DATA_ROLE BIT(3)
> > +/*
> > + * Debouncing delay to allow negotiation process to settle. 2s value
> > + * was arrived at via trial and error.
> > + */
> > +#define STEAMDECK_ROLE_SWITCH_DELAY  (msecs_to_jiffies(2000))
> > +
> > +struct steamdeck {
> > +     struct acpi_device *adev;
> > +     struct device *hwmon;
> > +     void *regmap;
> > +     long fan_target;
> > +     struct delayed_work role_work;
> > +     struct extcon_dev *edev;
> > +     struct device *dev;
> > +};
> > +
> > +static ssize_t
> > +steamdeck_simple_store(struct device *dev, const char *buf, size_t cou=
nt,
> > +                    const char *method,
> > +                    unsigned long upper_limit)
> > +{
> > +     struct steamdeck *fan =3D dev_get_drvdata(dev);
> > +     unsigned long value;
> > +
> > +     if (kstrtoul(buf, 10, &value) || value >=3D upper_limit)
>
> Is it not `value > upper_limit` by design?
>

Hmm, I think so. I'll switch to using clamp_val per further suggestion
which should fix this, I think.

>
> > +             return -EINVAL;
> > +
> > +     if (ACPI_FAILURE(acpi_execute_simple_method(fan->adev->handle,
> > +                                                 (char *)method, value=
)))
> > +             return -EIO;
> > +
> > +     return count;
> > +}
> > +
> > +#define STEAMDECK_ATTR_WO(_name, _method, _upper_limit)               =
       \
> > +     static ssize_t _name##_store(struct device *dev,                \
> > +                                  struct device_attribute *attr,     \
> > +                                  const char *buf, size_t count)     \
> > +     {                                                               \
> > +             return steamdeck_simple_store(dev, buf, count,          \
> > +                                         _method,                    \
> > +                                         _upper_limit);              \
> > +     }                                                               \
> > +     static DEVICE_ATTR_WO(_name)
> > +
> > +STEAMDECK_ATTR_WO(target_cpu_temp, "STCT", U8_MAX / 2);
> > +STEAMDECK_ATTR_WO(gain, "SGAN", U16_MAX);
> > +STEAMDECK_ATTR_WO(ramp_rate, "SFRR", U8_MAX);
> > +STEAMDECK_ATTR_WO(hysteresis, "SHTS",  U16_MAX);
> > +STEAMDECK_ATTR_WO(maximum_battery_charge_rate, "CHGR", U16_MAX);
> > +STEAMDECK_ATTR_WO(recalculate, "SCHG", U16_MAX);
> > +
> > +STEAMDECK_ATTR_WO(led_brightness, "CHBV", U8_MAX);
> > +STEAMDECK_ATTR_WO(content_adaptive_brightness, "CABC", U8_MAX);
> > +STEAMDECK_ATTR_WO(gamma_set, "GAMA", U8_MAX);
> > +STEAMDECK_ATTR_WO(display_brightness, "WDBV", U8_MAX);
> > +STEAMDECK_ATTR_WO(ctrl_display, "WCDV", U8_MAX);
> > +STEAMDECK_ATTR_WO(cabc_minimum_brightness, "WCMB", U8_MAX);
> > +STEAMDECK_ATTR_WO(memory_data_access_control, "MDAC", U8_MAX);
> > +
> > +#define STEAMDECK_ATTR_WO_NOARG(_name, _method)                       =
       \
> > +     static ssize_t _name##_store(struct device *dev,                \
> > +                                  struct device_attribute *attr,     \
> > +                                  const char *buf, size_t count)     \
> > +     {                                                               \
> > +             struct steamdeck *fan =3D dev_get_drvdata(dev);          =
 \
> > +                                                                     \
> > +             if (ACPI_FAILURE(acpi_evaluate_object(fan->adev->handle, =
\
> > +                                                   _method, NULL, NULL=
))) \
> > +                     return -EIO;                                    \
> > +                                                                     \
> > +             return count;                                           \
> > +     }                                                               \
> > +     static DEVICE_ATTR_WO(_name)
> > +
> > +STEAMDECK_ATTR_WO_NOARG(power_cycle_display, "DPCY");
> > +STEAMDECK_ATTR_WO_NOARG(display_normal_mode_on, "NORO");
> > +STEAMDECK_ATTR_WO_NOARG(display_inversion_off, "INOF");
> > +STEAMDECK_ATTR_WO_NOARG(display_inversion_on, "INON");
> > +STEAMDECK_ATTR_WO_NOARG(idle_mode_on, "WRNE");
> > +
> > +#define STEAMDECK_ATTR_RO(_name, _method)                            \
> > +     static ssize_t _name##_show(struct device *dev,                 \
> > +                                 struct device_attribute *attr,      \
> > +                                 char *buf)                          \
> > +     {                                                               \
> > +             struct steamdeck *jup =3D dev_get_drvdata(dev);          =
 \
>
> It's a small thing, but I am curious why is it named `jup` here when it i=
s mostly
> referred to as `sd` in other places?
>

Driver used to have a different name and this one was missed during
renaming. Will fix.

>
> > +             unsigned long long val;                                 \
> > +                                                                     \
> > +             if (ACPI_FAILURE(acpi_evaluate_integer(                 \
> > +                                      jup->adev->handle,             \
> > +                                      _method, NULL, &val)))         \
> > +                     return -EIO;                                    \
> > +                                                                     \
> > +             return sprintf(buf, "%llu\n", val);                     \
>
> You can use `sysfs_emit()`.
>

Will do, thanks.

>
> > +     }                                                               \
> > +     static DEVICE_ATTR_RO(_name)
> > +
> > +STEAMDECK_ATTR_RO(firmware_version, "PDFW");
> > +STEAMDECK_ATTR_RO(board_id, "BOID");
> > +STEAMDECK_ATTR_RO(pdcs, "PDCS");
> > +
> > +static umode_t
> > +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int=
 index)
> > +{
> > +     return attr->mode;
> > +}
> > +
> > +static struct attribute *steamdeck_attributes[] =3D {
> > +     &dev_attr_target_cpu_temp.attr,
> > +     &dev_attr_gain.attr,
> > +     &dev_attr_ramp_rate.attr,
> > +     &dev_attr_hysteresis.attr,
> > +     &dev_attr_maximum_battery_charge_rate.attr,
> > +     &dev_attr_recalculate.attr,
> > +     &dev_attr_power_cycle_display.attr,
> > +
> > +     &dev_attr_led_brightness.attr,
>
> Have you considered using a led class device instead? I think that should
> work even without the ability to query the brightness.
>

Not very seriously. Will take another look.

>
> > +     &dev_attr_content_adaptive_brightness.attr,
> > +     &dev_attr_gamma_set.attr,
> > +     &dev_attr_display_brightness.attr,
>
> Have you considered using a backlight class device?
>

Ditto.

>
> > +     &dev_attr_ctrl_display.attr,
> > +     &dev_attr_cabc_minimum_brightness.attr,
> > +     &dev_attr_memory_data_access_control.attr,
> > +
> > +     &dev_attr_display_normal_mode_on.attr,
> > +     &dev_attr_display_inversion_off.attr,
> > +     &dev_attr_display_inversion_on.attr,
> > +     &dev_attr_idle_mode_on.attr,
> > +
> > +     &dev_attr_firmware_version.attr,
> > +     &dev_attr_board_id.attr,
> > +     &dev_attr_pdcs.attr,
> > +
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group steamdeck_group =3D {
> > +     .attrs =3D steamdeck_attributes,
> > +     .is_visible =3D steamdeck_is_visible,
> > +};
> > +
> > +static const struct attribute_group *steamdeck_groups[] =3D {
> > +     &steamdeck_group,
> > +     NULL
> > +};
> > +
> > +static int steamdeck_read_fan_speed(struct steamdeck *jup, long *speed=
)
> > +{
> > +     unsigned long long val;
> > +
> > +     if (ACPI_FAILURE(acpi_evaluate_integer(jup->adev->handle,
> > +                                            "FANR", NULL, &val)))
> > +             return -EIO;
> > +
> > +     *speed =3D val;
> > +     return 0;
> > +}
> > +
> > +static int
> > +steamdeck_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > +                  u32 attr, int channel, long *out)
> > +{
> > +     struct steamdeck *sd =3D dev_get_drvdata(dev);
> > +     unsigned long long val;
> > +
> > +     switch (type) {
> > +     case hwmon_temp:
> > +             if (attr !=3D hwmon_temp_input)
> > +                     return -EOPNOTSUPP;
> > +
> > +             if (ACPI_FAILURE(acpi_evaluate_integer(sd->adev->handle,
> > +                                                    "BATT", NULL, &val=
)))
> > +                     return -EIO;
> > +             /*
> > +              * Assuming BATT returns deg C we need to mutiply it
> > +              * by 1000 to convert to mC
> > +              */
> > +             *out =3D val * 1000;
> > +             break;
> > +     case hwmon_fan:
> > +             switch (attr) {
> > +             case hwmon_fan_input:
> > +                     return steamdeck_read_fan_speed(sd, out);
> > +             case hwmon_fan_target:
> > +                     *out =3D sd->fan_target;
> > +                     break;
> > +             case hwmon_fan_fault:
> > +                     if (ACPI_FAILURE(acpi_evaluate_integer(
> > +                                              sd->adev->handle,
> > +                                              "FANC", NULL, &val)))
> > +                             return -EIO;
> > +                     /*
> > +                      * FANC (Fan check):
> > +                      * 0: Abnormal
> > +                      * 1: Normal
> > +                      */
> > +                     *out =3D !val;
> > +                     break;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +steamdeck_hwmon_read_string(struct device *dev, enum hwmon_sensor_type=
s type,
> > +                         u32 attr, int channel, const char **str)
> > +{
> > +     switch (type) {
> > +     case hwmon_temp:
> > +             *str =3D "Battery Temp";
> > +             break;
> > +     case hwmon_fan:
> > +             *str =3D "System Fan";
> > +             break;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +steamdeck_hwmon_write(struct device *dev, enum hwmon_sensor_types type=
,
> > +                   u32 attr, int channel, long val)
> > +{
> > +     struct steamdeck *sd =3D dev_get_drvdata(dev);
> > +
> > +     if (type !=3D hwmon_fan ||
> > +         attr !=3D hwmon_fan_target)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (val > U16_MAX)
> > +             return -EINVAL;
>
> What if `val < 0` ?
>

Good point. I'll be reworking this to use clamp_val()

>
> > +
> > +     sd->fan_target =3D val;
> > +
> > +     if (ACPI_FAILURE(acpi_execute_simple_method(sd->adev->handle,
> > +                                                 "FANS", val)))
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static umode_t
> > +steamdeck_hwmon_is_visible(const void *data, enum hwmon_sensor_types t=
ype,
> > +                        u32 attr, int channel)
> > +{
> > +     if (type =3D=3D hwmon_fan &&
> > +         attr =3D=3D hwmon_fan_target)
> > +             return 0644;
> > +
> > +     return 0444;
> > +}
> > +
> > +static const struct hwmon_channel_info *steamdeck_info[] =3D {
> > +     HWMON_CHANNEL_INFO(temp,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL),
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT | HWMON_F_LABEL |
> > +                        HWMON_F_TARGET | HWMON_F_FAULT),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops steamdeck_hwmon_ops =3D {
> > +     .is_visible =3D steamdeck_hwmon_is_visible,
> > +     .read =3D steamdeck_hwmon_read,
> > +     .read_string =3D steamdeck_hwmon_read_string,
> > +     .write =3D steamdeck_hwmon_write,
> > +};
> > +
> > +static const struct hwmon_chip_info steamdeck_chip_info =3D {
> > +     .ops =3D &steamdeck_hwmon_ops,
> > +     .info =3D steamdeck_info,
> > +};
> > +
> > +#define STEAMDECK_STA_OK                     \
> > +     (ACPI_STA_DEVICE_ENABLED |              \
> > +      ACPI_STA_DEVICE_PRESENT |              \
> > +      ACPI_STA_DEVICE_FUNCTIONING)
> > +
> > +static int
> > +steamdeck_ddic_reg_read(void *context, unsigned int reg, unsigned int =
*val)
> > +{
> > +     union acpi_object obj =3D { .type =3D ACPI_TYPE_INTEGER };
> > +     struct acpi_object_list arg_list =3D { .count =3D 1, .pointer =3D=
 &obj, };
> > +     struct steamdeck *sd =3D context;
> > +     unsigned long long _val;
> > +
> > +     obj.integer.value =3D reg;
> > +
> > +     if (ACPI_FAILURE(acpi_evaluate_integer(sd->adev->handle,
> > +                                            "RDDI", &arg_list, &_val))=
)
> > +             return -EIO;
> > +
> > +     *val =3D _val;
> > +     return 0;
> > +}
> > +
> > +static int steamdeck_read_pdcs(struct steamdeck *sd, unsigned long lon=
g *pdcs)
> > +{
> > +     acpi_status status;
> > +
> > +     status =3D acpi_evaluate_integer(sd->adev->handle, "PDCS", NULL, =
pdcs);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_err(sd->dev, "PDCS evaluation failed: %s\n",
> > +                     acpi_format_exception(status));
> > +             return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void steamdeck_usb_role_work(struct work_struct *work)
> > +{
> > +     struct steamdeck *sd =3D
> > +             container_of(work, struct steamdeck, role_work.work);
> > +     unsigned long long pdcs;
> > +     bool usb_host;
> > +
> > +     if (steamdeck_read_pdcs(sd, &pdcs))
> > +             return;
> > +
> > +     /*
> > +      * We only care about these two
> > +      */
> > +     pdcs &=3D ACPI_STEAMDECK_PORT_CONNECT | ACPI_STEAMDECK_CUR_DATA_R=
OLE;
> > +
> > +     /*
> > +      * For "connect" events our role is determined by a bit in
> > +      * PDCS, for "disconnect" we switch to being a gadget
> > +      * unconditionally. The thinking for the latter is we don't
> > +      * want to start acting as a USB host until we get
> > +      * confirmation from the firmware that we are a USB host
> > +      */
> > +     usb_host =3D (pdcs & ACPI_STEAMDECK_PORT_CONNECT) ?
> > +             pdcs & ACPI_STEAMDECK_CUR_DATA_ROLE : false;
> > +
> > +     WARN_ON(extcon_set_state_sync(sd->edev, EXTCON_USB_HOST,
> > +                                   usb_host));
> > +     dev_dbg(sd->dev, "USB role is %s\n", usb_host ? "host" : "device"=
);
> > +}
> > +
> > +static void steamdeck_notify(acpi_handle handle, u32 event, void *cont=
ext)
> > +{
> > +     struct device *dev =3D context;
> > +     struct steamdeck *sd =3D dev_get_drvdata(dev);
> > +     unsigned long long pdcs;
> > +     unsigned long delay;
> > +
> > +     switch (event) {
> > +     case ACPI_STEAMDECK_NOTIFY_STATUS:
> > +             if (steamdeck_read_pdcs(sd, &pdcs))
> > +                     return;
> > +             /*
> > +              * We process "disconnect" events immediately and
> > +              * "connect" events with a delay to give the HW time
> > +              * to settle. For example attaching USB hub (at least
> > +              * for HW used for testing) will generate intermediary
> > +              * event with "host" bit not set, followed by the one
> > +              * that does have it set.
> > +              */
> > +             delay =3D (pdcs & ACPI_STEAMDECK_PORT_CONNECT) ?
> > +                     STEAMDECK_ROLE_SWITCH_DELAY : 0;
> > +
> > +             queue_delayed_work(system_long_wq, &sd->role_work, delay)=
;
> > +             break;
> > +     default:
> > +             dev_err(dev, "Unsupported event [0x%x]\n", event);
>
> Since this is not fatal, I think `dev_warn()` would be better.
>

OK, will change.

>
> > +     }
> > +}
> > +
> > +static void steamdeck_remove_notify_handler(void *data)
> > +{
> > +     struct steamdeck *sd =3D data;
> > +
> > +     acpi_remove_notify_handler(sd->adev->handle, ACPI_DEVICE_NOTIFY,
> > +                                steamdeck_notify);
> > +     cancel_delayed_work_sync(&sd->role_work);
> > +}
> > +
> > +static const unsigned int steamdeck_extcon_cable[] =3D {
> > +     EXTCON_USB,
> > +     EXTCON_USB_HOST,
> > +     EXTCON_CHG_USB_SDP,
> > +     EXTCON_CHG_USB_CDP,
> > +     EXTCON_CHG_USB_DCP,
> > +     EXTCON_CHG_USB_ACA,
> > +     EXTCON_NONE,
> > +};
> > +
> > +static int steamdeck_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct steamdeck *sd;
> > +     acpi_status status;
> > +     unsigned long long sta;
> > +     int ret;
> > +
> > +     static const struct regmap_config regmap_config =3D {
> > +             .reg_bits =3D 8,
> > +             .val_bits =3D 8,
> > +             .max_register =3D 255,
> > +             .cache_type =3D REGCACHE_NONE,
> > +             .reg_read =3D steamdeck_ddic_reg_read,
> > +     };
> > +
> > +     sd =3D devm_kzalloc(dev, sizeof(*sd), GFP_KERNEL);
> > +     if (!sd)
> > +             return -ENOMEM;
> > +     sd->adev =3D ACPI_COMPANION(&pdev->dev);
> > +     sd->dev =3D dev;
> > +     platform_set_drvdata(pdev, sd);
> > +     INIT_DELAYED_WORK(&sd->role_work, steamdeck_usb_role_work);
> > +
> > +     status =3D acpi_evaluate_integer(sd->adev->handle, "_STA",
> > +                                    NULL, &sta);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_err(dev, "Status check failed (0x%x)\n", status);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if ((sta & STEAMDECK_STA_OK) !=3D STEAMDECK_STA_OK) {
> > +             dev_err(dev, "Device is not ready\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /*
> > +      * Our ACPI interface doesn't expose a method to read current
> > +      * fan target, so we use current fan speed as an
> > +      * approximation.
> > +      */
> > +     if (steamdeck_read_fan_speed(sd, &sd->fan_target))
> > +             dev_warn(dev, "Failed to read fan speed");
> > +
> > +     sd->hwmon =3D devm_hwmon_device_register_with_info(dev,
> > +                                                      "steamdeck",
> > +                                                      sd,
> > +                                                      &steamdeck_chip_=
info,
> > +                                                      steamdeck_groups=
);
> > +     if (IS_ERR(sd->hwmon)) {
> > +             dev_err(dev, "Failed to register HWMON device");
> > +             return PTR_ERR(sd->hwmon);
> > +     }
> > +
> > +     sd->regmap =3D devm_regmap_init(dev, NULL, sd, &regmap_config);
> > +     if (IS_ERR(sd->regmap))
> > +             dev_err(dev, "Failed to register REGMAP");
> > +
> > +     sd->edev =3D devm_extcon_dev_allocate(dev, steamdeck_extcon_cable=
);
> > +     if (IS_ERR(sd->edev))
> > +             return -ENOMEM;
>
> Maybe
>
>   return PTR_ERR(sd->edev)
>
> would be better?
>

Makes sense, will change.

>
> > +
> > +     ret =3D devm_extcon_dev_register(dev, sd->edev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to register extcon device: %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Set initial role value
> > +      */
> > +     queue_delayed_work(system_long_wq, &sd->role_work, 0);
> > +     flush_delayed_work(&sd->role_work);
> > +
> > +     status =3D acpi_install_notify_handler(sd->adev->handle,
> > +                                          ACPI_DEVICE_NOTIFY,
> > +                                          steamdeck_notify,
> > +                                          dev);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_err(dev, "Error installing ACPI notify handler\n");
> > +             return -EIO;
> > +     }
> > +
> > +     ret =3D devm_add_action_or_reset(dev, steamdeck_remove_notify_han=
dler,
> > +                                    sd);
> > +     return ret;
> > +}
> > +
> > +static const struct acpi_device_id steamdeck_device_ids[] =3D {
> > +     { "VLV0100", 0 },
> > +     { "", 0 },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, steamdeck_device_ids);
> > +
> > +static struct platform_driver steamdeck_driver =3D {
> > +     .probe =3D steamdeck_probe,
> > +     .driver =3D {
> > +             .name =3D "steamdeck",
> > +             .acpi_match_table =3D steamdeck_device_ids,
> > +     },
> > +};
> > +module_platform_driver(steamdeck_driver);
> > +
> > +MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
> > +MODULE_DESCRIPTION("Steam Deck ACPI platform driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
>
>
> Regards,
> Barnab=C3=A1s P=C5=91cze
