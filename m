Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127B9483F06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiADJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbiADJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641287931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3N7CYSoQla8irpwSFnEGY9wG/xnJ4eLv173SytGCxM=;
        b=h/ACt9ABBOIzb8C8camXuLLqzYQZ3POqWPfed4wGvsK/3A8Sb7mKMMBH8VhDy9AketIhsg
        2mrDwEf8DJXwPDo7dECN+/Vsl9/LgZyR0DIMm1TXnDPSrXAfChjrrR+kGlaGNO5hiNy1sQ
        Ss6GJ9yrJKns60zEb1pqu15LzbC9FMk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-gXCKjJA-NyS3igEZV2DCCw-1; Tue, 04 Jan 2022 04:18:50 -0500
X-MC-Unique: gXCKjJA-NyS3igEZV2DCCw-1
Received: by mail-pf1-f198.google.com with SMTP id x128-20020a628686000000b004ba53b6ec72so18201757pfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 01:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c3N7CYSoQla8irpwSFnEGY9wG/xnJ4eLv173SytGCxM=;
        b=XEJicvf71GXrkhQf2lSYe+gqymIng/JbYLLAcOpYMaFAp5FCbkmHfzU9FJQYiXyM4k
         Z92r56lTsNA+YMWoKPNIEiwlcD3S2pNgx0lIv5ns3Kj+ZRUbFEOh4X9g/CeIoXUhYs7E
         0Q5u7LxaujjZdH8oM9fO3V8XPrpPnimVOoV1pHBSBXpNv/IJoeCc+LTb1ppiKHhZl+0s
         r4gEn48+qhP7Zd6q3NJnslCcC8MCXh7rLOHBYbQM54V7W2UTG0Niup/VZzbhKyOkEAzR
         Ewk7uODf+i7za8Ud/6Y1q218ojT8fiMN3bspm5R4s5rGmU2srvWQnAjqFc9Us9qIVBJK
         BLKA==
X-Gm-Message-State: AOAM533xgkHCHuytWt2l33GZduhtMh2k9e9gZYIhhh1gb2ztZaM5Rujq
        Vj3OZc/HVbj1nJb3YcHsNY0fHNKISW2sgWSWmKtZ7gw/WaOD5tQzpwseS9qRKpf9BORB9sEo/jj
        IUJBS+6wwbwRyVag1eo0x6tQpwpuDPiKuQ/kUlCPk
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id f12-20020a170902860c00b00149101725f0mr48176813plo.116.1641287929068;
        Tue, 04 Jan 2022 01:18:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4ljkblRRX2ff41WUG3I/br32Iiy/+bj1gLf62jNXjzxJzQ3eN93G9VLuWk4uckhzc+g4O9lOSJIMlO8iK5/o=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr48176793plo.116.1641287928588; Tue, 04
 Jan 2022 01:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20211202110807.6783-1-jose.exposito89@gmail.com>
 <20211202110807.6783-3-jose.exposito89@gmail.com> <YdPoEI5+fdr0MS8S@google.com>
In-Reply-To: <YdPoEI5+fdr0MS8S@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Jan 2022 10:18:37 +0100
Message-ID: <CAO-hwJ+D7+0zpaN6JAYCb==s5vZmp9Pzi8Tg4a19Us4S9RQhxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: set INPUT_PROP_BUTTONPAD using input_set_property()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Colenbrander, Roelof" <roderick.colenbrander@sony.com>,
        pali@kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Nick Dyer <nick@shmanahar.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 7:24 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jos=C3=A9,
>
> On Thu, Dec 02, 2021 at 12:08:07PM +0100, Jos=C3=A9 Exp=C3=B3sito wrote:
>
> A short description would be appreciated.
>
> Jiri, Benjamin, do you mind if I take this through my tree or you would
> prefer having this split?

No objections from my side:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > ---
> >  drivers/hid/hid-alps.c                   | 2 +-
> >  drivers/hid/hid-asus.c                   | 3 +--
> >  drivers/hid/hid-elan.c                   | 3 +--
> >  drivers/hid/hid-logitech-hidpp.c         | 2 +-
> >  drivers/hid/hid-magicmouse.c             | 8 ++------
> >  drivers/hid/hid-multitouch.c             | 2 +-
> >  drivers/hid/hid-playstation.c            | 3 +--
> >  drivers/hid/hid-sony.c                   | 4 +---
> >  drivers/input/keyboard/applespi.c        | 2 +-
> >  drivers/input/mouse/alps.c               | 3 +--
> >  drivers/input/mouse/bcm5974.c            | 2 +-
> >  drivers/input/mouse/cyapa.c              | 2 +-
> >  drivers/input/mouse/elan_i2c_core.c      | 2 +-
> >  drivers/input/mouse/elantech.c           | 6 ++----
> >  drivers/input/mouse/focaltech.c          | 4 +---
> >  drivers/input/mouse/synaptics.c          | 2 +-
> >  drivers/input/rmi4/rmi_f30.c             | 2 +-
> >  drivers/input/rmi4/rmi_f3a.c             | 2 +-
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
> >  19 files changed, 21 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> > index 2b986d0dbde4..4cbfefec949c 100644
> > --- a/drivers/hid/hid-alps.c
> > +++ b/drivers/hid/hid-alps.c
> > @@ -722,7 +722,7 @@ static int alps_input_configured(struct hid_device =
*hdev, struct hid_input *hi)
> >       __set_bit(EV_KEY, input->evbit);
> >
> >       if (data->btn_cnt =3D=3D 1)
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       for (i =3D 0; i < data->btn_cnt; i++)
> >               __set_bit(BTN_LEFT + i, input->keybit);
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index f3ecddc519ee..99f37b636ec3 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> > @@ -798,8 +798,7 @@ static int asus_input_configured(struct hid_device =
*hdev, struct hid_input *hi)
> >                                             MAX_PRESSURE, 0, 0);
> >               }
> >
> > -             __set_bit(BTN_LEFT, input->keybit);
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >               ret =3D input_mt_init_slots(input, drvdata->tp->max_conta=
cts,
> >                                         INPUT_MT_POINTER);
> > diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
> > index 021049805bb7..b33842b9a92f 100644
> > --- a/drivers/hid/hid-elan.c
> > +++ b/drivers/hid/hid-elan.c
> > @@ -182,8 +182,7 @@ static int elan_input_configured(struct hid_device =
*hdev, struct hid_input *hi)
> >       input_set_abs_params(input, ABS_MT_PRESSURE, 0, ELAN_MAX_PRESSURE=
,
> >                            0, 0);
> >
> > -     __set_bit(BTN_LEFT, input->keybit);
> > -     __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +     input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       ret =3D input_mt_init_slots(input, ELAN_MAX_FINGERS, INPUT_MT_POI=
NTER);
> >       if (ret) {
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index 81de88ab2ecc..d7b8e0ed0b47 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -2679,7 +2679,7 @@ static void wtp_populate_input(struct hidpp_devic=
e *hidpp,
> >       if (hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS)
> >               input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
> >       else
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> > +             input_set_property(input_dev, INPUT_PROP_BUTTONPAD);
> >
> >       input_mt_init_slots(input_dev, wd->maxcontacts, INPUT_MT_POINTER =
|
> >               INPUT_MT_DROP_UNUSED);
> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.=
c
> > index d7687ce70614..2b28c0081362 100644
> > --- a/drivers/hid/hid-magicmouse.c
> > +++ b/drivers/hid/hid-magicmouse.c
> > @@ -545,11 +545,9 @@ static int magicmouse_setup_input(struct input_dev=
 *input, struct hid_device *hd
> >
> >               __clear_bit(EV_MSC, input->evbit);
> >               __clear_bit(BTN_0, input->keybit);
> > -             __clear_bit(BTN_RIGHT, input->keybit);
> > -             __clear_bit(BTN_MIDDLE, input->keybit);
> >               __set_bit(BTN_MOUSE, input->keybit);
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> >               __set_bit(BTN_TOOL_FINGER, input->keybit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >               mt_flags =3D INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
> >                               INPUT_MT_TRACK;
> > @@ -559,8 +557,6 @@ static int magicmouse_setup_input(struct input_dev =
*input, struct hid_device *hd
> >                * button (BTN_LEFT =3D=3D BTN_MOUSE). Make sure we don't
> >                * advertise buttons that don't exist...
> >                */
> > -             __clear_bit(BTN_RIGHT, input->keybit);
> > -             __clear_bit(BTN_MIDDLE, input->keybit);
> >               __set_bit(BTN_MOUSE, input->keybit);
> >               __set_bit(BTN_TOOL_FINGER, input->keybit);
> >               __set_bit(BTN_TOOL_DOUBLETAP, input->keybit);
> > @@ -569,7 +565,7 @@ static int magicmouse_setup_input(struct input_dev =
*input, struct hid_device *hd
> >               __set_bit(BTN_TOOL_QUINTTAP, input->keybit);
> >               __set_bit(BTN_TOUCH, input->keybit);
> >               __set_bit(INPUT_PROP_POINTER, input->propbit);
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >       }
> >
> >
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
> > index 082376a6cb3d..1bffb1787fd6 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -1287,7 +1287,7 @@ static int mt_touch_input_configured(struct hid_d=
evice *hdev,
> >               td->is_buttonpad =3D true;
> >
> >       if (td->is_buttonpad)
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       app->pending_palm_slots =3D devm_kcalloc(&hi->input->dev,
> >                                              BITS_TO_LONGS(td->maxconta=
cts),
> > diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstatio=
n.c
> > index b1b5721b5d8f..50815257ff86 100644
> > --- a/drivers/hid/hid-playstation.c
> > +++ b/drivers/hid/hid-playstation.c
> > @@ -651,8 +651,7 @@ static struct input_dev *ps_touchpad_create(struct =
hid_device *hdev, int width,
> >               return ERR_CAST(touchpad);
> >
> >       /* Map button underneath touchpad to BTN_LEFT. */
> > -     input_set_capability(touchpad, EV_KEY, BTN_LEFT);
> > -     __set_bit(INPUT_PROP_BUTTONPAD, touchpad->propbit);
> > +     input_set_property(touchpad, INPUT_PROP_BUTTONPAD);
> >
> >       input_set_abs_params(touchpad, ABS_MT_POSITION_X, 0, width - 1, 0=
, 0);
> >       input_set_abs_params(touchpad, ABS_MT_POSITION_Y, 0, height - 1, =
0, 0);
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index d1b107d547f5..302fd8fea243 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -1519,9 +1519,7 @@ static int sony_register_touchpad(struct sony_sc =
*sc, int touch_count,
> >       sc->touchpad->name =3D name;
> >
> >       /* We map the button underneath the touchpad to BTN_LEFT. */
> > -     __set_bit(EV_KEY, sc->touchpad->evbit);
> > -     __set_bit(BTN_LEFT, sc->touchpad->keybit);
> > -     __set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
> > +     input_set_property(sc->touchpad, INPUT_PROP_BUTTONPAD);
> >
> >       input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0)=
;
> >       input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0)=
;
> > diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard=
/applespi.c
> > index eda1b23002b5..9fc7608a8bbc 100644
> > --- a/drivers/input/keyboard/applespi.c
> > +++ b/drivers/input/keyboard/applespi.c
> > @@ -1289,7 +1289,7 @@ applespi_register_touchpad_device(struct applespi=
_data *applespi,
> >       input_set_capability(touchpad_input_dev, EV_REL, REL_Y);
> >
> >       __set_bit(INPUT_PROP_POINTER, touchpad_input_dev->propbit);
> > -     __set_bit(INPUT_PROP_BUTTONPAD, touchpad_input_dev->propbit);
> > +     input_set_property(touchpad_input_dev, INPUT_PROP_BUTTONPAD);
> >
> >       /* finger touch area */
> >       input_set_abs_params(touchpad_input_dev, ABS_MT_TOUCH_MAJOR,
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > index 4a6b33bbe7ea..d04c9553f9f2 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -3082,8 +3082,7 @@ int alps_init(struct psmouse *psmouse)
> >               dev1->keybit[BIT_WORD(BTN_2)] |=3D BIT_MASK(BTN_2);
> >               dev1->keybit[BIT_WORD(BTN_3)] |=3D BIT_MASK(BTN_3);
> >       } else if (priv->flags & ALPS_BUTTONPAD) {
> > -             set_bit(INPUT_PROP_BUTTONPAD, dev1->propbit);
> > -             clear_bit(BTN_RIGHT, dev1->keybit);
> > +             input_set_property(dev1, INPUT_PROP_BUTTONPAD);
> >       } else {
> >               dev1->keybit[BIT_WORD(BTN_MIDDLE)] |=3D BIT_MASK(BTN_MIDD=
LE);
> >       }
> > diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm597=
4.c
> > index 59a14505b9cd..986fed0ef978 100644
> > --- a/drivers/input/mouse/bcm5974.c
> > +++ b/drivers/input/mouse/bcm5974.c
> > @@ -538,7 +538,7 @@ static void setup_events_to_report(struct input_dev=
 *input_dev,
> >       __set_bit(BTN_LEFT, input_dev->keybit);
> >
> >       if (cfg->caps & HAS_INTEGRATED_BUTTON)
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> > +             input_set_property(input_dev, INPUT_PROP_BUTTONPAD);
> >
> >       input_mt_init_slots(input_dev, MAX_FINGERS,
> >               INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK)=
;
> > diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> > index 77cc653edca2..364de350128b 100644
> > --- a/drivers/input/mouse/cyapa.c
> > +++ b/drivers/input/mouse/cyapa.c
> > @@ -501,7 +501,7 @@ static int cyapa_create_input_dev(struct cyapa *cya=
pa)
> >               __set_bit(BTN_RIGHT, input->keybit);
> >
> >       if (cyapa->btn_capability =3D=3D CAPABILITY_LEFT_BTN_MASK)
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       /* Handle pointer emulation and unused slots in core */
> >       error =3D input_mt_init_slots(input, CYAPA_MAX_MT_SLOTS,
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
> > index 47af62c12267..b6cd6b282424 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -1177,7 +1177,7 @@ static int elan_setup_input_device(struct elan_tp=
_data *data)
> >       __set_bit(EV_ABS, input->evbit);
> >       __set_bit(INPUT_PROP_POINTER, input->propbit);
> >       if (data->clickpad) {
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >       } else {
> >               __set_bit(BTN_RIGHT, input->keybit);
> >               if (data->middle_button)
> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
> > index 956d9cd34796..38386a89831e 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -1122,10 +1122,8 @@ static void elantech_set_buttonpad_prop(struct p=
smouse *psmouse)
> >       struct input_dev *dev =3D psmouse->dev;
> >       struct elantech_data *etd =3D psmouse->private;
> >
> > -     if (elantech_is_buttonpad(&etd->info)) {
> > -             __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> > -             __clear_bit(BTN_RIGHT, dev->keybit);
> > -     }
> > +     if (elantech_is_buttonpad(&etd->info))
> > +             input_set_property(dev, INPUT_PROP_BUTTONPAD);
> >  }
> >
> >  /*
> > diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/foca=
ltech.c
> > index 6fd5fff0cbff..292b931483c0 100644
> > --- a/drivers/input/mouse/focaltech.c
> > +++ b/drivers/input/mouse/focaltech.c
> > @@ -330,8 +330,6 @@ static void focaltech_set_input_params(struct psmou=
se *psmouse)
> >       __clear_bit(EV_REL, dev->evbit);
> >       __clear_bit(REL_X, dev->relbit);
> >       __clear_bit(REL_Y, dev->relbit);
> > -     __clear_bit(BTN_RIGHT, dev->keybit);
> > -     __clear_bit(BTN_MIDDLE, dev->keybit);
> >
> >       /*
> >        * Now set up our capabilities.
> > @@ -341,7 +339,7 @@ static void focaltech_set_input_params(struct psmou=
se *psmouse)
> >       input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0=
);
> >       input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
> >       input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
> > -     __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> > +     input_set_property(dev, INPUT_PROP_BUTTONPAD);
> >  }
> >
> >  static int focaltech_read_register(struct ps2dev *ps2dev, int reg,
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/syna=
ptics.c
> > index ffad142801b3..1110c85dd370 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -1349,7 +1349,7 @@ static int set_input_params(struct psmouse *psmou=
se,
> >                       input_set_capability(dev, EV_KEY, BTN_0 + i);
> >
> >       if (SYN_CAP_CLICKPAD(info->ext_cap_0c)) {
> > -             __set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
> > +             input_set_property(dev, INPUT_PROP_BUTTONPAD);
> >               if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids)=
 &&
> >                   !SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10))
> >                       __set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
> > diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.=
c
> > index 35045f161dc2..92ca5a1da1de 100644
> > --- a/drivers/input/rmi4/rmi_f30.c
> > +++ b/drivers/input/rmi4/rmi_f30.c
> > @@ -265,7 +265,7 @@ static int rmi_f30_map_gpios(struct rmi_function *f=
n,
> >        * mapped buttons.
> >        */
> >       if (pdata->gpio_data.buttonpad || (button - BTN_LEFT =3D=3D 1))
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/input/rmi4/rmi_f3a.c b/drivers/input/rmi4/rmi_f3a.=
c
> > index 0e8baed84dbb..4017deff191f 100644
> > --- a/drivers/input/rmi4/rmi_f3a.c
> > +++ b/drivers/input/rmi4/rmi_f3a.c
> > @@ -159,7 +159,7 @@ static int rmi_f3a_map_gpios(struct rmi_function *f=
n, struct f3a_data *f3a,
> >       input->keycodemax =3D f3a->gpio_count;
> >
> >       if (pdata->gpio_data.buttonpad || (button - BTN_LEFT =3D=3D 1))
> > -             __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> > +             input_set_property(input, INPUT_PROP_BUTTONPAD);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index 05de92c0293b..fd9b6774ee9e 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -2028,7 +2028,7 @@ static void mxt_set_up_as_touchpad(struct input_d=
ev *input_dev,
> >
> >       input_dev->name =3D "Atmel maXTouch Touchpad";
> >
> > -     __set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
> > +     input_set_property(input_dev, INPUT_PROP_BUTTONPAD);
> >
> >       input_abs_set_res(input_dev, ABS_X, MXT_PIXELS_PER_MM);
> >       input_abs_set_res(input_dev, ABS_Y, MXT_PIXELS_PER_MM);
> > --
> > 2.25.1
> >
>
> --
> Dmitry
>

