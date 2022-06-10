Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF75464BD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiFJKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349207AbiFJKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:54:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2746212C8B;
        Fri, 10 Jun 2022 03:51:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LKHnt7049z4xD3;
        Fri, 10 Jun 2022 20:51:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654858293;
        bh=zgmxwfoNJ1GaOK0G2QJTcV3/IuzAV1jWBY06oRVWOzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJgfAJDu9juLt5OHZWwEdcZEKvlFF8tWCFaSJUGf/8S1ueE9VgDuOhNp6C54KwRcP
         B7gKJe4gww1EH6DZQO4hosTet3sBLx22ZrUVue5av/ghfPhM+sXMmBinq2NbIHqBZB
         2JLwnx9uQ/J5SMl+rXzj0MzkxVxDDo+IJNfJlDEwOT0NtPcekRSqBQGn9GogoV0JKH
         zUU08wer2WldZe6ugRxkgTzyUx8/Ue8fvnMMPIDKZg0w5tDQKNUdiGJyEpAYoHdFa5
         p7wJoD0C8l95V8V9KoePJE72ZvnpYywnkn4D/QKWWKdydhUoLmZtLqkA9saj3p6XDN
         sTI3Q/atDv9CA==
Date:   Fri, 10 Jun 2022 20:51:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <20220610205129.18a3c372@canb.auug.org.au>
In-Reply-To: <YqMMzfFtWiZM8iOw@kroah.com>
References: <20220426152739.62f6836e@canb.auug.org.au>
        <20220523184254.4e657cd1@canb.auug.org.au>
        <20220604111841.3887bf65@canb.auug.org.au>
        <YqMMzfFtWiZM8iOw@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H.SXB32sJBFJLaNSvO7zMU/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H.SXB32sJBFJLaNSvO7zMU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, 10 Jun 2022 11:20:13 +0200 Greg KH <greg@kroah.com> wrote:
> >=20
> > This merge resolution seems to have been lost somewhere along the way
> > :-( =20
>=20
> I've taken your resolution in the tree now, sorry for the delay.

Thanks.   I have now dropped my copy.

--=20
Cheers,
Stephen Rothwell

--Sig_/H.SXB32sJBFJLaNSvO7zMU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKjIjEACgkQAVBC80lX
0Gx/qgf9GMMSRxbNjiSwJeX1UqLYoZfnGG511nMdNhc6vDnc/uY1NBbWnPk3m3+q
tT2SFT0/9ZPjZawmEI8QOvWfahkqXEs3Ubq7xsgOzBn5MwzwatomtkTUBeV6Fm1h
pZdFyxEBvelx8XAJGKlNH7JrNVrjBHKFEXixMAkW1PZO/L4ce5o7hkmMIAXo3ySI
lzRQqkElfuxIYZrPiqo0n05tSczfKp18zEX6o7RFWfiDzOaieGwwtUwpWuBTnfV8
ckomJZzjnXyO/wzD7i/PQwX4WSIz0d6rp97nqbvLgoAgpJu2wAtyHNqz2MuvVVPq
HWOMAQSWpYNUHeSTKGK7Jd4YHak9mg==
=+3Le
-----END PGP SIGNATURE-----

--Sig_/H.SXB32sJBFJLaNSvO7zMU/--
