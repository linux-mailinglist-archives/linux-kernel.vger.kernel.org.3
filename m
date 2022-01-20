Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18E049460F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358314AbiATDVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:21:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:56293 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiATDVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:21:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSTC6ctRz4xmx;
        Thu, 20 Jan 2022 14:21:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642648864;
        bh=Yg2OryvxPVUiIJSuTkDKLKDC0L9VgXX7Gn4r3rgt5dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B8j9aM3XuZv12CTGkY7Q1loOfFBJAJPaapVqGbTfWv5AZ0saB8YmfC06CwML9LKpg
         YVtIcnWs3btZ5t+UJjSre/na+JYJ7DExYSyNc+ZaIPJooY48NrKwLJPg03zRlAs+gN
         lxqpOPkFiKQP8McsdHF+CJiiJ8MBZbNf1fzl8rPISBwhyvKdCPKb7cXVw6VgTXP6cj
         AXumRGJrOfZDC8jcHNIZ+GZF2QVnMploRQ5eAylulwYOyODTvtJQRpNIF0lRYphmlc
         mjRrlUXtoQm2HezWizZ8/xx7/V0Ml2uDyAFYtQqIDjm3FkklMlYntXAUKsIWPKkj69
         hd5gm8672ekJA==
Date:   Thu, 20 Jan 2022 14:21:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the spi-fixes tree
Message-ID: <20220120142103.6a72ec62@canb.auug.org.au>
In-Reply-To: <20211015211423.2d8d3c0b@canb.auug.org.au>
References: <20211015211423.2d8d3c0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//X0_Ewcq_Ts+iO_3F4.Bchf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//X0_Ewcq_Ts+iO_3F4.Bchf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 15 Oct 2021 21:14:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the spi-fixes tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> include/linux/spi/spi.h:671: warning: Function parameter or member 'add_l=
ock' not described in 'spi_controller'
>=20
> Introduced by commit
>=20
>   6098475d4cb4 ("spi: Fix deadlock when adding SPI controllers on SPI bus=
es")

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_//X0_Ewcq_Ts+iO_3F4.Bchf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1R8ACgkQAVBC80lX
0GwYnwf/Zd2GVyOGYgkCAA6z7pLIqzmNGVUsJlIbYA/Z4cpxCOeg5VDSKR9+PKxZ
HLSmtTauKXRE/mHYvZqHKAqnIHU/0i08o7uqvajDM7sVd0kvnjTl/foRFfv5MM3P
9IDDUL0oIdK4E/wK4C1QBTfFl/xW0bj+3PhNZLTpR1g/oygN1rCDIMuxG/d0rMCV
lK2GNhuQGgHk/6kMB7xZE3hDIpFDa9I0BXTcrA/4ZnyNvm4l4OSRcPQMmC6PBhaU
OoPBj0UOK6bYEIufAfvbkTR659zKI6keMNV4MPYL5Cb4seVX21ggTjC6Jw+p6Qou
hQobYrIu0C7VlOTltqT5M4gutQ+sRg==
=Gz5C
-----END PGP SIGNATURE-----

--Sig_//X0_Ewcq_Ts+iO_3F4.Bchf--
