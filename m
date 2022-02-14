Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364864B44C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiBNIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:47:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBNIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:47:10 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821044EA0F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:47:03 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id i27so294746vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=taYksPnVY5pJMwk/HmGJeKrRSkkr8l0mG1ddKJHLIxU=;
        b=gDwReEsv4bRWkypdgtNevukZVJtaSNxvBz+u0Yw5m0e/vMDEW3Ri+dMr/5otM2H5cT
         VQt3mdpWhZ6LI7n6dIRWmuNuAVERxe4Y1XBGXk37P9FyFTsht5AxtL+9S7khi6iHjzuq
         NfkD82F47injCkpVRuBv1o5Rzh0raNtB5Yxoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=taYksPnVY5pJMwk/HmGJeKrRSkkr8l0mG1ddKJHLIxU=;
        b=6Ss2VpVL24SX1tseUYxGWuj7+LenKH9dKu+nV7Mjr3VQZ7ciHnaiyxHuiKGCjLupqn
         MJ14QcJrb6pQ1+5unIxgI5BIQBDNC9WREiU8rxffV476zIVBw9bBfMWYCMUKVz5b7CdM
         Ij4Hp8OFUPvzVSWkDbM2O/Ja0uT/D4Kp/U5CtGP0ZEWk1MmbLKZbrCI2R9q34R8Zib4V
         kSqIs82SzTA3h4wf0mpGQtmNcLCAdjtA0sJuf7Q9XqaSSeNKvq1wsyttNwzPmaLHOV6Y
         KMV0n8Nsu4ijBkuYoLxDnoP/90BBVg9VMw5EBaeGHu7gHvYfgyZdhm49sSt+4u+K2E+K
         j0VQ==
X-Gm-Message-State: AOAM533RSEFLkFD2BP5L7lsWgWDriz8PpE/DJMYF35r+tbUMjhKjjoMB
        +LQIytI//9q964Ed/4llcDI4ukyJ8MbjHRwyBfyrng==
X-Google-Smtp-Source: ABdhPJxJOdIX0vpaF+uFKtQuKc3o75TuUPkGnPVJi23kP9It44Ga/9ZpiDKwRpjvZKTfd2YngKDP9eXTFgKmoS3TYGE=
X-Received: by 2002:a67:1a81:: with SMTP id a123mr3553687vsa.67.1644828422333;
 Mon, 14 Feb 2022 00:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20220207013613.1150783-1-skyostil@chromium.org>
 <20220207013613.1150783-2-skyostil@chromium.org> <YgSli/6HuZ+i+2gb@google.com>
 <CAPuLczuizJkwHsKo+W3MEjX7T_fHXApVyou3BuMH_aAQfyk1Vg@mail.gmail.com> <Ygm0+3S/Q+JHzzxB@google.com>
In-Reply-To: <Ygm0+3S/Q+JHzzxB@google.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Mon, 14 Feb 2022 19:46:50 +1100
Message-ID: <CAPuLcztqUaDWtgYe0KX0VWUMi8DLiO0a5Js4PCck9zH7=h+qCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] platform/chrome: add a driver for HPS
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, evanbenn@chromium.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ma 14. helmik. 2022 klo 12.48 Tzung-Bi Shih (tzungbi@google.com) kirjoitti:
>
> Hi,
>
> Left some follow-up questions before going for the v4.  Please also cc th=
e
> following patches to <chrome-platform@lists.linux.dev> in case we would
> overlook them from LKML.

Thank you, I appreciate the feedback!

>
> On Fri, Feb 11, 2022 at 08:08:45PM +1100, Sami Kyostila wrote:
> > ( to 10. helmik. 2022 klo 16.41 Tzung-Bi Shih (tzungbi@google.com) kirj=
oitti:
> > >
> > > On Mon, Feb 07, 2022 at 12:36:13PM +1100, Sami Ky=C3=B6stil=C3=A4 wro=
te:
> > > > When loaded, the driver exports the sensor to userspace through a
> > > > character device. This device only supports power management, i.e.,
> > > > communication with the sensor must be done through regular I2C
> > > > transmissions from userspace.
> > > >
> > > > Power management is implemented by enabling the respective power GP=
IO
> > > > while at least one userspace process holds an open fd on the charac=
ter
> > > > device. By default, the device is powered down if there are no acti=
ve
> > > > clients.
> > > >
> > > > Note that the driver makes no effort to preserve the state of the s=
ensor
> > > > between power down and power up events. Userspace is responsible fo=
r
> > > > reinitializing any needed state once power has been restored.
> > >
> > > It's weird.  If most of the thing is done by userspace programs, coul=
dn't it
> > > set the power GPIO via userspace interface (e.g. [1]) too?
> >
> > I agree that's a little unusual, but there are some good reasons for
> > this to be in the kernel. First, it lets us turn HPS off during system
> > suspend -- which I'm not sure how you'd do from userspace. Second, it
> > avoids the need to give write access to the entire GPIO chip to the
> > hpsd userspace daemon. We just need a single line, while the
> > controller in this case has a total of 360 gpios. Finally, HPS also
> > has an interrupt line, and we're planning to let it wake up the host,
> > which I also believe needs to be done in the kernel.
>
> What prevents it from implementing the I2C communication in kernel?
>
> Did you investigate if there are any existing frameworks for HPS
> (e.g. drivers/iio/)?  I am wondering if kernel already has some abstract =
code
> for HPS.
>
> Only found one via:
> $ git grep 'human presence sensor'
> drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h: [...]

Yes, we did look into some existing mechanisms in the kernel this
could fit into. HID was probably the closest fit since the spec has
been recently expanded with human presence sensing (in fact, the first
revision of this driver was HID-based[1]), but a few reasons made it a
poor fit:

1. Our HPS hardware doesn't use the HID-I2C wire protocol, so we'd
still need a bespoke I2C communication layer.

2. HPS uses a somewhat complex multi-stage firmware update process,
and we didn't feel comfortable trying to push that down into the
kernel at this point.

3. The feature set of HPS is still evolving, so this doesn't seem like
the right time to bake specific functionality into a syscall
interface.

I also had a quick look at iio, but it felt a bit overkill for the
very small amount of data HPS generates.

My feeling is that HID-I2C is probably the right long term fit, but
it'll take some time (and HW iterations) to get there. Earlier in the
patch series we discussed an intermediate step where we make it
possible to expose individual I2C devices to userspace through
separate device nodes, which will help reduce the attack surface of
giving userspace write access to the entire I2C bus just for HPS.

[1] go/hps-kernel-driver (sorry for the internal link)

> > > > +static void hps_unload(void *drv_data)
> > > > +{
> > > > +     struct hps_drvdata *hps =3D drv_data;
> > > > +
> > > > +     hps_set_power(hps, true);
> > >
> > > Why does it need to set to true when device removing?
> >
> > By default, HPS is powered on when the system starts and before the
> > driver is loaded. We want to restore it to that default state here.
> > This is needed for example for automated testing, where we can unbind
> > the driver to make sure HPS stays powered.
>
> Echo to the idea of previous comment: does kernel have any frameworks for=
 HPS?
> "HPS is powered on when the system starts" sounds like a chip specific
> implementation.

True, that's more of an implementation detail of our system rather
than any hard guarantee. I'll change this to save and restore the
power state that was there before the driver got loaded.

> > > > +static int hps_suspend(struct device *dev)
> > > > +{
> > > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > > +     struct hps_drvdata *hps =3D i2c_get_clientdata(client);
> > > > +
> > > > +     hps_set_power(hps, false);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int hps_resume(struct device *dev)
> > > > +{
> > > > +     struct i2c_client *client =3D to_i2c_client(dev);
> > > > +     struct hps_drvdata *hps =3D i2c_get_clientdata(client);
> > > > +
> > > > +     hps_set_power(hps, true);
> > > > +     return 0;
> > > > +}
> > >
> > > Does it need to save the old state before suspending?  Instead of tur=
ning on
> > > the power after every resumes.
> >
> > No, the runtime pm system makes sure suspend and resume are only
> > called when needed. For example, if someone has an open reference to
> > the device when the system goes to sleep, suspend and resume are
> > called appropriately. If HPS was already suspended, then neither
> > entrypoint gets called when going to sleep or waking up.
>
> It uses UNIVERSAL_DEV_PM_OPS() which also sets for .suspend() and .resume=
().
> OTOH, the documentation suggests it has deprecated (see include/linux/pm.=
h).

Thanks, I think I missed this distinction between .suspend/resume()
and .runtime_suspend/resume(). As far as I can tell it shouldn't make
a difference in practice since we are just toggling a GPIO pin, but
I'll nevertheless fix it for consistency.

- Sami
