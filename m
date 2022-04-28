Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41465135DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347831AbiD1OA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbiD1OA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:00:56 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F53DDD3;
        Thu, 28 Apr 2022 06:57:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 642DFDF8DB;
        Thu, 28 Apr 2022 06:57:39 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ig7oScWZPIsr; Thu, 28 Apr 2022 06:57:38 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:57:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1651154258; bh=vLbHlYOt6LoVdFmtMXhjYEpdyn/I1inbFkDo5q7Xc2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nz8/Fafk2Vr5aiEgJyewn2lnV+gj0UhPCZcRjHm8Ga08pP1HPo0C5a4D+B1Y4T7U4
         8ex9tXNujPUROXlCvv+P9shIRqhNsxZ3shnE0SQtMXvuPTZElqrm/ne+29SKalNmBP
         Yuk5J4MOeOy8feiBbKKVsRi/25Mj0ftp5H28iuiRQN83PNXbg5lnJOvFdVnoCIAM6S
         AEGni3jVS9boTKi6AmBHBYyAkYI0q2CHbKIFlpAM00++HnH3zpH0KsqQJqYkvDAHij
         /pQjVfgLhwFE1IYrkCn3uvPgR6IDzl3cWZHw5leET3fv3TlvGJeLe7l4dthxY5rXBO
         6CNgQPfVkpwyQ==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv2 1/2] doc/media api: Try to make enum usage clearer
Message-ID: <20220428155723.456b7ff0.dorota.czaplejewicz@puri.sm>
In-Reply-To: <20220428130448.bfht2nf23n6lidsk@uno.localdomain>
References: <20220428105211.7106ce6a.dorota.czaplejewicz@puri.sm>
        <20220428130448.bfht2nf23n6lidsk@uno.localdomain>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vPfZ4CbmyVqo94p47OVPln.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vPfZ4CbmyVqo94p47OVPln.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 28 Apr 2022 15:04:48 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Dorota,
>=20
>=20
> On Thu, Apr 28, 2022 at 10:52:11AM +0200, Dorota Czaplejewicz wrote:
> > Added: mbus codes must not repeat
> > Added: no holes in the enumeration
> > Added: enumerations per what?
> > Added: who fills in what in calls
> > Changed: "zero" -> "0"
> > Changed: "given" -> "specified"
> > =20
> A more discoursive commit message would be appreciated. Just a few lines
> before the crude list of changes:
>=20
> Something like
>=20
> "Update the documentation of ... in order to clarify etc etc"
>=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> > Hello,
> >
> > this is the second attempt at updating the media documentation.
> >
> > Differences from previous: "selected" is now "specified", "array" is no=
w "enumeration", and "caller" is now "application". =20
>=20
> Please stay in 80 cols even for parts that won't end up in the commit
> message, it's hard to read this if you have multiple terminal windows
> open.

I can try to comply with this, but I generally don't do it
because hard breaks are difficult to read
on a phone or if I have multiple messages open.
My line widths vary between 40 and 80 characters,
and hard breaks can only cover one width, at the cost of all others.
>=20
> >
> > No differences: I haven't used the frame intervals calls and haven't ga=
thered practical knowledge about where docs may be insufficient, so I didn'=
t touch its documentation. =20
>=20
> I think Hans required to change the documentation of that ioctl to
> match the style of the changes you have made here, not because
> something is missing there.
>=20
> >
> > Regards,
> > Dorota
> >
> >  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++++------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-m=
bus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbu=
s-code.rst
> > index 417f1a19bcc4..87572de0fd26 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-cod=
e.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-cod=
e.rst
> > @@ -31,15 +31,29 @@ Arguments
> >  Description
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -To enumerate media bus formats available at a given sub-device pad
> > -applications initialize the ``pad``, ``which`` and ``index`` fields of
> > -struct
> > -:c:type:`v4l2_subdev_mbus_code_enum` and
> > -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to t=
his
> > -structure. Drivers fill the rest of the structure or return an ``EINVA=
L``
> > -error code if either the ``pad`` or ``index`` are invalid. All media b=
us
> > -formats are enumerable by beginning at index zero and incrementing by
> > -one until ``EINVAL`` is returned.
> > +This call is used by the application to access the enumeration of bus =
formats
> > +for the selected pad. =20
>=20
> This is a good introductory phrase.
>=20
> > +
> > +The enumerations are defined by the driver, and indexed using the ``in=
dex`` field
> > +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> > +Each value of ``pad`` corresponds to a separate enumeration. =20
>=20
> Isn't this a repetition of the above "enumeration of bus formats for
> the selected pad" ? Also, the fact different mbus codes are available
> at different pads is an intrinsic characteristics of the device
> capabilities and of what a pad represents. Put it in this way it seems
> it's an API requirement.
>=20
> > +Each enumeration starts with the ``index`` of 0, and
> > +the lowest invalid index marks the end of enumeration.
> > +
> > +Therefore, to enumerate media bus formats available at a given sub-dev=
ice pad,
> > +initialize the ``pad``, and ``which`` fields to desired values,
> > +and set ``index`` to 0.
> > +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> > +with a pointer to this structure. =20
>=20
> Could these two paragraphs be just:
>=20
> To enumerate all the media bus codes available at a give sub-device pad,
> an application set the ``index`` field to 0 and then call the
> :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this structur=
e,
> incrementing ``index`` by one until ``EINVAL`` is returned.
>=20
What I found difficult with this documentation is that it described an algo=
rithm,
and did not describe the basic assumption about the shape of the data.
Here, I tried to give a quick overview of the data structure in the first p=
aragraph.
The second paragraph is just a description of details,
not needed to get a high level idea of the API.

> > +
> > +A successful call will return with the ``code`` field filled in
> > +with a mbus format value. =20
>=20
> Generally, I see "mbus code", not "mbus format" as far as
> I'm aware..
I was generally confused about the "mbus" thing the whole time I used the A=
PI.
That's why I came up with the idea to describe what it's useful for (format=
),
instead of using an abstract "code" which could mean anything.
"mbus code" is not even searchable online much, so it's difficult to make t=
he connection.
>=20
> > +Repeat with increasing ``index`` until ``EINVAL`` is received.
> > +``EINVAL`` means that either ``pad`` is invalid,
> > +or that there are no more codes available at this pad. =20
>=20
> Is it necessary to add this last paragraph. Isn't it specified in the
> error code description below ?
>=20
> EINVAL
>     The struct
>     :c:type:`v4l2_subdev_mbus_code_enum`
>     ``pad`` references a non-existing pad, or the ``index`` field is out
>     of bounds.
>=20
>=20
"Out of bounds" does not say what the bounds are.
What I wrote is in the context of the incrementing algorithm,
which implies that hitting it means hitting the bound ("no more codes").
> > +
> > +The driver must not return the same value of ``code`` for different in=
dices
> > +at the same pad. =20
>=20
> This might be a good thing to specify, a little obvious maybe but it
> doesn't hurt.
>=20
Given that I ran head first into a bug involving repeats (prompting this pa=
tch),
I testify that nothing about it is obvious :)
> >
> >  Available media bus formats may depend on the current 'try' formats at
> >  other pads of the sub-device, as well as on the current active links.
> > @@ -57,14 +71,15 @@ information about the try formats.
> >
> >      * - __u32
> >        - ``pad``
> > -      - Pad number as reported by the media controller API.
> > +      - Pad number as reported by the media controller API. Filled in =
by the application.
> >      * - __u32
> >        - ``index``
> > -      - Number of the format in the enumeration, set by the applicatio=
n.
> > +      - Index of the mbus code in the enumeration belonging to the giv=
en pad.
> > +    Filled in by the application. =20
>=20
> These last changes are good, provided this phrase still renders correctly
> now that you added a line break.
>=20
> >      * - __u32
> >        - ``code``
> >        - The media bus format code, as defined in
> > -	:ref:`v4l2-mbus-format`.
> > +	:ref:`v4l2-mbus-format`. Filled in by the driver.
> >      * - __u32
> >        - ``which``
> >        - Media bus format codes to be enumerated, from enum =20
>=20
> In general there are a few good additions, but to be honest I would
> keep the changes small for sake of consistency with the existing
> documentation of other enumeration-related ioctls
>=20
> Thanks
>    j
>=20
> > --
> > 2.35.1
> > =20
>=20
>=20
Thanks for reviewing.

--Dorota

--Sig_/vPfZ4CbmyVqo94p47OVPln.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJqnUMACgkQADBpX4S8
Znd8jQ/8DpjlOIzRKpSjFYvngl3DGOsYQirndJNf2pxHhwV3vU3kCpl/32K1bhrI
FZPD8THpKGhDmC9Kw2Q2mbxywvdS/crX5aeeucNgIg1KTSA/odIXou416vGAIrrO
Xcc/9F+NHIow7qht03zQqczCoBmNcQV1MeigW0WDHOWWSQVfzNPK+ZonUqGp5VKj
0aIiq6O7SZ1r5bdbt9CytRBnsOHCGeKc1mdPOh+ivIb/N5rgYNZA93DWpYpk6/10
UewSUuaQH0S9tKFxh48y423Y2awy8HcF8sdjSl7RUWoY1p02vrGs2umT8XI1LkuL
JBAKMTyVDk2neLGPWrLfcparK/ThbOtALutvQ2CoySYtiPIFcjQKvySreJoXkaUl
lZn4T6IAd8eAb1ygX+s3dLZxZH0cmnAwk2i3PyF1RJk9T0xGtDJgpRKszLkfIsY1
FcYnKZ6dcrgwswvwohzzivIicCF2etFMJq+1LQoW4JNvHGDEhsmzkzXmuKrQ4daj
9VEnEB6KUnndZLUrmAFy1fvRLdI1SGZ0pEGsXTweeYuEK4oz8porBy/F63BwcH+x
KE/7LZ/yZrz5NrK+c47xGTb3iGt5/1DCvue5wbHCOrK2OJ2r8jaYmz2znl0dpUXZ
gnE108lqzk+KWBeOTH3VlvXJclaKh6BqZOMpZV3OHfRmLkpBWy8=
=znw0
-----END PGP SIGNATURE-----

--Sig_/vPfZ4CbmyVqo94p47OVPln.--
