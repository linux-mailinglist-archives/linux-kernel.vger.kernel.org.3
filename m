Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080485A7BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiHaKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiHaKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:51:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933C95E47;
        Wed, 31 Aug 2022 03:51:40 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q16so14175018ljp.8;
        Wed, 31 Aug 2022 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=aR2DOIsV1mXDK4CgRRWC1HD4bF1B2sV8M+HQHPonAis=;
        b=SBXgnrc1kgaUeBhDanh1HBbcx3d2A9hyTlMdf1gSgBhE/GGLcX7NnygoLNj0VF6C9u
         KApO1v8aB9qkPwP55lyzDCRne9pgS3ABCes/vzk2yQ8fWOZIiDXCriIUh35f3fL9X14B
         R7B6BI4xLajC7vlwoekj8OGLEKGuAns5/4NdymwMgb2L0RQViC0kfQKNQWM4YE4/jqn7
         Qv2JrLoma4sLao1aZPkvF4IRkUYuFLxezybjulPtEjEp2VABbIB4mevXDP2+ppopxDDI
         HcV9MkaDlRcPyOIDfYev4q1MHFfIi2vH0fcKcpXdSMKdUJCaJnOFpRrcyeyBwyRuuI4j
         rpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aR2DOIsV1mXDK4CgRRWC1HD4bF1B2sV8M+HQHPonAis=;
        b=NL9AYLZ+PmUnTNTW/lM1o9TeczQw4uudmvobrIaScMVTJDrm6V1e5uLM1QOSQhCfTu
         hZZYOYuMO1CtQIyo7IZSKMz6/83x5kr6DDZJK9I47BfLBMwD3/CYLSJTdABS2CDCFT97
         J/hvib0GxgrxAbxD347UJFAM6AMjpFr+AXLyDuRYow2Ha74ZGC7H/DkjXME9er9hjzoC
         AW4xj0G02aKgdIYdrdfS89bKPDqFoJnh9BiFF134wbG4Pm1VUxoWbfHsTLgkBH0D4sOY
         Z7KMf2cYdfgwGUTNN6OAo60w4/kWtv/BOXkgybgP147ggpI+sAbIFedueVlzHnSJGSaO
         Lo5A==
X-Gm-Message-State: ACgBeo2Uc7j1P2cO/0Pj3ayXP0Zi9JsUcs/5XwKur46x1a38YupEluBD
        b6HjZl318TpA+sxYMhoEj/v2w9i+7LM=
X-Google-Smtp-Source: AA6agR5abi70+RUn1InN9JBo77lbvsdkFrKtNagu602Ttxf0Z8YIu0etw0KaQBa0FmRg1yctkHX8Ng==
X-Received: by 2002:a2e:b8d5:0:b0:25f:e94d:10a2 with SMTP id s21-20020a2eb8d5000000b0025fe94d10a2mr8872225ljp.274.1661943098500;
        Wed, 31 Aug 2022 03:51:38 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id o3-20020ac25e23000000b0048b12ff12e8sm1951564lfg.99.2022.08.31.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:51:37 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:56:51 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] HID: Add driver for VRC-2 Car Controller
Message-ID: <Yw8+cx+0QyHe6K95@gmail.com>
References: <20220830195055.1812192-1-marcus.folkesson@gmail.com>
 <20220830195055.1812192-2-marcus.folkesson@gmail.com>
 <CAO-hwJ+34yUM0nkp8HPnubf8-aHX7RXWt=m5u2qFgXByGg0+Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3X/soURl3JHM+qm5"
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+34yUM0nkp8HPnubf8-aHX7RXWt=m5u2qFgXByGg0+Ng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3X/soURl3JHM+qm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 31, 2022 at 11:45:21AM +0200, Benjamin Tissoires wrote:
> On Tue, Aug 30, 2022 at 9:46 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > VRC-2 is 2-axis controller often used in car simulators.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  MAINTAINERS            |   6 +++
> >  drivers/hid/Kconfig    |   9 ++++
> >  drivers/hid/Makefile   |   1 +
> >  drivers/hid/hid-vrc2.c | 100 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 116 insertions(+)
> >  create mode 100644 drivers/hid/hid-vrc2.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 216b9f021f72..33010f93c993 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8919,6 +8919,12 @@ F:       drivers/hid/hid-sensor-*
> >  F:     drivers/iio/*/hid-*
> >  F:     include/linux/hid-sensor-*
> >
> > +HID VRC-2 CAR CONTROLLER DRIVER
> > +M:     Marcus Folkesson <marcus.folkesson@gmail.com>
> > +L:     linux-input@vger.kernel.org
> > +S:     Maintained
> > +F:     drivers/hid/hid-vrc2.c
> > +
> >  HID WACOM DRIVER
> >  M:     Ping Cheng <ping.cheng@wacom.com>
> >  M:     Jason Gerecke  <jason.gerecke@wacom.com>
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index d8313d36086c..518e0a5a7852 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -481,6 +481,15 @@ config HID_VIEWSONIC
> >         help
> >           Support for ViewSonic/Signotec PD1011 signature pad.
> >
> > +config HID_VRC2
> > +       tristate "VRC-2 Car Controller"
> > +       depends on HID
> > +       help
> > +        Support for VRC-2 2-axis Car Controller
>=20
> maybe "Support for VRC-2 which is a 2-axis controller often used in
> car simulators." to be a little bit more explicit.

Will change, thank you.

>=20
> > +
> > +        To compile this driver as a module, choose M here: the
> > +        module will be called hid-vrc2.
> > +
> >  config HID_XIAOMI
> >         tristate "Xiaomi"
> >         depends on HID
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 85d50ab352ee..32ab85b1a776 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -137,6 +137,7 @@ obj-$(CONFIG_HID_XINMO)             +=3D hid-xinmo.o
> >  obj-$(CONFIG_HID_ZEROPLUS)     +=3D hid-zpff.o
> >  obj-$(CONFIG_HID_ZYDACRON)     +=3D hid-zydacron.o
> >  obj-$(CONFIG_HID_VIEWSONIC)    +=3D hid-viewsonic.o
> > +obj-$(CONFIG_HID_VRC2)         +=3D hid-vrc2.o
> >
> >  wacom-objs                     :=3D wacom_wac.o wacom_sys.o
> >  obj-$(CONFIG_HID_WACOM)                +=3D wacom.o
> > diff --git a/drivers/hid/hid-vrc2.c b/drivers/hid/hid-vrc2.c
> > new file mode 100644
> > index 000000000000..43c98607b837
> > --- /dev/null
> > +++ b/drivers/hid/hid-vrc2.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * HID driver for VRC-2 2-axis Car controller
> > + *
> > + * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +
> > +/*
> > + * VID/PID are probably "borrowed", so keep them locally and
> > + * do not populate hid-ids.h with those.
> > + */
> > +#define USB_VENDOR_ID_VRC2     (0x07c0)
> > +#define USB_DEVICE_ID_VRC2     (0x1125)
> > +
> > +static __u8 vrc2_rdesc_fixed[] =3D {
> > +       0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
> > +       0x09, 0x04,        // Usage (Joystick)
> > +       0xA1, 0x01,        // Collection (Application)
> > +       0x09, 0x01,        //   Usage (Pointer)
> > +       0xA1, 0x00,        //   Collection (Physical)
> > +       0x09, 0x30,        //     Usage (X)
> > +       0x09, 0x31,        //     Usage (Y)
> > +       0x15, 0x00,        //     Logical Minimum (0)
> > +       0x26, 0xFF, 0x07,  //     Logical Maximum (2047)
> > +       0x35, 0x00,        //     Physical Minimum (0)
> > +       0x46, 0xFF, 0x00,  //     Physical Maximum (255)
> > +       0x75, 0x10,        //     Report Size (16)
> > +       0x95, 0x02,        //     Report Count (2)
> > +       0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Pr=
eferred State,No Null Position)
> > +       0xC0,              //   End Collection
> > +       0x75, 0x08,        //   Report Size (8)
> > +       0x95, 0x03,        //   Report Count (3)
> > +       0x81, 0x03,        //   Input (Cnst,Var,Abs)
> > +       0xC0,              // End Collection
> > +};
> > +
> > +static __u8 *vrc2_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> > +                               unsigned int *rsize)
> > +{
> > +       if (*rsize =3D=3D 23)
> > +               return rdesc;
>=20
> This test is not required. probe() returned -ENODEV for this
> interface, so we are sure we have the correct one when we are there.

Got it.

>=20
> > +
> > +       hid_info(hdev, "fixing up VRC-2 report descriptor\n");
> > +       *rsize =3D sizeof(vrc2_rdesc_fixed);
> > +       return vrc2_rdesc_fixed;
> > +}
> > +
> > +static int vrc2_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * The device gives us 2 separate USB endpoints.
> > +        * One of those (the one with report descriptor size of 23) is =
just bogus so ignore it
> > +        */
> > +       if (hdev->dev_rsize =3D=3D 23)
> > +               return -ENODEV;
> > +
> > +       ret =3D hid_parse(hdev);
> > +       if (ret) {
> > +               hid_err(hdev, "parse failed\n");
> > +               return ret;
> > +       }
> > +
> > +       ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +       if (ret) {
> > +               hid_err(hdev, "hw start failed\n");
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void vrc2_remove(struct hid_device *hdev)
> > +{
> > +       hid_hw_stop(hdev);
> > +}
>=20
> I am pretty sure you can remove that vrc2_remove(), hid-core should be
> able to call hid_hw_stop() for you.
>=20

Hrm. Looking at this description:

/**
 * hid_hw_start - start underlying HW
 * @hdev: hid device
 * @connect_mask: which outputs to connect, see HID_CONNECT_*
 *
 * Call this in probe function *after* hid_parse. This will setup HW
 * buffers and start the device (if not defeirred to device open).
 * hid_hw_stop must be called if this was successful.
 */

 and


/**
 * hid_hw_stop - stop underlying HW
 * @hdev: hid device
 *
 * This is usually called from remove function or from probe when something
 * failed and hid_hw_start was called already.
 */

Most of the HID drivers actually do call hid_hw_stop() in the their .remove.

hid_device_remove(struct device *dev)
Seems to do this for you though.

Maybe we should clean it up to avoid more drivers to follow this
pattern?


> > +
> > +static const struct hid_device_id vrc2_devices[] =3D {
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_VRC2, USB_DEVICE_ID_VRC2) },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(hid, vrc2_devices);
> > +
> > +static struct hid_driver vrc2_driver =3D {
> > +       .name =3D "vrc2",
> > +       .id_table =3D vrc2_devices,
> > +       .report_fixup =3D vrc2_report_fixup,
> > +       .probe =3D vrc2_probe,
> > +       .remove =3D vrc2_remove,
> > +};
> > +module_hid_driver(vrc2_driver);
> > +
> > +MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
> > +MODULE_DESCRIPTION("HID driver for VRC-2 2-axis Car controller");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.37.1
> >
>=20
> Cheers,
> Benjamin
>=20

Best regards,
Marcus Folkesson

--3X/soURl3JHM+qm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMPPmkACgkQiIBOb1ld
UjJQBg//fWa9zKyzQsNfquM5bXHlPaedUoW6xIuVslE8R2Q5EmYGLt1vzobW1gSf
cqYPIVFyyz3thMa9hCoEQi/+VjWCshsVSq7jnHANp0HMRUj04XklJiv1OzpfXGD+
IuCxeEoeswfviO1gM+qK2TXCArgAPjDv7YptC8vduFG1rviUrKtoNyxZdGcXqe1G
34uNJ3IWrB91vHKYcermn6CWyIOU8rZLA8ARC8Z0ysQnRHrg6sxyH9IHivn4kuqN
a5HsZCroBm5DajvnSw/XjwleswOG8jsCmIUnPAqQyWxnKpkvZ422M6Jy5Xl9jugY
3kF/EGL3hFMtdEWYSuydoAU49b999OJ3BtY1/L20RU0M+wykkrUw/CF/+vBehKBs
+roKB8AfC6PsL2mnJozmr7fJHlRW34bG3MHr3kygYnk6dNAP3kBjqFHmn6Xvk4EN
qC++BSrEljlSox6QFRH/RXfAOAGJcVPt6MEGwNIBWoexBF0dEhw26qe7vUi8VABm
KmetM/r4NVZOJWLMqK4afzDDLrEr3KaR4yYPlxC1VcgEi0OGZKyyfB3ZDxCpUTg6
qsZB+CvNFrV5NGGx2TeytS0ys3j2emgPi7c99nLFox6vIaQYjg3WuNKqxkGDYQg4
RuwRu7+kXCN9lWDK+03DaYruTdajPbirJcIAbP9tsrFIfuqUTFE=
=jkNZ
-----END PGP SIGNATURE-----

--3X/soURl3JHM+qm5--
