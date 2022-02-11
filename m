Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8237F4B2105
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiBKJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:09:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbiBKJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:09:00 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0B1028
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:08:58 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i26so5863345vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0KOVwirQQBNGOX4G5quJ1fMnOjQ7Nk3bktohVFnVL9Q=;
        b=isShAkpIaF4YVuBMEixjDdC5hD9AGNT70itg07YA9zsSXOYnfLMg5K9Q17+pArRtat
         dUBjpYQ+vd/hd67cELBAHuOkQXluTpK5BsAo1BLpxQseIJ/B96lGhZlfUz6gFU3SkTTD
         P8lfthBKMnTf2QYozzCgQ2MTW6+3r8Yzkbjpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0KOVwirQQBNGOX4G5quJ1fMnOjQ7Nk3bktohVFnVL9Q=;
        b=1lUDHVYSSY6rGW87bDpo+1HKA7OaZ1lcdnrRC+ADdnFZC07pXCZmEvxad7naJck/ka
         TbOBlez5MAZgZZziypTDcadVvnprn28xsBq5wOn/kFG9mRJraCYbEqBi06JDgye6r9cm
         6tCnCeF32jKSh9B9IVaIydIZXnN1fAds/VL48dcwrNB0bWCYCIeNZh9UYxlmvtj/+ehm
         DnIJz0WFhYTqZ56K63RRnWuF500QtA0pLEIAYowd1LMgsqv8NkF+/IxFmiSZkM6p+nAQ
         +TrYL5sZU+LKupLV3BxNiHEN18Q/hkeBYwpQBEaf+UNVwuRlWUlfsN3aBnWZ/8z70HBm
         pNQg==
X-Gm-Message-State: AOAM531yXi40kehDGr0TsWsnNB45ISQc7QcjLZtdXqjPM6VezPVCRMzA
        lmojMsZ/bu2TrrtAsghiRkEmmBLuMP4r0E6jfkR0vg==
X-Google-Smtp-Source: ABdhPJx3B1s2gkSrrBvmi6Jh+td1qANZQnuqD9w7VsCLiznoyrWYK+MIfdrAwq989w77OZclxt9gMCDS70+TlPQ1w0E=
X-Received: by 2002:a67:b00e:: with SMTP id z14mr221962vse.57.1644570536901;
 Fri, 11 Feb 2022 01:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20220207013613.1150783-1-skyostil@chromium.org>
 <20220207013613.1150783-2-skyostil@chromium.org> <YgSli/6HuZ+i+2gb@google.com>
In-Reply-To: <YgSli/6HuZ+i+2gb@google.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Fri, 11 Feb 2022 20:08:45 +1100
Message-ID: <CAPuLczuizJkwHsKo+W3MEjX7T_fHXApVyou3BuMH_aAQfyk1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] platform/chrome: add a driver for HPS
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, evanbenn@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

( to 10. helmik. 2022 klo 16.41 Tzung-Bi Shih (tzungbi@google.com) kirjoitt=
i:
>
> On Mon, Feb 07, 2022 at 12:36:13PM +1100, Sami Ky=C3=B6stil=C3=A4 wrote:
> > This patch introduces a driver for the ChromeOS screen privacy
> > sensor (aka. HPS). The driver supports a sensor connected to the I2C bu=
s
> > and identified as "GOOG0020" in the ACPI tables.

Thanks for the review!

> The patch uses HPS instead of SPS everywhere.  Would you consider to use
> "human presence sensor" when referring it?

Sure thing, I'll unify the terminology. There are a few different
names going around for the user-facing features powered by the sensor
which makes this a bit confusing.

> > When loaded, the driver exports the sensor to userspace through a
> > character device. This device only supports power management, i.e.,
> > communication with the sensor must be done through regular I2C
> > transmissions from userspace.
> >
> > Power management is implemented by enabling the respective power GPIO
> > while at least one userspace process holds an open fd on the character
> > device. By default, the device is powered down if there are no active
> > clients.
> >
> > Note that the driver makes no effort to preserve the state of the senso=
r
> > between power down and power up events. Userspace is responsible for
> > reinitializing any needed state once power has been restored.
>
> It's weird.  If most of the thing is done by userspace programs, couldn't=
 it
> set the power GPIO via userspace interface (e.g. [1]) too?

I agree that's a little unusual, but there are some good reasons for
this to be in the kernel. First, it lets us turn HPS off during system
suspend -- which I'm not sure how you'd do from userspace. Second, it
avoids the need to give write access to the entire GPIO chip to the
hpsd userspace daemon. We just need a single line, while the
controller in this case has a total of 360 gpios. Finally, HPS also
has an interrupt line, and we're planning to let it wake up the host,
which I also believe needs to be done in the kernel.

>
> [1]: https://embeddedbits.org/new-linux-kernel-gpio-user-space-interface/
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> [...]
> > +HPS (ChromeOS screen privacy sensor) DRIVER
>
> Does it make more sense to use "CHROMEOS HPS DRIVER" title?

Good idea, done.

> > diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/=
chrome/cros_hps_i2c.c
> [...]
> > +static void hps_set_power(struct hps_drvdata *hps, bool state)
> > +{
> > +     if (!IS_ERR_OR_NULL(hps->enable_gpio))
>
> Could it get rid of the check?  Does the function get called if device pr=
obe
> fails?

True, done.

> > +static void hps_unload(void *drv_data)
> > +{
> > +     struct hps_drvdata *hps =3D drv_data;
> > +
> > +     hps_set_power(hps, true);
>
> Why does it need to set to true when device removing?

By default, HPS is powered on when the system starts and before the
driver is loaded. We want to restore it to that default state here.
This is needed for example for automated testing, where we can unbind
the driver to make sure HPS stays powered.

> > +static int hps_open(struct inode *inode, struct file *file)
> > +{
> > +     struct hps_drvdata *hps =3D container_of(file->private_data,
> > +                                            struct hps_drvdata, misc_d=
evice);
> > +     struct device *dev =3D &hps->client->dev;
> > +     int ret;
> > +
> > +     ret =3D pm_runtime_get_sync(dev);
> > +     if (ret < 0)
> > +             goto pm_get_fail;
> > +     return 0;
> > +
> > +pm_get_fail:
> > +     pm_runtime_put(dev);
> > +     pm_runtime_disable(dev);
>
> The two functions are not effectively symmetric if pm_runtime_get_sync()
> fails.
> - It doesn't need to call pm_runtime_put() if pm_runtime_get_sync() fails=
.
> - I guess it wouldn't want to pm_runtime_disable() here.  The capability =
is
>   controlled when the device probing and removing.

According to the documentation, pm_runtime_get_sync() always bumps the
usage count, including in failure cases. However there's
pm_runtime_resume_and_get() which doesn't increment the counter for
failures, so I've switched to that so that we don't have to handle the
error case here. I agree that pm_runtime_disable() isn't really
necessary here -- removed.

> > +static int hps_release(struct inode *inode, struct file *file)
> > +{
> > +     struct hps_drvdata *hps =3D container_of(file->private_data,
> > +                                            struct hps_drvdata, misc_d=
evice);
> > +     struct device *dev =3D &hps->client->dev;
> > +     int ret;
> > +
> > +     ret =3D pm_runtime_put(dev);
> > +     if (ret < 0)
> > +             goto pm_put_fail;
> > +     return 0;
> > +
> > +pm_put_fail:
> > +     pm_runtime_disable(dev);
>
> Same here.

Removed.

>
> > +const struct file_operations hps_fops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .open =3D hps_open,
> > +     .release =3D hps_release,
> > +};
>
> The struct can be static.

Done.

>
> > +static int hps_i2c_probe(struct i2c_client *client)
> > +{
> > +     struct hps_drvdata *hps;
> > +     int ret =3D 0;
>
> It doesn't need to be initialized.  It's going to be overridden soon.

Fixed.

> > +     memset(&hps->misc_device, 0, sizeof(hps->misc_device));
> > +     hps->misc_device.parent =3D &client->dev;
> > +     hps->misc_device.minor =3D MISC_DYNAMIC_MINOR;
> > +     hps->misc_device.name =3D "hps";
>
> Does "cros_hps_i2c" or "cros_hps" make more sense?

Changed to "cros-hps" to better match the driver's name (and the
naming convention of other Chrome OS drivers).

> > +     ret =3D devm_add_action(&client->dev, &hps_unload, hps);
> > +     if (ret) {
> > +             dev_err(&client->dev,
> > +                     "failed to install unload action: %d\n", ret);
> > +             return ret;
> > +     }
>
> Why does it need to call hps_unload() when device removing?  Couldn't it =
put
> the code in hps_i2c_remove()?

Ah, this was left over from an earlier version where the
setup/teardown sequence was a little more complex. Agreed and moved to
hps_i2c_remove.

>
> > +     hps_set_power(hps, false);
> > +     pm_runtime_enable(&client->dev);
> > +     return ret;
>
> Using `return 0;` makes it clear.

Done.

> > +static int hps_suspend(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct hps_drvdata *hps =3D i2c_get_clientdata(client);
> > +
> > +     hps_set_power(hps, false);
> > +     return 0;
> > +}
> > +
> > +static int hps_resume(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct hps_drvdata *hps =3D i2c_get_clientdata(client);
> > +
> > +     hps_set_power(hps, true);
> > +     return 0;
> > +}
>
> Does it need to save the old state before suspending?  Instead of turning=
 on
> the power after every resumes.

No, the runtime pm system makes sure suspend and resume are only
called when needed. For example, if someone has an open reference to
the device when the system goes to sleep, suspend and resume are
called appropriately. If HPS was already suspended, then neither
entrypoint gets called when going to sleep or waking up.

> > +static const struct i2c_device_id hps_i2c_id[] =3D {
> > +     { "hps", 0 },
>
> Does "cros_hps_i2c" or "cros_hps" make more sense?

Went with "cros-hps".

> > +static struct i2c_driver hps_i2c_driver =3D {
> > +     .probe_new =3D hps_i2c_probe,
> > +     .remove =3D hps_i2c_remove,
> > +     .id_table =3D hps_i2c_id,
> > +     .driver =3D {
> > +             .name =3D "hps",
>
> Does "cros_hps_i2c" or "cros_hps" make more sense?

Ditto.

> > +#ifdef CONFIG_ACPI
> > +             .acpi_match_table =3D ACPI_PTR(hps_acpi_id),
> > +#endif
>
> It doesn't need the guard as ACPI_PTR() already does.

Ah, good to know!

- Sami
