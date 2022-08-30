Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADC5A666E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiH3OiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiH3OiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:38:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3EDDAA3;
        Tue, 30 Aug 2022 07:38:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b26so4677231ljk.12;
        Tue, 30 Aug 2022 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KT4CEEFigdfBkwC21XenOrRdhHS27xgKj8m4x4Zt2bw=;
        b=piD0MyvFvmi5sZXSQzAUauhIilDg2eVnNTDCXsfUqskuEzG0tZ6SLk6TNxRMluGacq
         kcnRBp2189aiufLZHTEACfDLo/ekwkmaslTqgbp8ISS/WMAlTRpGZy0xIBo9Mg8fzKFO
         7nkWVjWbYW18WJ8OiW1FpVV7W2+mj4vNXQAl8DSHiNpfgELjz+wluLVXWnYOksKJh5Jc
         L5BtVmALP4gH2lHaQgEvk0tAIpPL76T4wJYB24x8yQd19HLLkWnm+RsZp33IHP+KC2V2
         0bOrK8FYdR4EL6NOGm3iFT7HIecC+fXspoKCTi/dVpA9Th53bIR5/qIO6sHkJ2gbFduF
         SWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KT4CEEFigdfBkwC21XenOrRdhHS27xgKj8m4x4Zt2bw=;
        b=zEOpiOL9N3V5/xEGbCIfaOxjfhri79/g+W+kVy8OiA81I1x7uDi2XGCcwGxDCVlivl
         q9wWauXxT0AoRkCCh6ZGOa/FFFfPwpNHSlSv2RyJ/JrAuPtj1tWRwdJKOwzBLv7jAOue
         6J+ZkRQVJghkiMWhsXmtcvHigLPmSpkT0tfUsz/uln5SxTSq9kY1ztLkrudpQRezXp/0
         m+1teBF1SN9sJrEn80l9dL2fL+Zn4XztMG6orj7J6QxcHe9dz8uLB3gQzjx4arTUP6eb
         TsLTBQP1n45k/mHGU1/S7ydWj5O+tB7ApTiJYpoPCaOWKfI7rK+R1MySHyZrQOceaY2v
         XCtw==
X-Gm-Message-State: ACgBeo2I9eTJKWMhXTdN4YHAilPs57/SLxmIXB0UonomF4WACu9SwDU5
        U/TYFQhWC8/duzzB29bbNIo=
X-Google-Smtp-Source: AA6agR72J7/6KHVrr4lu5aNaYQo/+wGx3qhfMaBHLOvqFjkpDol2Jhc/IjJpKd2SzvCNJTGb/Sp8qQ==
X-Received: by 2002:a05:651c:150e:b0:261:e507:2bbd with SMTP id e14-20020a05651c150e00b00261e5072bbdmr6845145ljf.62.1661870288913;
        Tue, 30 Aug 2022 07:38:08 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z3-20020a05651c11c300b0025debf2a59asm139147ljo.108.2022.08.30.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:38:07 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:43:21 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <Yw4iCWYhuxmVdFBG@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com>
 <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <Ywt5Oo+kTDoZFbqH@gmail.com>
 <CAO-hwJ+YD8KuaO86Ws0T0y1VBzttpVSEKW=ut0JuT4TxGdDowQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3fZ1JFuUIbtALSdz"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+YD8KuaO86Ws0T0y1VBzttpVSEKW=ut0JuT4TxGdDowQ@mail.gmail.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3fZ1JFuUIbtALSdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

Thank you for your detailed response!

On Tue, Aug 30, 2022 at 02:35:54PM +0200, Benjamin Tissoires wrote:
> Hi Marcus,
>=20
> On Sun, Aug 28, 2022 at 4:13 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > Hi,
> >
> > On Tue, Aug 23, 2022 at 06:43:47PM +0200, Benjamin Tissoires wrote:
> > > On Tue, Aug 23, 2022 at 5:13 PM Marcus Folkesson
> > > <marcus.folkesson@gmail.com> wrote:
> >
> > > >
> > > > Thank you  Benjamin,
> > > >
> > > > On Tue, Aug 23, 2022 at 11:49:59AM +0200, Benjamin Tissoires wrote:
> > > > > Hi Marcus,
> > > > >
> > > > > [and sorry for the delay in the review of your patches]
> > > > >
> > > > > On Mon, Aug 22, 2022 at 8:04 AM Marcus Folkesson
> > > > > <marcus.folkesson@gmail.com> wrote:
> > > > > >
> > > > > > Several RC Simulator Controllers are HID compliant with similar
> > > > > > interface.
> > > > > >
> > > > > > Add support for these controllers:
> > > > > >  - Phoenix RC (HID variant)
> > > > > >  - Car VRC2.0
> > > > > >  - Real Flight G5/G6/G7
> > > > > >  - Aero Fly, FMS
> > > > > >  - OrangeRX FrSky
> > > > > >
> > > > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > > ---
> > > > > >  Documentation/hid/index.rst |   1 +
> > > > > >  Documentation/hid/rcsim.rst | 142 ++++++++++++++++
> > > > > >  drivers/hid/Kconfig         |  11 ++
> > > > > >  drivers/hid/Makefile        |   1 +
> > > > > >  drivers/hid/hid-ids.h       |   5 +
> > > > > >  drivers/hid/hid-rcsim.c     | 315 ++++++++++++++++++++++++++++=
++++++++
> > > > > >  6 files changed, 475 insertions(+)
> > > > > >  create mode 100644 Documentation/hid/rcsim.rst
> > > > > >  create mode 100644 drivers/hid/hid-rcsim.c
> > > > > >
> > > > > > diff --git a/Documentation/hid/index.rst b/Documentation/hid/in=
dex.rst
> > > > > > index e50f513c579c..e5813d264f37 100644
> > > > > > --- a/Documentation/hid/index.rst
> > > > > > +++ b/Documentation/hid/index.rst
> > > > > > @@ -17,3 +17,4 @@ Human Interface Devices (HID)
> > > > > >     hid-alps
> > > > > >     intel-ish-hid
> > > > > >     amd-sfh-hid
> > > > > > +   rcsim
> > > > > > diff --git a/Documentation/hid/rcsim.rst b/Documentation/hid/rc=
sim.rst
> > > > > > new file mode 100644
> > > > > > index 000000000000..1a031f7189cb
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/hid/rcsim.rst
> > > > > > @@ -0,0 +1,142 @@
> > > > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > > > +
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > +rcsim - RC Simulator Controllers
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > +
> > > > > > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > > > +
> > > > > > +This driver let you use your own RC controller plugged
> > > > > > +into your computer using an HID compatible USB dongle.
> > > > > > +
> > > > > > +There are several HID compatible USB dongles from different
> > > > > > +vendors. The driver currently supports:
> > > > > > +
> > > > > > +- Phoenix RC (HID variant) (8ch)
> > > > > > +- Car VRC2.0 (2ch)
> > > > > > +- Real Flight G5/G6/G7 (6ch)
> > > > > > +- Aero Fly, FMS (8ch)
> > > > > > +- OrangeRX FrSky (6ch)
> > > > > > +
> > > > > > +Many RC controllers is able to configure which stick goes to w=
hich channel.
> > > > > > +This is also configurable in most simulators, so a matching is=
 not necessary.
> > > > > > +
> > > > > > +Supported dongles
> > > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > +
> > > > > > +PhoenixRC
> > > > > > +----------
> > > > > > +
> > > > > > +The PhoenixRC has one HID compatible variant which is supporte=
d by this driver.
> > > > > > +The controller has support for 8 analog channels.
> > > > > > +
> > > > > > +The driver is generating the following input event for on chan=
nels:
> > > > > > +
> > > > > > ++---------+----------------+
> > > > > > +| Channel |      Event     |
> > > > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > > > +|     1   |  ABS_Y         |
> > > > > > ++---------+----------------+
> > > > > > +|     2   |  ABS_X         |
> > > > > > ++---------+----------------+
> > > > > > +|     3   |  ABS_RY        |
> > > > > > ++---------+----------------+
> > > > > > +|     4   |  ABS_RX        |
> > > > > > ++---------+----------------+
> > > > > > +|     5   |  ABS_RUDDER    |
> > > > > > ++---------+----------------+
> > > > > > +|     6   |  ABS_THROTTLE  |
> > > > > > ++---------+----------------+
> > > > > > +|     7   |  ABS_Z         |
> > > > > > ++---------+----------------+
> > > > > > +|     8   |  ABS_RZ        |
> > > > > > ++---------+----------------+
> > > > > > +
> > > > > > +VRC2.0
> > > > > > +----------
> > > > > > +VRC2.0 is a controller for RC Cars.
> > > > > > +The controller has support for 2 analog channels.
> > > > > > +
> > > > > > +The driver is generating the following input event for on chan=
nels:
> > > > > > +
> > > > > > ++---------+----------------+
> > > > > > +| Channel |      Event     |
> > > > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > > > +|     1   |  ABS_GAS       |
> > > > > > ++---------+----------------+
> > > > > > +|     2   |  ABS_WHEEL     |
> > > > > > ++---------+----------------+
> > > > > > +
> > > > > > +RealFlight
> > > > > > +----------
> > > > > > +
> > > > > > +This driver supports Realflight G4-G7 and above
> > > > > > +The controller has support for 4 analog channels and two butto=
ns.
> > > > > > +
> > > > > > +The driver is generating the following input event for on chan=
nels:
> > > > > > +
> > > > > > ++---------+----------------+
> > > > > > +| Channel |      Event     |
> > > > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > > > +|     1   |  ABS_Y         |
> > > > > > ++---------+----------------+
> > > > > > +|     2   |  ABS_X         |
> > > > > > ++---------+----------------+
> > > > > > +|     3   |  ABS_RY        |
> > > > > > ++---------+----------------+
> > > > > > +|     4   |  ABS_RX        |
> > > > > > ++---------+----------------+
> > > > > > +|     5   |  BTN_A         |
> > > > > > ++---------+----------------+
> > > > > > +|     6   |  BTN_B         |
> > > > > > ++---------+----------------+
> > > > > > +
> > > > > > +XTR+G2+FMS Controllers
> > > > > > +--------------------------------
> > > > > > +
> > > > > > +The controllers has support for 8 analog channels.
> > > > > > +
> > > > > > +The driver is generating the following input event for on chan=
nels:
> > > > > > +
> > > > > > ++---------+----------------+
> > > > > > +| Channel |      Event     |
> > > > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > > > +|     1   |  ABS_Y         |
> > > > > > ++---------+----------------+
> > > > > > +|     2   |  ABS_X         |
> > > > > > ++---------+----------------+
> > > > > > +|     3   |  ABS_RY        |
> > > > > > ++---------+----------------+
> > > > > > +|     4   |  ABS_RX        |
> > > > > > ++---------+----------------+
> > > > > > +|     5   |  ABS_RUDDER    |
> > > > > > ++---------+----------------+
> > > > > > +|     6   |  ABS_THROTTLE  |
> > > > > > ++---------+----------------+
> > > > > > +|     7   |  ABS_Z         |
> > > > > > ++---------+----------------+
> > > > > > +|     8   |  ABS_RZ        |
> > > > > > ++---------+----------------+
> > > > > > +
> > > > > > +OrangeRX
> > > > > > +----------
> > > > > > +
> > > > > > +The controllers has support for 6 analog channels.
> > > > > > +
> > > > > > +The driver is generating the following input event for on chan=
nels:
> > > > > > +
> > > > > > ++---------+----------------+
> > > > > > +| Channel |      Event     |
> > > > > > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> > > > > > +|     1   |  ABS_Y         |
> > > > > > ++---------+----------------+
> > > > > > +|     2   |  ABS_X         |
> > > > > > ++---------+----------------+
> > > > > > +|     3   |  ABS_RY        |
> > > > > > ++---------+----------------+
> > > > > > +|     4   |  ABS_RX        |
> > > > > > ++---------+----------------+
> > > > > > +|     5   |  ABS_RUDDER    |
> > > > > > ++---------+----------------+
> > > > > > +|     6   |  ABS_THROTTLE  |
> > > > > > ++---------+----------------+
> > > > > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > > > > index 70da5931082f..d8313d36086c 100644
> > > > > > --- a/drivers/hid/Kconfig
> > > > > > +++ b/drivers/hid/Kconfig
> > > > > > @@ -957,6 +957,17 @@ config HID_RAZER
> > > > > >         Support for Razer devices that are not fully compliant =
with the
> > > > > >         HID standard.
> > > > > >
> > > > > > +config HID_RCSIM
> > > > > > +       tristate "RC Simulator Controllers"
> > > > > > +       depends on HID
> > > > > > +       help
> > > > > > +       Support for several HID compatible RC Simulator Control=
lers including
> > > > > > +         - Phoenix RC
> > > > > > +         - Car VRC2.0
> > > > > > +         - Real Flight
> > > > > > +         - Aero Fly, FMS
> > > > > > +         - OrangeRX FrSky
> > > > > > +
> > > > > >  config HID_PRIMAX
> > > > > >         tristate "Primax non-fully HID-compliant devices"
> > > > > >         depends on HID
> > > > > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > > > > index cac2cbe26d11..85d50ab352ee 100644
> > > > > > --- a/drivers/hid/Makefile
> > > > > > +++ b/drivers/hid/Makefile
> > > > > > @@ -102,6 +102,7 @@ obj-$(CONFIG_HID_PLANTRONICS)       +=3D hi=
d-plantronics.o
> > > > > >  obj-$(CONFIG_HID_PLAYSTATION)  +=3D hid-playstation.o
> > > > > >  obj-$(CONFIG_HID_PRIMAX)       +=3D hid-primax.o
> > > > > >  obj-$(CONFIG_HID_RAZER)        +=3D hid-razer.o
> > > > > > +obj-$(CONFIG_HID_RCSIM)        +=3D hid-rcsim.o
> > > > >
> > > > > General rule of thumbs, we try to name the drivers after their
> > > > > vendors, unless we know we have a generic driver.
> > > > >
> > > > > Here, this driver seems to be really tied to a small set of devic=
es,
> > > > > and thus I don't think we can call it "generic".
> > > >
> > > > Got it.
> > > >
> > > > >
> > > > > >  obj-$(CONFIG_HID_REDRAGON)     +=3D hid-redragon.o
> > > > > >  obj-$(CONFIG_HID_RETRODE)      +=3D hid-retrode.o
> > > > > >  obj-$(CONFIG_HID_ROCCAT)       +=3D hid-roccat.o hid-roccat-co=
mmon.o \
> > > > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > > > index d9eb676abe96..baf5f74d5bed 100644
> > > > > > --- a/drivers/hid/hid-ids.h
> > > > > > +++ b/drivers/hid/hid-ids.h
> > > > > > @@ -1381,6 +1381,11 @@
> > > > > >
> > > > > >  #define USB_VENDOR_ID_MULTIPLE_1781    0x1781
> > > > > >  #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD    0x0a9d
> > > > > > +#define USB_DEVICE_ID_PHOENIXRC        0x0898
> > > > > > +#define USB_DEVICE_ID_REALFLIGHT       0x0e56
> > > > > > +
> > > > > > +#define USB_VENDOR_ID_DIPLING  0x0B9B
> > > > > > +#define USB_DEVICE_ID_DIPLING_RCCONTROLLER     0x4012
> > > > > >
> > > > > >  #define USB_VENDOR_ID_DRACAL_RAPHNET   0x289b
> > > > > >  #define USB_DEVICE_ID_RAPHNET_2NES2SNES        0x0002
> > > > > > diff --git a/drivers/hid/hid-rcsim.c b/drivers/hid/hid-rcsim.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..0f214cb5816a
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/hid/hid-rcsim.c
> > > > > > @@ -0,0 +1,315 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Driver for several HID compatible RC Simulator Controllers.
> > > > > > + * Currently supported controllers are:
> > > > > > + *
> > > > > > + * - Phoenix RC (HID variant) (8ch)
> > > > > > + * - Car VRC2.0 (2ch)
> > > > > > + * - Real Flight G5/G6/G7 (6ch)
> > > > > > + * - Aero Fly, FMS (8ch)
> > > > > > + * - OrangeRX FrSky (6ch)
> > > > > > + *
> > > > > > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail=
=2Ecom>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/bitfield.h>
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/input.h>
> > > > > > +#include <linux/hid.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/usb.h>
> > > > > > +
> > > > > > +#include "hid-ids.h"
> > > > > > +
> > > > > > +/*
> > > > > > + * Some of these VID/PID are probably "borrowed", so keep them=
 locally and
> > > > > > + * do not populate hid-ids.h with those.
> > > > > > + */
> > > > > > +
> > > > > > +/* PHOENIXRC Controlloer (HID variant) */
> > > > > > +#define PHOENIXRC_VID  (USB_VENDOR_ID_MULTIPLE_1781)
> > > > > > +#define PHOENIXRC_PID  (USB_DEVICE_ID_PHOENIXRC)
> > > > > > +#define PHOENIXRC_DSIZE        (8)
> > > > > > +
> > > > > > +/* VRC2 Controlloer */
> > > > > > +#define VRC2_VID       (0x07c0)
> > > > > > +#define VRC2_PID       (0x1125)
> > > > > > +#define VRC2_DSIZE     (7)
> > > > > > +
> > > > > > +/* Realflight G4-&7 and Above Controller */
> > > > > > +#define REALFLIGHT_VID (USB_VENDOR_ID_MULTIPLE_1781)
> > > > > > +#define REALFLIGHT_PID (USB_DEVICE_ID_REALFLIGHT)
> > > > > > +#define REALFLIGHT_DSIZE       (8)
> > > > > > +
> > > > > > +#define REALFLIGHT_BTN_A       BIT(0)
> > > > > > +#define REALFLIGHT_BTN_B       BIT(1)
> > > > > > +
> > > > > > +/* XTR+G2+FMS Controller */
> > > > > > +#define XTRG2FMS_VID   (USB_VENDOR_ID_DIPLING)
> > > > > > +#define XTRG2FMS_PID   (USB_DEVICE_ID_DIPLING_RCCONTROLLER)
> > > > > > +#define XTRG2FMS_DSIZE (8)
> > > > > > +
> > > > > > +#define XTRG2FMS_X_HI  GENMASK(3, 2)
> > > > > > +#define XTRG2FMS_Y_HI  GENMASK(1, 0)
> > > > > > +#define XTRG2FMS_RX_HI GENMASK(7, 6)
> > > > > > +#define XTRG2FMS_RY_HI GENMASK(5, 4)
> > > > > > +#define XTRG2FMS_ALT1_HI       GENMASK(3, 2)
> > > > > > +#define XTRG2FMS_ALT2_HI       GENMASK(1, 0)
> > > > > > +
> > > > > > +/* OrangeRX FrSky */
> > > > > > +#define ORANGERX_VID   (0x0451)
> > > > > > +#define ORANGERX_PID   (0x16a5)
> > > > > > +#define ORANGERX_DSIZE (8)
> > > > > > +
> > > > > > +enum rcsim_controller {
> > > > > > +       PHOENIXRC,
> > > > > > +       VRC2,
> > > > > > +       REALFLIGHT,
> > > > > > +       XTRG2FMS,
> > > > > > +       ORANGERX
> > > > > > +};
> > > > > > +
> > > > > > +struct rcsim_priv {
> > > > > > +       struct hid_device *hdev;
> > > > > > +       struct input_dev *input;
> > > > > > +       enum rcsim_controller controller;
> > > > > > +       u8 alt;
> > > > > > +};
> > > > > > +
> > > > > > +static int rcsim_open(struct input_dev *dev)
> > > > > > +{
> > > > > > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > > > > > +
> > > > > > +       return hid_hw_open(priv->hdev);
> > > > > > +}
> > > > > > +
> > > > > > +static void rcsim_close(struct input_dev *dev)
> > > > > > +{
> > > > > > +       struct rcsim_priv *priv =3D input_get_drvdata(dev);
> > > > > > +
> > > > > > +       hid_hw_close(priv->hdev);
> > > > > > +}
> > > > > > +
> > > > > > +static int rcsim_setup_input(struct rcsim_priv *priv)
> > > > > > +{
> > > > > > +       struct input_dev *input;
> > > > > > +
> > > > > > +       input =3D devm_input_allocate_device(&priv->hdev->dev);
> > > > > > +       if (!input)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       input->id.bustype =3D priv->hdev->bus;
> > > > > > +       input->id.vendor  =3D priv->hdev->vendor;
> > > > > > +       input->id.product =3D priv->hdev->product;
> > > > > > +       input->id.version =3D priv->hdev->bus;
> > > > > > +       input->phys =3D priv->hdev->phys;
> > > > > > +       input->uniq =3D priv->hdev->uniq;
> > > > > > +       input->open =3D rcsim_open;
> > > > > > +       input->close =3D rcsim_close;
> > > > > > +
> > > > > > +       input_set_drvdata(input, priv);
> > > > > > +
> > > > > > +       switch (priv->controller) {
> > > > > > +       case PHOENIXRC:
> > > > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0=
);
> > > > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0=
);
> > > > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_Z, 0, 255, 0, 0=
);
> > > > > > +               input_set_abs_params(input, ABS_RZ, 0, 255, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255,=
 0, 0);
> > > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 25=
5, 0, 0);
> > > > > > +               input->name =3D "RC Simuator Controller Phoenix=
RC";
> > > > > > +               break;
> > > > > > +       case VRC2:
> > > > > > +               input_set_abs_params(input, ABS_GAS, 0, 2048, 0=
, 0);
> > > > > > +               input_set_abs_params(input, ABS_WHEEL, 0, 2048,=
 0, 0);
> > > > > > +               input->name =3D "RC Simuator Controller VRC2.0";
> > > > > > +               break;
> > > > > > +       case REALFLIGHT:
> > > > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0,=
 0);
> > > > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0,=
 0);
> > > > > > +               input_set_capability(input, EV_KEY, BTN_A);
> > > > > > +               input_set_capability(input, EV_KEY, BTN_B);
> > > > > > +               input->name =3D "RC Simuator Controller Realfli=
ght";
> > > > > > +               break;
> > > > > > +       case XTRG2FMS:
> > > > > > +               input_set_abs_params(input, ABS_X, 0, 1024, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_Y, 0, 1024, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RX, 0, 1024, 0,=
 0);
> > > > > > +               input_set_abs_params(input, ABS_RY, 0, 1024, 0,=
 0);
> > > > > > +               input_set_abs_params(input, ABS_Z, 0, 1024, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RZ, 0, 1024, 0,=
 0);
> > > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 1024=
, 0, 0);
> > > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 10=
24, 0, 0);
> > > > > > +               input->name =3D "RC Simuator Controller AeroFly=
, FMS";
> > > > > > +               priv->alt =3D 0;
> > > > > > +               break;
> > > > > > +       case ORANGERX:
> > > > > > +               input_set_abs_params(input, ABS_X, 0, 255, 0, 0=
);
> > > > > > +               input_set_abs_params(input, ABS_Y, 0, 255, 0, 0=
);
> > > > > > +               input_set_abs_params(input, ABS_RX, 0, 255, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RY, 0, 255, 0, =
0);
> > > > > > +               input_set_abs_params(input, ABS_RUDDER, 0, 255,=
 0, 0);
> > > > > > +               input_set_abs_params(input, ABS_THROTTLE, 0, 25=
5, 0, 0);
> > > > > > +               input->name =3D "RC Simuator Controller OrangeR=
X FrSky";
> > > > > > +               break;
> > > > > > +       };
> > > > > > +
> > > > > > +       priv->input =3D input;
> > > > > > +       return input_register_device(priv->input);
> > > > > > +}
> > > > >
> > > > > You are basically rewriting hid-input.c, which is suboptimal.
> > > >
> > > > Ouch. I will have a look at hid-input, thanks.
> > > >
> > > > >
> > > > > I guess the report descriptor provided by these devices are basic=
ally
> > > > > useless, and so you have to parse the reports yourself in the
> > > > > raw_event callback.
> > > >
> > > > Yep.
> > > >
> > > > >
> > > > > But instead of manually doing that, why not overwrite the report
> > > > > descriptor (with .rdesc_fixup) and declare here all of the data t=
hat
> > > >  Do you mean .report_fixup?
> > >
> > > yes, sorry :/
> > >
> > > >
> > > > > needs to be exported. You could remove basically everything in th=
is
> > > > > driver by just providing a fixed report descriptor.
> > > >
> > > > What you are aiming for is to fixup the report descriptor and let t=
he
> > > > generic hid-raw driver handle the rest, or do I get you wrong?
> > >
> > > yep, exactly
> > >
> > > >
> > > > How is the report mapped to certain events then?
> > >
> > > Have a look at hid_configure_usage in hid-input.c [3]. Most of HID
> > > events are mapped to input events with a one to one mapping.
> > >
> > > >
> > > > I do read at [1] but it is not obvious how to put it together.
> > > > Most drivers I've looked at that is using .report_fixup just fix br=
oken
> > > > reports. I guess these reports are not "broken", just.. odd?
> > >
> > > Have a look at [2], lots of full report descriptors :)
> > >
> > > And in your case, the reports are incomplete, not odd.
> > >
> > > >
> > > >
> > > > >
> > > > > > +
> > > > > > +static int rcsim_raw_event(struct hid_device *hdev,
> > > > > > +                              struct hid_report *report,
> > > > > > +                              u8 *raw_data, int size)
> > > > > > +{
> > > > > > +       struct rcsim_priv *priv =3D hid_get_drvdata(hdev);
> > > > > > +       u16 value;
> > > > > > +
> > > > > > +       switch (priv->controller) {
> > > > > > +       case PHOENIXRC:
> > > > > > +               if (size !=3D PHOENIXRC_DSIZE)
> > > > > > +                       break;
> > > > > > +
> > > > > > +               /* X, RX, Y and RY, RUDDER and THROTTLE are sen=
t every time */
> > > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2=
]);
> > > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[0=
]);
> > > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[=
4]);
> > > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[=
3]);
> > > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_d=
ata[5]);
> > > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw=
_data[6]);
> > > > > > +
> > > > > > +               /* Z and RZ are sent every other time */
> > > > > > +               if (priv->alt)
> > > > > > +                       input_report_abs(priv->input, ABS_Z, ra=
w_data[7]);
> > > > > > +               else
> > > > > > +                       input_report_abs(priv->input, ABS_RZ, r=
aw_data[7]);
> > > > > > +
> > > > > > +               priv->alt ^=3D 1;
> > > > > > +               break;
> > > > > > +       case VRC2:
> > > > > > +               if (size !=3D VRC2_DSIZE)
> > > > > > +                       break;
> > > > > > +               value =3D (raw_data[1] << 8 | raw_data[0]) & GE=
NMASK(10, 0);
> > > > > > +               input_report_abs(priv->input, ABS_GAS, value);
> > > > > > +               value =3D (raw_data[3] << 8 | raw_data[2]) & GE=
NMASK(10, 0);
> > > > > > +               input_report_abs(priv->input, ABS_WHEEL, value);
> > > > > > +               break;
> > > > > > +       case REALFLIGHT:
> > > > > > +               if (size !=3D REALFLIGHT_DSIZE)
> > > > > > +                       break;
> > > > > > +               input_report_abs(priv->input, ABS_X, raw_data[2=
]);
> > > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[1=
]);
> > > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[=
5]);
> > > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[=
3]);
> > > > > > +               input_report_abs(priv->input, ABS_MISC, raw_dat=
a[4]);
> > > > > > +               input_report_key(priv->input, BTN_A,
> > > > > > +                               raw_data[7] & REALFLIGHT_BTN_A);
> > > > > > +               input_report_key(priv->input, BTN_B,
> > > > > > +                               raw_data[7] & REALFLIGHT_BTN_B);
> > > > > > +               break;
> > > > > > +       case XTRG2FMS:
> > > > > > +               if (size !=3D XTRG2FMS_DSIZE)
> > > > > > +                       break;
> > > > > > +
> > > > > > +               /* X, RX, Y and RY are sent every time */
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_X_HI, raw_data[3]);
> > > > > > +               value =3D (value << 8) | raw_data[1];
> > > > > > +               input_report_abs(priv->input, ABS_X, value);
> > > > > > +
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_Y_HI, raw_data[3]);
> > > > > > +               value =3D (value << 8) | raw_data[2];
> > > > > > +               input_report_abs(priv->input, ABS_Y, value);
> > > > > > +
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_RX_HI, raw_data[3]=
);
> > > > > > +               value =3D (value << 8) | raw_data[0];
> > > > > > +               input_report_abs(priv->input, ABS_RX, value);
> > > > > > +
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_RY_HI, raw_data[3]=
);
> > > > > > +               value =3D (value << 8) | raw_data[4];
> > > > > > +               input_report_abs(priv->input, ABS_RY, value);
> > > > > > +
> > > > > > +               /* Z, RZ, RUDDER and THROTTLE are sent every ot=
her time */
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[=
7]);
> > > > > > +               value =3D (value << 8) | raw_data[6];
> > > > > > +               if (priv->alt)
> > > > > > +                       input_report_abs(priv->input, ABS_Z, va=
lue);
> > > > > > +               else
> > > > > > +                       input_report_abs(priv->input, ABS_RUDDE=
R, value);
> > > > > > +
> > > > > > +               value =3D FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[=
7]);
> > > > > > +               value =3D (value << 8) | raw_data[5];
> > > > > > +               if (priv->alt)
> > > > > > +                       input_report_abs(priv->input, ABS_RZ, v=
alue);
> > > > > > +               else
> > > > > > +                       input_report_abs(priv->input, ABS_THROT=
TLE, value);
> > > > > > +
> > > > > > +               priv->alt ^=3D 1;
> > > > > > +               break;
> > > > > > +       case ORANGERX:
> > > > > > +               if (size !=3D ORANGERX_DSIZE)
> > > > > > +                       break;
> > > > > > +               input_report_abs(priv->input, ABS_X, raw_data[0=
]);
> > > > > > +               input_report_abs(priv->input, ABS_Y, raw_data[2=
]);
> > > > > > +               input_report_abs(priv->input, ABS_RX, raw_data[=
3]);
> > > > > > +               input_report_abs(priv->input, ABS_RY, raw_data[=
1]);
> > > > > > +               input_report_abs(priv->input, ABS_RUDDER, raw_d=
ata[5]);
> > > > > > +               input_report_abs(priv->input, ABS_THROTTLE, raw=
_data[6]);
> > > > > > +               break;
> > > > > > +       };
> > > > > > +
> > > > > > +       input_sync(priv->input);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int rcsim_probe(struct hid_device *hdev, const struct h=
id_device_id *id)
> > > > > > +{
> > > > > > +       struct device *dev =3D &hdev->dev;
> > > > > > +       struct rcsim_priv *priv;
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       if (!hid_is_using_ll_driver(hdev, &usb_hid_driver))
> > > > > > +               return -ENODEV;
> > > > >
> > > > > You are not accessing anything in the USB stack, so there is no n=
eed
> > > > > to prevent regression tests that could inject uhid devices to your
> > > > > drivers.
> > > >
> > > > Ok, thanks.
> > > >
> > > > >
> > > > > Cheers,
> > > > > Benjamin
> > > > >
> > > >
> > > > Best regards,
> > > > Marcus Folkesson
> > > >
> > > > [1] https://www.usb.org/hid
> > > >
> > >
> > > If you need help in writing report descriptors, I can give you some,
> > > but the easiest might be for you to start from the report descriptor
> > > in hid-sony.c. I used to have a tool to dynamically write a report
> > > descriptor, but I'm not sure it still works...
> >
> > I've worked with the report descriptor for VRC2, and have come up with
> > something that works.
>=20
> Great that you managed to fill in most of the gaps :)
>=20
> >
> >
> > static __u8 vrc2_rdesc_fixed[] =3D {
> >         0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
> >         0x09, 0x04,        // Usage (Joystick)
> >         0xA1, 0x01,        // Collection (Application)
> >         0x09, 0x01,        //   Usage (Pointer)
> >         0xA1, 0x00,        //   Collection (Physical)
> >         0x09, 0x30,        //     Usage (X)
> >         0x09, 0x31,        //     Usage (Y)
> >         0x15, 0x00,        //     Logical Minimum (0)
> >         0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
> >         0x35, 0x00,        //     Physical Minimum (0)
> >         0x46, 0xFF, 0x00,  //     Physical Maximum (255)
> >         0x75, 0x10,        //     Report Size (16)
> >         0x95, 0x02,        //     Report Count (2)
> >         0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Pr=
eferred State,No Null Position)
> >         0xC0,              //   End Collection
> >         0x95, 0x01,        //   Report Count (1)
> >         0x75, 0x18,        //   Report Size (24)
> >         0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,P=
referred State,No Null Position)
> >         0x09, 0x00,        //   Usage (Undefined)
> >         0x15, 0x00,        //   Logical Minimum (0)
> >         0x26, 0xFF, 0x00,  //   Logical Maximum (255)
> >         0x75, 0x08,        //   Report Size (8)
> >         0x95, 0x08,        //   Report Count (8)
> >         0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Pr=
eferred State,No Null Position,Non-volatile)
> >         0xC0,              // End Collection
> > };
> >
> >
> > It is a result of reading specifications and looking at various
> > examples.
> >
> > These lines are taken from an example, and I do not know why I need
> > those. I think the constant report size is wrong (should be 32 to
>=20
> Do you have an example of the actual data sent on the wire? hexdump or
> hid-recorder should be enough for me to get what is missing.

Sorry, this will be a little confusing.

I just realized that there are actually two hidraw devices showing
up.

One with this descriptor:
0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
0x09, 0x00,        // Usage (Undefined)
0xA1, 0x01,        // Collection (Application)
0x15, 0x00,        //   Logical Minimum (0)
0x25, 0x01,        //   Logical Maximum (1)
0x75, 0x01,        //   Report Size (1)
0x05, 0x09,        //   Usage Page (Button)
0x19, 0x01,        //   Usage Minimum (0x01)
0x29, 0x3F,        //   Usage Maximum (0x3F)
0x95, 0x40,        //   Report Count (64)
0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,=
No Null Position)
0xC0,              // End Collection

Output from hid-recorder:
E: 000074.735891 8 20 00 ed 03 00 00 00 cc
#  Button: 0  0  0  0  0  1  0  0  0  0  0  0  0  0  0  0  0  0  0  1  0  1=
  1  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0=
  0  0  0  0  0  0  0  0  0  0  0  1  1  0  0  1 , 1

At a first glance, it did look as the button bits follows the same
pattern as the joystick axis in the descriptor below. It is hard to
debug though, as it causes random clicks and button presses
everywhere... and it driving me nuts.


The other one looks like this:
0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
0x09, 0x04,        // Usage (Joystick)
0xA1, 0x01,        // Collection (Application)
0x09, 0x01,        //   Usage (Pointer)
0xA1, 0x00,        //   Collection (Physical)
0x09, 0x30,        //     Usage (X)
0x09, 0x31,        //     Usage (Y)
0x09, 0x32,        //     Usage (Z)
0x15, 0x00,        //     Logical Minimum (0)
0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
0x35, 0x00,        //     Physical Minimum (0)
0x46, 0xFF, 0x00,  //     Physical Maximum (255)
0x75, 0x10,        //     Report Size (16)
0x95, 0x03,        //     Report Count (3)
0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred Stat=
e,No Null Position)
0xC0,              //   End Collection
0x05, 0x09,        //   Usage Page (Button)
0x19, 0x01,        //   Usage Minimum (0x01)
0x29, 0x02,        //   Usage Maximum (0x02)
0x15, 0x00,        //   Logical Minimum (0)
0x25, 0x01,        //   Logical Maximum (1)
0x95, 0x02,        //   Report Count (2)
0x75, 0x01,        //   Report Size (1)
0x81, 0x02,        //   Input (Data,Var,Abs,No Wrap,Linear,Preferred State,=
No Null Position)
0x95, 0x01,        //   Report Count (1)
0x75, 0x06,        //   Report Size (6)
0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,Preferred Sta=
te,No Null Position)
0x09, 0x00,        //   Usage (0x00)
0x15, 0x00,        //   Logical Minimum (0)
0x26, 0xFF, 0x00,  //   Logical Maximum (255)
0x75, 0x08,        //   Report Size (8)
0x95, 0x08,        //   Report Count (8)
0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Preferred Stat=
e,No Null Position,Non-volatile)
0xC0,              // End Collection

Output from hid-recorder:
E: 000013.240054 7 00 00 00 00 80 00 00
#  X:      110 | Y:      122 | Z:    0   | Button: 0  0 | #


The controller does only support 2 axis (X/Y) and no buttons, so this
descriptor is wrong in any way.
I see that it makes use of Feature as well.
Does this feature have something to do with the first HID device?

>=20
> As I read the report descriptors, we had:
> * old one:
>   - opening of application collection of usage undefined
>     - 64 buttons (logical max of 1), usage being being 0x01 and 0x3F
> (63) -> so the last bit is ignored
>=20
> Which would translate to a report of the following (each 0 being a
> separate button, | is marking bytes):
>=20
> 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0,
> 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0,
> 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, 0 | 0, 0, 0, 0, 0, 0, 0, X
>=20
> -> 64 * 1 =3D 64 bits
>=20
> ()last bit being ignored because of its duplicated usage with the previou=
s one)
>=20
> * new one:
>   - opening of an application collection of usage Joystick
>     - opening of a physical collection of type Pointer
>       - 16 bits for X, with logical max of 2047 and physical max of 255
>       - 16 bits for Y, with logical max of 2047 and physical max of 255
>     - 1 const element of size 24 that has to be ignored
>     - one feature that should not be there :)
>=20
> So it would translate into the following (c being constant bit):
> X (2 bytes) | Y (2 bytes) | c, c, c, c, c, c, c, c | c, c, c, c, c, c,
> c, c | c, c, c, c, c, c, c, c
>=20
> -> 24 + 2*8 + 2*8 =3D 56 bits
>=20
> So I agree with you, you are missing 16 bits
>=20
> > fill up) and I do not know what the Feature is used for.
>=20
> You should not have to declare a feature. A feature is a special HID
> endpoint that you can use to talk to the HID device. By emitting
> special HID commands, (HID_REPORT_GET/HID_REPORT_SET) you can control
> how the device works. But if your current report descriptor doesn't
> have a feature declared, you should not declare it.
>=20
> >
> >         0x95, 0x01,        //   Report Count (1)
> >         0x75, 0x18,        //   Report Size (24)
> >         0x81, 0x01,        //   Input (Const,Array,Abs,No Wrap,Linear,P=
referred State,No Null Position)
> >         0x09, 0x00,        //   Usage (Undefined)
> >         0x15, 0x00,        //   Logical Minimum (0)
> >         0x26, 0xFF, 0x00,  //   Logical Maximum (255)
> >         0x75, 0x08,        //   Report Size (8)
> >         0x95, 0x08,        //   Report Count (8)
> >         0xB1, 0x02,        //   Feature (Data,Var,Abs,No Wrap,Linear,Pr=
eferred State,No Null Position,Non-volatile)
> >
> > If I omit any of these lines then I only get tons of
> >
> > kernel: usb 3-12.3.1.3.3: input irq status -75 received
>=20
> I assume the feature in this particular case helps the driver to
> understand that you need to allocate a 64 bits chunk of memory to
> communicate with the device.
>=20
> I would advise to use the following report instead:
>=20
> ----
> static __u8 vrc2_rdesc_fixed[] =3D {
>         0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
>         0x09, 0x04,        // Usage (Joystick)
>         0xA1, 0x01,        // Collection (Application)
>         0x09, 0x01,        //   Usage (Pointer)
>         0xA1, 0x00,        //   Collection (Physical)
>         0x09, 0x30,        //     Usage (X)
>         0x09, 0x31,        //     Usage (Y)
>         0x15, 0x00,        //     Logical Minimum (0)
>         0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
>         0x35, 0x00,        //     Physical Minimum (0)
>         0x46, 0xFF, 0x00,  //     Physical Maximum (255)
>         0x75, 0x10,        //     Report Size (16)
>         0x95, 0x02,        //     Report Count (2)
>         0x81, 0x02,        //     Input (Data,Var,Abs,No
> Wrap,Linear,Preferred State,No Null Position)
>         0xC0,              //   End Collection
>         0x75, 0x08,        //   Report Size (8)
>        0x95, 0x04,        //   Report Count (4)
>         0x81, 0x03,        //   Input (Cnst,Var,Abs)
>         0xC0,              // End Collection
> };
> ---

This report is more of what I want it to look like.

I got the same "usb 3-12.3.1.3.1: input irq status -75 received" error
when using this descriptor though.
I think it is beacause it is applied to both hid-devices?


>=20
> Few changes:
> - use of 4 bytes of padding, instead of 1 24bits slot of padding
> - changed the padding from 0x01 to 0x03 to remove the "array" const
> definition which is tricky to handle
> - removed the feature report.
>=20
> Cheers,
> Benjamin
>=20
> >
> > In the kernel log.
> >
> >
> > >
> > > FYI, I just re-read rcsim_raw_event() and there is stuff that would
> > > require more than just a report descriptor fixup (the fact that some
> > > data is sent every other report is not good and will need some manual
> > > handling though).
> > >
> > > Cheers,
> > > Benjamin
> > >
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/hid/hid-uclogic-rdesc.c
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/hid/hid-input.c#n817
> > >
> >
> >
> > Best regards
> > Marcus Folkesson
>=20

Best regards,
Marcus Folkesson

--3fZ1JFuUIbtALSdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMOIgQACgkQiIBOb1ld
UjItyg//RoIpPPVuXxbOL0EC7wpBM+mKCusbrJwmKNiVuycg6pgugCwkuJW7XItx
WWMyMoHMBXJ/sjDQdThTOKx2lZjHLnJVqzEoKnVYkX9doR45YnwtbI8KLNwCASIs
rUtqV/kPOhdkogPaWwUeRgKZv5/i+M/5WfsolZ5CiLPuOTOifcQC0lORNlzcMlJv
Q1YdpiCecLpO+k3RfYOXnXvjtB1VxWI/Uh+vNeFBofP3r+QOZ0Fj5Sed/IzpAJvU
2kwfanASVZzUVOyETK9FEXGogGm3IbZXf7pK9BcNYxwM+3+s5J05pmq0sZ9WnZJX
GAh/tJRDSk8JVRLEfpGcSctThKuSF8cb0+PY+7/Wd8YpKHcc2pe63QObwwDuhWtI
W7sbiAa3cUEIVTKZ08CVRprQEijesVln412vDFEpLoapkNIiq1pz26qVRXfD9GaF
BTeqGYqOCFm7paSlPaebyz53K1EdTc0gg/tFLtlMDfVL8+OID9Nj6gSxLSfqU+Wl
Zj6lyIwZtsbgnm4UD1jah5wiJygq2hmrOGzep5N2vjW/ORiZvT6JXP1bcwG4W3F0
5mk325X2UQQ73DpfDTczC8EuCiJusfN85FBanKDmDqE5lNhyOvaojNyXCCltD291
plmWOpJ+k1nE2yVH8jLRJwMIKL5rHVM05rsc+ROXlE2zaArm11o=
=A9l/
-----END PGP SIGNATURE-----

--3fZ1JFuUIbtALSdz--
