Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B6558D79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiFXCrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFXCrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:47:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607E56F92;
        Thu, 23 Jun 2022 19:47:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LThP941ppz4xDK;
        Fri, 24 Jun 2022 12:47:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656038861;
        bh=yFtCPj1SzPSBQkV5SbE9tEhDnZF5+EC8vLJsfwvgCpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hhupRS8HZKpQJizcCdDscs4+En1OhDc0WUuXAaR13iadaIaYcO8owY5l6pZeCAh4p
         1g1mcCvgOzXt8Rx7lB93/d15Qr3P2ZjcHvUDDGEbDWlGBkl/8tkJVwWtQWVdWkhg7L
         OZjInlUzFZi0QXSJ/K7h/Cxy6ZK8p/FCIMlL/r6Xd8lZR/rqucLKcMHheHrPCkibUA
         0wrIbtXNZRgHkN1GRLi4uhOQKp0wGopCMLp9R1/2kyfcyKeuqNLB/qoGz5g9Le+rnI
         es2FzLzN3Mb6xfXLrLE4h+fzat04D/ElzuW7cA35RSGE3uOU8+B1SsenXdFPTot6fE
         Zd6gfJKk8xWWQ==
Date:   Fri, 24 Jun 2022 12:47:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20220624124730.3516928c@canb.auug.org.au>
In-Reply-To: <20220620104503.11c0f2e1@canb.auug.org.au>
References: <20220620104503.11c0f2e1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_bab67luTDIwaOcF=iwpXn.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_bab67luTDIwaOcF=iwpXn.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jun 2022 10:45:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the battery tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/power/reset/pwr-mlxbf.c: In function 'pwr_mlxbf_probe':
> drivers/power/reset/pwr-mlxbf.c:67:15: error: implicit declaration of fun=
ction 'devm_work_autocancel' [-Werror=3Dimplicit-function-declaration]
>    67 |         err =3D devm_work_autocancel(dev, &priv->send_work, pwr_m=
lxbf_send_work);
>       |               ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control=
 driver")
>=20
> I have used the battery tree from next-20220617 for today.

I am still seeing this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/_bab67luTDIwaOcF=iwpXn.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK1JcIACgkQAVBC80lX
0Gyo+wf/QX+1ajOnP+FOslzsJ+J+orlzN0bHaEEP2eqlvcjKIM5w3v7P+j9YGfSm
L1AD8HcSSKfzu9vAjtlwTGEPaaw2RjjN/fzPTASyWZdxHAXaTCt6ES41T0UwuK/V
i3MibQ0q7wDlovNBAatMiJi4V9BtkpsL6sL4FpCWnc6gV5SPjJquy7rffeYnbsZO
w6ORpVkcSWKHVAL2Mm5uuaJ7FdGVNl/Hp8q3Of6+d+YBeiE/lbgeQYOZCKxLKwl6
5c7YoC5gtlueinCsBIwOPlEdZL6ALaKr1BJ+9f4rzWGFIYMK6ZboLc4qpUt1bmY7
gpsyAV3HYm8/t0OcpkR97uDeMcB5qw==
=kAsG
-----END PGP SIGNATURE-----

--Sig_/_bab67luTDIwaOcF=iwpXn.--
