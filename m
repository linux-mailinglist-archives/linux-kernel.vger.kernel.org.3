Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3053975E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347699AbiEaTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347510AbiEaTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:50:45 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EC59319;
        Tue, 31 May 2022 12:50:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id b81so6701816vkf.1;
        Tue, 31 May 2022 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q6/Wv8wsJhsvDWyg0pI0aMNyw+1t0p93Rxz6ZrPsGzI=;
        b=FiaAbAWUQ4ihhl3UsOn+jIQ30gSwYU0l3jDsffBxoVKw5N/iXsr8UL7wNfLKex2EEo
         OvK27i2nqnMfmSbyXegR/oq6rzO6rYn0/R5NGXoUsAh7QQ4udi+UYEjTe6scrtsEhHAJ
         m4yAf+TkKjNE0SkgeEgkOJ3xCziuht7KbNReVgq3pukEpQSbGbUVYx0ukFTv/aJviJAL
         6bCkHDc+lBM3j9ai0xoWOF9WIvIsMXxJLZ3Z4Ro86W5QKU3ITrDN35HA95kMeQppyeqO
         +zx7DzNLrpeL+1I+qGUPGkumc98mgUmcJWXzZAF/BWSpXppfoVTfgNcIZrZXm7Q6gYYy
         ZDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q6/Wv8wsJhsvDWyg0pI0aMNyw+1t0p93Rxz6ZrPsGzI=;
        b=nJtTG8G0PTwSL7Jv2au1ekXV07O3t5DTrz64HzT3qyIlbTILSKHSqkoEGrANlEoZev
         7rGFOgookuJc0IGts6wnTjO5SXShNXPvRw24aIb+nOe7sV+FDGS246wu+rk3EVwlzxd4
         nf3Md1dp18bg5r1L+n/iFEFGtB00QT1qlWCxjRCXKJCNJ71LMw9DY6duvhsJsilnMruM
         +TjZ2JFfk4/NIupNPniJ9OOXLtQpnG++UZXeDZX8wR7jmCHnpTKndK1JGMuCKwZf2EKe
         W1Uo8Owhf43YyU89uYoNPZsg5NDQz+SiAV+IQ/h8B4lEOZNrg7sTQ1TZ+UbpVGK7CzrZ
         rPuw==
X-Gm-Message-State: AOAM531MZFVYDI4pe/odfqddwcXyIfDC1MsfUJuVhG3PV56ZLCE55s4Q
        S6wbneSyJ+vzkme2q+2RYrQq3Lh+PFN7b/tRaNTkxZPQCRmVnA==
X-Google-Smtp-Source: ABdhPJzJoGmFYuDd0d0FBA7fMz2bQMAu5mbakktE/OtPicmpmyxq/80UEcIIwtRtOnaRBAXuAt0NjFhl3g7N4T9zqTE=
X-Received: by 2002:a05:6122:14e:b0:358:4f5b:f65c with SMTP id
 r14-20020a056122014e00b003584f5bf65cmr12072347vko.3.1654026641228; Tue, 31
 May 2022 12:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220529180230.17e9a0f9@ultrarare.space> <20220529182036.10226-1-jose.exposito89@gmail.com>
 <20220530083752.1973a905@ultrarare.space> <20220530061812.GA10391@elementary>
 <20220531221102.7bd7da7d@ultrarare.space> <20220531223330.3d63e2fe@ultrarare.space>
 <20220531172053.GA10651@elementary>
In-Reply-To: <20220531172053.GA10651@elementary>
From:   Bryan Cain <bryancain3@gmail.com>
Date:   Tue, 31 May 2022 13:50:30 -0600
Message-ID: <CAPnXWxG8gbe1arQK9kBtwM1Xcta+wreTN742kgtBBr1v0ewKug@mail.gmail.com>
Subject: Re: [PATCH v2] HID: apple: Workaround for non-Apple keyboards
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Hilton Chain <hako@ultrarare.space>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:20 AM Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> wrote:
>
> Hi Hilton,
>
> Thanks for sending v2 of this patch.
> Please find a couple of minor comments inline:
>
> On Tue, May 31, 2022 at 10:33:30PM +0800, Hilton Chain wrote:
> > There's a bunch of non-Apple keyboard misuses Apple's vendor and produc=
t
> > id, causing hid_apple to be served for them. However they can't handle =
the
> > default fnmode.
> >
> > This commit adds an array of non-Apple keyboards' device names, togethe=
r
> > with a function apple_is_non_apple_keyboard() to identify and create
> > exception for them.
> >
> > Signed-off-by: Hilton Chain <hako@ultrarare.space>
> > ---
> >  drivers/hid/hid-apple.c | 40 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> > index 42a568902f49..4429b25ae3d8 100644
> > --- a/drivers/hid/hid-apple.c
> > +++ b/drivers/hid/hid-apple.c
> > @@ -36,7 +36,7 @@
> >  #define APPLE_NUMLOCK_EMULATION      BIT(8)
> >  #define APPLE_RDESC_BATTERY  BIT(9)
> >  #define APPLE_BACKLIGHT_CTL  BIT(10)
> > -#define APPLE_IS_KEYCHRON    BIT(11)
> > +#define APPLE_IS_NON_APPLE   BIT(11)
> >
> >  #define APPLE_FLAG_FKEY              0x01
> >
> > @@ -65,6 +65,10 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and =
left Control keys. "
> >               "(For people who want to keep PC keyboard muscle memory. =
"
> >               "[0] =3D as-is, Mac layout, 1 =3D swapped, PC layout)");
> >
> > +struct apple_non_apple_keyboard {
> > +     char *name;
> > +};
> > +
> >  struct apple_sc_backlight {
> >       struct led_classdev cdev;
> >       struct hid_device *hdev;
> > @@ -313,6 +317,29 @@ static const struct apple_key_translation swapped_=
fn_leftctrl_keys[] =3D {
> >       { }
> >  };
> >
> > +static const struct apple_non_apple_keyboard non_apple_keyboards[] =3D=
 {
> > +     { "SONiX USB DEVICE" },
> > +     { "Keychron" },
> > +     { }
>
> Could the "non_apple && strlen(non_apple)" check be avoided by removing
> this empty item?
>
> > +};
> > +
> > +static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
> > +{
> > +     unsigned long i;
> > +     unsigned long non_apple_total =3D sizeof(non_apple_keyboards) /
> > +                                     sizeof(struct apple_non_apple_key=
board);
>
> Here you coud take advantage of the "ARRAY_SIZE" macro:
>
> https://kernelnewbies.org/MagicMacros
>
> It'll also allow you to use an int. Something similar to:
>
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(non_apple_keyboards); i++) {
>                 [...]
>
> > +
> > +     for (i =3D 0; i < non_apple_total; i++) {
> > +             char *non_apple =3D non_apple_keyboards[i].name;
> > +
> > +             if (non_apple && strlen(non_apple) &&
>
> This is the check I meant in my first comment ^
>
> > +                             strncmp(hdev->name, non_apple, strlen(non=
_apple)) =3D=3D 0)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static inline void apple_setup_key_translation(struct input_dev *input=
,
> >               const struct apple_key_translation *table)
> >  {
> > @@ -363,7 +390,7 @@ static int hidinput_apple_event(struct hid_device *=
hid, struct input_dev *input,
> >       }
> >
> >       if (fnmode =3D=3D 3) {
> > -             real_fnmode =3D (asc->quirks & APPLE_IS_KEYCHRON) ? 2 : 1=
;
> > +             real_fnmode =3D (asc->quirks & APPLE_IS_NON_APPLE) ? 2 : =
1;
> >       } else {
> >               real_fnmode =3D fnmode;
> >       }
> > @@ -667,11 +694,12 @@ static int apple_input_configured(struct hid_devi=
ce *hdev,
> >       if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
> >               hid_info(hdev, "Fn key not found (Apple Wireless Keyboard=
 clone?), disabling Fn key handling\n");
> >               asc->quirks &=3D ~APPLE_HAS_FN;
> > -     }
> >
> > -     if (strncmp(hdev->name, "Keychron", 8) =3D=3D 0) {
> > -             hid_info(hdev, "Keychron keyboard detected; function keys=
 will default to fnmode=3D2 behavior\n");
> > -             asc->quirks |=3D APPLE_IS_KEYCHRON;
> > +             if (apple_is_non_apple_keyboard(hdev)) {
> > +                     hid_info(hdev,
> > +                             "Non-apple keyboard detected; function ke=
ys will default to fnmode=3D2 behavior\n");
>
> Checkpatch nitpick:
>
>         CHECK: Alignment should match open parenthesis
>         FILE: drivers/hid/hid-apple.c:700:
>         hid_info(hdev,
>                 "Non-apple keyboard detected; function keys will default =
to fnmode=3D2 behavior\n");
>
> It suggest to add  an extra space before "Non-apple ...".
>
> In case you don't know the tool, it helps to find style errors, I
> usually run it like:
>
> $ ./scripts/checkpatch.pl --strict --codespell --git HEAD-1
>
>
> > +                     asc->quirks |=3D APPLE_IS_NON_APPLE;
> > +             }
>
> This slightly changes the behaviour from the previous patch.
> Previously, the APPLE_IS_NON_APPLE quirk was set even if APPLE_HAS_FN
> was not present. Now the condition is nested.
>
> I'm not saying it is wrong (I don't have the required hardware to test
> it), I'm just pointing it out in case it was an accidental change.
> Bryan, should be able to confirm if it works with his keyboard.

I haven't tested it, but I can tell from reading the patch that it will bre=
ak
compatibility with Keychron keyboards like mine, precisely because of the
nesting.

The biggest reason that my Keychron patch was needed at all was that Keychr=
on
devices advertise the Fn key, and thus don't hit the first clone check sinc=
e
asc->fn_found is actually true for them. So nesting the check for the Keych=
ron
manufacturer/product name inside of that check won't work.

To tell the truth, I'm still a bit confused about the precise behavior of t=
he
Sonix firmware that this patch is made to work around. If it's not advertis=
ing
an Apple-style Fn key, why isn't the existing behavior of disabling Fn-key
handling enough to make it work? The fnmode parameter is ignored entirely
when APPLE_HAS_FN isn't set, so it's hard to imagine that the change to fnm=
ode
behavior would even do anything in that case.

Regards,
Bryan

>
> >       }
> >
> >       return 0;
> >
> > base-commit: 8ab2afa23bd197df47819a87f0265c0ac95c5b6a
> > --
> > 2.36.1
> >
>
>
> Best wishes,
> Jos=C3=A9 Exp=C3=B3sito
