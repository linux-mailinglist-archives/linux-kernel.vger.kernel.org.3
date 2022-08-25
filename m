Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA25A090D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiHYGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHYGoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:44:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF1FA0628;
        Wed, 24 Aug 2022 23:44:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bn9so10934591ljb.6;
        Wed, 24 Aug 2022 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fCqPJdGrxDmqHnnybrRmXsBnNNGdb+J4MxtkazPkIw8=;
        b=GIcyMcFJxDyq0yaN3ZbLZDqVYVDTRQ5PbZmc5jfi8X+v+aV5PXQotkuJmhLsa3RbrB
         P7dlG+0wPc5lNj9eNjxkTOBtk8awX6CRASWVy0HURJjl6QO+PCWkfcGX/PKzF/gDitGP
         9QTTC9eyNDZFYbCo8CAE7xKygE9mF2JiGmmMIsSg7S9EL2c7s0Lv7JdqfYfbAWFcPC0+
         aZVPUNJxNogCxptBnkbEOcOK3QuqSrJxxwUrmg3tvSU8fBM/hnLs9Ya3dvvQBIrVAyRp
         6cuzTUz4WKYSKnqsu82dtkx7Vvo4s/6EimOgvMhcnxdhZvqcpkpSxaM3+Ns5mJQVwDmT
         Un2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fCqPJdGrxDmqHnnybrRmXsBnNNGdb+J4MxtkazPkIw8=;
        b=WO0ybQGgU/8zXGSYJbZYwcnLG+YGAEiVn8x0B2wMA5P/TxcH0P6lNur2G+8rfeGr+9
         YAvrKdpkpVglf59wLXbSqoVJlbjHDX3/yB1P3K79VT3eu95nnyn0DnXo6/PB0RxjQR4V
         H9GqnEwW5m+hXBlgO81bSgk6SuoJHbwqkqdGXWiWlkgATelwwQDDa1znmeLdhfqicMyY
         T9Ex3Qv+pOThyl2YkB3gEgcE3sdPYmIB+lxTBMc1LSaOMy407jonGa37aPXyP4X4tmEm
         hxYuERX2rjOx/1DSKyroIkBUcuzidPkUQon0gpjvo/tVmMsILwq+VviNNo8O0iCbYyqe
         Il9A==
X-Gm-Message-State: ACgBeo3RwT4QTP+LWfLV2BfAqtJXDr3dA3W5tQ9QLuzXcW4+kZc5d87J
        ZzuGqpShbuN95d0ZTayAeyk=
X-Google-Smtp-Source: AA6agR5DjMkW3860q87IRXS1RfFsHKZ16C9THLWAEwykJH05MGe41NVV/uXrTGS2NNU/xuANVeTFLw==
X-Received: by 2002:a05:651c:1a1e:b0:25f:e7bd:6a4e with SMTP id by30-20020a05651c1a1e00b0025fe7bd6a4emr715035ljb.362.1661409838828;
        Wed, 24 Aug 2022 23:43:58 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v19-20020a056512349300b00489c6c76385sm319335lfr.268.2022.08.24.23.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 23:43:57 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:48:52 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <YwcbVJswrL1Doi4s@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com>
 <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7Xw/4XWTP378h0nh"
Content-Disposition: inline
In-Reply-To: <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7Xw/4XWTP378h0nh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

Thank you!
I have a few questions regarding the report descriptor, please see
below.

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

[...]

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

Got it.
I've parsed [4] the report descriptor for VRC2, and I guess it does not loo=
ks
that good:

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

The Usage should rather be Joystick than undefined, the other
fields does also looks wrong to me.

The data for each axis (WHEEL and GAS) is 11 bit long (Logical maximum
2047 ?), how does the report descriptor map to the actual data in terms
of offset, order and length?

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

I think at least some advice would be great :-)

The VRC2 would be the most simple of those, it only has 2 axis with
resolution of 11-bit.
If you have time, would you please give some advice what a report descripto=
r would look
like and I could probably come up with something for the others.

>=20
> FYI, I just re-read rcsim_raw_event() and there is stuff that would
> require more than just a report descriptor fixup (the fact that some
> data is sent every other report is not good and will need some manual
> handling though).


Is the fact that more than one button share the same
byte hard to describe in the report?

  value =3D FIELD_GET(XTRG2FMS_ALT1_HI, raw_data[7]);
  value =3D (value << 8) | raw_data[6];

=2E..
  value =3D FIELD_GET(XTRG2FMS_ALT2_HI, raw_data[7]);
  value =3D (value << 8) | raw_data[5];


>=20
> Cheers,
> Benjamin
>=20

Best regards
Marcus Folkesson

> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/hid/hid-uclogic-rdesc.c
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/hid/hid-input.c#n817
[4] https://eleccelerator.com/usbdescreqparser/

--7Xw/4XWTP378h0nh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMHG08ACgkQiIBOb1ld
UjIO5A/+JWXCCZI2+4+Nk+jnYQoqETdMveimgYOIgUBeWONUtcRW5vYhgUNh+huy
G0hre6n6misVW59F94LmWtJ9EMWD45jc1jt3l8r4OjBvirI3M3UMudsnmYlkWXpT
jktg8/B8lV5S8ATYpEZp+NwNR1wX0HI8B59J5S88LGuyF7nfZzp71GnZSPeyPqs4
WeKr8gehyfGpVr4g6wox7sdywWGPTEc2Xyrye0CJ4QlVLHYvCs51ZJCGBIREuFty
znQk9Wom/pkPodQNnQgtEAr9xvWzZkbEa3k0UBzhxxe2vx4JaknIhTEzwafa8mif
Mg1GQ/vvYYivSMS98rsUtE7Kk1dbnykZSsUGrC2i6LbRNW4to8uxQ+v9d/4x8U6Z
1Qgj50cF4DurR56xv06fZXLfiZjUpMoJ3eKYjQK9SvTASIlj4CflSTTJUfr8lClc
kNzkfXrZWsoZiAYQicY7fAtTQYyrSBG8rkHn2OUsisHnYBQcELmpD1u+o5nXplh1
Fox+cisVkNtEt1ymHtXnBNAojaHW5hQ0iXy4V3B2J6F9E/BZ8RHADm2F6sMoSWHy
MpqbXTid/aoqKabOj75A8p5PIPzhbl69AP+YlgNwFrzEhdnltvjJTR9PTePIuChy
NGxzIXbjj6hZ9UzmzOFUxgYxCDVGjn3nC0dh9p5/NGy/G0RwAUA=
=P5uZ
-----END PGP SIGNATURE-----

--7Xw/4XWTP378h0nh--
