Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725FA4B7592
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiBORT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:19:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiBORT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:19:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCB1AF33;
        Tue, 15 Feb 2022 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644945545;
        bh=FTRaQZEhcQHE3D6iMKxlWyuUw3TDc4VB3gHJh1I0RhM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FEvtmI8ovHWgdCHsVqY8UkXxveuRoUoaN2mnIeYRYWyCh5pH9ZDEGQ33Ea7LguYfI
         2eM0MX57verzTfxdJLrkrqQ4iSSGbhlbwiY8Xgi/1vORd8ko9cooMDgvQIvh2M6WYW
         +Lq1Vp6vnWzzDnidbYX6Li6TIS062BREM+z9cCGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1nhZyt2TT0-00TH5q; Tue, 15
 Feb 2022 18:19:05 +0100
Date:   Tue, 15 Feb 2022 18:19:04 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <Ygvf3COuzZ9bTXuy@latitude>
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude>
 <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
 <YfpyjDBH83FE7r4o@latitude>
 <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
 <YgdyjUbb4lnrVHmJ@latitude>
 <CACPK8Xe-t8Qso_AX+q08OxrgmUPbEayhnHXH5xiLr7M6rDxjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHIAxUhFauf14s9F"
Content-Disposition: inline
In-Reply-To: <CACPK8Xe-t8Qso_AX+q08OxrgmUPbEayhnHXH5xiLr7M6rDxjuw@mail.gmail.com>
X-Provags-ID: V03:K1:c1cqtZLz7Mg2BLdDxmXoFqJl53D7wRN7wbycXFZiU0+GIgC08IU
 8CEMhMS0O8QjQ4TO8yCfgeM1QAyNJA4faQGEzXHAmCFeDquzpIwRsvHcD5F/LIHr7ofT4NF
 iH3LABJcrT6QqURzbtpYi21Vqd9GEZc8lcJCcBh8M5Gnl8Mto4FMRRAdYiyrtRKcwVRDOZf
 E4xpDfashLDaUm+T0HBbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xB1RnmaMPC0=:9dGoAvV1W0XTvwGMz27dkn
 JRjiKQGBbeJRe1KdQxY3bGtt4Z0aXYBZGp3dt27nA5swetlfQg73eJYCKL1M+yo9kQNjlhIpl
 TcN1irGX8l043UlSzT5H5VjdmtPUdeVyafrH3+h8fJsqp2kcUcORrkH9ho3Uo2wcsy3qDX8qJ
 XA+w0j3e3ClpPdlzNG1G5h3F5W1FSeMTCxvSa3rHkTMwTLDYk48spCcB/7IadVVfzNZuyp2z+
 7QzxA+2V4Dk9dzbSWFbGWIiCZBTz26WUpZ2ZRU87LgA6H39ExMw++vPO4ZVTkzNsplmduZFhj
 ut+cRgYom/UeQjIRUQO2mqvQA8upoxa2+NLh4D6ekp81P+NeXhmpQReIfNRIVOJL/duqWjYnX
 Gy9iNXqBvafWwh0N1vokOdpwQuqkI5TcFBH0/cRJx0NBGGnLTE2X06XOVacaIHgXQ9p2euIN0
 9Vd1r1TMQI/CcyAIwuA/uFdN8GhmG75JkUPZk0Qz4jQFuv5wy3yzzKzGK3Lb24raXqmd3vLNy
 /p63aI7RFIFer+uWreAgBZhIljaZWDdhQ0+SMW3SztHhZJTG+FtjytMflrnXjVPDTVjxfXMyK
 LvnXdR4yJKDxTJa6w98OMwz8uko63xTOvI6li2DT2pPq0S1qWzqmxx7p7vVwA3NYrS9pY5YSF
 9dR+UE/nYmVeAIYXbEmH4GmAspTusRQW9nz/lBvfRPouqgJ3Dhu+MHvEEsdvhaUzxQUgO+v1V
 KuZLfK9hLawh1EFjmzX+E1SHw88SyuxqrHoSMR1qk6QcwaT4zIs4kfpzxzufCZmOYGH3FR1AY
 M0801yvqfVLNVfW2jsh8u5e/QYJ/YPfnBleaiepBGOCkjvEeS7D6p+Iy/TM/4ZWGyNARSFD9F
 Z0b9NHlGYEuUOEzRJ0KlF0V0MWjiQ3WDZhBahteKFiK2d9CX2htaU7PF6qD47GNcE0+a0O5lc
 I5iDuTBbOo4L1x5SgaU7AVOy0AGqiMrCx5eObd5NXnD2zrlLFIRmfy+8Dot6u0xSUhhbPLHXH
 wiQTDdU0vQjaWzN9+F4zxgKoXzxsJM9OagakYvArSYcy9Nxli8E0p9R4h25UXK4uEeMOWGL4c
 uBdx7nTHAAYu70=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHIAxUhFauf14s9F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 05:56:17AM +0000, Joel Stanley wrote:
> On Mon, 14 Feb 2022 at 12:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
=2Enet> wrote:
> >
> > On Wed, Feb 02, 2022 at 02:10:44PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 2, 2022 at 2:01 PM Jonathan Neusch=C3=A4fer
> > > <j.neuschaefer@gmx.net> wrote:
> > > > On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> > > > > On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschae=
fer@gmx.net> wrote:
> > >
> > > ...
> > >
> > > > > I assume you're sending a v6 to fix some of the warnings?
> > > >
> > > > No, the warnings are fairly independent of this patchset, it's just=
 that
> > > > the adjacent pinctrl-npcm7xx driver started to be built by the bot,=
 due
> > > > to my Kconfig change. I'll fix them in a separate patchset.
> > >
> > > I guess you need to fix that first.
> > >
> > > Because now and then all CIs will complain to your patch and confuse =
people.
> >
> > FWIW, Linus has applied the npcm7xx fixes to for-next in the pinctrl tr=
ee,
> > which means that they are not blocking this patchset anymore, AFAICS.
>=20
> I've applied the device tree changes, and I will send a pull request
> for v5.18 with those.

Thanks!


> I assume you want Linus to merge the pinctrl bindings and driver
> through his tree.

Yes, that sounds alright.


Jonathan

--UHIAxUhFauf14s9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIL4IgACgkQCDBEmo7z
X9tgPg/9GbVJ8o9ImxZI9vUt8PXnJrwRertT1KoqTqsDH0QH7OV/DHkhwAcy/yqr
wTOVb4U1JTAyfLDUkBBmWOBsM/qKxxzS98YHYbeQSKgUfHNgw1eHdbdizk2nkJoZ
YlKICyy7iwVLDo9DEk3//vlV5FxEwzSpcWi0ezc1uTHK9UWRB0Y6UCrEIbfpWEy1
twd2mvUi5T93F09L50diwPevgLFtDyoF+CfyyKwX1bwLrf5W0V9hDS1kGvLsZHc6
fIy5e/ojgOBkU5nUU1lhagDtL0dw1GCLpRy7RlA3c2iJsQMtDx/8K/SDOxluKPJ0
SJD/a7s/yX1ylEG9//H17URcD8aRfbegodOa2W2+U+kBUpIta2NzA5cdaEwbsT4R
iTKasMt4FMeegas6Hn/+BT81Uv/2GnE1wZ90TWXBFZR+0MYLaL/LGU0vVOpkLVb0
EMDppg9IS0evPiKe5yeaYRV0jF4LM5/TTRiWJ8sdvRlnmgISUl2n6X0xXwgLMiIi
Wcv0NpUtOQd+BBQT8UFGf7cb1pSDKj/r8qWMBR0pUFSNghwcIttSoO09USMELKLm
ZW5eKL3V5UBiowKK+a2A6cmrzXAILwk72onoHIulxXnAQIba9QwlLHofOzxNwHxG
4mPpbjk8UMgbhqphCfIYFimIAIIDc9sAjsMc1zG4pAP/Z7vldOQ=
=WIma
-----END PGP SIGNATURE-----

--UHIAxUhFauf14s9F--
