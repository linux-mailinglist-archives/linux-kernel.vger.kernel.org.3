Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFFF4B33DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 09:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiBLIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 03:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiBLIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:41:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2542613A;
        Sat, 12 Feb 2022 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644655247;
        bh=6yeoDgDJPy6Mv0rvAeCcJ+cV6rpBoVqlTD6BL6nGPBA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ECsMFeCK10kEQy3vbM9SlWqvEBXVpIb+kEL310FW9HTi3XaktD/N3qlGeNb11HQn1
         dLcf++lYoAUcthwIAk0zz+LAN6GgpMU+xYbomhYFNvmTsdqaD+ilXbFHoyBv5Xzmm8
         jXucMoJq9Sb5zEpy3Otb7VAJ3pWZix6JwAZat8hk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1na3rS2BsH-00Hyov; Sat, 12
 Feb 2022 09:40:47 +0100
Date:   Sat, 12 Feb 2022 09:40:45 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
Message-ID: <YgdyjUbb4lnrVHmJ@latitude>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude>
 <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
 <YfpyjDBH83FE7r4o@latitude>
 <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zAZgCYGBplb8VEfC"
Content-Disposition: inline
In-Reply-To: <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
X-Provags-ID: V03:K1:hJPvO5vHcOttZM1wfVcuMJQGsgrEjDcKwOkTeT64bNtzFABDEGK
 WIamoNhFYPIJHSOMwXV0YQfcg3M4errYW7wm5rOzvzRkWqMDpmhLL04tZCTAsKolznmxDEH
 phmVnU7DTvxszphcydPY+LPpRINwC5jVWzlk5OGTGRtEXG7YLZAd2GCetPFrbrQw1At0n4X
 nqekm7hvvtg4RUJUdg8HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m2XNOyAVX7w=:s0wxwPeA9HvMlq2eNhUmBQ
 YnTuICPMq5UsHNHC5Xa5U0FlgVBZIBn4D9GIa/bhgvvI1dP8Jg9zJOi64TOWmMFa3mTeW1cJR
 oANWnW5BPC87zf5727tPIKYgQpEtk30o4RVJbbf/LKXzdD/jxdHrEZTRHX56YvNjv9H0yXK7k
 RPvyYbRYCBA1isASYbQfU51gvgP4bq2q1JlUjocLr2GA3ZfrYyhGJ39VxrOniZFyrr6Ph3lPy
 0uGTB0YB9vEXollfRTCk3wtZqgGUO/YaQcS4X30SdX9N6YG8U8RQwQyJuniI0sWWP1zxUm5ZZ
 vt344G6IR9U7mmrfmrZk9ePes8Ec6cR37hvpotm94pD1YH1FS4smHA//xhBpOmdgDdBWGBHJF
 c+54oo1DKmcgFJY4BCzr4bk1W1CEJSg45jaVdC/Pgn8OGXwTesZVH/QCgWNfZQKEkgzhoxVF2
 o4UZnAxQZ7t1hsZUMMFh0UBEplloQvZNwySlX4Xe6cXc6fChoYdGMyoTfQ0+g9Yfg/pXDbnvL
 rLmvg/wg7peJ1aIKWczNnZ88QlV8xRwJ++rZM2aXkqdd62RJcupYTPoRyDuYAJ5MJ38mcc9o1
 53cQeMQD7RPXXYqhWL6hZpDGsmjWP258ovGjZNjO/25uVlsUcyBG79JkhuXsEWuxbOPjKikCd
 rjtOZPAD38MFanB4kGS7127Nhz3yulktAB+aG7ZUusXUE5kV0JMpwS6rrSj+j71JK/JKjPM6Y
 uBt+u3XfHRzkaV1zWYSCSd9dM75n6Duzj0WX/jWsW8pDFIq7z/59D0zn9GGKk5nc/nuIRfvQr
 YjEVYxAsDit4uVyRAfut/wojaqtA8XbZe5WV2KkkpxZnnYTBdxY10x4F7jbxsgjlbp71yBY8A
 8Rp2K08sB5seh24kdJnoV9Xi4sdmwdbK44Mz1l7bQGBY5p8GHU1jLN7qCkjSpBd4Ay6jqwkuc
 6T12h008PmhZtSCE/9LeVR0OdIaWvZ3ItPAztVon95bjlfwWmCCeA4KFIYfn4NpNBsBKMy3li
 TgYCLZrYfc3v+digCqTQbdQfkScxHa3dVT96D8riDMX7/eAXnwQAgnBQmp/wFJ21OxBL0tMzq
 1ksURp/xrWAjIM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zAZgCYGBplb8VEfC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 02:10:44PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 2, 2022 at 2:01 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> > > On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@=
gmx.net> wrote:
>=20
> ...
>=20
> > > I assume you're sending a v6 to fix some of the warnings?
> >
> > No, the warnings are fairly independent of this patchset, it's just that
> > the adjacent pinctrl-npcm7xx driver started to be built by the bot, due
> > to my Kconfig change. I'll fix them in a separate patchset.
>=20
> I guess you need to fix that first.
>=20
> Because now and then all CIs will complain to your patch and confuse peop=
le.

FWIW, Linus has applied the npcm7xx fixes to for-next in the pinctrl tree,
which means that they are not blocking this patchset anymore, AFAICS.


Jonathan

--zAZgCYGBplb8VEfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIHcmkACgkQCDBEmo7z
X9uckRAAoi/mjUjwvtfOFTsTH/PH/r6DDSOiFTU+ycxhILZmK9lMk3c33cNUu1ib
9eJY87Mg8UpRJvvNST2usUdrxKV1eUi/lEI0idiu9+Q9HMFo84s0Wv37NhfwCGDR
mgTW0IbUsLvRegIP6Rl75XSAn6+GTIIYyhMA0Ohw9T37JOa1YI2ysV+dkqPkSala
WUe1CmWQ6yFSyLslMp6ZqZtg2rpTMCR0vat54Ykbfrity9fxd67OZE/561bvGKht
qpCEXrfWk1N35pQH/2VUfVBerwLWfW+Dq6ddq5qGMyTXr4hnGyQiidGQb16aPugT
ZGzq1S7TdnJ3r3k+HwMOpbARR4sn5i4LWkPkvAv2WvGScHfUwOfS4ttM0Q6H6/2T
lLt7jnYuosmvFtArXbc/PllfNWRfQeMylBzRoh8GOHCNSHhgewMZYB+SBqGrMqb7
lue4pyfWONnC85aWCYZyBbM1Bmh9E0LAs/8KxievUS/nWbDOe/Qz09m+XanUq1CF
5QzMKcaJekmiVVxDquzj/17c9V7ZZrb9dT6mTSYSoG0I77rKsPNHMkIccRVHm9ez
J10PVtMUNLYUdc5r62fn9HBo+x/aNtEHdnd/CTx3jZ2CFVPmAW2gGz9fQMwlWLyJ
LAKCGXBxxFoEO/bcZevsri26S8yvt7Lw+mIpupglsw/luJwHNUQ=
=Yhe6
-----END PGP SIGNATURE-----

--zAZgCYGBplb8VEfC--
