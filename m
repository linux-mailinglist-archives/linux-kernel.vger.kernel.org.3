Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631BC59E9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiHWRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiHWReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:34:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEE7D1FC;
        Tue, 23 Aug 2022 08:13:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u24so8226861lji.0;
        Tue, 23 Aug 2022 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CSqkYPAyRqO5N2lNYSGZuEqbPoNq5Wl5uPjFUZY3VVY=;
        b=AojDAgiupfOinUSFXJcaDjw6/okbv+oyi9ROOekjZYsQOOYBjwu0aGal9qKluDj5/d
         L5O1bHJ/cv7CBsC7fIe+LOc4UzEyGLMcDyeLQwzGu0027yh3d+uJYxnxvxn6Gql18UBa
         gBNtaao99vpMe952jhn5gPhCCBCvj/EEwoGzko87BuNlF6MkzvJy82UfF240nRuM2ayp
         WYSbC3iI9vk/sx0fc6v/qTrr14KC8XwR9xNymM1VwiCaDC7xjQiKdXO/aTtb54p16X5s
         A2DpJazSuL0NTA1CJfZcDVvrEYsYoXdYDY/eoyxZFb3OaeUItHN4DRnrZMSJt4agnay5
         z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CSqkYPAyRqO5N2lNYSGZuEqbPoNq5Wl5uPjFUZY3VVY=;
        b=xnkq5bKg7AUp7jbGMYScpsUDW+KrAoGAsczq0PSF2IlgHV5Vpr8Tg0OOGEZr0PtPQd
         RCXxxJ1tR5rH6UvNmk0IaV5Q0PfbRy06Dwlsj6Vitba7RLDHMZICMqo+fVZqDf+z/BXi
         elR0dv8rJPFSF88OaQCBn8uHvgWM/k/pGYM/zhXvdr/3zw6Q3tuOTLT63/SBJJikt7pR
         anXeeWPMHbn8KDMJvL/ijnTur2vumbzd3Ck5d+VrRkw7XFJ3DPBrRHl+wNNwDLpRHQHZ
         jS42UIWIqvje2ncmQnOaDfdv5WWULxgK393RAkLCJWC6YNUuyHbeI98MOEdbNqAbb7FO
         1MpA==
X-Gm-Message-State: ACgBeo3UmEMqhhW1guHEZmBYl8BN3vGZRoS/gp0ZpHbss09MGAAyqlDk
        sDZVIm4MljLSr4UXRfEtKAo=
X-Google-Smtp-Source: AA6agR6qmRIMAR+HkVQpAhUNRt4HZBDBepKIwQZfZ4zo6Kv6yRaT4S7PNza1ROMvQUqXaMQejW+qZg==
X-Received: by 2002:a2e:9e0b:0:b0:261:d9ac:b533 with SMTP id e11-20020a2e9e0b000000b00261d9acb533mr569107ljk.74.1661267590346;
        Tue, 23 Aug 2022 08:13:10 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id d20-20020ac241d4000000b0048b045a5c3asm73487lfi.201.2022.08.23.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:13:09 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:18:04 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <YwTvrNuulKx0SB6H@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O6mxBkcZjd/3ARLA"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O6mxBkcZjd/3ARLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you  Benjamin,

On Tue, Aug 23, 2022 at 11:49:59AM +0200, Benjamin Tissoires wrote:
> Hi Marcus,
>=20
> [and sorry for the delay in the review of your patches]
>=20
> On Mon, Aug 22, 2022 at 8:04 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > Several RC Simulator Controllers are HID compliant with similar
> > interface.
> >
> > Add support for these controllers:
> >  - Phoenix RC (HID variant)
> >  - Car VRC2.0
> >  - Real Flight G5/G6/G7
> >  - Aero Fly, FMS
> >  - OrangeRX FrSky
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  Documentation/hid/index.rst |   1 +
> >  Documentation/hid/rcsim.rst | 142 ++++++++++++++++
> >  drivers/hid/Kconfig         |  11 ++
> >  drivers/hid/Makefile        |   1 +
> >  drivers/hid/hid-ids.h       |   5 +
> >  drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++++++++++
> >  6 files changed, 475 insertions(+)
> >  create mode 100644 Documentation/hid/rcsim.rst
> >  create mode 100644 drivers/hid/hid-rcsim.c
> >
> > diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.rst
> > index e50f513c579c..e5813d264f37 100644
> > --- a/Documentation/hid/index.rst
> > +++ b/Documentation/hid/index.rst
> > @@ -17,3 +17,4 @@ Human Interface Devices (HID)
> >     hid-alps
> >     intel-ish-hid
> >     amd-sfh-hid
> > +   rcsim
> > diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rcsim.rst
> > new file mode 100644
> > index 000000000000..1a031f7189cb
> > --- /dev/null
> > +++ b/Documentation/hid/rcsim.rst
> > @@ -0,0 +1,142 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +rcsim - RC Simulator Controllers
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > +
> > +This driver let you use your own RC controller plugged
> > +into your computer using an HID compatible USB dongle.
> > +
> > +There are several HID compatible USB dongles from different
> > +vendors. The driver currently supports:
> > +
> > +- Phoenix RC (HID variant) (8ch)
> > +- Car VRC2.0 (2ch)
> > +- Real Flight G5/G6/G7 (6ch)
> > +- Aero Fly, FMS (8ch)
> > +- OrangeRX FrSky (6ch)
> > +
> > +Many RC controllers is able to configure which stick goes to which cha=
nnel.
> > +This is also configurable in most simulators, so a matching is not nec=
essary.
> > +
> > +Supported dongles
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +PhoenixRC
> > +----------
> > +
> > +The PhoenixRC has one HID compatible variant which is supported by thi=
s driver.
> > +The controller has support for 8 analog channels.
> > +
> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +|     1   |  ABS_Y         |
> > ++---------+----------------+
> > +|     2   |  ABS_X         |
> > ++---------+----------------+
> > +|     3   |  ABS_RY        |
> > ++---------+----------------+
> > +|     4   |  ABS_RX        |
> > ++---------+----------------+
> > +|     5   |  ABS_RUDDER    |
> > ++---------+----------------+
> > +|     6   |  ABS_THROTTLE  |
> > ++---------+----------------+
> > +|     7   |  ABS_Z         |
> > ++---------+----------------+
> > +|     8   |  ABS_RZ        |
> > ++---------+----------------+
> > +
> > +VRC2.0
> > +----------
> > +VRC2.0 is a controller for RC Cars.
> > +The controller has support for 2 analog channels.
> > +
> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +|     1   |  ABS_GAS       |
> > ++---------+----------------+
> > +|     2   |  ABS_WHEEL     |
> > ++---------+----------------+
> > +
> > +RealFlight
> > +----------
> > +
> > +This driver supports Realflight G4-G7 and above
> > +The controller has support for 4 analog channels and two buttons.
> > +
> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +|     1   |  ABS_Y         |
> > ++---------+----------------+
> > +|     2   |  ABS_X         |
> > ++---------+----------------+
> > +|     3   |  ABS_RY        |
> > ++---------+----------------+
> > +|     4   |  ABS_RX        |
> > ++---------+----------------+
> > +|     5   |  BTN_A         |
> > ++---------+----------------+
> > +|     6   |  BTN_B         |
> > ++---------+----------------+
> > +
> > +XTR+G2+FMS Controllers
> > +--------------------------------
> > +
> > +The controllers has support for 8 analog channels.
> > +
> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +|     1   |  ABS_Y         |
> > ++---------+----------------+
> > +|     2   |  ABS_X         |
> > ++---------+----------------+
> > +|     3   |  ABS_RY        |
> > ++---------+----------------+
> > +|     4   |  ABS_RX        |
> > ++---------+----------------+
> > +|     5   |  ABS_RUDDER    |
> > ++---------+----------------+
> > +|     6   |  ABS_THROTTLE  |
> > ++---------+----------------+
> > +|     7   |  ABS_Z         |
> > ++---------+----------------+
> > +|     8   |  ABS_RZ        |
> > ++---------+----------------+
> > +
> > +OrangeRX
> > +----------
> > +
> > +The controllers has support for 6 analog channels.
> > +
> > +The driver is generating the following input event for on channels:
> > +
> > ++---------+----------------+
> > +| Channel |      Event     |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +|     1   |  ABS_Y         |
> > ++---------+----------------+
> > +|     2   |  ABS_X         |
> > ++---------+----------------+
> > +|     3   |  ABS_RY        |
> > ++---------+----------------+
> > +|     4   |  ABS_RX        |
> > ++---------+----------------+
> > +|     5   |  ABS_RUDDER    |
> > ++---------+----------------+
> > +|     6   |  ABS_THROTTLE  |
> > ++---------+----------------+
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 70da5931082f..d8313d36086c 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -957,6 +957,17 @@ config HID_RAZER
> >         Support for Razer devices that are not fully compliant with the
> >         HID standard.
> >
> > +config HID_RCSIM
> > +       tristate "RC Simulator Controllers"
> > +       depends on HID
> > +       help
> > +       Support for several HID compatible RC Simulator Controllers inc=
luding
> > +         - Phoenix RC
> > +         - Car VRC2.0
> > +         - Real Flight
> > +         - Aero Fly, FMS
> > +         - OrangeRX FrSky
> > +
> >  config HID_PRIMAX
> >         tristate "Primax non-fully HID-compliant devices"
> >         depends on HID
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index cac2cbe26d11..85d50ab352ee 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)       +=3D hid-plantr=
onics.o
> >  obj-$(CONFIG_HID_PLAYSTATION)  +=3D hid-playstation.o
> >  obj-$(CONFIG_HID_PRIMAX)       +=3D hid-primax.o
> >  obj-$(CONFIG_HID_RAZER)        +=3D hid-razer.o
> > +obj-$(CONFIG_HID_RCSIM)        +=3D hid-rcsim.o
>=20
> General rule of thumbs, we try to name the drivers after their
> vendors, unless we know we have a generic driver.
>=20
> Here, this driver seems to be really tied to a small set of devices,
> and thus I don't think we can call it "generic".

Got it.

>=20
> >  obj-$(CONFIG_HID_REDRAGON)     +=3D hid-redragon.o
> >  obj-$(CONFIG_HID_RETRODE)      +=3D hid-retrode.o
> >  obj-$(CONFIG_HID_ROCCAT)       +=3D hid-roccat.o hid-roccat-common.o \
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index d9eb676abe96..baf5f74d5bed 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -1381,6 +1381,11 @@
> >
> >  #define USB_VENDOR_ID_MULTIPLE_1781    0x1781
> >  #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD    0x0a9d
> > +#define USB_DEVICE_ID_PHOENIXRC        0x0898
> > +#define USB_DEVICE_ID_REALFLIGHT       0x0e56
> > +
> > +#define USB_VENDOR_ID_DIPLING  0x0B9B
> > +#define USB_DEVICE_ID_DIPLING_RCCONTROLLER     0x4012
> >
> >  #define USB_VENDOR_ID_DRACAL_RAPHNET   0x289b
> >  #define USB_DEVICE_ID_RAPHNET_2NES2SNES        0x0002
> > diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
> > new file mode 100644
> > index 000000000000..0f214cb5816a
> > --- /dev/null
> > +++ b/drivers/hid/hid-rcsim.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Driver for several HID compatible RC Simulator Controllers.
> > + * Currently supported controllers are:
> > + *
> > + * - Phoenix RC (HID variant) (8ch)
> > + * - Car VRC2.0 (2ch)
> > + * - Real Flight G5/G6/G7 (6ch)
> > + * - Aero Fly, FMS (8ch)
> > + * - OrangeRX FrSky (6ch)
> > + *
> > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +#include <linux/usb.h>
> > +
> > +#include "hid-ids.h"
> > +
> > +/*
> > + * Some of these VID/PID are probably "borrowed", so keep them locally=
 and
> > + * do not populate hid-ids.h with those.
> > + */
> > +
> > +/* PHOENIXRC Controlloer (HID variant) */
> > +#define PHOENIXRC_VID  (USB_VENDOR_ID_MULTIPLE_1781)
> > +#define PHOENIXRC_PID  (USB_DEVICE_ID_PHOENIXRC)
> > +#define PHOENIXRC_DSIZE        (8)
> > +
> > +/* VRC2 Controlloer */
> > +#define VRC2_VID       (0x07c0)
> > +#define VRC2_PID       (0x1125)
> > +#define VRC2_DSIZE     (7)
> > +
> > +/* Realflight G4-&7 and Above Controller */
> > +#define REALFLIGHT_VID (USB_VENDOR_ID_MULTIPLE_1781)
> > +#define REALFLIGHT_PID (USB_DEVICE_ID_REALFLIGHT)
> > +#define REALFLIGHT_DSIZE       (8)
> > +
> > +#define REALFLIGHT_BTN_A       BIT(0)
> > +#define REALFLIGHT_BTN_B       BIT(1)
> > +
> > +/* XTR+G2+FMS Controller */
> > +#define XTRG2FMS_VID   (USB_VENDOR_ID_DIPLING)
> > +#define XTRG2FMS_PID   (USB_DEVICE_ID_DIPLING_RCCONTROLLER)
> > +#define XTRG2FMS_DSIZE (8)
> > +
> > +#define XTRG2FMS_X_HI  GENMASK(3, 2)
> > +#define XTRG2FMS_Y_HI  GENMASK(1, 0)
> > +#define XTRG2FMS_RX_HI GENMASK(7, 6)
> > +#define XTRG2FMS_RY_HI GENMASK(5, 4)
> > +#define XTRG2FMS_ALT1_HI       GENMASK(3, 2)
> > +#define XTRG2FMS_ALT2_HI       GENMASK(1, 0)
> > +
> > +/* OrangeRX FrSky */
> > +#define ORANGERX_VID   (0x0451)
> > +#define ORANGERX_PID   (0x16a5)
> > +#define ORANGERX_DSIZE (8)
> > +
> > +enum rcsim_controller {
> > +       PHOENIXRC,
> > +       VRC2,
> > +       REALFLIGHT,
> > +       XTRG2FMS,
> > +       ORANGERX
> > +};
> > +
> > +struct rcsim_priv {
> > +       struct hid_device *hdev;
> > +       struct input_dev *input;
> > +       enum rcsim_controller controller;
> > +       u8 alt;
> > +};
> > +
> > +static int rcsim_open(struct input_dev *dev)
> > +{
> > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > +
> > +       return hid_hw_open(priv->hdev);
> > +}
> > +
> > +static void rcsim_close(struct input_dev *dev)
> > +{
> > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > +
> > +       hid_hw_close(priv->hdev);
> > +}
> > +
> > +static int rcsim_setup_input(struct rcsim_priv *priv)
> > +{
> > +       struct input_dev *input;
> > +
> > +       input =3D devm_input_allocate_device(&priv->hdev->dev);
> > +       if (!input)
> > +               return -ENOMEM;
> > +
> > +       input->id.bustype =3D priv->hdev->bus;
> > +       input->id.vendor  =3D priv->hdev->vendor;
> > +       input->id.product =3D priv->hdev->product;
> > +       input->id.version =3D priv->hdev->bus;
> > +       input->phys =3D priv->hdev->phys;
> > +       input->uniq =3D priv->hdev->uniq;
> > +       input->open =3D rcsim_open;
> > +       input->close =3D rcsim_close;
> > +
> > +       input_set_drvdata(input, priv);
> > +
> > +       switch (priv->controller) {
> > +       case PHOENIXRC:
> > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > +               input->name =3D "RC Simuator Controller PhoenixRC";
> > +               break;
> > +       case VRC2:
> > +               input_set_abs_params(input, ABS_GAS, 0, 2048, 0, 0);
> > +               input_set_abs_params(input, ABS_WHEEL, 0, 2048, 0, 0);
> > +               input->name =3D "RC Simuator Controller VRC2.0";
> > +               break;
> > +       case REALFLIGHT:
> > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > +               input_set_capability(input, EV_KEY, BTN_A);
> > +               input_set_capability(input, EV_KEY, BTN_B);
> > +               input->name =3D "RC Simuator Controller Realflight";
> > +               break;
> > +       case XTRG2FMS:
> > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_Z, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RZ, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_RUDDER, 0, 1024, 0, 0);
> > +               input_set_abs_params(input, ABS_THROTTLE, 0, 1024, 0, 0=
);
> > +               input->name =3D "RC Simuator Controller AeroFly, FMS";
> > +               priv->alt =3D 0;
> > +               break;
> > +       case ORANGERX:
> > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, 0);
> > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0, 0);
> > +               input->name =3D "RC Simuator Controller OrangeRX FrSky";
> > +               break;
> > +       };
> > +
> > +       priv->input =3D input;
> > +       return input_register_device(priv->input);
> > +}
>=20
> You are basically rewriting hid-input.c, which is suboptimal.

Ouch. I will have a look at hid-input, thanks.

>=20
> I guess the report descriptor provided by these devices are basically
> useless, and so you have to parse the reports yourself in the
> raw_event callback.

Yep.

>=20
> But instead of manually doing that, why not overwrite the report
> descriptor (with .rdesc_fixup) and declare here all of the data that
 Do you mean .report_fixup?

> needs to be exported. You could remove basically everything in this
> driver by just providing a fixed report descriptor.

What you are aiming for is to fixup the report descriptor and let the
generic hid-raw driver handle the rest, or do I get you wrong?

How is the report mapped to certain events then?

I do read at [1] but it is not obvious how to put it together.
Most drivers I've looked at that is using .report_fixup just fix broken
reports. I guess these reports are not "broken", just.. odd?


>=20
> > +
> > +static int rcsim_raw_event(struct hid_device *hdev,
> > +                              struct hid_report *report,
> > +                              u8 *raw_data, int size)
> > +{
> > +       struct rcsim_priv *priv =3D hid_get_drvdata(hdev);
> > +       u16 value;
> > +
> > +       switch (priv->controller) {
> > +       case PHOENIXRC:
> > +               if (size !=3D PHOENIXRC_DSIZE)
> > +                       break;
> > +
> > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sent every =
time */
> > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > +               input_report_abs(priv->input, ABS_Y, raw_data[0]);
> > +               input_report_abs(priv->input, ABS_RX, raw_data[4]);
> > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]=
);
> > +
> > +               /* Z and RZ are sent every other time */
> > +               if (priv->alt)
> > +                       input_report_abs(priv->input, ABS_Z, raw_data[7=
]);
> > +               else
> > +                       input_report_abs(priv->input, ABS_RZ, raw_data[=
7]);
> > +
> > +               priv->alt ^=3D 1;
> > +               break;
> > +       case VRC2:
> > +               if (size !=3D VRC2_DSIZE)
> > +                       break;
> > +               value =3D (raw_data[1] << 8 | raw_data[0]) & GENMASK(10=
, 0);
> > +               input_report_abs(priv->input, ABS_GAS, value);
> > +               value =3D (raw_data[3] << 8 | raw_data[2]) & GENMASK(10=
, 0);
> > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > +               break;
> > +       case REALFLIGHT:
> > +               if (size !=3D REALFLIGHT_DSIZE)
> > +                       break;
> > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > +               input_report_abs(priv->input, ABS_Y, raw_data[1]);
> > +               input_report_abs(priv->input, ABS_RX, raw_data[5]);
> > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > +               input_report_abs(priv->input, ABS_MISC, raw_data[4]);
> > +               input_report_key(priv->input, BTN_A,
> > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > +               input_report_key(priv->input, BTN_B,
> > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > +               break;
> > +       case XTRG2FMS:
> > +               if (size !=3D XTRG2FMS_DSIZE)
> > +                       break;
> > +
> > +               /* X, RX, Y and RY are sent every time */
> > +               value =3D FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > +               value =3D (value << 8) | raw_data[1];
> > +               input_report_abs(priv->input, ABS_X, value);
> > +
> > +               value =3D FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > +               value =3D (value << 8) | raw_data[2];
> > +               input_report_abs(priv->input, ABS_Y, value);
> > +
> > +               value =3D FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
> > +               value =3D (value << 8) | raw_data[0];
> > +               input_report_abs(priv->input, ABS_RX, value);
> > +
> > +               value =3D FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
> > +               value =3D (value << 8) | raw_data[4];
> > +               input_report_abs(priv->input, ABS_RY, value);
> > +
> > +               /* Z, RZ, RUDDER and THROTTLE are sent every other time=
 */
> > +               value =3D FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
> > +               value =3D (value << 8) | raw_data[6];
> > +               if (priv->alt)
> > +                       input_report_abs(priv->input, ABS_Z, value);
> > +               else
> > +                       input_report_abs(priv->input, ABS_RUDDER, value=
);
> > +
> > +               value =3D FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
> > +               value =3D (value << 8) | raw_data[5];
> > +               if (priv->alt)
> > +                       input_report_abs(priv->input, ABS_RZ, value);
> > +               else
> > +                       input_report_abs(priv->input, ABS_THROTTLE, val=
ue);
> > +
> > +               priv->alt ^=3D 1;
> > +               break;
> > +       case ORANGERX:
> > +               if (size !=3D ORANGERX_DSIZE)
> > +                       break;
> > +               input_report_abs(priv->input, ABS_X, raw_data[0]);
> > +               input_report_abs(priv->input, ABS_Y, raw_data[2]);
> > +               input_report_abs(priv->input, ABS_RX, raw_data[3]);
> > +               input_report_abs(priv->input, ABS_RY, raw_data[1]);
> > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[5]);
> > +               input_report_abs(priv->input, ABS_THROTTLE, raw_data[6]=
);
> > +               break;
> > +       };
> > +
> > +       input_sync(priv->input);
> > +       return 0;
> > +}
> > +
> > +static int rcsim_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> > +{
> > +       struct device *dev =3D &hdev->dev;
> > +       struct rcsim_priv *priv;
> > +       int ret;
> > +
> > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > +               return -ENODEV;
>=20
> You are not accessing anything in the USB stack, so there is no need
> to prevent regression tests that could inject uhid devices to your
> drivers.

Ok, thanks.

>=20
> Cheers,
> Benjamin
>=20

Best regards,
Marcus Folkesson

[1] https://www.usb.org/hid


--O6mxBkcZjd/3ARLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmME76gACgkQiIBOb1ld
UjLWGg//YV2eqhAwVheBoH6rccbk2c6fN/gazy2DVg+Mp0zpw94bCrFDSxHI1lCx
2lMFzFkyK+wFcsvIxnu8zHApweDLlX0gzqKHfyNPyzY8ytmhQkCDD8kS00LEpUHu
b+rvFdazKx4BuyFhwJh5laHObl/Uw59PhPVI/DFtRKM0DOzHunZ8Nm7atsGwk2+x
J1bZTRxbP4sbxDIZyT2gcGGx4VC49zv39HhGTe5MAd+dt3+c/uQyz2Uoy2SYjxwM
MQefR24kWKUJr3UsY1WXuC1vRLcfbt9fn+MASD/ynMgCeAk/mUSi6FvxtB5V2fE1
aHbg70W1CBYkh8JUSAKTqiYyP9/8jYQxlIxTMxEXdlCnAGRNTMZ530Vi805IOnHF
alysNc6e6EVNDCQxNuvC3hJFN9Ygc/pxiLNzV9JQF7EO2mo+OjFKk5ZSZmVMkOnp
TDJud1dDCdhB5hk7/HR5ff4WF10C6BjWJcZitHWkV0+xr/uRrbZhiLU1n5NdDVrn
G53S7KPVo1nrwWN4lZUVjIIQCYLlJOftuvRNtAtzDoO83WgPVDogrwZ7GzUhUTPO
s5mL343VL0d+qamQ5pT203H8NqxxKOMK6jA1nCzFfW8LEqvEBTqvXgwE7x6zvcQd
3W/fImHzwN01OKkFo7VTTCsjYrqAFUIJet5gkoIE84NRJN0uZW4=
=WCti
-----END PGP SIGNATURE-----

--O6mxBkcZjd/3ARLA--
