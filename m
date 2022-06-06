Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E753453E0D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiFFFtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFFFtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:49:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A22CE02;
        Sun,  5 Jun 2022 22:49:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LGjGd6VBbz4xXg;
        Mon,  6 Jun 2022 15:48:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654494539;
        bh=CPBKHzFDCKd53m27AvAECAMd2sdqPutUmjqhp7KG9bI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IFweyYUIwvAkZnMkehnkfoif9wvOuCeXNIHleZUfiqOPZfKIThbnzZZOm/fKU1Mqd
         +Og2OoQk4nJs6Zy5iy6Q3ir+RstQws3zok6zXGtjRJB0nie1irnHYoohlmXrS+Wsx9
         gpiFbH1BHz1TCgvCp3xddkGrF4RB4v0sQZUou2gUSwvLEzt74QWn+dSCNAgaXlbMyL
         jx7/1fRCkdhhUhTCfze6KF7GhRVScDdsSs4ilvUkCWEGTE+098gFi9VwMnmQElhkqL
         DeNl1KO1mGClcIWEb4nc89y1euc/kh4pOC25q/AXC9b3YQyANhjDlx3bLTY6ODEj3C
         k6GORb4heslPg==
Date:   Mon, 6 Jun 2022 15:48:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] gpio: Fix kernel-doc comments to nested union
Message-ID: <20220606154854.653c08ee@canb.auug.org.au>
In-Reply-To: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
References: <27612e81-d843-d161-ecd2-c653c7d5bae9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OxU+zvSxT+aW_NkUeZrEfx2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OxU+zvSxT+aW_NkUeZrEfx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Akira,

On Mon, 6 Jun 2022 13:44:24 +0900 Akira Yokosawa <akiyks@gmail.com> wrote:
>
> Commit 48ec13d36d3f ("gpio: Properly document parent data union")
> is supposed to have fixed a warning from "make htmldocs" regarding
> kernel-doc comments to union members.  However, the same warning
> still remains [1].
>=20
> Fix the issue by following the example found in section "Nested
> structs/unions" of Documentation/doc-guide/kernel-doc.rst.
>=20
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 48ec13d36d3f ("gpio: Properly document parent data union")
> Link: https://lore.kernel.org/r/20220606093302.21febee3@canb.auug.org.au/=
 [1]
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/gpio/driver.h | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Looks good, thanks.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/OxU+zvSxT+aW_NkUeZrEfx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKdlUYACgkQAVBC80lX
0GzMeQgAmySfWjcyc+xFr/XHVcCpHvT2l98zbkfuyMs8Bu2vsutDKzizn/+T7hof
2k5YYIAsxJSGd7bcKKyW6WuuCYILScEKiD2Lmh0RdDMMg6gOCdsoYA7VfYUhplvw
qyCOx9xlE2Zlcjgu3K0XJEXDqKM9j4/CCbqWxlZLfJjEoWJyBhWjYv/Q7w/ZyqFV
tI7suLKwiC0QXSWpKdP/m1xE8r92CdNsALaL1pN8uWureqDNDZfIFRxGxf4yZTAE
lJjGvuxhfO7JYsaepVKmDNmNsYrSQbOkHT8lCx+ZFGzbgHTWgyEJNNs+zJ30SDrx
5y4ZlcwFKNQeU7ZF/dx8CkFERNv/SA==
=KKQb
-----END PGP SIGNATURE-----

--Sig_/OxU+zvSxT+aW_NkUeZrEfx2--
