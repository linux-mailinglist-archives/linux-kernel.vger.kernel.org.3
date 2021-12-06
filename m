Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDB46AA62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351495AbhLFV2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:28:54 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46943 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348660AbhLFV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:28:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 473E35803A3;
        Mon,  6 Dec 2021 16:25:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 06 Dec 2021 16:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=NfXU9pTezFHc8ebqpddROUBifoe
        F1csYPG0ILJTnS04=; b=YAYjPDpiwhpN630k1LvlVrbXMi5y0NynQbhnIpe+ao2
        zMR8hxIcDgkAUKDuPMeLYd7eNZ4FJzERBvqffGipi8f+EMdAthx0vB6lKFzyhtKF
        F4ZBGKECm0LzKHk+5wZmKXx9uFGfp48/+rcC7gdwDHqOGWABPDyxELaLzhIqqDBV
        ZPV7Bcn4LpnWfS1Vghtrhx5f3WW/4MEdyPCSRzwP9dieYky2At86Jdyrk/gf4Tm6
        D3LY9nEiEmntSCcWabRF1Qxykhpoopn9KYPHABjYRM8rL+Mgol3GHpGgN29Kuumc
        alw3DDakhx5H+Mb9hpTx3riJbKQTVuf01AYIkukzocQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NfXU9p
        TezFHc8ebqpddROUBifoeF1csYPG0ILJTnS04=; b=GkNBGz5ynQ6XLpBI5Lx421
        XmZnT0kJzmGlFoO289+63Mr0O43IBpJjnwxmrdD3sGZwvpuJLu30zGmBJ+uff3x5
        mgjzRHb9ji+6mRwnzXlBj7hPn9nIdzmuD+J6T81WqgX4oZqLT+pOrjm//Y7Gf9sz
        IwVLX9j/rjs7xGaMmHJul6NGsiKEkQtZ0i7lEWKMX3R2+MUDUyPJZoKVvSMmhzuc
        YwYdl/Xlqv9BwA16p4ruz7NXOWNdv+d/tgDVY64ngWOVKwTIH6biN1Qlm75lHBtG
        WFKN0HDBo85mUHiCiixZwCdkniv4BGFfyj7GdnwUisTqP0EBVto7f3wRQ8a39Vjw
        ==
X-ME-Sender: <xms:wX-uYQu1jqy7wFWiI3IK7KJQ54hO1Xy2wCkvbm9f0p7NiVn2l1FaGA>
    <xme:wX-uYdcThWfOmhckBmicqd45ygwTRUzvIRzNf3931Zn-P4HHmZKX4hZt9lonjIH6v
    DjY6qVqTyVIBbDyGvo>
X-ME-Received: <xmr:wX-uYbz0EFedyquTMT6PGVnhK3ZNcS1U0rkqpHHyRGwXjpTONlCU48SOpagl7fRZJBVlBwSi1zIJS2uMr-AGjUnT6mIbCoLIdoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeefgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:wX-uYTOITDgdzy04Bx8B0b2WFKVY6dcoEmhKnQQQ9FSf9UT8nbbkMA>
    <xmx:wX-uYQ-UO8B-BWHGCso7V0LNiiuUuAOFHfQ7b_9w5IaFKW2wSxuNPA>
    <xmx:wX-uYbUgHmFuQLZMPTdZVeB0jR50c0ONvPWxoe_EwV0morZY0mBF8A>
    <xmx:wn-uYR1Ie42QNp1HuX0wrGiv6yoTADqdhZc2K_nATIXXd2oPGGfw7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Dec 2021 16:25:21 -0500 (EST)
Date:   Mon, 6 Dec 2021 15:25:19 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Howard Chiu <howard10703049@gmail.com>
Cc:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Howard Chiu <howard.chiu@quantatw.com>
Subject: Re: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Message-ID: <Ya5/v+VhOM9o9BtQ@heinlein>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3yGt1ASd+zxP8cbq"
Content-Disposition: inline
In-Reply-To: <20211201033738.121846-1-howard.chiu@quantatw.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3yGt1ASd+zxP8cbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 01, 2021 at 11:37:38AM +0800, Howard Chiu wrote:
> Initial introduction of Facebook Bletchley equipped with
> Aspeed 2600 BMC SoC.
>=20
> Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
>=20

=2E..

> Change since v2:
> - Remove uart5 workaround
> - Remove gpio nodes of pca9552/pca9539
> - Modify gpio-line-name of led/power/presence pins with openbmc pattern

A number of the GPIOs do not have defined openbmc patterns for them yet.  T=
he
names you have chosen are ok for now, but we will be changing them as we re=
fine
development of this machine further.

> +		gpio-line-names =3D
> +		"SLED0_MS_DETECT1","SLED0_VBUS_BMC_EN","SLED0_INA230_ALERT","SLED0_P12=
V_STBY_ALERT",
> +		"SLED0_SSD_ALERT","SLED0_MS_DETECT0","SLED0_RST_CCG5","SLED0_FUSB302_I=
NT",
> +		"SLED0_MD_STBY_RESET","SLED0_MD_IOEXP_EN_FAULT","SLED0_MD_DIR","SLED0_=
MD_DECAY",
> +		"SLED0_MD_MODE1","SLED0_MD_MODE2","SLED0_MD_MODE3","power-host0";

Such as these...

> --=20
> 2.25.1
>=20

Otherwise,

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--3yGt1ASd+zxP8cbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmGuf70ACgkQqwNHzC0A
wRnbFQ/7B4R+LFeP1OPALJwb2dWd0yqhi378WMujEkcu9TTjG3kMQB3HyXfyckia
fwlXHtGSb+xNpxzSPlusBW+JRm5VYPcjUH5+rtrzC6UdUpb2pJguFlVJ4wNY3FeR
W7vmmsmw16AtK0qiQq1TXrErXKhw6Ot6QK1Yos82eecEqhvniznZGdYeNcf3HT40
wNQkNSsCNUps6LH+lzWW5Rh/6K+DGyhzZHu/gHyJk/UHcT8BQKI/TmMSmLL1Ncvv
piaCVsQuFOv6kSOasoiCjae7m4f0vsUsu8E0lfgFn3+qUmO3KV4Fv52eFnmKOheD
R4JcnZJGqhAi9Xf0JDWgUaJFhEtsWXicPD/d2F+kMIh947QcKxTfGua0oTC8pX61
OeCzzaVz0InxGIj63LgulKZZz15BoSPRHW3DQBTFqm9Ju4JfrqIK2WgQs9r6h+PG
kFjmqiEgmaBtqepT+uzT8kDOeLNGzzy6EcwxAnyZK49IIXHhjueFhE/3sJ2Ammt8
z0XCFx9zxwuVJz8PsKmQ04QeRy8/yST0HtwkaBrsCCJx+gdrADcBbUbOjt9oMFOH
lbejpDXRBPLTd5UQ3nQtQklfUgcaE4FAnDizRIxPv91rPhZIsjNHMtWPn6nP1Khe
pcWtecl2tSSaR4UOcWlBcG2ZsT02KoZffYQY3qxZ4uDpLLsiq4U=
=pGUy
-----END PGP SIGNATURE-----

--3yGt1ASd+zxP8cbq--
