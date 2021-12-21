Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0003B47C343
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhLUPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:43:51 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53599 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236412AbhLUPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:43:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C411A32007BE;
        Tue, 21 Dec 2021 10:43:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Dec 2021 10:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=m87v0MiJXQ0AYj9J0oYwIBg3htz
        mOL4yODzPrK1faxo=; b=DhHhd+KTg89y/ElZQyf/JblypvTFCxblsyT0FwOWh0C
        DFLCfq2NQSAV/YWoGengVqG4FK1Yli3uyOVOhDm7aDMSa0AbtC0LgcCVR2JNFr+8
        8VPYmrv83E2dtQ6UW9NlVhtzAw0QdAY9FH5CATN1x43VlmkRMTSrXycCpt324VYq
        4PwrtElB5GHaum4a3bZwe9eUcA6SLG2kUeoUC+06iG+B6sVOS32m8SBGmK8qIDW3
        YVchBKlshK1HI9M7xCinF4hlLNoN35qLJ61mOOjNBzef7BNfwEA6bRnxZcftfSmS
        Fo7vNUXr5IkvVkWe8jnnDQXxoTXv7w6/u8LkuW77P1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=m87v0M
        iJXQ0AYj9J0oYwIBg3htzmOL4yODzPrK1faxo=; b=nUeJlLCcJ4LL0E2BzTOUKn
        s5xBGjo9kbChietQozgooF+RRtz6hO+MY0ETTSfh77gVW6GY3jn5dNf/2wIrsAQ5
        MgxhGSyVEFFjuY2uHKN7xPb8Werh//4vlnufwmAEQSb1XqfqrkA2UVLpiAWfhXLN
        a/lqEnMj6ZAmHQPr1ECRO3LNWmqWAai62UrHRRsoeVgSJxdMtqHSIhXTjXqIIAq3
        W2K17lUL4Wq5h2pKW+SsYIqgscr5gIb1pkIZMGGhYxznvu93F9UGBeq8MYQQZ3WE
        AMgG5U6tD0O1vYQNZw7UcJOcDarvxG/2u3GKp0vvYqvLEzduOU4ze0/d2zfkojnQ
        ==
X-ME-Sender: <xms:MvbBYa5qCcNVQIHEuOncCQGWrAJInObd9nNXgJuylDkWzNixyJ_OpQ>
    <xme:MvbBYT7cOAUDgviUN7A7z5moTBaKrfMwDkZHnKTu9uHicJxP4u0tCpZijN6Oqev0v
    -TQqUwM2jQU8wl8tjE>
X-ME-Received: <xmr:MvbBYZfSnRMnHofZP4WbgQwuipIPH4ckldNCNgfePVd3__bV6wNMSC2tcCFuI6-F9Q0rqdcizgNpBB5x-cBSOAzdNKXhd6qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:MvbBYXLAfX85ZXBgHoQD6yr5GfObCv5QEBuo3AkXFaiUPOeZfUyQ-Q>
    <xmx:MvbBYeIgzcRVY2jMYVpLhYgqYx0cfj2K2sy272aq8Yl6SXeHiWM88w>
    <xmx:MvbBYYyoIOSYQTv67lvvGNwT8S_PHxD_Uk5wGtRHO0g8pfnAXSrISg>
    <xmx:NPbBYd-O0noIj5jhq8LbVaoMvsZx1RmyUILgmIKdKNhiCbVActrJag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Dec 2021 10:43:46 -0500 (EST)
Date:   Tue, 21 Dec 2021 09:43:45 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Howard Chiu <howard10703049@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Potin Lai =?utf-8?B?KOiztOafj+W7tyk=?= <Potin.Lai@quantatw.com>,
        Howard Chiu <howard.chiu@quantatw.com>
Subject: Re: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <YcH2MSByPLAvw5mI@heinlein>
References: <20211207094923.422422-1-howard.chiu@quantatw.com>
 <CACPK8XddhFn3PreJM3D=djkREgqGD7yZhS7YoqxxXsNfhZpLhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HM0gOAIGGoJB3tSG"
Content-Disposition: inline
In-Reply-To: <CACPK8XddhFn3PreJM3D=djkREgqGD7yZhS7YoqxxXsNfhZpLhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HM0gOAIGGoJB3tSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 21, 2021 at 04:37:55AM +0000, Joel Stanley wrote:
> Hi Patrick,
>=20
> On Tue, 7 Dec 2021 at 09:52, Howard Chiu <howard10703049@gmail.com> wrote:
> >
> > Initial introduction of Facebook Bletchley equipped with
> > Aspeed 2600 BMC SoC.
> >
> > Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
>=20
> Are you ok for this one to go in for v5.17?

Yes.

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Would also appreciate if you could apply to your Aspeed tree for OpenBMC.

--=20
Patrick Williams

--HM0gOAIGGoJB3tSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmHB9i8ACgkQqwNHzC0A
wRkTXQ/+KMROyY3iAc3pg9nNuSF7rxqc8a1K7gZ+4SHFwwvD49PMhiywWiR8qqs/
ehvUMImlcjIfTGAizpi1zlWwH87GOxqLnLwJ4IfFaiC895ho20SJWTaazksu6/SV
qdjHOOkvBScfGfftQoq4/G4ty1rNUlLl1O2AuXoDaLGZali9TbupFcQqd8qOKYAp
MaVEQck3YPd5Tj3PGQSpVnuUvZL77qvjoIgaeR9Pdoj02O4rTZZXcHsckGi0doDD
ZmZA4Xt4COqT+VDXrc0I5UsGvhYtlzCJ8V+nt6lRbQ+Kc0klIhTt5/iZ04HmKzsO
y5gw/CgBTSkvd/6aHYvXTyby4uSzSvrJn5GHH40aG8FA4z2BDst+C0Y64Q+2xc0j
ZNkq2HWsNYlHJsEhlSwDwglh8otlJn/+czYcuHkiDuylrXItuRS8O0C+sfxhE9l9
dCpVfLKM/idXbyIMTK5Ya8Q1cfRHsarpNHsBH7bYm/FuuNJHu9OBojTfE5F60ia2
qwSLf3O6V8UpDMKJM/ntItNh3B5X9HjjsTpfiVqV7fLb0MpwiA7KmY/AGcqs7sPJ
kKODFplbuJKI7CHzzzGdXwDZruXaWUOaiEB4WjGUjCSBYhWNRjaCafvRjNYmMciW
YEWrOcPSfV2A8BHqv6NjRMgBCOSkCUTA3veNYPNT89GFPIukAnI=
=izBI
-----END PGP SIGNATURE-----

--HM0gOAIGGoJB3tSG--
