Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C45513658
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiD1OIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiD1OIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:08:09 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAE7AC076;
        Thu, 28 Apr 2022 07:04:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 49234DF8D8;
        Thu, 28 Apr 2022 07:04:54 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ggvQbIEcjV6V; Thu, 28 Apr 2022 07:04:53 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:04:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1651154693; bh=kEN2az4QinOm4QNlEhCC9dIUweT4lFTVpB8RS//MQaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LqHi/bxahONXQYIkUJWMdmLGu8p6bAXjEnrVmR7elGDlMIN+yepAToo8pRWB76f/l
         PXY2MRvXtcBKD0mQlz976Qc+z+rTQuuGQ8Uvx0krzbjmhuBQF8zCg0RJdDg+u83H4G
         bZBLYko9yk1WtFB1YpAsbkfV87QNMLwj93K3eyWylHo4nczKI+oFhnEQETyAH2uXt5
         Q3CrpwesXgiJZ3+S+G31WHfixkHciC8aVQ8jkaOYA6mp8wkgNJDzBLn28D9Qaq5AfE
         I7eh4+4kMszVfUXu9Ix7ctx5ihf8R565Q8SD14FNYoQmgOvaSaqPNUagNa3vxcQ77g
         izzaq0PnPzHkw==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv2 2/2] media api: Try to make enum usage clearer
Message-ID: <20220428160448.6e23e50c.dorota.czaplejewicz@puri.sm>
In-Reply-To: <20220428131146.ofdn7tr5mkxya3ck@uno.localdomain>
References: <20220428083715.75997-1-dorota.czaplejewicz@puri.sm>
        <20220428105219.4b068b1f.dorota.czaplejewicz@puri.sm>
        <20220428131146.ofdn7tr5mkxya3ck@uno.localdomain>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/02RSxe3sdM1r0_xf5dPXf4D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/02RSxe3sdM1r0_xf5dPXf4D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 28 Apr 2022 15:11:46 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Dorota
>=20
> On Thu, Apr 28, 2022 at 10:52:19AM +0200, Dorota Czaplejewicz wrote:
> > Fixed: typo "format" -> "frame size" in enum-frame-size
> > Added: no holes in the enumeration
> > Added: enumerations per what?
> > Added: who fills in what in calls
> > Changed: "zero" -> "0"
> > Changed: "given" -> "specified" =20
>=20
> Empty line here
>=20
> > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > ---
> >  .../v4l/vidioc-subdev-enum-frame-size.rst     | 44 ++++++++++++-------
> >  1 file changed, 28 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-f=
rame-size.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-fr=
ame-size.rst
> > index c25a9896df0e..2c6fd291dc44 100644
> > --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-si=
ze.rst
> > +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-frame-si=
ze.rst
> > @@ -31,18 +31,29 @@ Arguments
> >  Description
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -This ioctl allows applications to enumerate all frame sizes supported =
by
> > -a sub-device on the given pad for the given media bus format. Supported
> > -formats can be retrieved with the
> > +This ioctl allows applications to access the enumeration of frame size=
s supported by =20
>=20
> over 80 cols
>=20
> > +a sub-device on the specified pad for the specified media bus format.
> > +Supported formats can be retrieved with the =20
>=20
> This seems quite an arbitrary change. What's wrong with the existing
> phrase ?
>=20
"Given" is vague and does not really say who gives and who is given.
Is it the kernel or the application? It kept confusing me.
I tried to turn it into a "selected", which has more "application" vibes,
but I was asked to change it to "specified".
IMO this could benefit from an active voice, but I didn't want to rewrite i=
t completely.

About "access the enumeration" - this serves to show the data structure up =
front.
In my original patch it was "array", which hopefully implies some things:
that it's continuous and indexed.
I was asked to get rid of "array" though.

Thanks,
Dorota
> >  :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE`
> >  ioctl.
> >
> > -To enumerate frame sizes applications initialize the ``pad``, ``which``
> > -, ``code`` and ``index`` fields of the struct
> > -:c:type:`v4l2_subdev_mbus_code_enum` and
> > -call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointer to =
the
> > -structure. Drivers fill the minimum and maximum frame sizes or return =
an
> > -EINVAL error code if one of the input parameters is invalid.
> > +The enumerations are defined by the driver, and indexed using the ``in=
dex`` field
> > +of the struct :c:type:`v4l2_subdev_mbus_code_enum`.
> > +Each pair of ``pad`` and ``code`` correspond to a separate enumeration.
> > +Each enumeeration starts with the ``index`` of 0, and =20
>=20
> s/enumeeration/enumeration/
>=20
> > +the lowest invalid index marks the end of the enumeration.
> > +
> > +Therefore, to enumerate frame sizes allowed on the specified pad
> > +and using the specified mbus format, initialize the
> > +``pad``, ``which``, and ``code`` fields to desired values,
> > +and set ``index`` to 0.
> > +Then call the :ref:`VIDIOC_SUBDEV_ENUM_FRAME_SIZE` ioctl with a pointe=
r to the
> > +structure.
> > +
> > +A successful call will return with minimum and maximum frame sizes fil=
led in.
> > +Repeat with increasing ``index`` until ``EINVAL`` is received.
> > +``EINVAL`` means that either no more entries are available in the enum=
eration,
> > +or that an input parameter was invalid.
> >
> >  Sub-devices that only support discrete frame sizes (such as most
> >  sensors) will return one or more frame sizes with identical minimum and
> > @@ -72,26 +83,27 @@ information about try formats.
> >
> >      * - __u32
> >        - ``index``
> > -      - Number of the format in the enumeration, set by the applicatio=
n.
> > +      - Index of the frame size in the enumeration =20
>=20
> Rougue line break
>=20
> > +    belonging to the given pad and format. Filled in by the applicatio=
n.
> >      * - __u32
> >        - ``pad``
> > -      - Pad number as reported by the media controller API.
> > +      - Pad number as reported by the media controller API. Filled in =
by the application. =20
>=20
> over 80 cols
>=20
> >      * - __u32
> >        - ``code``
> >        - The media bus format code, as defined in
> > -	:ref:`v4l2-mbus-format`.
> > +	:ref:`v4l2-mbus-format`. Filled in by the application.
> >      * - __u32
> >        - ``min_width``
> > -      - Minimum frame width, in pixels.
> > +      - Minimum frame width, in pixels. Filled in by the driver.
> >      * - __u32
> >        - ``max_width``
> > -      - Maximum frame width, in pixels.
> > +      - Maximum frame width, in pixels. Filled in by the driver.
> >      * - __u32
> >        - ``min_height``
> > -      - Minimum frame height, in pixels.
> > +      - Minimum frame height, in pixels. Filled in by the driver.
> >      * - __u32
> >        - ``max_height``
> > -      - Maximum frame height, in pixels.
> > +      - Maximum frame height, in pixels. Filled in by the driver.
> >      * - __u32
> >        - ``which``
> >        - Frame sizes to be enumerated, from enum =20
>=20
> Even more than 1/2, I am a bit failing to see what is missing in the
> existing doc. If it feels better to others who will have a look, I for su=
re
> won't oppose this change though :)
>=20
> > --
> > 2.35.1
> > =20
>=20
>=20


--Sig_/02RSxe3sdM1r0_xf5dPXf4D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmJqnwAACgkQADBpX4S8
ZncAVA/+OGS6CIfwV7O9+nUL37fOPbbylVjZVeQPEItOlQFykECjlPaCSZ5kK9VN
gSPllfQKLN3ICzT3tdcQdutT+rW14dplKgvHIXlFayqMJeZyO7rV63UmElAwwTTL
mBlFIg1Vuw5jzC8lBnjly4xsrb6qi71KE9sNnhYqI5aK1JYYMw7JSCGNQmG8/Cre
VCXd2/DhkkwUsqa4Y0wtiRB5ZU7MCfbnBLoDwHLlLQSsRy7flKporCCGEQAlVPBJ
C+FLcFNMJ5OaBQASELrTaenf21Hq8nKDhnm1vtiSs1kCoeTjkVyzuIkZL1cGm+8X
8qsX9DIYFSYe3yR1JyAdblnrfPuU6TdxDE8TaMVdzuHSL1umA/eifUvCIoVnZFD4
FH6bBr4WMBNsmCA8KtNaDmbvGFcY2MMQPHwVEufPeHd9uK2DoAEYGKKXx12dqH8Q
lXGPuhn9VWIxqNBiW48Z4CLfY5PraH7WmLasWLbuzGewfgjUahh7FxvnvEy3qbX1
PSK/g5rbf/4mMHFgSk/24PLBep3BAZDnLbFLk/djMS9V6hok212ZeCIYKqPMJ/Ui
ga5WSZMq7MV3U0K28sGPxzhflovBqput9+zKIHpaUOnl0vInxcxPRk851zVpjcXP
U0Z1FfdECSoVizelszDNupUpTFDVYRDK9ThBaWbowpQzvbmyiV0=
=Q2X7
-----END PGP SIGNATURE-----

--Sig_/02RSxe3sdM1r0_xf5dPXf4D--
