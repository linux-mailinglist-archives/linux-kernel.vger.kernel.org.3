Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DCC5A3DF4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH1ON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1ON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:13:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14151C100;
        Sun, 28 Aug 2022 07:13:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n24so5741349ljc.13;
        Sun, 28 Aug 2022 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Hmlqcx5+xVQ1Z2JH6/O/eDkYJY6GIADOa+2xNWA3bo4=;
        b=XbiFpBgp9/O3A0VjQx7HoOuMm3kPCuK2Nc49QlIC6/yyDuzWlFDzuynpx++710AUJ2
         jx8lTVOI3acliH/wM64z+sySD3303rdzL+GVJu3VHvRncYT6JaMKMT+Qgt22uRViMufz
         BetkckvqiZlbPyqWIpLozXU4kOiScoFx/O42masmSLeZ1b+M3Aa2u8ojvU0xbZAa0cFj
         jziiJw8v/ncXqrJhYoBAGPBpBDC/XR1XGtKL1vWepsZTDnlZm0ewNmtRXIekpczCxkBn
         DWvtjQjZ2pKDDMMcM6I6AzDXwN5sYL1AIvqeEPYlEk5isaR/YmJjTOT4cg57U3tgKmOE
         yTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Hmlqcx5+xVQ1Z2JH6/O/eDkYJY6GIADOa+2xNWA3bo4=;
        b=O9z8j1yuUlujkzRJ0Hwp5XHFImn2yNhhVe92bSZdOLjPQAKRtFIM1isXXrMWWUq/k3
         1XRLFqsxBIp+HBBPerIXNuyKUWt5yd0xCAuLpKyWC7/pFHe+nOJB6ys7vjjHtAYi31qQ
         qcw89nO60kRB2q+3QeNFeYpY1BmddJjwrnPySw7Q9G7lvythAaXa9r4+Yn7GY1ZbLsL6
         G8P45J25JFqVs7ImOK1FZocSWKzmwsNUs9f3ruATrL6UmRmZvj9ixUw7j7uBDmHZB8oB
         fAsx3tgRxAeCrWejyofJSSHWony63c8WJDB8luleemIlavxPFnjiMZE3pvKjWNdxg3un
         oG5A==
X-Gm-Message-State: ACgBeo11M2oV9qoAqC0VgEU77xt1wcM0CwGvbnOWwzY4yPgaClNvCQ+V
        cNRxMJccqHZv+qptIZJjIbP9QpZA/8c=
X-Google-Smtp-Source: AA6agR6cGCNShC3XYzds+FEmnRSS4C3uYCAtmC2ufv8C3gLoxoCd0gz/Qoee0t3+h+dS9dWb4Z6L9w==
X-Received: by 2002:a2e:2a02:0:b0:264:435e:f12 with SMTP id q2-20020a2e2a02000000b00264435e0f12mr1003129ljq.298.1661696002086;
        Sun, 28 Aug 2022 07:13:22 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512214400b00492d8a0b408sm963864lfr.163.2022.08.28.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 07:13:20 -0700 (PDT)
Date:   Sun, 28 Aug 2022 16:18:34 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <Ywt5Oo+kTDoZFbqH@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com>
 <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0Z4FHod6toqwbRBv"
Content-Disposition: inline
In-Reply-To: <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Z4FHod6toqwbRBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 23, 2022 at 06:43:47PM +0200, Benjamin Tissoires wrote:
> On Tue, Aug 23, 2022 at 5:13 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:

> >
> > Thank you  Benjamin,
> >
> > On Tue, Aug 23, 2022 at 11:49:59AM +0200, Benjamin Tissoires wrote:
> > > Hi Marcus,
> > >
> > > [and sorry for the delay in the review of your patches]
> > >
> > > On Mon, Aug 22, 2022 at 8:04 AM Marcus Folkesson
> > > <marcus.folkesson@gmail.com> wrote:
> > > >
> > > > Several RC Simulator Controllers are HID compliant with similar
> > > > interface.
> > > >
> > > > Add support for these controllers:
> > > >  - Phoenix RC (HID variant)
> > > >  - Car VRC2.0
> > > >  - Real Flight G5/G6/G7
> > > >  - Aero Fly, FMS
> > > >  - OrangeRX FrSky
> > > >
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > ---
> > > >  Documentation/hid/index.rst |   1 +
> > > >  Documentation/hid/rcsim.rst | 142 ++++++++++++++++
> > > >  drivers/hid/Kconfig         |  11 ++
> > > >  drivers/hid/Makefile        |   1 +
> > > >  drivers/hid/hid-ids.h       |   5 +
> > > >  drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++++++=
++++
> > > >  6 files changed, 475 insertions(+)
> > > >  create mode 100644 Documentation/hid/rcsim.rst
> > > >  create mode 100644 drivers/hid/hid-rcsim.c
> > > >
> > > > diff --git a/Documentation/hid/index.rst b/Documentation/hid/index.=
rst
> > > > index e50f513c579c..e5813d264f37 100644
> > > > --- a/Documentation/hid/index.rst
> > > > +++ b/Documentation/hid/index.rst
> > > > @@ -17,3 +17,4 @@ Human Interface Devices (HID)
> > > >     hid-alps
> > > >     intel-ish-hid
> > > >     amd-sfh-hid
> > > > +   rcsim
> > > > diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rcsim.=
rst
> > > > new file mode 100644
> > > > index 000000000000..1a031f7189cb
> > > > --- /dev/null
> > > > +++ b/Documentation/hid/rcsim.rst
> > > > @@ -0,0 +1,142 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +rcsim - RC Simulator Controllers
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > +
> > > > +This driver let you use your own RC controller plugged
> > > > +into your computer using an HID compatible USB dongle.
> > > > +
> > > > +There are several HID compatible USB dongles from different
> > > > +vendors. The driver currently supports:
> > > > +
> > > > +- Phoenix RC (HID variant) (8ch)
> > > > +- Car VRC2.0 (2ch)
> > > > +- Real Flight G5/G6/G7 (6ch)
> > > > +- Aero Fly, FMS (8ch)
> > > > +- OrangeRX FrSky (6ch)
> > > > +
> > > > +Many RC controllers is able to configure which stick goes to which=
 channel.
> > > > +This is also configurable in most simulators, so a matching is not=
 necessary.
> > > > +
> > > > +Supported dongles
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +PhoenixRC
> > > > +----------
> > > > +
> > > > +The PhoenixRC has one HID compatible variant which is supported by=
 this driver.
> > > > +The controller has support for 8 analog channels.
> > > > +
> > > > +The driver is generating the following input event for on channels:
> > > > +
> > > > ++---------+----------------+
> > > > +| Channel |      Event     |
> > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > > > +|     1   |  ABS_Y         |
> > > > ++---------+----------------+
> > > > +|     2   |  ABS_X         |
> > > > ++---------+----------------+
> > > > +|     3   |  ABS_RY        |
> > > > ++---------+----------------+
> > > > +|     4   |  ABS_RX        |
> > > > ++---------+----------------+
> > > > +|     5   |  ABS_RUDDER    |
> > > > ++---------+----------------+
> > > > +|     6   |  ABS_THROTTLE  |
> > > > ++---------+----------------+
> > > > +|     7   |  ABS_Z         |
> > > > ++---------+----------------+
> > > > +|     8   |  ABS_RZ        |
> > > > ++---------+----------------+
> > > > +
> > > > +VRC2.0
> > > > +----------
> > > > +VRC2.0 is a controller for RC Cars.
> > > > +The controller has support for 2 analog channels.
> > > > +
> > > > +The driver is generating the following input event for on channels:
> > > > +
> > > > ++---------+----------------+
> > > > +| Channel |      Event     |
> > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > > > +|     1   |  ABS_GAS       |
> > > > ++---------+----------------+
> > > > +|     2   |  ABS_WHEEL     |
> > > > ++---------+----------------+
> > > > +
> > > > +RealFlight
> > > > +----------
> > > > +
> > > > +This driver supports Realflight G4-G7 and above
> > > > +The controller has support for 4 analog channels and two buttons.
> > > > +
> > > > +The driver is generating the following input event for on channels:
> > > > +
> > > > ++---------+----------------+
> > > > +| Channel |      Event     |
> > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > > > +|     1   |  ABS_Y         |
> > > > ++---------+----------------+
> > > > +|     2   |  ABS_X         |
> > > > ++---------+----------------+
> > > > +|     3   |  ABS_RY        |
> > > > ++---------+----------------+
> > > > +|     4   |  ABS_RX        |
> > > > ++---------+----------------+
> > > > +|     5   |  BTN_A         |
> > > > ++---------+----------------+
> > > > +|     6   |  BTN_B         |
> > > > ++---------+----------------+
> > > > +
> > > > +XTR+G2+FMS Controllers
> > > > +--------------------------------
> > > > +
> > > > +The controllers has support for 8 analog channels.
> > > > +
> > > > +The driver is generating the following input event for on channels:
> > > > +
> > > > ++---------+----------------+
> > > > +| Channel |      Event     |
> > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > > > +|     1   |  ABS_Y         |
> > > > ++---------+----------------+
> > > > +|     2   |  ABS_X         |
> > > > ++---------+----------------+
> > > > +|     3   |  ABS_RY        |
> > > > ++---------+----------------+
> > > > +|     4   |  ABS_RX        |
> > > > ++---------+----------------+
> > > > +|     5   |  ABS_RUDDER    |
> > > > ++---------+----------------+
> > > > +|     6   |  ABS_THROTTLE  |
> > > > ++---------+----------------+
> > > > +|     7   |  ABS_Z         |
> > > > ++---------+----------------+
> > > > +|     8   |  ABS_RZ        |
> > > > ++---------+----------------+
> > > > +
> > > > +OrangeRX
> > > > +----------
> > > > +
> > > > +The controllers has support for 6 analog channels.
> > > > +
> > > > +The driver is generating the following input event for on channels:
> > > > +
> > > > ++---------+----------------+
> > > > +| Channel |      Event     |
> > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> > > > +|     1   |  ABS_Y         |
> > > > ++---------+----------------+
> > > > +|     2   |  ABS_X         |
> > > > ++---------+----------------+
> > > > +|     3   |  ABS_RY        |
> > > > ++---------+----------------+
> > > > +|     4   |  ABS_RX        |
> > > > ++---------+----------------+
> > > > +|     5   |  ABS_RUDDER    |
> > > > ++---------+----------------+
> > > > +|     6   |  ABS_THROTTLE  |
> > > > ++---------+----------------+
> > > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > > index 70da5931082f..d8313d36086c 100644
> > > > --- a/drivers/hid/Kconfig
> > > > +++ b/drivers/hid/Kconfig
> > > > @@ -957,6 +957,17 @@ config HID_RAZER
> > > >         Support for Razer devices that are not fully compliant with=
 the
> > > >         HID standard.
> > > >
> > > > +config HID_RCSIM
> > > > +       tristate "RC Simulator Controllers"
> > > > +       depends on HID
> > > > +       help
> > > > +       Support for several HID compatible RC Simulator Controllers=
 including
> > > > +         - Phoenix RC
> > > > +         - Car VRC2.0
> > > > +         - Real Flight
> > > > +         - Aero Fly, FMS
> > > > +         - OrangeRX FrSky
> > > > +
> > > >  config HID_PRIMAX
> > > >         tristate "Primax non-fully HID-compliant devices"
> > > >         depends on HID
> > > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > > index cac2cbe26d11..85d50ab352ee 100644
> > > > --- a/drivers/hid/Makefile
> > > > +++ b/drivers/hid/Makefile
> > > > @@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)       +=3D hid-pl=
antronics.o
> > > >  obj-$(CONFIG_HID_PLAYSTATION)  +=3D hid-playstation.o
> > > >  obj-$(CONFIG_HID_PRIMAX)       +=3D hid-primax.o
> > > >  obj-$(CONFIG_HID_RAZER)        +=3D hid-razer.o
> > > > +obj-$(CONFIG_HID_RCSIM)        +=3D hid-rcsim.o
> > >
> > > General rule of thumbs, we try to name the drivers after their
> > > vendors, unless we know we have a generic driver.
> > >
> > > Here, this driver seems to be really tied to a small set of devices,
> > > and thus I don't think we can call it "generic".
> >
> > Got it.
> >
> > >
> > > >  obj-$(CONFIG_HID_REDRAGON)     +=3D hid-redragon.o
> > > >  obj-$(CONFIG_HID_RETRODE)      +=3D hid-retrode.o
> > > >  obj-$(CONFIG_HID_ROCCAT)       +=3D hid-roccat.o hid-roccat-common=
=2Eo \
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index d9eb676abe96..baf5f74d5bed 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -1381,6 +1381,11 @@
> > > >
> > > >  #define USB_VENDOR_ID_MULTIPLE_1781    0x1781
> > > >  #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD    0x0a9d
> > > > +#define USB_DEVICE_ID_PHOENIXRC        0x0898
> > > > +#define USB_DEVICE_ID_REALFLIGHT       0x0e56
> > > > +
> > > > +#define USB_VENDOR_ID_DIPLING  0x0B9B
> > > > +#define USB_DEVICE_ID_DIPLING_RCCONTROLLER     0x4012
> > > >
> > > >  #define USB_VENDOR_ID_DRACAL_RAPHNET   0x289b
> > > >  #define USB_DEVICE_ID_RAPHNET_2NES2SNES        0x0002
> > > > diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
> > > > new file mode 100644
> > > > index 000000000000..0f214cb5816a
> > > > --- /dev/null
> > > > +++ b/drivers/hid/hid-rcsim.c
> > > > @@ -0,0 +1,315 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Driver for several HID compatible RC Simulator Controllers.
> > > > + * Currently supported controllers are:
> > > > + *
> > > > + * - Phoenix RC (HID variant) (8ch)
> > > > + * - Car VRC2.0 (2ch)
> > > > + * - Real Flight G5/G6/G7 (6ch)
> > > > + * - Aero Fly, FMS (8ch)
> > > > + * - OrangeRX FrSky (6ch)
> > > > + *
> > > > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/input.h>
> > > > +#include <linux/hid.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/usb.h>
> > > > +
> > > > +#include "hid-ids.h"
> > > > +
> > > > +/*
> > > > + * Some of these VID/PID are probably "borrowed", so keep them loc=
ally and
> > > > + * do not populate hid-ids.h with those.
> > > > + */
> > > > +
> > > > +/* PHOENIXRC Controlloer (HID variant) */
> > > > +#define PHOENIXRC_VID  (USB_VENDOR_ID_MULTIPLE_1781)
> > > > +#define PHOENIXRC_PID  (USB_DEVICE_ID_PHOENIXRC)
> > > > +#define PHOENIXRC_DSIZE        (8)
> > > > +
> > > > +/* VRC2 Controlloer */
> > > > +#define VRC2_VID       (0x07c0)
> > > > +#define VRC2_PID       (0x1125)
> > > > +#define VRC2_DSIZE     (7)
> > > > +
> > > > +/* Realflight G4-&7 and Above Controller */
> > > > +#define REALFLIGHT_VID (USB_VENDOR_ID_MULTIPLE_1781)
> > > > +#define REALFLIGHT_PID (USB_DEVICE_ID_REALFLIGHT)
> > > > +#define REALFLIGHT_DSIZE       (8)
> > > > +
> > > > +#define REALFLIGHT_BTN_A       BIT(0)
> > > > +#define REALFLIGHT_BTN_B       BIT(1)
> > > > +
> > > > +/* XTR+G2+FMS Controller */
> > > > +#define XTRG2FMS_VID   (USB_VENDOR_ID_DIPLING)
> > > > +#define XTRG2FMS_PID   (USB_DEVICE_ID_DIPLING_RCCONTROLLER)
> > > > +#define XTRG2FMS_DSIZE (8)
> > > > +
> > > > +#define XTRG2FMS_X_HI  GENMASK(3, 2)
> > > > +#define XTRG2FMS_Y_HI  GENMASK(1, 0)
> > > > +#define XTRG2FMS_RX_HI GENMASK(7, 6)
> > > > +#define XTRG2FMS_RY_HI GENMASK(5, 4)
> > > > +#define XTRG2FMS_ALT1_HI       GENMASK(3, 2)
> > > > +#define XTRG2FMS_ALT2_HI       GENMASK(1, 0)
> > > > +
> > > > +/* OrangeRX FrSky */
> > > > +#define ORANGERX_VID   (0x0451)
> > > > +#define ORANGERX_PID   (0x16a5)
> > > > +#define ORANGERX_DSIZE (8)
> > > > +
> > > > +enum rcsim_controller {
> > > > +       PHOENIXRC,
> > > > +       VRC2,
> > > > +       REALFLIGHT,
> > > > +       XTRG2FMS,
> > > > +       ORANGERX
> > > > +};
> > > > +
> > > > +struct rcsim_priv {
> > > > +       struct hid_device *hdev;
> > > > +       struct input_dev *input;
> > > > +       enum rcsim_controller controller;
> > > > +       u8 alt;
> > > > +};
> > > > +
> > > > +static int rcsim_open(struct input_dev *dev)
> > > > +{
> > > > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > > > +
> > > > +       return hid_hw_open(priv->hdev);
> > > > +}
> > > > +
> > > > +static void rcsim_close(struct input_dev *dev)
> > > > +{
> > > > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > > > +
> > > > +       hid_hw_close(priv->hdev);
> > > > +}
> > > > +
> > > > +static int rcsim_setup_input(struct rcsim_priv *priv)
> > > > +{
> > > > +       struct input_dev *input;
> > > > +
> > > > +       input =3D devm_input_allocate_device(&priv->hdev->dev);
> > > > +       if (!input)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       input->id.bustype =3D priv->hdev->bus;
> > > > +       input->id.vendor  =3D priv->hdev->vendor;
> > > > +       input->id.product =3D priv->hdev->product;
> > > > +       input->id.version =3D priv->hdev->bus;
> > > > +       input->phys =3D priv->hdev->phys;
> > > > +       input->uniq =3D priv->hdev->uniq;
> > > > +       input->open =3D rcsim_open;
> > > > +       input->close =3D rcsim_close;
> > > > +
> > > > +       input_set_drvdata(input, priv);
> > > > +
> > > > +       switch (priv->controller) {
> > > > +       case PHOENIXRC:
> > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Z, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RZ, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, =
0);
> > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0=
, 0);
> > > > +               input->name =3D "RC Simuator Controller PhoenixRC";
> > > > +               break;
> > > > +       case VRC2:
> > > > +               input_set_abs_params(input, ABS_GAS, 0, 2048, 0, 0);
> > > > +               input_set_abs_params(input, ABS_WHEEL, 0, 2048, 0, =
0);
> > > > +               input->name =3D "RC Simuator Controller VRC2.0";
> > > > +               break;
> > > > +       case REALFLIGHT:
> > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > > +               input_set_capability(input, EV_KEY, BTN_A);
> > > > +               input_set_capability(input, EV_KEY, BTN_B);
> > > > +               input->name =3D "RC Simuator Controller Realflight";
> > > > +               break;
> > > > +       case XTRG2FMS:
> > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Z, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RZ, 0, 1024, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 1024, 0,=
 0);
> > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 1024, =
0, 0);
> > > > +               input->name =3D "RC Simuator Controller AeroFly, FM=
S";
> > > > +               priv->alt =3D 0;
> > > > +               break;
> > > > +       case ORANGERX:
> > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, 0);
> > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255, 0, =
0);
> > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 255, 0=
, 0);
> > > > +               input->name =3D "RC Simuator Controller OrangeRX Fr=
Sky";
> > > > +               break;
> > > > +       };
> > > > +
> > > > +       priv->input =3D input;
> > > > +       return input_register_device(priv->input);
> > > > +}
> > >
> > > You are basically rewriting hid-input.c, which is suboptimal.
> >
> > Ouch. I will have a look at hid-input, thanks.
> >
> > >
> > > I guess the report descriptor provided by these devices are basically
> > > useless, and so you have to parse the reports yourself in the
> > > raw_event callback.
> >
> > Yep.
> >
> > >
> > > But instead of manually doing that, why not overwrite the report
> > > descriptor (with .rdesc_fixup) and declare here all of the data that
> >  Do you mean .report_fixup?
>=20
> yes, sorry :/
>=20
> >
> > > needs to be exported. You could remove basically everything in this
> > > driver by just providing a fixed report descriptor.
> >
> > What you are aiming for is to fixup the report descriptor and let the
> > generic hid-raw driver handle the rest, or do I get you wrong?
>=20
> yep, exactly
>=20
> >
> > How is the report mapped to certain events then?
>=20
> Have a look at hid_configure_usage in hid-input.c [3]. Most of HID
> events are mapped to input events with a one to one mapping.
>=20
> >
> > I do read at [1] but it is not obvious how to put it together.
> > Most drivers I've looked at that is using .report_fixup just fix broken
> > reports. I guess these reports are not "broken", just.. odd?
>=20
> Have a look at [2], lots of full report descriptors :)
>=20
> And in your case, the reports are incomplete, not odd.
>=20
> >
> >
> > >
> > > > +
> > > > +static int rcsim_raw_event(struct hid_device *hdev,
> > > > +                              struct hid_report *report,
> > > > +                              u8 *raw_data, int size)
> > > > +{
> > > > +       struct rcsim_priv *priv =3D hid_get_drvdata(hdev);
> > > > +       u16 value;
> > > > +
> > > > +       switch (priv->controller) {
> > > > +       case PHOENIXRC:
> > > > +               if (size !=3D PHOENIXRC_DSIZE)
> > > > +                       break;
> > > > +
> > > > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sent ev=
ery time */
> > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > +               input_report_abs(priv->input, ABS_Y, raw_data[0]);
> > > > +               input_report_abs(priv->input, ABS_RX, raw_data[4]);
> > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[=
5]);
> > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_dat=
a[6]);
> > > > +
> > > > +               /* Z and RZ are sent every other time */
> > > > +               if (priv->alt)
> > > > +                       input_report_abs(priv->input, ABS_Z, raw_da=
ta[7]);
> > > > +               else
> > > > +                       input_report_abs(priv->input, ABS_RZ, raw_d=
ata[7]);
> > > > +
> > > > +               priv->alt ^=3D 1;
> > > > +               break;
> > > > +       case VRC2:
> > > > +               if (size !=3D VRC2_DSIZE)
> > > > +                       break;
> > > > +               value =3D (raw_data[1] << 8 | raw_data[0]) & GENMAS=
K(10, 0);
> > > > +               input_report_abs(priv->input, ABS_GAS, value);
> > > > +               value =3D (raw_data[3] << 8 | raw_data[2]) & GENMAS=
K(10, 0);
> > > > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > > > +               break;
> > > > +       case REALFLIGHT:
> > > > +               if (size !=3D REALFLIGHT_DSIZE)
> > > > +                       break;
> > > > +               input_report_abs(priv->input, ABS_X, raw_data[2]);
> > > > +               input_report_abs(priv->input, ABS_Y, raw_data[1]);
> > > > +               input_report_abs(priv->input, ABS_RX, raw_data[5]);
> > > > +               input_report_abs(priv->input, ABS_RY, raw_data[3]);
> > > > +               input_report_abs(priv->input, ABS_MISC, raw_data[4]=
);
> > > > +               input_report_key(priv->input, BTN_A,
> > > > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > > > +               input_report_key(priv->input, BTN_B,
> > > > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > > > +               break;
> > > > +       case XTRG2FMS:
> > > > +               if (size !=3D XTRG2FMS_DSIZE)
> > > > +                       break;
> > > > +
> > > > +               /* X, RX, Y and RY are sent every time */
> > > > +               value =3D FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > > > +               value =3D (value << 8) | raw_data[1];
> > > > +               input_report_abs(priv->input, ABS_X, value);
> > > > +
> > > > +               value =3D FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > > > +               value =3D (value << 8) | raw_data[2];
> > > > +               input_report_abs(priv->input, ABS_Y, value);
> > > > +
> > > > +               value =3D FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]);
> > > > +               value =3D (value << 8) | raw_data[0];
> > > > +               input_report_abs(priv->input, ABS_RX, value);
> > > > +
> > > > +               value =3D FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]);
> > > > +               value =3D (value << 8) | raw_data[4];
> > > > +               input_report_abs(priv->input, ABS_RY, value);
> > > > +
> > > > +               /* Z, RZ, RUDDER and THROTTLE are sent every other =
time */
> > > > +               value =3D FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
> > > > +               value =3D (value << 8) | raw_data[6];
> > > > +               if (priv->alt)
> > > > +                       input_report_abs(priv->input, ABS_Z, value);
> > > > +               else
> > > > +                       input_report_abs(priv->input, ABS_RUDDER, v=
alue);
> > > > +
> > > > +               value =3D FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
> > > > +               value =3D (value << 8) | raw_data[5];
> > > > +               if (priv->alt)
> > > > +                       input_report_abs(priv->input, ABS_RZ, value=
);
> > > > +               else
> > > > +                       input_report_abs(priv->input, ABS_THROTTLE,=
 value);
> > > > +
> > > > +               priv->alt ^=3D 1;
> > > > +               break;
> > > > +       case ORANGERX:
> > > > +               if (size !=3D ORANGERX_DSIZE)
> > > > +                       break;
> > > > +               input_report_abs(priv->input, ABS_X, raw_data[0]);
> > > > +               input_report_abs(priv->input, ABS_Y, raw_data[2]);
> > > > +               input_report_abs(priv->input, ABS_RX, raw_data[3]);
> > > > +               input_report_abs(priv->input, ABS_RY, raw_data[1]);
> > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_data[=
5]);
> > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw_dat=
a[6]);
> > > > +               break;
> > > > +       };
> > > > +
> > > > +       input_sync(priv->input);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int rcsim_probe(struct hid_device *hdev, const struct hid_d=
evice_id *id)
> > > > +{
> > > > +       struct device *dev =3D &hdev->dev;
> > > > +       struct rcsim_priv *priv;
> > > > +       int ret;
> > > > +
> > > > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > > > +               return -ENODEV;
> > >
> > > You are not accessing anything in the USB stack, so there is no need
> > > to prevent regression tests that could inject uhid devices to your
> > > drivers.
> >
> > Ok, thanks.
> >
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
> > Best regards,
> > Marcus Folkesson
> >
> > [1] https://www.usb.org/hid
> >
>=20
> If you need help in writing report descriptors, I can give you some,
> but the easiest might be for you to start from the report descriptor
> in hid-sony.c. I used to have a tool to dynamically write a report
> descriptor, but I'm not sure it still works...

I've worked with the report descriptor for VRC2, and have come up with
something that works.


static __u8 vrc2_rdesc_fixed[] =3D {
	0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
	0x09, 0x04,        // Usage (Joystick)
	0xA1, 0x01,        // Collection (Application)
	0x09, 0x01,        //   Usage (Pointer)
	0xA1, 0x00,        //   Collection (Physical)
	0x09, 0x30,        //     Usage (X)
	0x09, 0x31,        //     Usage (Y)
	0x15, 0x00,        //     Logical Minimum (0)
	0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
	0x35, 0x00,        //     Physical Minimum (0)
	0x46, 0xFF, 0x00,  //     Physical Maximum (255)
	0x75, 0x10,        //     Report Size (16)
	0x95, 0x02,        //     Report Count (2)
	0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred Sta=
te,No Null Position)
	0xC0,              //   End Collection
	0x95, 0x01,        //   Report Count (1)
	0x75, 0x18,        //   Report Size (24)
	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred St=
ate,No Null Position)
	0x09, 0x00,        //   Usage (Undefined)
	0x15, 0x00,        //   Logical Minimum (0)
	0x26, 0xFF, 0x00,  //   Logical Maximum (255)
	0x75, 0x08,        //   Report Size (8)
	0x95, 0x08,        //   Report Count (8)
	0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred Sta=
te,No Null Position,Non-volatile)
	0xC0,              // End Collection
};


It is a result of reading specifications and looking at various
examples.=20

These lines are taken from an example, and I do not know why I need
those. I think the constant report size is wrong (should be 32 to
fill up) and I do not know what the Feature is used for.

	0x95, 0x01,        //   Report Count (1)
	0x75, 0x18,        //   Report Size (24)
	0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred St=
ate,No Null Position)
	0x09, 0x00,        //   Usage (Undefined)
	0x15, 0x00,        //   Logical Minimum (0)
	0x26, 0xFF, 0x00,  //   Logical Maximum (255)
	0x75, 0x08,        //   Report Size (8)
	0x95, 0x08,        //   Report Count (8)
	0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred Sta=
te,No Null Position,Non-volatile)

If I omit any of these lines then I only get tons of

kernel: usb 3-12.3.1.3.3: input irq status -75 received

In the kernel log.


>=20
> FYI, I just re-read rcsim_raw_event() and there is stuff that would
> require more than just a report descriptor fixup (the fact that some
> data is sent every other report is not good and will need some manual
> handling though).
>=20
> Cheers,
> Benjamin
>=20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/hid/hid-uclogic-rdesc.c
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/hid/hid-input.c#n817
>=20


Best regards
Marcus Folkesson

--0Z4FHod6toqwbRBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMLeTUACgkQiIBOb1ld
UjJ85A//XbWvMCfTf4p6Hmp3z+BK4pR8XGa5A2sfzQ3485xAgNR4MJgKwEduJXYp
5+zg0IuSYQwsSe2AI6O+aAkoXuxC3hGgl5NrwrdJOuPa7S7P9w9fpX1uzL6KLmtJ
zFQYbOMoXR0pxLZ7+p4UhCmenA6IRIchnRnYDgo0DpE68sdB/bbnJcztbGd+YKMf
rb/yEe3xdsgFECV556UoL1bh5OhAyHK8+z9jNbb0p63gO/yuxNbLGoJOW2M2H9WO
Kz2ZGN2qJJw5zJ7ieg5E02byrxKLgU6DFDpgeQ9G+wJFREu3TPYhLSxR0sv1eX6D
u5aNr9d4ziM513+AdT63zLFeaIVf+hZuedE5wbDCBmTtPq09/ujgtM9YvEbpsMPA
zWQ2j7hNjiLAHMkGfq5/02YUODCTkvfidcXBu9I4/dpSVdHz6YLQN7NQtVw7Az3Z
3/84xOpEGChEC7prGye8MNiwYL2fCMblSAV3IrzPbwOXYwibmSICsc+lIoHBw/io
rDugrO21PO9MnzL2h0knDqF1hLnu57acCy2I9/iZXD6gR0iBe6FH9Czt774cIpEw
jmUsCvRVv+DeuQdpup8N61Ae/Xekcdgbq/vVtcekbyEKeOlkg0yUCZNT8aKjaqTh
wec1fPFAiI43Oz0yNCQNZ1qXSLyOEsSX51hf+4KQwr/Wy97kVfc=
=oMUH
-----END PGP SIGNATURE-----

--0Z4FHod6toqwbRBv--
