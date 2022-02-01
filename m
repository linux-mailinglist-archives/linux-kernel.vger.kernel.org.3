Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098924A5A42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiBAKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBAKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:42:14 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC5C061714;
        Tue,  1 Feb 2022 02:42:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i34so12574441lfv.2;
        Tue, 01 Feb 2022 02:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=NfgyCFDAeK3WhiTxa0pFdQjhu2x7hx0LuMmE0ZH5CP8=;
        b=cf9B6QwBtjcxGtBI7AtuY4I7GEhh0IJAHhBv7V0OQfk96rX4WAS71GdQl0zY8m58St
         +goLrnFY9rd8zWo4ke8oLJQMKuVxNY/Sejh90ToP3xL7wkltc/IoKAk5StKbr8beS2uC
         nb9sesuHsSWPmaymVtV+Ewa+rkoRVzZRbiDjAE1Y3XJC8IzjAl9o175kWWZrk/QN8oFj
         7EgY+CnT/6cOxXqhXs2mhSue1xo3FEtYFYWwes6FyRDPWLKCO4gqGRUPi4nCG6qeOUdp
         IOVdkDuHzKgKmVV/7EmlD3u84l1dSAneOvOJbj86Z1GuPyfTruahHAlpUjUgjufHlE7w
         p5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=NfgyCFDAeK3WhiTxa0pFdQjhu2x7hx0LuMmE0ZH5CP8=;
        b=TGJV7+4oAfcpQ7AjyvB0Sa4ymBmk9jWaHQl5QzukoNltHdiKabdcQQisdqMGfwNK9c
         ibGNCA14NRTbn0miiwNVNVWCjVJR4r9WpqAogRbQLsDF26eqdje03oC2zVBFP5xv3elK
         DwrDiP4Lt8KvsAjhAHeyr4jC9Qt7irTx2sy6dQw3667yr6bDa9RTQKPghqiJ1nFyxf0L
         03efEPf1AFv9KxDwxiGP6zvBhntOOOmt8iwlyYwkintR/lSc48zECw7YMXCIA++XNY5Q
         egQva7P/gTKkHaYNECvYyQDWW/E3VjEtPEMZiZgeSdynIjEibjHviN2uMy2kVm/7W3j0
         JzKw==
X-Gm-Message-State: AOAM532K787y6ty+nNmfTVXWjWwChkcZZSLYFTMJv0bVi4SsYZffvm0Z
        TcRPYIAdrhZjvGkBLf+3G6w=
X-Google-Smtp-Source: ABdhPJwwKjPurKGXxcuYSvTBMCWOu2f+u6c+35tZD+1zP/+Hz905wxI2CDdpZtM0O2PZBJrjv0sjig==
X-Received: by 2002:ac2:5e7b:: with SMTP id a27mr18758785lfr.417.1643712132165;
        Tue, 01 Feb 2022 02:42:12 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id o7sm3291960lfu.37.2022.02.01.02.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:42:11 -0800 (PST)
Date:   Tue, 1 Feb 2022 12:42:08 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <20220201124208.39c31e59@eldfell>
In-Reply-To: <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
        <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
        <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
        <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
        <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
        <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
        <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sxz7U9Ufs9HWN7B5No+lEp2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sxz7U9Ufs9HWN7B5No+lEp2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Feb 2022 10:49:03 +0100
Javier Martinez Canillas <javierm@redhat.com> wrote:

> On 2/1/22 09:38, Daniel Vetter wrote:
> > On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote: =
=20
> >>
> >> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> >> =20
> >>> What's the story with the Rn formats?
> >>>
> >>> The comments say "n bpp Red", while this is a monochrome (even
> >>> inverted) display? =20
> >>
> >> I don't think the color matters that much. "Red" was picked just becau=
se it was
> >> an arbitrary color, to make the difference with e.g. C8. Or am I mista=
ken? =20
> >=20
> > The red comes from gl, where with shaders it really doesn't matter
> > what meaning you attach to channels, but really just how many you
> > have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
> > 4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
> > interop in general, hence why these exist.
> >=20
> > We should probably make a comment that this really isn't a red channel
> > when used for display it's a greyscale/intensity format. Aside from
> > that documentation gap I think reusing Rx formats for
> > greyscale/intensity for display makes perfect sense.
> > -Daniel =20
>=20
> To sump up the conversation in the #dri-devel channel, these drivers
> should support the following formats:
>=20
> 1) Dx (Daniel suggested that for darkness, but inverted mono)

Did you consider format C1 instead?

To my understanding, the C formats are paletted, which would also fit
very nicely semantically. You have an enumerated list of pixel values
and each of them produces some arbitrary color on screen. This would
fit e.g. blue/white LCD panels nicely.

The little problem there is the palette.

C8 format is traditionally translated to RGB triplets through GAMMA LUT.
Therefore the display itself is still three-channel, it's just the
framebuffer format that is single-channel. But now, we are dealing
with truly paletted displays. Furthermore, the palette is fixed,
ingrained in the panel hardware.

So we would probably need a new KMS property for the fixed palette of
the panel. What would it be called? Would it be a connector property?

The property would be a read-only blob, an array that maps Cx values to
"colors". How do we represent "colors"? How do we accommodate C1, C2,
C4 and C8 with the same blob?

Since the blob is a mapping from color index to "color", and the array
in the blob has N entries, we could simply say that Cx integer value is
the color index. If the Cx you use does not go up to N, then you miss
some colors. If the Cx you use can go higher than N, then Cx values >=3D
N will clamp to N-1, for example. Of course, if your panel palette has
only 4 entries, you can expose C1 and C2 and have no reason to expose
C4 or C8, avoiding the Cx >=3D N issue.

How do we define the array contents then, the "colors"... plain old RGB
triplets do not mean much[1], but that would be better than nothing. I
also suppose that people would not be keen on seeing something like CIE
1931 XYZ or Lab values, even though those would probably have the most
useful definition. Coming up with those values properly would require a
colorimeter. As a compromise, maybe we could use an RGB triplet, and
assume sRGB SDR color space and transfer function, just like we do with
all displays whether they are that or not. If someone needs to know
better, then they can profile the display. sRGB triplets would likely
give enough intuition to what color the indices result in, that it
could be used in automated color conversions or quantizations from
larger color spaces like sRGB with some rough degree of color
similarity.

It is a lot of hassle, but it would have a clear benefit: userspace
would know very well how the display behaves (what colors it shows,
roughly), and you could use Cx formats to drive a panel in its "native"
format.

Possible problems are around interactions with the old GAMMA property,
which is traditionally used for the C8 palette. But if you have a
fixed-palette panel, then maybe you wouldn't expose GAMMA property on
the CRTC at all?

I have no idea how this would map to fbdev API though.


[1] https://gitlab.freedesktop.org/pq/color-and-hdr/-/blob/main/doc/pixels_=
color.md

Thanks,
pq


> 2) Rx (single-channel for grayscale)
> 3) RxGxBxAx (4-channel fake 32-bpp truecolor)
>=20
> The format preference will be in that order, so if user-space is able
> to use Dx then there won't be a need for any conversion and just the
> native format will be used.
>=20
> If using Rx then only a Rx -> Dx conversion will happen and the last
> format will require the less performant RxGxBxAx -> Rx -> Dx path.
>=20
> But we still need RxGxBxAx as a fallback for compatibility with the
> existing user-space, so all this could be done as a follow-up as an
> optimization and shouldn't block monochromatic panel drivers IMO.
>=20
> Best regards,


--Sig_/Sxz7U9Ufs9HWN7B5No+lEp2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmH5DoAACgkQI1/ltBGq
qqdQHRAAsEi+6XySVlxhsY0CtJOqClHhuaE+2ObdFY28PqLOtmpM6sHJgP/3kn0b
kROfNch8c/Bxv28Jg3EMdcBav3oLC/hNotHK9OiUxm7C2NFMNCyulX/jv/0VerNY
pC5r9V9AeENihHmY1mzxn+D9MbCyL7nkWc1zcnZ0ga/4hmUr7GQqdC08FmnO8vXz
aeRBY2TG5sNePTxby7cM3yCFtVAqaIU8zx8uMPC0A+KFmVTLh2gaE0EjX6I0kfRQ
Qj09BIMMwNMYLfn5J7wLs+qbUSNBEx2Ro5YBYky/cXfjQNqL217zjmXkL6bHS7hF
mUGvwr88PVcsGL9g8TEuc6sXgdh3ut59gdXNAswhrBqbPPqqwgSkxn7U5Ep02Crm
HppqDcoD5PXcASJ/5X9YXlq9IFI9tzub/aW6DEPImx+5scJnxBk8VNVOa69tirKF
XkuUFvD7oDxenr9hV/ZmyVHy3pjO/Bi0+zatoNTBqPCzyheVGKAqPHy4z0cji5aD
mz8c6n7T5DOTFLHS2Yk8jZn2PD0oxNDVtTTkWgk1ocptwWRtCYKtfpbf62wFtFcn
PO+/UiHWwA+6OUounMjQfQqWRpDIH/WGvEWmh1r+j8e+ApjSRGeM202VGnBvffyW
4yDqnjMBJSzS2QxRT0yp9Fg4qAIk4tpz6K0MgATgFrkgghBkEs4=
=PuLM
-----END PGP SIGNATURE-----

--Sig_/Sxz7U9Ufs9HWN7B5No+lEp2--
